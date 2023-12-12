package com.example.momol.Mapper;

import com.example.momol.DTO.BusinessVO;
import com.example.momol.DTO.CommunityVO;
import com.example.momol.DTO.UserVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface InfoMapper {

    UserVO userSelectbyUID(String UID);

    void updateUser(UserVO updatedUser);

    BusinessVO businessSelectbyUID(String UID);

    List<CommunityVO> my_post(String UID);

}
