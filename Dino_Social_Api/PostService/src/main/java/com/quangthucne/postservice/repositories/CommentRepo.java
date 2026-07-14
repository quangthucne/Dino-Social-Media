package com.quangthucne.postservice.repositories;

import com.quangthucne.postservice.entities.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface CommentRepo extends JpaRepository<Comment, UUID> {
    List<Comment> findByPostIdOrderByCreatedAtAsc(UUID postId);
    long countByPostId(UUID postId);
    void deleteByPostId(UUID postId);
}
