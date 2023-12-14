package com.example.momol.Service;

import com.example.momol.DTO.LoginFailureVO;
import com.example.momol.DTO.UserVO;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

public interface UserService extends UserDetailsService {
    UserDetails loadUserByUsername(String Id);
    List<UserVO> checkedExist(UserVO vo);

    int userInsert(UserVO vo);

    String lastUID(int index, String UID);

    int updateUID(String newUID, String currentUID);

    UserVO findCheck(UserVO vo);

    int passwordUpdate(String UID, String tmpPw);

    UserVO pwMatchByUID(String UID);

    int pwUpdate(String UID, String newPw);

    int loginFailureData(LoginFailureVO fvo);

    int loginFailureCount(String Id);

    int loginFailureDelete(String UID);
}