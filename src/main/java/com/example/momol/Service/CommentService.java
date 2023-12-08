package com.example.momol.Service;

import com.example.momol.DTO.CommentsVO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface CommentService {
    List<CommentsVO> getCommentsByBoardNum(int num);
    void addComment(CommentsVO comment);
}
