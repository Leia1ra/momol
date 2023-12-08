package com.example.momol.Service;

import com.example.momol.DTO.UserVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminService {

    List<UserVO> user_list(UserVO in);
    int user_delete(String id);

    // int nick_edit(String usernick, String userid);
    int nick_edit(@Param("usernick") String usernick, @Param("userid") String userid);

}
