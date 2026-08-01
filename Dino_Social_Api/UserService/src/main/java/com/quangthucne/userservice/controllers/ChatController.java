package com.quangthucne.userservice.controllers;

import com.quangthucne.common.exceptions.BadRequestException;
import com.quangthucne.common.responses.Response;
import com.quangthucne.userservice.entities.Conversation;
import com.quangthucne.userservice.entities.Message;
import com.quangthucne.userservice.entities.User;
import com.quangthucne.userservice.repositories.ConversationRepo;
import com.quangthucne.userservice.repositories.MessageRepo;
import com.quangthucne.userservice.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("messages")
public class ChatController {

    @Autowired
    private ConversationRepo conversationRepo;

    @Autowired
    private MessageRepo messageRepo;

    @Autowired
    private UserRepo userRepo;

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

    // DTOs
    public static class ConversationDTO {
        public UUID id;
        public String name;
        public String avatarUrl;
        public String lastMessage;
        public LocalDateTime lastUpdated;
        public List<ParticipantDTO> participants;

        public ConversationDTO(Conversation c, UUID currentUserId) {
            this.id = c.getId();
            this.lastMessage = c.getLastMessage();
            this.lastUpdated = c.getLastUpdated();
            this.participants = c.getParticipants().stream()
                    .map(ParticipantDTO::new)
                    .collect(Collectors.toList());

            if (c.getParticipants().size() == 2) {
                User other = c.getParticipants().stream()
                        .filter(u -> !u.getId().equals(currentUserId))
                        .findFirst()
                        .orElse(null);
                if (other != null) {
                    this.name = other.getFullName() != null ? other.getFullName() : other.getUsername();
                    this.avatarUrl = other.getProfilePictureUrl();
                }
            }
            if (this.name == null) {
                this.name = c.getName() != null ? c.getName() : "Trò chuyện nhóm";
            }
        }
    }

    public static class ParticipantDTO {
        public UUID userId;
        public String username;
        public String fullName;
        public String avatarUrl;

        public ParticipantDTO(User u) {
            this.userId = u.getId();
            this.username = u.getUsername();
            this.fullName = u.getFullName();
            this.avatarUrl = u.getProfilePictureUrl();
        }
    }

    public static class MessageDTO {
        public UUID id;
        public UUID conversationId;
        public UUID senderId;
        public String senderName;
        public String senderAvatar;
        public String content;
        public LocalDateTime sentAt;
        public boolean isRead;

        public MessageDTO(Message m) {
            this.id = m.getId();
            this.conversationId = m.getConversation().getId();
            this.senderId = m.getSender().getId();
            this.senderName = m.getSender().getFullName() != null ? m.getSender().getFullName() : m.getSender().getUsername();
            this.senderAvatar = m.getSender().getProfilePictureUrl();
            this.content = m.getContent();
            this.sentAt = m.getSentAt();
            this.isRead = m.isRead();
        }
    }

    public static class CreateConvRequest {
        public UUID targetUserId;
    }

    public static class SendMsgRequest {
        public UUID conversationId;
        public String content;
    }

    @GetMapping("/conversations")
    public ResponseEntity<?> getConversations() {
        UUID currentUserId = getCurrentUserId();
        List<Conversation> convs = conversationRepo.findAllByParticipantId(currentUserId);
        List<ConversationDTO> dtos = convs.stream()
                .map(c -> new ConversationDTO(c, currentUserId))
                .collect(Collectors.toList());
        return ResponseEntity.ok(Response.success(dtos));
    }

    @GetMapping("/conversations/{id}")
    public ResponseEntity<?> getMessages(@PathVariable("id") UUID conversationId) {
        UUID currentUserId = getCurrentUserId();
        Conversation conv = conversationRepo.findById(conversationId)
                .orElseThrow(() -> new BadRequestException("Không tìm thấy cuộc trò chuyện"));
        
        boolean isParticipant = conv.getParticipants().stream()
                .anyMatch(u -> u.getId().equals(currentUserId));
        if (!isParticipant) {
            throw new BadRequestException("Bạn không tham gia cuộc trò chuyện này");
        }

        List<Message> msgs = messageRepo.findAllByConversationIdOrderBySentAtAsc(conversationId);
        List<MessageDTO> dtos = msgs.stream()
                .map(MessageDTO::new)
                .collect(Collectors.toList());
        return ResponseEntity.ok(Response.success(dtos));
    }

    @PostMapping("/conversations")
    public ResponseEntity<?> startConversation(@RequestBody CreateConvRequest req) {
        UUID currentUserId = getCurrentUserId();
        if (req.targetUserId == null) {
            throw new BadRequestException("Thiếu targetUserId");
        }
        if (currentUserId.equals(req.targetUserId)) {
            throw new BadRequestException("Không thể trò chuyện với chính mình");
        }

        User currentUser = userRepo.findById(currentUserId)
                .orElseThrow(() -> new BadRequestException("Không tìm thấy người dùng hiện tại"));
        User targetUser = userRepo.findById(req.targetUserId)
                .orElseThrow(() -> new BadRequestException("Không tìm thấy người dùng mục tiêu"));

        List<Conversation> existing = conversationRepo.findConversationsBetween(currentUserId, req.targetUserId);
        for (Conversation c : existing) {
            if (c.getParticipants().size() == 2) {
                return ResponseEntity.ok(Response.success(new ConversationDTO(c, currentUserId)));
            }
        }

        Conversation conv = new Conversation();
        conv.setParticipants(Arrays.asList(currentUser, targetUser));
        conv.setLastUpdated(LocalDateTime.now());
        conv.setLastMessage("Hãy bắt đầu cuộc trò chuyện!");
        conv = conversationRepo.save(conv);

        return ResponseEntity.ok(Response.success(new ConversationDTO(conv, currentUserId)));
    }

    @PostMapping("/send")
    public ResponseEntity<?> sendMessage(@RequestBody SendMsgRequest req) {
        UUID currentUserId = getCurrentUserId();
        if (req.conversationId == null || req.content == null || req.content.trim().isEmpty()) {
            throw new BadRequestException("Dữ liệu gửi tin nhắn không hợp lệ");
        }

        Conversation conv = conversationRepo.findById(req.conversationId)
                .orElseThrow(() -> new BadRequestException("Không tìm thấy cuộc trò chuyện"));

        User currentUser = conv.getParticipants().stream()
                .filter(u -> u.getId().equals(currentUserId))
                .findFirst()
                .orElseThrow(() -> new BadRequestException("Bạn không thuộc cuộc trò chuyện này"));

        Message msg = new Message();
        msg.setConversation(conv);
        msg.setSender(currentUser);
        msg.setContent(req.content.trim());
        msg.setSentAt(LocalDateTime.now());
        msg = messageRepo.save(msg);

        conv.setLastMessage(msg.getContent());
        conv.setLastUpdated(msg.getSentAt());
        conversationRepo.save(conv);

        return ResponseEntity.ok(Response.success(new MessageDTO(msg)));
    }
}
