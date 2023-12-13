package com.example.momol.Service;

import com.example.momol.DTO.CommunityVO;
import com.example.momol.Mapper.CommunityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommunityServiceImpl implements CommunityService {
    @Autowired
    CommunityMapper mapper;

    @Autowired
    private BoardDAO dao;

    @Override
    public int communityInsert(CommunityVO vo) {
        return mapper.communityInsert(vo);
    }

    @Override
    public CommunityVO getPostByNum(int num) {
        return mapper.getPostByNum(num);
    }

    @Override
    public int deletePost(int num) {
        // 게시글 삭제 로직
        return dao.deletePost(num);
    }

    @Override
    public int getLikes(int num) {
        return dao.getLikes(num);
    }

    @Override
    public int updateLikes(int num) {
        return dao.updateLikes(num);
    }
}
