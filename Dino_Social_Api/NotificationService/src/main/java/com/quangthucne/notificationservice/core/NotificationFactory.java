package com.quangthucne.notificationservice.core;

import com.quangthucne.notificationservice.dtos.NotificationRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class NotificationFactory {
    private final List<NotificationProvider> providers;

    public void excute(NotificationRequest request) {
        providers.stream()
                .filter(p -> p.supports(request.getType()))
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException("Provider not supported"))
                .send(request);
    }
}
