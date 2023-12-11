package com.example.momol.Service;

import com.example.momol.DTO.UserVO;
import com.example.momol.Mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService{
    @Autowired
    UserMapper mapper;

    @Override
    public UserVO userSelect(UserVO vo) {
        return mapper.userSelect(vo);
    }
}
