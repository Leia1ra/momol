package com.example.momol.Service;

import com.example.momol.DTO.CommunityVO;


public interface CommunityService {
    int communityInsert(CommunityVO vo);
    CommunityVO getPostByNum(int num);

    int deletePost(int num);

    int updateLikes(int num);

    int getLikes(int num);
}
