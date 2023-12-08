package com.example.momol.DTO;

import com.example.momol.Config.Role.Role;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Data @NoArgsConstructor @AllArgsConstructor
public class UserVO implements UserDetails {
    private String UID;

    private String Id;
    private String Pw;
    private String Nick;

    private String Name;
    private String email;
    private String Birth;
    private String Phone;
    private String gender;

    private String JoinDate;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        if(this.UID != null){
            String type = this.UID.substring(0, this.UID.indexOf("_"));
            List<GrantedAuthority> authorities = new ArrayList<>();
            if(type.equals("GENE")){
                authorities.add(new SimpleGrantedAuthority(Role.GENERAL.getKey()));
            } else if(type.equals("BUSI")){
                authorities.add(new SimpleGrantedAuthority(Role.GENERAL.getKey()));
                authorities.add(new SimpleGrantedAuthority(Role.BUSINESS.getKey()));
            } else if(type.equals("ADMIN")) {
                authorities.add(new SimpleGrantedAuthority(Role.GENERAL.getKey()));
                authorities.add(new SimpleGrantedAuthority(Role.BUSINESS.getKey()));
                authorities.add(new SimpleGrantedAuthority(Role.ADMIN.getKey()));
            } else {
                return null;
            }
            return authorities;
        } else {
            return null;
        }
    }

    @Override
    public String getPassword() {
        return this.Pw;
    }

    @Override
    public String getUsername() {
        return this.Id;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
