package com.example.momol.Config;

import com.example.momol.Config.Handler.ErrorAccessDeniedHandler;
import com.example.momol.Config.Handler.AuthFailureHandler;
import com.example.momol.Config.Handler.AuthSuccessHandler;
import com.example.momol.Config.Handler.ErrorAuthenticationEntryPoint;
import com.example.momol.Config.Role.Role;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception{
        http.cors((httpSecurityCorsConfigurer) -> //Cross-Origin Resource Sharing
            // 추가 HTTP 헤더를 사용하여, 한 출처에서 실행 중인 웹 애플리케이션이
            // 다른 출처의 선택한 자원에 접근할 수 있는 권한을 부여하도록 브라우저에 알려주는 체제입니다.
            // 웹 앱은 리소스가 자신의 출처(도메인, 프로토콜, 포트)와 다를 때 교차 출처 HTTP 요청을 실행합니다.
            httpSecurityCorsConfigurer.disable()
        ).csrf((httpSecurityCsrfConfigurer)-> //Cross site Request forgery
            // CSRF 공격(Cross Site Request Forgery)은 웹 어플리케이션 취약점 중 하나로
            // 인터넷 사용자(희생자)가 자신의 의지와는 무관하게
            // 공격자가 의도한 행위(수정, 삭제, 등록 등)를 특정 웹사이트에 요청하게 만드는 공격입니다.
            httpSecurityCsrfConfigurer
                // .ignoringRequestMatchers(new AntPathRequestMatcher("/h2-console/**"))
                .disable()
        );
        http.headers((httpSecurityHeadersConfigurer) ->
            httpSecurityHeadersConfigurer.disable()
        );
        http.authorizeHttpRequests(authorize ->
            authorize
                .requestMatchers("/").permitAll()
                // .requestMatchers("/", "/account/login", "/community/**").permitAll()
                .requestMatchers("/general/**").hasRole(Role.GENERAL.name()) // ROLE_를 자동으로 붙임
                .requestMatchers("/mmypage/business","/mmypage/businessOk", "/mmypage/menuInsertOk", "/mmypage/menuDeleteOk","/mmypage/menuUpdate").hasRole(Role.BUSINESS.name())
                .requestMatchers("/admin/**").hasRole(Role.ADMIN.name())
                .anyRequest().permitAll()//.authenticated()
        );
        http.formLogin((httpSecurityFormLoginConfigurer) ->
            httpSecurityFormLoginConfigurer
                .loginPage("/account/login")
                .loginProcessingUrl("/account/loginOk")
                .usernameParameter("Id") // login 시 필요한 id 값을 Id로 설정 (default는 username)
                .passwordParameter("Pw") // password 값을 Pw로 설정 (default는 password)로 설정
                // .defaultSuccessUrl("/") // login 성공시 /로 redirect
                .successHandler(new AuthSuccessHandler())
                .failureHandler(new AuthFailureHandler())
        );

        http.logout((httpSecurityLogoutConfigurer) ->
            httpSecurityLogoutConfigurer
                .logoutUrl("/account/logout")
                .logoutSuccessUrl("/")
                .invalidateHttpSession(true)
        );

        http.exceptionHandling((handlingConfigurer)->
            handlingConfigurer
                    .accessDeniedHandler(new ErrorAccessDeniedHandler())
                    .authenticationEntryPoint(new ErrorAuthenticationEntryPoint())
                    // .accessDeniedPage("/err")
        );

        return http.build();
    }


    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }
}
