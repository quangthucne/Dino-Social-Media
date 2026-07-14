package com.quangthucne.postservice.dtos;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CreatePostDTO {
    private String caption;

    @NotBlank(message = "Media URL is required")
    @Size(max = 255, message = "Media URL cannot exceed 255 characters")
    private String mediaUrl;

    @NotBlank(message = "Media Type is required")
    @Size(max = 10, message = "Media Type cannot exceed 10 characters")
    private String mediaType;
}
