package com.quangthucne.postservice.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.time.OffsetDateTime;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "comments")
public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @ColumnDefault("gen_random_uuid()")
    @Column(name = "comment_id", nullable = false)
    private UUID id;

    @NotNull
    @Column(name = "post_id", nullable = false)
    private UUID postId;

    @NotNull
    @Column(name = "user_id", nullable = false)
    private UUID userId;

    @NotNull
    @Column(name = "comment_text", nullable = false, length = Integer.MAX_VALUE)
    private String commentText;

    @ColumnDefault("now()")
    @Column(name = "created_at")
    private OffsetDateTime createdAt = OffsetDateTime.now();
}
