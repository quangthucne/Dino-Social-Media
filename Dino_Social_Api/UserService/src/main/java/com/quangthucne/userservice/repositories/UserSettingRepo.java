package com.quangthucne.userservice.repositories;

import com.quangthucne.userservice.entities.UserSetting;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserSettingRepo extends JpaRepository<UserSetting, Long> {
}
