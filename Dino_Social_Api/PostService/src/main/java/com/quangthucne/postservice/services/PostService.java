package com.quangthucne.postservice.services;

import com.quangthucne.common.exceptions.BadRequestException;
import com.quangthucne.common.exceptions.ResourceNotFoundException;
import com.quangthucne.postservice.dtos.*;
import com.quangthucne.postservice.entities.*;
import com.quangthucne.postservice.repositories.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class PostService {

    @Autowired
    private PostRepo postRepo;

    @Autowired
    private CommentRepo commentRepo;

    @Autowired
    private LikeRepo likeRepo;

    public PostDTO createPost(UUID currentUserId, CreatePostDTO dto) {
        Post post = new Post();
        post.setUserId(currentUserId);
        post.setCaption(dto.getCaption());
        post.setMediaUrl(dto.getMediaUrl());
        post.setMediaType(dto.getMediaType());
        post = postRepo.save(post);
        return convertToPostDTO(post, currentUserId);
    }

    public PostDTO getPostById(UUID postId, UUID currentUserId) {
        Post post = postRepo.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Bài viết không tồn tại."));
        return convertToPostDTO(post, currentUserId);
    }

    @Transactional
    public void deletePost(UUID postId, UUID currentUserId) {
        Post post = postRepo.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Bài viết không tồn tại."));
        if (!post.getUserId().equals(currentUserId)) {
            throw new BadRequestException("Bạn không có quyền xóa bài viết này.");
        }
        commentRepo.deleteByPostId(postId);
        likeRepo.deleteByPostId(postId);
        postRepo.delete(post);
    }

    public List<PostDTO> getPostsByUserId(UUID userId, UUID currentUserId) {
        return postRepo.findByUserIdOrderByCreatedAtDesc(userId).stream()
                .map(post -> convertToPostDTO(post, currentUserId))
                .collect(Collectors.toList());
    }

    public List<PostDTO> getFeed(UUID currentUserId) {
        return postRepo.findAllByOrderByCreatedAtDesc().stream()
                .map(post -> convertToPostDTO(post, currentUserId))
                .collect(Collectors.toList());
    }

    @Transactional
    public void likePost(UUID postId, UUID currentUserId) {
        if (!postRepo.existsById(postId)) {
            throw new ResourceNotFoundException("Bài viết không tồn tại.");
        }
        if (likeRepo.existsByPostIdAndUserId(postId, currentUserId)) {
            throw new BadRequestException("Bạn đã thích bài viết này rồi.");
        }
        Like like = new Like();
        like.setPostId(postId);
        like.setUserId(currentUserId);
        likeRepo.save(like);
    }

    @Transactional
    public void unlikePost(UUID postId, UUID currentUserId) {
        if (!postRepo.existsById(postId)) {
            throw new ResourceNotFoundException("Bài viết không tồn tại.");
        }
        Like like = likeRepo.findByPostIdAndUserId(postId, currentUserId)
                .orElseThrow(() -> new BadRequestException("Bạn chưa thích bài viết này."));
        likeRepo.delete(like);
    }

    public CommentDTO addComment(UUID postId, UUID currentUserId, CreateCommentDTO dto) {
        if (!postRepo.existsById(postId)) {
            throw new ResourceNotFoundException("Bài viết không tồn tại.");
        }
        Comment comment = new Comment();
        comment.setPostId(postId);
        comment.setUserId(currentUserId);
        comment.setCommentText(dto.getCommentText());
        comment = commentRepo.save(comment);

        CommentDTO responseDto = new CommentDTO();
        responseDto.setId(comment.getId());
        responseDto.setPostId(comment.getPostId());
        responseDto.setUserId(comment.getUserId());
        responseDto.setCommentText(comment.getCommentText());
        responseDto.setCreatedAt(comment.getCreatedAt());
        return responseDto;
    }

    public List<CommentDTO> getCommentsByPostId(UUID postId) {
        if (!postRepo.existsById(postId)) {
            throw new ResourceNotFoundException("Bài viết không tồn tại.");
        }
        return commentRepo.findByPostIdOrderByCreatedAtAsc(postId).stream()
                .map(comment -> {
                    CommentDTO dto = new CommentDTO();
                    dto.setId(comment.getId());
                    dto.setPostId(comment.getPostId());
                    dto.setUserId(comment.getUserId());
                    dto.setCommentText(comment.getCommentText());
                    dto.setCreatedAt(comment.getCreatedAt());
                    return dto;
                })
                .collect(Collectors.toList());
    }

    private PostDTO convertToPostDTO(Post post, UUID currentUserId) {
        PostDTO dto = new PostDTO();
        dto.setId(post.getId());
        dto.setUserId(post.getUserId());
        dto.setCaption(post.getCaption());
        dto.setMediaUrl(post.getMediaUrl());
        dto.setMediaType(post.getMediaType());
        dto.setCreatedAt(post.getCreatedAt());

        long likeCount = likeRepo.countByPostId(post.getId());
        long commentCount = commentRepo.countByPostId(post.getId());
        boolean isLiked = currentUserId != null && likeRepo.existsByPostIdAndUserId(post.getId(), currentUserId);

        dto.setLikeCount(likeCount);
        dto.setCommentCount(commentCount);
        dto.setLiked(isLiked);

        return dto;
    }
}
