package com.quangthucne.postservice.controllers;

import com.quangthucne.postservice.dtos.*;
import com.quangthucne.postservice.services.PostService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/posts")
@Tag(name = "Post & Interaction", description = "Các API đăng bài, bình luận, và like")
public class PostController {

    @Autowired
    private PostService postService;

    private UUID getCurrentUserId(Authentication authentication) {
        return UUID.fromString((String) authentication.getPrincipal());
    }

    @PostMapping
    @Operation(summary = "Đăng bài viết mới")
    public ResponseEntity<PostDTO> createPost(Authentication authentication, @Valid @RequestBody CreatePostDTO dto) {
        UUID currentUserId = getCurrentUserId(authentication);
        return ResponseEntity.ok(postService.createPost(currentUserId, dto));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Xem chi tiết bài viết")
    public ResponseEntity<PostDTO> getPost(Authentication authentication, @PathVariable UUID id) {
        UUID currentUserId = getCurrentUserId(authentication);
        return ResponseEntity.ok(postService.getPostById(id, currentUserId));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Xóa bài viết")
    public ResponseEntity<String> deletePost(Authentication authentication, @PathVariable UUID id) {
        UUID currentUserId = getCurrentUserId(authentication);
        postService.deletePost(id, currentUserId);
        return ResponseEntity.ok("Xóa bài viết thành công.");
    }

    @GetMapping("/user/{userId}")
    @Operation(summary = "Lấy tất cả bài viết của một user")
    public ResponseEntity<List<PostDTO>> getUserPosts(Authentication authentication, @PathVariable UUID userId) {
        UUID currentUserId = getCurrentUserId(authentication);
        return ResponseEntity.ok(postService.getPostsByUserId(userId, currentUserId));
    }

    @GetMapping("/feed")
    @Operation(summary = "Lấy bảng tin (Tất cả bài viết mới nhất)")
    public ResponseEntity<List<PostDTO>> getFeed(Authentication authentication) {
        UUID currentUserId = getCurrentUserId(authentication);
        return ResponseEntity.ok(postService.getFeed(currentUserId));
    }

    @PostMapping("/{id}/like")
    @Operation(summary = "Thích bài viết")
    public ResponseEntity<String> likePost(Authentication authentication, @PathVariable UUID id) {
        UUID currentUserId = getCurrentUserId(authentication);
        postService.likePost(id, currentUserId);
        return ResponseEntity.ok("Đã thích bài viết.");
    }

    @PostMapping("/{id}/unlike")
    @Operation(summary = "Bỏ thích bài viết")
    public ResponseEntity<String> unlikePost(Authentication authentication, @PathVariable UUID id) {
        UUID currentUserId = getCurrentUserId(authentication);
        postService.unlikePost(id, currentUserId);
        return ResponseEntity.ok("Đã bỏ thích bài viết.");
    }

    @PostMapping("/{id}/comments")
    @Operation(summary = "Bình luận vào bài viết")
    public ResponseEntity<CommentDTO> addComment(Authentication authentication, @PathVariable UUID id, @Valid @RequestBody CreateCommentDTO dto) {
        UUID currentUserId = getCurrentUserId(authentication);
        return ResponseEntity.ok(postService.addComment(id, currentUserId, dto));
    }

    @GetMapping("/{id}/comments")
    @Operation(summary = "Lấy danh sách bình luận của bài viết")
    public ResponseEntity<List<CommentDTO>> getComments(@PathVariable UUID id) {
        return ResponseEntity.ok(postService.getCommentsByPostId(id));
    }
}
