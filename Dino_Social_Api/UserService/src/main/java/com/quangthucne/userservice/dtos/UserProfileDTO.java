package com.quangthucne.userservice.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.OffsetDateTime;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserProfileDTO {
    private UUID id;
    private String username;
    private String email;
    private String fullName;
    private String bio;
    private String profilePictureUrl;
    private String websiteUrl;
    private Boolean isVerified;
    private OffsetDateTime createdAt;
    private long followerCount;
    private long followingCount;
    private boolean isFollowing;
}
