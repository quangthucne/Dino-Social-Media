package com.quangthucne.userservice.security;

import com.quangthucne.userservice.entities.User;
import com.quangthucne.userservice.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Optional;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserRepo userRepo;

    @Override
    public UserDetails loadUserByUsername(String identifier) throws UsernameNotFoundException {
        Optional<User> userOptional = userRepo.findByIndentifier(identifier);

        User user = userOptional
                .orElseThrow(() -> new UsernameNotFoundException("User not found with identifier: " + identifier));

        // Assuming your User entity has a 'role' field or similar for authorities
        // For simplicity, let's assume a default role or fetch from user entity
        return new org.springframework.security.core.userdetails.User(
                user.getId().toString(), // Use ID as username for UserDetails
                user.getPassword(),
                Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER")) // Default role
        );
    }
}
