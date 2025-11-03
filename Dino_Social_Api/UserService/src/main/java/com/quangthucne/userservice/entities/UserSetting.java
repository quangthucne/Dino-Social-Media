package com.quangthucne.userservice.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.OffsetDateTime;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "user_settings")
public class UserSetting {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @ColumnDefault("gen_random_uuid()")
    @Column(name = "setting_id", nullable = false)
    private UUID id;

    @NotNull
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Size(max = 10)
    @ColumnDefault("'light'")
    @Column(name = "theme", length = 10)
    private String theme;

    @Size(max = 5)
    @ColumnDefault("'en'")
    @Column(name = "language", length = 5)
    private String language;

    @ColumnDefault("true")
    @Column(name = "notifications_enabled")
    private Boolean notificationsEnabled;

    @ColumnDefault("now()")
    @Column(name = "last_updated")
    private OffsetDateTime lastUpdated;

}