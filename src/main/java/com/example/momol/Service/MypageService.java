package com.example.momol.Service;

import com.example.momol.DTO.CommunityVO;
import com.example.momol.DTO.UserVO;

import java.util.List;

public interface MypageService {
    UserVO userSelectbyUID(String UID);

    void updateUser(UserVO updatedUser);
    List<CommunityVO> my_post(String UID);
}