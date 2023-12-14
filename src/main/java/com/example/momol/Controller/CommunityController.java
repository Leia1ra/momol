package com.example.momol.Controller;

import com.example.momol.DAO.BoardDAO;
import com.example.momol.DTO.CommentsVO;
import com.example.momol.DTO.CommunityVO;
import com.example.momol.Service.CommentService;
import com.example.momol.Service.CommunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

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

    @GetMapping("/myrecipe/{num}")
    public String myrcp_view(@PathVariable int num, Model model) {
        BoardDAO boardDAO = new BoardDAO();
        CommunityVO board = boardDAO.vo(num);

        // 조회수 업데이트
        boardDAO.viewUpdate(board.getViews() + 1, num);
        List<CommentsVO> commentList = commentService.getCommentsByBoardNum(num);

        model.addAttribute("board", board);
        model.addAttribute("comments", commentList);
        return "Community/post-view";
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


    @PostMapping("/imgs/upload")
    @ResponseBody
    public ResponseEntity<String> handleFileUpload(@RequestParam("upload") MultipartFile file) {
        try {
            // 업로드할 디렉토리 설정
            String uploadDir = "src/main/resources/static/community/imgs/upload";
            Path uploadPath = Path.of(uploadDir).toAbsolutePath().normalize();

            // 디렉토리가 없으면 생성
            Files.createDirectories(uploadPath);

            // 파일명 생성 (여기서는 간단히 현재 시간을 사용)
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();

            // 파일 저장 경로 설정
            Path targetPath = uploadPath.resolve(fileName);

            // 파일 복사
            Files.copy(file.getInputStream(), targetPath, StandardCopyOption.REPLACE_EXISTING);

            // 파일 업로드 성공 시 파일 URL 반환
            String fileUrl = "/community/imgs/upload/" + fileName;
            return ResponseEntity.ok(fileUrl);
        } catch (IOException e) {
            e.printStackTrace();
            // 파일 업로드 실패 시 오류 메시지 반환
            return ResponseEntity.status(500).body("파일 업로드 실패");
        }
    }

    @PostMapping("/posting")
    public String writePost(
            CommunityVO vo,
            @RequestPart(value = "file", required = false) MultipartFile file,
            RedirectAttributes redirectAttributes) {
        System.out.println(">" + vo.toString());

        int result = service.communityInsert(vo);
        redirectAttributes.addFlashAttribute("result", result);

        return "redirect:/";
    }

    @GetMapping("/delete/{num}")
    public String deletePost(@PathVariable int num, RedirectAttributes redirectAttributes) {
        int result = service.deletePost(num);

        if (result > 0) {
            redirectAttributes.addFlashAttribute("message", "게시글이 삭제되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("message", "게시글 삭제에 실패했습니다.");
        }

        return "redirect:/community/walls";
    }

    @PostMapping("/walls/{num}/like")
    @ResponseBody
    public ResponseEntity<Integer> likePost(@PathVariable int num) {
        // 게시글 번호를 이용하여 좋아요 수를 증가시키는 로직을 구현
        int updatedLikes = service.likePost(num);
        return ResponseEntity.ok(updatedLikes);
    }

    @GetMapping("/edit/{num}")
    public String editPost(@PathVariable int num, Model model) {
        BoardDAO boardDAO = new BoardDAO();
        CommunityVO board = boardDAO.vo(num);

        model.addAttribute("board", board);
        return "Community/edit";
    }

    @PostMapping("/edit/{num}")
    public String updatePost(@PathVariable int num, @ModelAttribute CommunityVO vo, RedirectAttributes redirectAttributes) {
        int result = service.updatePost(vo);

        if (result > 0) {
            redirectAttributes.addFlashAttribute("message", "게시글이 수정되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("message", "게시글 수정에 실패했습니다.");
        }

        return "redirect:/community/walls/" + num;
    }


}
