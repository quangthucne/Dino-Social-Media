package com.quangthucne.userservice.validations;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import com.quangthucne.userservice.actions.auth.Login;
import com.quangthucne.userservice.actions.auth.Register;

import java.time.OffsetDateTime;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserValid {

    private UUID id;

    @NotNull
    @NotBlank(message = "Username không được bỏ trống", groups = { Register.class })
    private String username;

    @NotNull
    @NotBlank(message = "Email không được bỏ trống", groups = { Register.class })
    private String email;

    @NotNull
    @NotBlank(message = "Password không được bỏ trống", groups = { Register.class, Login.class })
    private String password;

    @NotNull
    @NotBlank(message = "Fullname không được bỏ trống", groups = { Register.class })
    private String fullname;

    private String bio;

    private String profilePictureUrl;

    private String websiteUrl;

    private Boolean isVerified;

    private OffsetDateTime createdAt;

    private OffsetDateTime lastLogin;
}
