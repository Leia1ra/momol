package com.example.momol.Service;

import com.example.momol.DTO.BusinessVO;
import com.example.momol.DTO.CommunityVO;
import com.example.momol.DTO.UserVO;
import com.example.momol.Mapper.InfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InfoServiceImpl implements MypageService, BusinessService {

    @Autowired
    InfoMapper mapper;

    @Override
    public UserVO userSelectbyUID(String UID) {
        return mapper.userSelectbyUID(UID);
    }

    @Override
    public int updateUser(UserVO updatedUser) {
        return mapper.updateUser(updatedUser);
    }

    @Override
    public List<CommunityVO> my_post(String UID) {
        return mapper.my_post(UID);
    }

    @Override
    public BusinessVO businessSelectbyUID(String UID) {
        return mapper.businessSelectbyUID(UID);
    }
}