package com.example.momol.Service;

import com.example.momol.DAO.BoardDAO;
import com.example.momol.DTO.CommunityVO;
import com.example.momol.Mapper.CommunityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
    public int likePost(int num) {
        return dao.incrementLikes(num);
    }

    @Override
    public int updatePost(CommunityVO vo) {
        return dao.updatePost(vo);
    }

}