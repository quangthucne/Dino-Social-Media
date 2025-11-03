package com.quangthucne.userservice.repositories;

import com.quangthucne.userservice.entities.User;


import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepo extends JpaRepository<User, Long> {

    @Query("SELECT u FROM User u WHERE u.username = ?1 or u.email = ?1 or CAST(u.id AS string) = ?1 ")
    Optional<User> findByIndentifier(String indentifier);

    boolean existsByUsername(String username);

    boolean existsByEmail(String email);

}
