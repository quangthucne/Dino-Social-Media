package com.quangthucne.postservice.repositories;

import com.quangthucne.postservice.entities.Like;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface LikeRepo extends JpaRepository<Like, UUID> {
    boolean existsByPostIdAndUserId(UUID postId, UUID userId);
    Optional<Like> findByPostIdAndUserId(UUID postId, UUID userId);
    long countByPostId(UUID postId);
    void deleteByPostId(UUID postId);
}
