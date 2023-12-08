package com.example.momol.Service;

import com.example.momol.DTO.UserVO;

public interface MypageService {
    UserVO userSelectbyUID(String UID);

    void updateUser(UserVO updatedUser);
}