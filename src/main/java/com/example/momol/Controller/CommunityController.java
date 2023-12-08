package com.example.momol.Controller;

import com.example.momol.DAO.BoardDAO;
import com.example.momol.DTO.CommentsVO;
import com.example.momol.DTO.CommunityVO;
import com.example.momol.Service.CommentService;
import com.example.momol.Service.CommunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/community")
public class CommunityController {

    @Autowired
    CommunityService service;
    @Autowired
    CommentService commentService;

    @GetMapping("/wishlist")
    public String wishlist(Model model) {
        BoardDAO boardDAO = new BoardDAO();
        List<CommunityVO> boards = boardDAO.getAllBoards();

        model.addAttribute("boards", boards);
        return "Community/wishlist";
    }

    @GetMapping("/wishlist/{num}")
    public String wish_view(@PathVariable int num, Model model) {
        BoardDAO boardDAO = new BoardDAO();
        CommunityVO board = boardDAO.vo(num);

        // 조회수 업데이트
        boardDAO.viewUpdate(board.getViews() + 1, num);
        List<CommentsVO> commentList = commentService.getCommentsByBoardNum(num);

        model.addAttribute("board", board);
        model.addAttribute("comments", commentList);
        return "Community/post-view";
    }

    @GetMapping("/walls")
    public String walls(Model model) {
        BoardDAO boardDAO = new BoardDAO();
        List<CommunityVO> boards = boardDAO.getAllBoards();

        model.addAttribute("boards", boards);
        return "Community/walls";
    }

    @GetMapping("/walls/{num}")
    public String walls_view(@PathVariable int num, Model model) {
        BoardDAO boardDAO = new BoardDAO();
        CommunityVO board = boardDAO.vo(num);

        // 조회수 업데이트
        boardDAO.viewUpdate(board.getViews() + 1, num);
        List<CommentsVO> commentList = commentService.getCommentsByBoardNum(num);

        model.addAttribute("board", board);
        model.addAttribute("comments", commentList);
        return "Community/post-view";
    }



    @GetMapping("/dadaima")
    public String dadaima(Model model) {
        BoardDAO boardDAO = new BoardDAO();
        List<CommunityVO> boards = boardDAO.getAllBoards();

        model.addAttribute("boards", boards);
        return "Community/dadaima";
    }

    @GetMapping("/dadaima/{num}")
    public String dada_view(@PathVariable int num, Model model) {
        BoardDAO boardDAO = new BoardDAO();
        CommunityVO board = boardDAO.vo(num);

        // 조회수 업데이트
        boardDAO.viewUpdate(board.getViews() + 1, num);
        List<CommentsVO> commentList = commentService.getCommentsByBoardNum(num);

        model.addAttribute("board", board);
        model.addAttribute("comments", commentList);
        return "Community/post-view";
    }

    @GetMapping("/myrecipe")
    public String myrecipe(Model model) {
        BoardDAO boardDAO = new BoardDAO();
        List<CommunityVO> boards = boardDAO.getAllBoards();

        model.addAttribute("boards", boards);
        return "Community/myrecipe";
    }

    @GetMapping("/recommendme")
    public String recommendme(Model model) {
        BoardDAO boardDAO = new BoardDAO();
        List<CommunityVO> boards = boardDAO.getAllBoards();


        model.addAttribute("boards", boards);
        return "Community/recommendme";
    }

    @GetMapping("/recommendme/{num}")
    public String rcmd_view(@PathVariable int num, Model model) {
        BoardDAO boardDAO = new BoardDAO();
        CommunityVO board = boardDAO.vo(num);

        // 조회수 업데이트
        boardDAO.viewUpdate(board.getViews() + 1, num);
        List<CommentsVO> commentList = commentService.getCommentsByBoardNum(num);

        model.addAttribute("board", board);
        model.addAttribute("comments", commentList);
        return "Community/post-view";
    }

    @GetMapping("/writing")
    public String posting() {
        return "Community/posting";
    }


    @PostMapping("/posting")
    public String writePost(CommunityVO vo, RedirectAttributes redirectAttributes) {
        System.out.println(">" + vo.toString());
        int result = service.communityInsert(vo);

        // 리다이렉트 시에 데이터 전달
        redirectAttributes.addFlashAttribute("result", result);

        // 리다이렉트할 경로를 반환
        return "redirect:/"; // 리다이렉트할 경로를 적절하게 수정
    }


}
