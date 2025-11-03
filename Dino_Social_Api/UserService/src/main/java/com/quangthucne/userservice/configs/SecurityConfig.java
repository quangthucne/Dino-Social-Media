package com.quangthucne.userservice.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import com.quangthucne.userservice.middlewares.RequestsMiddleWare;
import com.quangthucne.userservice.security.CustomAuthenticationEntryPoint;
import com.quangthucne.userservice.security.CustomAccessDeniedHandler;
import com.quangthucne.userservice.security.CustomUserDetailsService; // Import CustomUserDetailsService

import java.util.Arrays;
import java.util.List;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final RequestsMiddleWare requestsMiddleWare;
    private final CustomAuthenticationEntryPoint customAuthenticationEntryPoint;
    private final CustomAccessDeniedHandler customAccessDeniedHandler;
    private final AuthenticationConfiguration authenticationConfiguration;
    private final CustomUserDetailsService customUserDetailsService; // Add CustomUserDetailsService field

    public SecurityConfig(RequestsMiddleWare requestsMiddleWare,
            CustomAuthenticationEntryPoint customAuthenticationEntryPoint,
            CustomAccessDeniedHandler customAccessDeniedHandler,
            AuthenticationConfiguration authenticationConfiguration,
            CustomUserDetailsService customUserDetailsService) { // Inject CustomUserDetailsService
        this.requestsMiddleWare = requestsMiddleWare;
        this.customAuthenticationEntryPoint = customAuthenticationEntryPoint;
        this.customAccessDeniedHandler = customAccessDeniedHandler;
        this.authenticationConfiguration = authenticationConfiguration;
        this.customUserDetailsService = customUserDetailsService; // Initialize CustomUserDetailsService
    }

    @Bean
    public AuthenticationManager authenticationManager() throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(customUserDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable()) // Vô hiệu hóa CSRF
                .cors(cors -> cors.configurationSource(corsConfigurationSource())) // Cấu hình CORS
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)) // Stateless
                                                                                                              // session
                                                                                                              // for JWT
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/sa/**").hasAuthority("Quản trị")
                        .requestMatchers("/staff/**").hasAnyAuthority("Quản trị", "Nhân viên")
                        .requestMatchers("/user/**").hasAnyAuthority("Quản trị", "Người dùng")
                        .requestMatchers(
                                "/api/ws/**", // Cho phép truy cập WebSocket/SockJS không cần auth
                                "/ws/**", // Hỗ trợ các endpoint WebSocket khác
                                "/topic/**", // Các topic public
                                "/app/**", // Các destination prefix
                                "/auth/**" // Cho phép truy cập các endpoint xác thực mà không cần auth
                        ).permitAll()
                        .anyRequest().permitAll() // Cho phép tất cả các yêu cầu khác (có thể thắt chặt sau)
                )
                .exceptionHandling(ex -> ex
                        .authenticationEntryPoint(customAuthenticationEntryPoint)
                        .accessDeniedHandler(customAccessDeniedHandler))
                .addFilterBefore(requestsMiddleWare, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(List.of("*")); // Cho phép tất cả các origin, có thể cần cụ thể hơn trong
                                                       // production
        configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(List.of("Authorization", "Cache-Control", "Content-Type"));
        configuration.setAllowCredentials(true);
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}
