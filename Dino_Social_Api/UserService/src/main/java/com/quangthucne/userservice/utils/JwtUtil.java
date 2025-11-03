package com.quangthucne.userservice.utils;

import java.security.Key;
import java.util.*;
import java.util.stream.Collectors;

import javax.crypto.SecretKey;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import com.quangthucne.common.exceptions.BadRequestException;
import com.quangthucne.userservice.entities.User;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.http.HttpServletRequest;

@Component
public class JwtUtil {
    @Autowired
    HttpServletRequest request;

    @Value("${jwt.secret}")
    private String SECRET_KEY;

    @Value("${jwt.expiration}") // 7 day
    private long EXPIRATION_TIME;

    @Value("${jwt.refresh.expiration}")
    private long REFRESH_TIME;


    // Tạo Key từ chuỗi secret
    private SecretKey getSigningKey() {
        return Keys.hmacShaKeyFor(Base64.getDecoder().decode(this.SECRET_KEY));
    }

    public String generateToken(UserDetails userdDetails) {

        Map<String, Object> claims = new HashMap<>();
        claims.put("id", userdDetails.getUsername());

        return Jwts.builder()
                .setClaims(claims)
                .setSubject(userdDetails.getUsername())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    public String generateRefreshToken(UserDetails userdDetails) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("id", userdDetails.getUsername());

        return Jwts.builder()
                .setClaims(claims)
                .setSubject(userdDetails.getUsername())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + REFRESH_TIME))
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    public String extractId(String token) {
        try {
            return Jwts.parser()
                    .setSigningKey(getSigningKey())
                    .parseClaimsJws(token)
                    .getBody()
                    .get("id", String.class);
        } catch (ExpiredJwtException e) {
            throw new BadRequestException("Token đã hết hạn");
        } catch (JwtException e) {
            throw new BadRequestException("Token không hợp lệ");
        }
    }

    public String extractRole(String token) {
        try {
            return Jwts.parser()
                    .setSigningKey(SECRET_KEY)
                    .parseClaimsJws(token)
                    .getBody()
                    .get("role", String.class);
        } catch (ExpiredJwtException e) {
            throw new BadRequestException("Token đã hết hạn");
        } catch (JwtException e) {
            throw new BadRequestException("Token không hợp lệ");
        }
    }

    public Claims getPayloadFromToken(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(SECRET_KEY)
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        } catch (ExpiredJwtException e) {
            System.out.println("Token đã hết hạn: " + e.getMessage());
            throw new BadRequestException("Token đã hết hạn");
        } catch (JwtException e) {
            System.out.println("Token không hợp lệ: " + e.getMessage());
            throw new BadRequestException("Token không hợp lệ");
        }
    }

    public boolean validateToken(String token, UserDetails userDetails) {
        String id = extractId(token);
        return id.equals(userDetails.getUsername());
    }

    public String getToken() {
        String token = request.getHeader("Authorization");
        if (token != null && token.startsWith("Bearer ")) {
            token = token.substring(7);
            return token;
        }
        return null;
    }
}
