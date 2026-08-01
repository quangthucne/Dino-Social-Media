package com.quangthucne.userservice.repositories;

import com.quangthucne.userservice.entities.Message;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.UUID;

public interface MessageRepo extends JpaRepository<Message, UUID> {
    List<Message> findAllByConversationIdOrderBySentAtAsc(UUID conversationId);
}
