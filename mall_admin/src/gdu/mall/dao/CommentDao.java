package gdu.mall.dao;
import gdu.mall.util.*;
import gdu.mall.vo.*;

import java.sql.*;
import java.util.*;

public class CommentDao {
	
	// deleteNotiecAction
	public static int selectCommentCnt(int noticeNo) throws Exception {
		int rowCnt = 0;
		String sql = "SELECT count(*) cnt FROM comment WHERE notice_no=?";
		// DB연결 및 SQL실행
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		System.out.println("selectCommentCnt " + stmt); // 디버깅
		   ResultSet rs = stmt.executeQuery();      
		      if(rs.next()) {
		         rowCnt = rs.getInt("cnt");
		      }
		      System.out.println(rowCnt);
		      return rowCnt;
		   }
	
	
	// 댓글 입력 매소드
	public static void insertComment(Comment comment) throws Exception {
		// SQL
		String sql="INSERT INTO comment(notice_no,manager_id,comment_content,comment_date) VALUES(?,?,?,NOW())";
		
		// DB연결 및 SQL실행
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, comment.getNoticeNo());
		stmt.setString(2, comment.getManagerId());
		stmt.setString(3, comment.getCommentContent());
		System.out.println("comment입력 stmt-> "+stmt);
		
		stmt.executeUpdate();
	}
	
	
	
	// 댓글 가져오기 
	public static ArrayList<Comment> selectCommentListByNoticeNo(int noticeNo) throws Exception {
		// select * from comment where notice_no=? 
		// SQL
		String sql = "SELECT comment_no commentNo, notice_no noticeNo, manager_id managerId, comment_content commentContent, comment_date commentDate FROM comment WHERE notice_no=? ORDER BY comment_no ASC";
		// 배열 변수 초기화
		ArrayList<Comment> list = new ArrayList<Comment>();
		
		// DB연결 및 SQL실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		System.out.println("commentList stmt-> "+stmt);
		ResultSet rs = stmt.executeQuery();
		
		// 가져온 데이터 담기(?)
		while(rs.next()) {
			Comment temp = new Comment();
			temp.setCommentContent(rs.getString("commentContent"));
			temp.setCommentDate(rs.getString("commentDate"));
			temp.setCommentNo(rs.getInt("commentNo"));
			temp.setManagerId(rs.getString("managerId")) ;
			temp.setNoticeNo(rs.getInt("noticeNo"));
			list.add(temp);
		}
		
		// return
		return list;
	}
	
	
	
	// 삭제 매소드
	// 매개변수가 다르면 동일한 이름의 매소드를 만들 수 있음 , deleteComment 매소드 오버로딩
	public static void deleteComment(int commentNo) throws Exception { // commentNo, managerId
		// 쿼리 = delete from comment where comment_no=?
		// 쿼리 = delete from comment where comment_no=? and manager_id = ?
		// SQL
		String sql = "DELETE FROM comment WHERE comment_no=?";
		
		// DB연결 및 SQL실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		System.out.println("comment삭제 stmt-> "+stmt);
		
		stmt.executeUpdate();
	}
	
			
	
	// 삭제 매소드
	public static void deleteComment(int commentNo, String managerId) throws Exception { // commentNo, managerId
		// 쿼리 = delete from comment where comment_no=?
		// 쿼리 = delete from comment where comment_no=? and manager_id = ?
		// SQL
		String sql = "DELETE FROM comment WHERE comment_no=? and manager_id=?";
		
		// DB연결 및 SQL실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		stmt.setString(2, managerId);
		System.out.println("comment삭제 stmt-> "+stmt);
		
		stmt.executeUpdate();

	}
}
