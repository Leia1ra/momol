package com.example.momol.Mapper;

import com.example.momol.DTO.UserVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {

    UserVO loadUserByUsername(String Id);

    List<UserVO> checkedExist(UserVO vo);

    int userInsert(UserVO vo);

    String lastUID(int index, String UID);
    int updateUID(String newUID, String currentUID);

}
