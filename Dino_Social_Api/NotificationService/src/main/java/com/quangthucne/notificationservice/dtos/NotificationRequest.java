package com.quangthucne.notificationservice.dtos;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.tomcat.util.http.parser.Priority;

import java.util.Map;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class NotificationRequest {
    // 1. Thông tin định danh & Bảo mật
    private String requestId;      // Idempotency Key để tránh gửi trùng
    private String senderId;       // Hệ thống hoặc User ID gửi
    private String recipient;      // Email hoặc Device Token (FCM Token)
    private NotificationType type; // Enum: EMAIL, PUSH, SMS

    // 2. Định hướng nội dung
    private String templateCode;   // Ví dụ: "WELCOME_USER", "NEW_COMMENT"

    // 3. Data Dynamic (Placeholders)
    // Chứa các biến như {username}, {post_title}, {otp_code}
    private Map<String, String> placeholders;

    // 4. Metadata cho Mobile (Flutter Deep-linking)
    // Quan trọng để khi user bấm vào Push, app biết mở màn hình nào
    private Map<String, String> metadata;

    // 5. Cấu hình ưu tiên
    private Priority priority;     // HIGH (cho OTP), LOW (cho Marketing)
}