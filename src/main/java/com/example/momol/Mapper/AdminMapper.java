package com.example.momol.Mapper;

import com.example.momol.DTO.UserVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AdminMapper {
    List<UserVO> user_list(UserVO in);
    int user_delete(String id);
    int nick_edit(String usernick, String userid);

}
