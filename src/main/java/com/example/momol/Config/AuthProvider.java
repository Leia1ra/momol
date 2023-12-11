package com.example.momol.Config;

import com.example.momol.Config.Role.Role;
import com.example.momol.DTO.UserVO;
import com.example.momol.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.stereotype.Component;


@Component
public class AuthProvider /*extends UsernamePasswordAuthenticationFilter*/ implements AuthenticationProvider {
    @Autowired
    private UserService service;

    @Autowired
    private PasswordEncoder passwordEncoder;
    /*public AuthProvider(AuthenticationManager authenticationManager){
        super.setAuthenticationManager(authenticationManager);
    }*/

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String Id = (String) authentication.getPrincipal();
        String Pw = (String) authentication.getCredentials();

        UserVO userVO = (UserVO) service.loadUserByUsername(Id);
        String type;
        if(userVO != null) type = userVO.getUID().substring(0, userVO.getUID().indexOf("_"));
        else throw new BadCredentialsException("존재하지 않는 아이디 입니다.");

        if(type.equals("Tmp")) throw new BadCredentialsException("비인증된 계정입니다.");
        else if(!passwordEncoder.matches(Pw, userVO.getPw())){
            throw new BadCredentialsException("아이디 또는 비밀번호가 일치하지 않습니다.");
        } else {
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
