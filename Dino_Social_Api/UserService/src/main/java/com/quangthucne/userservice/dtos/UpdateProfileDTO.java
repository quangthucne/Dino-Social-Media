package com.quangthucne.userservice.dtos;

import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UpdateProfileDTO {
    @Size(max = 100, message = "Full name cannot exceed 100 characters")
    private String fullName;

    private String bio;

    @Size(max = 255, message = "Profile picture URL cannot exceed 255 characters")
    private String profilePictureUrl;

    @Size(max = 255, message = "Website URL cannot exceed 255 characters")
    private String websiteUrl;
}
