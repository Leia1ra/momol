package com.example.momol.DAO;

import com.example.momol.DTO.CommunityVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Component
public class BoardDAO {
    private Connection conn;
    private ResultSet rs;
    @Autowired
    private JdbcTemplate jdbcTemplate;
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/momol";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "tiger1234";

    public List<CommunityVO> getAllBoards() {
        List<CommunityVO> boards = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery("SELECT * FROM board ORDER BY num DESC ")) {

            while (resultSet.next()) {
                CommunityVO vo = new CommunityVO();
                vo.setNum(resultSet.getInt("num"));
                vo.setCatnum(resultSet.getInt("catnum"));
                vo.setUID(resultSet.getString("UID"));
                vo.setTitle(resultSet.getString("title"));
                vo.setWritetime(resultSet.getDate("writetime"));
                vo.setContent(resultSet.getString("content"));
                vo.setLikes(resultSet.getInt("likes"));
                vo.setViews(resultSet.getInt("views"));
                vo.setDeleted(resultSet.getBoolean("deleted"));
                vo = vo(resultSet.getInt("num"));

                boards.add(vo);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return boards;
    }

    public CommunityVO vo(int num) {
        String SQL = "SELECT * from board where num = ?";

        try {
            conn = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                CommunityVO vo = new CommunityVO();
                vo.setNum(rs.getInt("num"));
                vo.setCatnum(rs.getInt("catnum"));
                vo.setUID(rs.getString("UID"));
                vo.setTitle(rs.getString("title"));
                vo.setWritetime(rs.getDate("writetime"));
                vo.setContent(rs.getString("content"));
                vo.setLikes(rs.getInt("likes"));
                vo.setViews(rs.getInt("views"));
                vo.setDeleted(rs.getBoolean("deleted"));
                return vo;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public int viewUpdate(int views, int num) {
        String SQL = "update board set views = ? where num = ?";
        try {
            conn = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, views);
            pstmt.setInt(2, num);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int deletePost(int num) {
        String SQL = "DELETE FROM board WHERE num = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(SQL)) {

            pstmt.setInt(1, num);
            return pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }

    public int getLikes(int num) {
        String SQL = "SELECT likes FROM board WHERE num = ?";
        return jdbcTemplate.queryForObject(SQL, Integer.class, num);
    }

    public int updateLikes(int num) {
        String SQL = "UPDATE board SET likes = ? WHERE num = ?";
        return jdbcTemplate.update(SQL, num);
    }
}

