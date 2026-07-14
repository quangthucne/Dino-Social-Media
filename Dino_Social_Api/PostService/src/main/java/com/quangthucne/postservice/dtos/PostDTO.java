package com.quangthucne.postservice.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.OffsetDateTime;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PostDTO {
    private UUID id;
    private UUID userId;
    private String caption;
    private String mediaUrl;
    private String mediaType;
    private OffsetDateTime createdAt;
    private long likeCount;
    private long commentCount;
    private boolean isLiked;
}
