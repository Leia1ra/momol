package com.example.momol.Service;

import com.example.momol.DTO.UserVO;
import com.example.momol.Mapper.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImple implements AdminService{

    @Autowired
    AdminMapper mapper;

    @Override
    public List<UserVO> user_list(UserVO in) {
        return mapper.user_list(in);
    }

    @Override
    public int user_delete(String id) {
        return mapper.user_delete(id);
    }

    @Override
    public int nick_edit(String usernick, String userid) {
        return mapper.nick_edit(usernick, userid);
    }
}
