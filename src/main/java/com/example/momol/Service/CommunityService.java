package com.example.momol.Service;

import com.example.momol.DTO.CommunityVO;

import java.util.List;


public interface CommunityService {

    int communityInsert(CommunityVO vo);
    CommunityVO getPostByNum(int num);

    int deletePost(int num);
    int likePost(int num);

    int updatePost(CommunityVO vo);
}
