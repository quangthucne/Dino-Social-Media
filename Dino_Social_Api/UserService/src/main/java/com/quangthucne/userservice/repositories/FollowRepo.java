package com.quangthucne.userservice.repositories;

import com.quangthucne.userservice.entities.Follow;
import com.quangthucne.userservice.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface FollowRepo extends JpaRepository<Follow, UUID> {
    boolean existsByFollowerAndFollowing(User follower, User following);

    Optional<Follow> findByFollowerAndFollowing(User follower, User following);

    long countByFollower(User follower);

    long countByFollowing(User following);

    List<Follow> findByFollower(User follower);

    List<Follow> findByFollowing(User following);
}
