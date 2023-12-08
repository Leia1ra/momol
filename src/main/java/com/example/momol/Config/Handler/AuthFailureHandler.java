package com.example.momol.Config.Handler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import java.io.IOException;
import java.util.Base64;
import java.util.Base64.Encoder;

public class AuthFailureHandler extends SimpleUrlAuthenticationFailureHandler {
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, org.springframework.security.core.AuthenticationException exception) throws IOException, ServletException {
        // HttpSession session = request.getSession();
        // session.setAttribute("loginErrMessage", exception.getMessage());
        // request.setAttribute("loginErrMsg", exception.getMessage());
        // setDefaultFailureUrl("/account/login");
        Encoder encoder = Base64.getEncoder();
        byte[] encodedErr = encoder.encode(exception.getMessage().getBytes());
        String errMsg = new String(encodedErr);
        // String errMsg = URLEncoder.encode(exception.getMessage(),"UTF-8");
        setDefaultFailureUrl("/account/login?error="+errMsg);

        // request.getRequestDispatcher("/account/login").forward(request, response);
        super.onAuthenticationFailure(request,response,exception);
    }
}
