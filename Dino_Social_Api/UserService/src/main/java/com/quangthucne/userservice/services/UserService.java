package com.quangthucne.userservice.services;

import com.quangthucne.common.exceptions.BadRequestException;
import com.quangthucne.common.exceptions.ResourceNotFoundException;
import com.quangthucne.userservice.dtos.ChangePasswordDTO;
import com.quangthucne.userservice.dtos.UpdateProfileDTO;
import com.quangthucne.userservice.dtos.UserDTO;
import com.quangthucne.userservice.dtos.UserProfileDTO;
import com.quangthucne.userservice.entities.Follow;
import com.quangthucne.userservice.entities.User;
import com.quangthucne.userservice.mappers.UserMapper;
import com.quangthucne.userservice.repositories.FollowRepo;
import com.quangthucne.userservice.repositories.UserRepo;
import com.quangthucne.userservice.utils.PasswordHash;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private FollowRepo followRepo;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private PasswordHash passwordHash;

    public List<UserDTO> getAllUsers() {
        List<User> users = userRepo.findAll();
        return users.stream()
                .map(user -> userMapper.toDTO(user))
                .collect(Collectors.toList());
    }

    public Optional<User> getUserById(UUID id) {
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

    public void followUser(UUID followerId, UUID followingId) {
        if (followerId.equals(followingId)) {
            throw new BadRequestException("Bạn không thể tự theo dõi chính mình");
        }

        User follower = userRepo.findById(followerId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy người dùng"));
        User following = userRepo.findById(followingId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy người dùng được follow"));

        if (followRepo.existsByFollowerAndFollowing(follower, following)) {
            throw new BadRequestException("Bạn đã theo dõi người dùng này rồi");
        }

        Follow follow = new Follow();
        follow.setFollower(follower);
        follow.setFollowing(following);
        followRepo.save(follow);
    }

    public void unfollowUser(UUID followerId, UUID followingId) {
        User follower = userRepo.findById(followerId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy người dùng"));
        User following = userRepo.findById(followingId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy người dùng được follow"));

        Follow follow = followRepo.findByFollowerAndFollowing(follower, following)
                .orElseThrow(() -> new BadRequestException("Bạn chưa theo dõi người dùng này"));

        followRepo.delete(follow);
    }

    public List<UserDTO> getFollowers(UUID userId) {
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy người dùng"));
        List<Follow> follows = followRepo.findByFollowing(user);
        return follows.stream()
                .map(follow -> userMapper.toDTO(follow.getFollower()))
                .collect(Collectors.toList());
    }

    public List<UserDTO> getFollowing(UUID userId) {
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy người dùng"));
        List<Follow> follows = followRepo.findByFollower(user);
        return follows.stream()
                .map(follow -> userMapper.toDTO(follow.getFollowing()))
                .collect(Collectors.toList());
    }

    public UserProfileDTO getUserProfile(UUID targetUserId, UUID currentUserId) {
        User targetUser = userRepo.findById(targetUserId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy người dùng"));

        long followerCount = followRepo.countByFollowing(targetUser);
        long followingCount = followRepo.countByFollower(targetUser);
        boolean isFollowing = false;

        if (currentUserId != null) {
            Optional<User> currentUserOpt = userRepo.findById(currentUserId);
            if (currentUserOpt.isPresent()) {
                isFollowing = followRepo.existsByFollowerAndFollowing(currentUserOpt.get(), targetUser);
            }
        }

        UserProfileDTO profileDTO = new UserProfileDTO();
        profileDTO.setId(targetUser.getId());
        profileDTO.setUsername(targetUser.getUsername());
        profileDTO.setEmail(targetUser.getEmail());
        profileDTO.setFullName(targetUser.getFullName());
        profileDTO.setBio(targetUser.getBio());
        profileDTO.setProfilePictureUrl(targetUser.getProfilePictureUrl());
        profileDTO.setWebsiteUrl(targetUser.getWebsiteUrl());
        profileDTO.setIsVerified(targetUser.getIsVerified());
        profileDTO.setCreatedAt(targetUser.getCreatedAt());
        profileDTO.setFollowerCount(followerCount);
        profileDTO.setFollowingCount(followingCount);
        profileDTO.setFollowing(isFollowing);

        return profileDTO;
    }

    public UserDTO updateProfile(UUID userId, UpdateProfileDTO dto) {
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy người dùng"));

        if (dto.getFullName() != null) {
            user.setFullName(dto.getFullName());
        }
        if (dto.getBio() != null) {
            user.setBio(dto.getBio());
        }
        if (dto.getProfilePictureUrl() != null) {
            user.setProfilePictureUrl(dto.getProfilePictureUrl());
        }
        if (dto.getWebsiteUrl() != null) {
            user.setWebsiteUrl(dto.getWebsiteUrl());
        }

        return userMapper.toDTO(userRepo.save(user));
    }

    public void changePassword(UUID userId, ChangePasswordDTO dto) {
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy người dùng"));

        if (!passwordHash.verifyPassword(dto.getOldPassword(), user.getPassword())) {
            throw new BadRequestException("Mật khẩu cũ không chính xác");
        }

        user.setPassword(passwordHash.hashPassword(dto.getNewPassword()));
        userRepo.save(user);
    }

    public List<UserDTO> searchUsers(String query) {
        List<User> users = userRepo.findByUsernameContainingIgnoreCaseOrFullNameContainingIgnoreCase(query, query);
        return users.stream()
                .map(user -> userMapper.toDTO(user))
                .collect(Collectors.toList());
    }
}
