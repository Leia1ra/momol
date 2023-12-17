package com.example.momol.Config.Handler;

import lombok.Data;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

@Data
@RequiredArgsConstructor
public class ErrorResponse {
    private final HttpStatus status;
    private final String message;
}
