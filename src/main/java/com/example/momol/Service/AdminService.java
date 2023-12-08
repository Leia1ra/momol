package com.example.momol.Service;

import com.example.momol.DTO.UserVO;

import java.util.List;

public interface AdminService {

    List<UserVO> user_list(UserVO in);
    int user_delete(String id);

}
