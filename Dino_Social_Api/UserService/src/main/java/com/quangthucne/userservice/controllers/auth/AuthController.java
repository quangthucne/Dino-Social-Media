package com.quangthucne.userservice.controllers.auth;

import com.quangthucne.common.responses.Response;
import com.quangthucne.common.status.ResponseStatus;
import com.quangthucne.userservice.actions.auth.RefreshToken;
import com.quangthucne.userservice.dtos.UserDTO;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.quangthucne.userservice.actions.auth.Login;
import com.quangthucne.userservice.services.auth.AuthService;
import com.quangthucne.userservice.validations.auth.AuthValid;
import com.quangthucne.userservice.validations.UserValid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.quangthucne.userservice.actions.auth.Register;

@RestController
@RequestMapping("auth")
public class AuthController {

    @Autowired
    AuthService authService;


    @PostMapping("/login")
    public ResponseEntity<Response> login(@Validated(Login.class) @RequestBody AuthValid authValid) {
        Response response = new Response();

        response.setStatus(ResponseStatus.SUCCESS.getCode());
        response.setMessage("Đăng nhập thành công!");
        response.setData(authService.login(authValid));
        return ResponseEntity.ok().body(response);
    }

    @PostMapping("/refresh")
    public ResponseEntity<Response> refreshToken(@RequestBody @Validated(RefreshToken.class) AuthValid authValid) {
        Response response = new Response();
        response.setStatus(ResponseStatus.SUCCESS.getCode());
        response.setMessage("SUCCESS");
        response.setData(authService.refreshToken(authValid.getRefreshToken()));
        return ResponseEntity.ok(response);
    }

    @PostMapping("/register")
    public ResponseEntity<Response<UserDTO>> register(@Validated(Register.class) @RequestBody UserValid userValid) {
        Response response = new Response();
        response.setMessage("Đăng ký thành công!");
        response.setStatus(ResponseStatus.CREATED.getCode());
        response.setData(authService.register(userValid));
        return ResponseEntity.ok().body(response);
    }
}
