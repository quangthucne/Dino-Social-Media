package com.quangthucne.userservice.repositories;

import com.quangthucne.userservice.entities.Conversation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ConversationRepo extends JpaRepository<Conversation, UUID> {
    
    @Query("SELECT c FROM Conversation c JOIN c.participants p WHERE p.id = :userId ORDER BY c.lastUpdated DESC")
    List<Conversation> findAllByParticipantId(@Param("userId") UUID userId);

    @Query("SELECT c FROM Conversation c JOIN c.participants p1 JOIN c.participants p2 WHERE p1.id = :user1Id AND p2.id = :user2Id")
    List<Conversation> findConversationsBetween(@Param("user1Id") UUID user1Id, @Param("user2Id") UUID user2Id);
}
