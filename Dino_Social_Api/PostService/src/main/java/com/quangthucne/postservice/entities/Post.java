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
@Table(name = "posts")
public class Post {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @ColumnDefault("gen_random_uuid()")
    @Column(name = "post_id", nullable = false)
    private UUID id;

    @NotNull
    @Column(name = "user_id", nullable = false)
    private UUID userId;

    @Column(name = "caption", length = Integer.MAX_VALUE)
    private String caption;

    @NotNull
    @Column(name = "media_url", nullable = false, length = 255)
    private String mediaUrl;

    @NotNull
    @Column(name = "media_type", nullable = false, length = 10)
    private String mediaType;

    @ColumnDefault("now()")
    @Column(name = "created_at")
    private OffsetDateTime createdAt = OffsetDateTime.now();
}
