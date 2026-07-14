package com.quangthucne.notificationservice.providers;

import com.quangthucne.notificationservice.core.NotificationProvider;
import com.quangthucne.notificationservice.dtos.NotificationRequest;
import com.quangthucne.notificationservice.dtos.NotificationType;
import com.quangthucne.notificationservice.services.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
public class EmailProviders implements NotificationProvider {
    @Autowired
    private EmailService emailService;

    @Async("notificationExecutor")
    @Override
    public void send(NotificationRequest request) {
        emailService.send(request);
    }

    @Override
    public boolean supports(NotificationType type) {
        return false;
    }
}
