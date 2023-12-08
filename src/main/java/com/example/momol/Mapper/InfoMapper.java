package com.example.momol.Mapper;

import com.example.momol.DTO.BusinessVO;
import com.example.momol.DTO.UserVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface InfoMapper {

    UserVO userSelectbyUID(String UID);

    void updateUser(UserVO updatedUser);

    BusinessVO businessSelectbyUID(String UID);

}
