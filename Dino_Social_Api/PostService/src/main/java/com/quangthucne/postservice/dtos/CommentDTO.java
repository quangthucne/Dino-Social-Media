package com.quangthucne.postservice.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.OffsetDateTime;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentDTO {
    private UUID id;
    private UUID postId;
    private UUID userId;
    private String commentText;
    private OffsetDateTime createdAt;
}
