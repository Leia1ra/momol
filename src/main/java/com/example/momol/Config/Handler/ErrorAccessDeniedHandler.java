package com.example.momol.Config.Handler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Component;

import java.beans.Encoder;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;

@Component
public class ErrorAccessDeniedHandler implements AccessDeniedHandler {
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
        String message = new String("지정한 리소스에 대한 액세스가 금지되었습니다.");
        Base64.Encoder e = Base64.getEncoder();
        ErrorResponse fail = new ErrorResponse(HttpStatus.FORBIDDEN, new String(e.encode(message.getBytes())));

        response.setStatus(HttpStatus.FORBIDDEN.value());
        response.sendRedirect("/err?status="+fail.getStatus()+"&message="+fail.getMessage());
        request.setAttribute("errResponse", fail);
    }
}
