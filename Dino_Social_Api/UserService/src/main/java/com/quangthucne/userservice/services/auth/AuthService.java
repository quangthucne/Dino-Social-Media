package com.quangthucne.userservice.services.auth;

import com.quangthucne.userservice.dtos.UserDTO;
import com.quangthucne.userservice.dtos.auth.AuthDTO;
import com.quangthucne.userservice.entities.User;
import com.quangthucne.userservice.mappers.UserMapper;
import com.quangthucne.userservice.security.CustomUserDetailsService;
import com.quangthucne.userservice.utils.PasswordHash;
import com.quangthucne.userservice.validations.UserValid;
import com.quangthucne.userservice.validations.auth.AuthValid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.quangthucne.common.exceptions.BadRequestException;
import com.quangthucne.userservice.repositories.UserRepo;
import com.quangthucne.userservice.services.UserService;
import com.quangthucne.userservice.utils.JwtUtil;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AuthService {

    @Autowired
    AuthenticationManager authenticationManager;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepo userRepo;

    @Autowired
    UserMapper userMapper;

    @Autowired
    private PasswordHash passwordHash;

    @Autowired
    CustomUserDetailsService customUserDetailsService;

    public AuthDTO login(AuthValid authValid) {
        try {
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(authValid.getIdentifier(), authValid.getPassword()));
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();

            return new AuthDTO(jwtUtil.generateToken(userDetails), jwtUtil.generateRefreshToken(userDetails));
        } catch (BadCredentialsException e) {
            throw new BadRequestException("Thông tin đăng nhập không hợp lệ");
        }
    }


    public AuthDTO refreshToken(String refreshToken) {
        String id = jwtUtil.extractId(refreshToken);

        if (id != null) {
            UserDetails userDetails = customUserDetailsService.loadUserByUsername(id);
            if (jwtUtil.validateToken(refreshToken, userDetails)) {
                return new AuthDTO(jwtUtil.generateToken(userDetails), refreshToken);
            }
        }
        throw new BadRequestException("Token không hợp lệ");
    }

    @Transactional
    public UserDTO register(UserValid userValid) {
        if (userRepo.existsByUsername(userValid.getUsername())) {
            throw new BadRequestException("Username already exists");
        }

        if (userRepo.existsByEmail(userValid.getEmail())) {
            throw new BadRequestException("Email already exists");
        }

        User user = userMapper.toEntity(userValid);
        user.setIsVerified(false);

        return userMapper.toDTO(userRepo.save(user));
    }
}
