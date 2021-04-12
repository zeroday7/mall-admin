package gdu.mall.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import gdu.mall.util.DBUtil;
import gdu.mall.vo.Comment;

public class CommentDao {
	public static int selectCommentCnt(int noticeNo) throws Exception {
		int rowCnt = 0;
		String sql = "select count(*) cnt from comment where notice_no=?";
		//DB 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		System.out.println("selectCommentCnt " + stmt); // 디버깅
		ResultSet rs = stmt.executeQuery();		
		if(rs.next()) {
			rowCnt = rs.getInt("cnt");
		}
		System.out.println(rowCnt+" <---rowCnt");
		return rowCnt;
	}
	
	public static void insertComment(Comment comment) throws Exception {
		String sql = "INSERT INTO comment (notice_no, manager_id, comment_content, comment_date) VALUES (?, ?, ?, NOW())";
		
		//DB 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, comment.noticeNo);
		stmt.setString(2, comment.managerId);
		stmt.setString(3, comment.commentContent);
		System.out.println("insertComment " + stmt); // 디버깅
		
		stmt.executeUpdate();
	}
	
	public static ArrayList<Comment> selectCommentListByNoticeNo(int noticeNo) throws Exception {
		String sql = "select * from comment where notice_no=? order by comment_date desc";
		
		//DB 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, noticeNo);
		System.out.println("selectCommentListByNoticeNo " + stmt); // 디버깅
		
		ResultSet rs = stmt.executeQuery();
		ArrayList<Comment> list = new ArrayList<Comment>();
		
		while(rs.next()) {
			Comment c = new Comment();
			c.commentNo = rs.getInt("comment_no");
			c.noticeNo = rs.getInt("notice_no");
			c.managerId = rs.getString("manager_id");
			c.commentContent = rs.getString("comment_content");
			c.commentDate = rs.getString("comment_date");
			list.add(c);
		}
		return list;
	}
	
	// 관리자 레벨 2로 접근했을 경우 레벨2는 다 지울 수 있는 권한
	public static void deleteComment(int commentNo) throws Exception {
		String sql = "delete from comment where comment_no=?";
		
		//DB 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, commentNo);
		System.out.println("deleteComment " + stmt); // 디버깅
		
		stmt.executeUpdate();
	}
	
	// 관리자 레벨 1인경우 자기가 작성한 것만 지울 수 있다.
	public static void deleteComment(int commentNo, String managerId) throws Exception {
		String sql = "delete from comment where comment_no=? and manager_id=?";
		
		//DB 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, commentNo);
		stmt.setString(2, managerId);
		System.out.println("deleteComment " + stmt); // 디버깅
		
		stmt.executeUpdate();
	}
}