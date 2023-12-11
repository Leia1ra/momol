package com.example.momol.Service;

import com.example.momol.DTO.UserVO;
import com.example.momol.Mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserMapper mapper;

    @Override
    public UserDetails loadUserByUsername(String Id) throws UsernameNotFoundException {
        return mapper.loadUserByUsername(Id);
    }
    @Override
    public List<UserVO> checkedExist(UserVO vo) {
        return mapper.checkedExist(vo);
    }
    @Override
    public int userInsert(UserVO vo) { return mapper.userInsert(vo); }
    @Override
    public String lastUID(int index, String UID) {
        return mapper.lastUID(index, UID);
    }
    @Override
    public int updateUID(String newUID, String currentUID) {
        return mapper.updateUID(newUID, currentUID);
    }
    @Override
    public UserVO findCheck(UserVO vo) {
        return mapper.findCheck(vo);
    }
    @Override
    public int passwordUpdate(String UID, String tmpPw) {
        return mapper.passwordUpdate(UID, tmpPw);
    }
    @Override
    public UserVO pwMatchByUID(String UID) {
        return mapper.pwMatchByUID(UID);
    }
    @Override
    public int pwUpdate(String UID, String newPw) {
        return mapper.pwUpdate(UID, newPw);
    }
}