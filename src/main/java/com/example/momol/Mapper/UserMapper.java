package com.example.momol.Mapper;

import com.example.momol.DTO.UserVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {

    UserVO userSelect(UserVO vo);
}
