package com.quangthucne.userservice.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Value;

import java.io.Serializable;
import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * DTO for {@link com.quangthucne.userservice.entites.UserSetting}
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserSettingDTO {
    private UUID id;
    private String theme;
    private String language;
    private Boolean notificationsEnabled;
    private OffsetDateTime lastUpdated;
}