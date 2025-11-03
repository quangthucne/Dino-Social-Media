package com.quangthucne.common.status;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.http.HttpStatus;


@AllArgsConstructor
public enum ResponseStatus {
    // 2xx Thành công
    SUCCESS(HttpStatus.OK, "Thành công"),
    CREATED(HttpStatus.CREATED, "Tạo mới thành công"),

    // 4xx Lỗi Client
    BAD_REQUEST(HttpStatus.BAD_REQUEST, "Yêu cầu không hợp lệ"),
    UNAUTHORIZED(HttpStatus.UNAUTHORIZED, "Chưa xác thực"),
    FORBIDDEN(HttpStatus.FORBIDDEN, "Không có quyền truy cập"),
    NOT_FOUND(HttpStatus.NOT_FOUND, "Không tìm thấy tài nguyên"),

    // 5xx Lỗi Server
    INTERNAL_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "Lỗi hệ thống");

    private final HttpStatus httpStatus;
    private final String defaultMessage;

    public int getCode() {
        return this.httpStatus.value();
    }

    public String getName() {
        return this.name(); // .name() là phương thức có sẵn của Enum
    }

    public HttpStatus getHttpStatus() {
        return this.httpStatus;
    }

    public String getDefaultMessage() {
        return this.defaultMessage;
    }
}
