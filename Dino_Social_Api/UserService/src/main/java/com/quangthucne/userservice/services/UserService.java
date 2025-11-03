package com.quangthucne.userservice.services;

import com.quangthucne.userservice.dtos.UserDTO;

import com.quangthucne.userservice.entities.User;
import com.quangthucne.userservice.mappers.UserMapper;
import com.quangthucne.userservice.repositories.UserRepo;
import com.quangthucne.userservice.utils.PasswordHash;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    UserRepo userRepo;

    @Autowired
    UserMapper userMapper;

    private final PasswordHash passwordHash = new PasswordHash();

    public List<UserDTO> getAllUsers() {
        List<User> users = userRepo.findAll();
        return users.stream()
                .map(user -> userMapper.toDTO(user))
                .collect(Collectors.toList());
    }

    public Optional<User> getUserById(Long id) {
        return userRepo.findById(id);
    }

    public boolean login(String identifier, String password) {
        Optional<User> userOpt = userRepo.findByIndentifier(identifier);
        if (userOpt.isEmpty()) {
            return false;
        }
        User user = userOpt.get();
        return passwordHash.verifyPassword(password, user.getPassword());
    }

}
