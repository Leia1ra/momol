package com.example.momol.Config.Handler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import java.io.IOException;
import java.util.Base64;
import java.util.Base64.Encoder;


public class AuthFailureHandler extends SimpleUrlAuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        HttpSession session = request.getSession();

        /* 에러 인코딩*/
        Encoder encoder = Base64.getEncoder();
        byte[] encodedErr = encoder.encode(exception.getMessage().getBytes());
        String errMsg = new String(encodedErr);
        /* 로그인 실패 */
        if(exception instanceof LockedException){
            session.setAttribute("Locked", true);
        }
        // session.invalidate();

        setDefaultFailureUrl("/account/login?error="+errMsg);
        super.onAuthenticationFailure(request,response,exception);
    }
}
