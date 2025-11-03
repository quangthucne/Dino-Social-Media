package com.quangthucne.userservice.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Value;

import java.io.Serializable;
import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * DTO for {@link com.quangthucne.userservice.entites.User}
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO {
    private UUID id;
    private String username;
    private String email;
    private String passwordHash;
    private String fullName;
    private String bio;
    private String profilePictureUrl;
    private String websiteUrl;
    private Boolean isVerified;
    private OffsetDateTime createdAt;
    private OffsetDateTime lastLogin;
}