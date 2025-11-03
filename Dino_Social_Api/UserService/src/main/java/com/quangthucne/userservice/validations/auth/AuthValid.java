package com.quangthucne.userservice.validations.auth;

import com.quangthucne.userservice.actions.auth.RefreshToken;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import com.quangthucne.userservice.actions.auth.Login;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AuthValid {

    @NotNull
    @NotBlank(message = "Identifier không được bỏ trống", groups = { Login.class })
    private String identifier;

    @NotNull
    @NotBlank(message = "Password không được bỏ trống", groups = { Login.class })
    private String password;

    @NotNull(groups = { RefreshToken.class })
    private String refreshToken;
}
