package com.example.momol.Service;

import com.example.momol.DAO.CommentsDAO;
import com.example.momol.DTO.CommentsVO;
import com.example.momol.Mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {
    private final CommentMapper commentMapper;
    private final CommentsDAO commentsDAO;

    @Autowired
    public CommentServiceImpl(CommentMapper commentMapper, CommentsDAO commentsDAO) {
        this.commentMapper = commentMapper;
        this.commentsDAO = commentsDAO;
    }

    @Override
    public List<CommentsVO> getCommentsByBoardNum(int num) {
        return commentMapper.getCommentsbyBoardNum(num);
    }

    @Override
    public void addComment(CommentsVO comment) {
        commentMapper.addComment(comment);
    }

    @Override
    public void deleteComment(int UID) {
        commentMapper.deleteComment(UID);
    }

    @Override
    public int increaseLikes(int UID) {
        return commentsDAO.increaseLikes(UID);
    }
}