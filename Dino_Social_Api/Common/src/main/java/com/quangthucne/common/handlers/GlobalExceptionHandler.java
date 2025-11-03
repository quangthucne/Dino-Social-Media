package com.quangthucne.common.handlers;

import com.quangthucne.common.exceptions.BadRequestException;
import com.quangthucne.common.exceptions.ResourceNotFoundException;
import com.quangthucne.common.responses.Response;
import com.quangthucne.common.status.ResponseStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import java.util.Map;
import org.springframework.web.bind.MethodArgumentNotValidException;
import java.util.HashMap;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<Response> handleResourceNotFoundException(ResourceNotFoundException ex, WebRequest request) {
        Response response = new Response();
        response.setStatus(com.quangthucne.common.status.ResponseStatus.NOT_FOUND.getCode());
        response.setMessage(com.quangthucne.common.status.ResponseStatus.NOT_FOUND.getDefaultMessage());
        response.setData(null);
        return ResponseEntity.badRequest().body(response);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<Response> handleAllUncaughtException(Exception ex, WebRequest request) {
        Response response = new Response();
        response.setStatus(com.quangthucne.common.status.ResponseStatus.INTERNAL_SERVER_ERROR.getCode());
        response.setMessage(com.quangthucne.common.status.ResponseStatus.INTERNAL_SERVER_ERROR.getDefaultMessage());
        response.setData(ex.getMessage());
        return ResponseEntity.badRequest().body(response);
    }

    @ExceptionHandler(BadRequestException.class)
    public ResponseEntity<Response> handleBadRequestException(BadRequestException ex, WebRequest request) {
        Response response = new Response();
        response.setStatus(com.quangthucne.common.status.ResponseStatus.BAD_REQUEST.getCode());
        response.setMessage(com.quangthucne.common.status.ResponseStatus.BAD_REQUEST.getDefaultMessage());
        response.setData(ex.getMessage());
        return ResponseEntity.badRequest().body(response);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Response> handleValidationErrors(MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getFieldErrors().forEach(error ->
                errors.put(error.getField(), error.getDefaultMessage())
        );

        Response response = new Response();
        response.setStatus(ResponseStatus.BAD_REQUEST.getCode());
        response.setMessage("Validation failed");
        response.setData(errors);
        return ResponseEntity.badRequest().body(response);
    }
}
