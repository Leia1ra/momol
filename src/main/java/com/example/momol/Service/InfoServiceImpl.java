package com.example.momol.Service;

import com.example.momol.DTO.BusinessVO;
import com.example.momol.DTO.UserVO;
import com.example.momol.Mapper.InfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class InfoServiceImpl implements MypageService, BusinessService {

    @Autowired
    InfoMapper mapper;

    @Override
    public UserVO userSelectbyUID(String UID) {
        return mapper.userSelectbyUID(UID);
    }

    @Override
    public void updateUser(UserVO updatedUser) {
        System.out.println("UpdateUser method is called."); // 디버그 로그 추가
        mapper.updateUser(updatedUser);
    }

    @Override
    public BusinessVO businessSelectbyUID(String UID) {
        return mapper.businessSelectbyUID(UID);
    }
}