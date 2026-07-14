package com.quangthucne.notificationservice.core;

import com.quangthucne.notificationservice.dtos.NotificationRequest;
import com.quangthucne.notificationservice.dtos.NotificationType;

public interface NotificationProvider {
    void send(NotificationRequest request);
    boolean supports(NotificationType type);
}
