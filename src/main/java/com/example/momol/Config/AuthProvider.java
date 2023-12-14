package com.example.momol.Config;

import com.example.momol.DTO.LoginFailureVO;
import com.example.momol.DTO.UserVO;
import com.example.momol.Service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Component
public class AuthProvider implements AuthenticationProvider {
    @Autowired
    private UserService service;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String Id = (String) authentication.getPrincipal();
        String Pw = (String) authentication.getCredentials();

        UserVO userVO = (UserVO) service.loadUserByUsername(Id);
        int failCount = service.loginFailureCount(Id);

        boolean locked;
        if(req.getSession().getAttribute("Locked") == null){
            locked = false;
        } else if((Boolean) req.getSession().getAttribute("Locked")) {
            locked = true;
        } else {
            locked = false;
        }
        System.out.println("Locked -> "+locked);

        if(userVO == null){
            throw new InternalAuthenticationServiceException("존재하지 않는 아이디 입니다.");
        } else if(!userVO.isEnabled()) {
            throw new DisabledException("비인증된 계정입니다.");
        } else if (failCount>=5 && !locked) {
            throw new LockedException("비밀번호 입력 오류 횟수가 5회 이상인 계정입니다.");
        } else if(!passwordEncoder.matches(Pw, userVO.getPw())){
            WebAuthenticationDetails authDetails = (WebAuthenticationDetails) authentication.getDetails();

            LoginFailureVO failureVO = new LoginFailureVO();
            failureVO.setUID(userVO.getUID());
            failureVO.setId(userVO.getId());
            failureVO.setIp(authDetails.getRemoteAddress());

            service.loginFailureData(failureVO);
            throw new BadCredentialsException("아이디 또는 비밀번호가 일치하지 않습니다.");
        } else {
            service.loginFailureDelete(userVO.getUID());
            return new UsernamePasswordAuthenticationToken(
                    userVO,true, userVO.getAuthorities()
            );
        }
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }
}
