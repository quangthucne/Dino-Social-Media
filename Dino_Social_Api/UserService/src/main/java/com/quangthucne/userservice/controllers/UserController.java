package com.quangthucne.userservice.controllers;

import com.quangthucne.common.responses.Response;
import com.quangthucne.common.status.ResponseStatus;
import com.quangthucne.userservice.dtos.ChangePasswordDTO;
import com.quangthucne.userservice.dtos.UpdateProfileDTO;
import com.quangthucne.userservice.dtos.UserDTO;
import com.quangthucne.userservice.dtos.UserProfileDTO;
import com.quangthucne.userservice.services.UserService;
import com.quangthucne.common.exceptions.BadRequestException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("users")
public class UserController {

    @Autowired
    private UserService userService;

    private UUID getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || authentication.getPrincipal() == null) {
            throw new BadRequestException("Bạn chưa đăng nhập");
        }
        Object principal = authentication.getPrincipal();
        if (principal instanceof String) {
            try {
                return UUID.fromString((String) principal);
            } catch (IllegalArgumentException e) {
                throw new BadRequestException("Token không chứa định danh UUID hợp lệ");
            }
        }
        throw new BadRequestException("Định danh người dùng không hợp lệ");
    }

    private UUID getNullableCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || authentication.getPrincipal() == null) {
            return null;
        }
        Object principal = authentication.getPrincipal();
        if (principal instanceof String) {
            try {
                return UUID.fromString((String) principal);
            } catch (IllegalArgumentException e) {
                return null;
            }
        }
        return null;
    }

    @GetMapping("")
    public ResponseEntity<?> getListUser() {
        return ResponseEntity.ok(userService.getAllUsers());
    }

    @GetMapping("/me")
    public ResponseEntity<Response<UserProfileDTO>> getCurrentUserProfile() {
        UUID currentUserId = getCurrentUserId();
        UserProfileDTO profile = userService.getUserProfile(currentUserId, currentUserId);
        
        Response<UserProfileDTO> response = new Response<>();
        response.setStatus(ResponseStatus.SUCCESS.getCode());
        response.setMessage("Lấy thông tin cá nhân thành công");
        response.setData(profile);
        
        return ResponseEntity.ok(response);
    }

    @GetMapping("/profile/{id}")
    public ResponseEntity<Response<UserProfileDTO>> getUserProfile(@PathVariable UUID id) {
        UUID currentUserId = getNullableCurrentUserId();
        UserProfileDTO profile = userService.getUserProfile(id, currentUserId);

        Response<UserProfileDTO> response = new Response<>();
        response.setStatus(ResponseStatus.SUCCESS.getCode());
        response.setMessage("Lấy trang cá nhân thành công");
        response.setData(profile);

        return ResponseEntity.ok(response);
    }

    @PutMapping("/profile")
    public ResponseEntity<Response<UserDTO>> updateProfile(@RequestBody @Validated UpdateProfileDTO dto) {
        UUID currentUserId = getCurrentUserId();
        UserDTO updatedUser = userService.updateProfile(currentUserId, dto);

        Response<UserDTO> response = new Response<>();
        response.setStatus(ResponseStatus.SUCCESS.getCode());
        response.setMessage("Cập nhật trang cá nhân thành công");
        response.setData(updatedUser);

        return ResponseEntity.ok(response);
    }

    @PutMapping("/password")
    public ResponseEntity<Response<Void>> changePassword(@RequestBody @Validated ChangePasswordDTO dto) {
        UUID currentUserId = getCurrentUserId();
        userService.changePassword(currentUserId, dto);

        Response<Void> response = new Response<>();
        response.setStatus(ResponseStatus.SUCCESS.getCode());
        response.setMessage("Đổi mật khẩu thành công");
        response.setData(null);

        return ResponseEntity.ok(response);
    }

    @GetMapping("/search")
    public ResponseEntity<Response<List<UserDTO>>> searchUsers(@RequestParam("q") String query) {
        List<UserDTO> users = userService.searchUsers(query);

        Response<List<UserDTO>> response = new Response<>();
        response.setStatus(ResponseStatus.SUCCESS.getCode());
        response.setMessage("Tìm kiếm người dùng thành công");
        response.setData(users);

        return ResponseEntity.ok(response);
    }

    @PostMapping("/{id}/follow")
    public ResponseEntity<Response<Void>> followUser(@PathVariable UUID id) {
        UUID currentUserId = getCurrentUserId();
        userService.followUser(currentUserId, id);

        Response<Void> response = new Response<>();
        response.setStatus(ResponseStatus.SUCCESS.getCode());
        response.setMessage("Theo dõi người dùng thành công");
        response.setData(null);

        return ResponseEntity.ok(response);
    }

    @PostMapping("/{id}/unfollow")
    public ResponseEntity<Response<Void>> unfollowUser(@PathVariable UUID id) {
        UUID currentUserId = getCurrentUserId();
        userService.unfollowUser(currentUserId, id);

        Response<Void> response = new Response<>();
        response.setStatus(ResponseStatus.SUCCESS.getCode());
        response.setMessage("Hủy theo dõi người dùng thành công");
        response.setData(null);

        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}/followers")
    public ResponseEntity<Response<List<UserDTO>>> getFollowers(@PathVariable UUID id) {
        List<UserDTO> followers = userService.getFollowers(id);

        Response<List<UserDTO>> response = new Response<>();
        response.setStatus(ResponseStatus.SUCCESS.getCode());
        response.setMessage("Lấy danh sách người theo dõi thành công");
        response.setData(followers);

        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}/following")
    public ResponseEntity<Response<List<UserDTO>>> getFollowing(@PathVariable UUID id) {
        List<UserDTO> following = userService.getFollowing(id);

        Response<List<UserDTO>> response = new Response<>();
        response.setStatus(ResponseStatus.SUCCESS.getCode());
        response.setMessage("Lấy danh sách đang theo dõi thành công");
        response.setData(following);

        return ResponseEntity.ok(response);
    }
}
