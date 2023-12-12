package com.example.momol.Service;

import com.example.momol.DTO.CommunityVO;
import com.example.momol.Mapper.CommunityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommunityServiceImpl implements CommunityService {
    @Autowired
    CommunityMapper mapper;

    @Override
    public int communityInsert(CommunityVO vo) {
        return mapper.communityInsert(vo);
    }

    @Override
    public CommunityVO getPostByNum(int num) {
        return mapper.getPostByNum(num);
    }

}
