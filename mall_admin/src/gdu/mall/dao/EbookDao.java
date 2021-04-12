package gdu.mall.dao;

import java.sql.*;
import java.util.*;

import gdu.mall.util.*;
import gdu.mall.vo.*;
public class EbookDao {
	
	// 삭제 매소드
	public static void deleteEbookOne(String ebookISBN) throws Exception { 
			// sql
			String sql = "delete from ebook where ebook_isbn = ?";
				
			// db연결 , SQL 실행
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- stmt 디버깅"); // sql문 디버깅
			stmt.setString(1, ebookISBN); 
			
			stmt.executeUpdate();
	}
		
		
		
		
		
	// Summary 수정 매소드
	public static void updateEbookSummary(Ebook ebook) throws Exception {
			// sql
			String sql = "UPDATE ebook SET ebook_summary = ? where ebook_isbn = ?";
			
			// db연결 , SQL 실행 
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- updateEbookSummary 디버깅"); // sql문 디버깅
			stmt.setString(1, ebook.getEbookSummary());
			stmt.setString(2, ebook.getEbookISBN());
			
			stmt.executeUpdate();
	}
	
		
		
		
		
	// 이미지 수정 매소드
	public static int updateEbookImg(Ebook ebook) throws Exception {
			// sql
			String sql = "UPDATE ebook SET ebook_img = ? where ebook_isbn = ?";
			
			// 초기화
			int rowCnt = 0;
				
			// db연결 , SQL 실행 
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- updateEbookImg 디버깅"); // sql문 디버깅
			stmt.setString(1, ebook.getEbookImg());
			stmt.setString(2, ebook.getEbookISBN());
			rowCnt = stmt.executeUpdate();
			
			// 리턴
			return rowCnt;
	}
	
		
		
	
	// ebookOne 보기 매소드
    public static Ebook selectEbookOne(String ebookISBN) throws Exception {
       /*
        * select ebook_isbn, category_name, ebook_title, ebook_author,
        * ebook_company, ebook_page_count, ebook_price, ebook_img, ebook_summary, 
        * ebook_date, ebook_state FROM ebook WHERE ebook_isbn = ?";
        */
       
       //sql문
       String sql = "SELECT ebook_no, ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_img, ebook_summary, ebook_date, ebook_state FROM ebook WHERE ebook_isbn = ?";
       
       // 초기화
       Ebook ebook = null;
       
       // db 연결, SQL 실행
       Connection conn = DBUtil.getConnection();
       PreparedStatement stmt = conn.prepareStatement(sql);
       System.out.println(stmt + "<-- stmt 디버깅"); //  디버깅
       stmt.setString(1, ebookISBN);
       ResultSet rs = stmt.executeQuery();
          
       while(rs.next()) {
          ebook = new Ebook();
          ebook.setEbookNo(rs.getInt("ebook_no"));
          ebook.setEbookISBN(rs.getString("ebook_isbn"));
          ebook.setCategoryName(rs.getString("category_name"));
          ebook.setEbookTitle(rs.getString("ebook_title"));
          ebook.setEbookAuthor(rs.getString("ebook_author"));
          ebook.setEbookCompany(rs.getString("ebook_company"));
          ebook.setEbookPageCount(rs.getInt("ebook_page_count"));
          ebook.setEbookPrice(rs.getInt("ebook_price"));
          ebook.setEbookImg(rs.getString("ebook_img"));
          ebook.setEbookSummary(rs.getString("ebook_summary"));
          ebook.setEbookDate(rs.getString("ebook_date"));
          ebook.setEbookState(rs.getString("ebook_state"));
          }
          
       // 4. 리턴
       return ebook;   
    }
	
	
	// 입력 매소드
	public static int insertEbook(Ebook ebook) throws Exception {
		//sql문
		String sql = "INSERT INTO ebook(ebook_isbn,category_name,ebook_title,ebook_author,ebook_company,ebook_page_count,ebook_price,ebook_summary,ebook_img,ebook_date,ebook_state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'default.jpg', NOW(), '판매중')";
		
		// 초기화
		int rowCnt = 0;
		
		// db 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookISBN());
		stmt.setString(2, ebook.getCategoryName());
		stmt.setString(3, ebook.getEbookTitle());
		stmt.setString(4, ebook.getEbookAuthor());
		stmt.setString(5, ebook.getEbookCompany());
		stmt.setInt(6, ebook.getEbookPageCount());
		stmt.setInt(7, ebook.getEbookPrice());
		stmt.setString(8, ebook.getEbookSummary());
		rowCnt = stmt.executeUpdate();
		
		// 리턴
		return rowCnt;
	}

	
	
	
	
	// 전체 행의 수  , 총 row 개수 매소드
	public static int totalCount() throws Exception {
		//sql문
		String sql = "SELECT COUNT(*) cnt FROM ebook";
		
		// 초기화
		int total = 0;
		
		// db 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("totalCount sql: " + stmt);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) { //데이터 값이 존재한다면 총 개수를 입력해준다.
			total = rs.getInt("cnt");
		}
		
		// 리턴
		return total; // 총 데이터 개수 반환
	}
	
	
	
		
	// 전체 목록 메소드 (전체 목록에서 desc사용하기)
	public static ArrayList<Ebook> selectEbookListByPage(int rowPerPage, int beginRow, String categoryName) throws Exception {
			
		// 리턴값 초기화
		ArrayList<Ebook> list = new ArrayList<>();
		
		// DB 핸들링
		Connection conn = DBUtil.getConnection();
		 PreparedStatement stmt = null;
		
		// 쿼리 작성
		String sql = "";
		
		if(categoryName.equals("")) { // 만약 카테고리를 누르지 않았다면
	         sql = "select category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice from ebook order by ebook_date desc limit ?,?";
	         stmt = conn.prepareStatement(sql);
	         System.out.println(stmt + " <-- stmt 디버깅"); // sql문 실행 디버깅
	         stmt.setInt(1, beginRow);
	         stmt.setInt(2, rowPerPage);
	      } else { // 원하는 카테고리를 눌렀을 경우
	         sql = "select category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice from ebook where category_name = ? order by ebook_date desc limit ?,?";
	         stmt = conn.prepareStatement(sql);
	         System.out.println(stmt + " <-- stmt 디버깅"); // sql문 실행 디버깅
	         stmt.setString(1, categoryName);
	         stmt.setInt(2, beginRow);
	         stmt.setInt(3, rowPerPage);
	      }

		
		/*
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println(stmt + "<-- EbookDao selectEbookListByPage의 stmt");
		*/
		
		ResultSet rs = stmt.executeQuery();
		
		
			while (rs.next()) {
				Ebook e = new Ebook();
				e.setCategoryName(rs.getString("categoryName"));
				e.setEbookISBN(rs.getString("ebookISBN"));
				e.setEbookTitle(rs.getString("ebookTitle"));
				e.setEbookAuthor(rs.getString("ebookAuthor"));
				e.setEbookDate(rs.getString("ebookDate"));
				e.setEbookPrice(rs.getInt("ebookPrice"));
				list.add(e);
		}
		
		// 4. 결과값 리턴
		return list;
	}
	
	
	
	// isbn 중복 체크 , isbn 받아오는 매소드
	public static String selectEbookISBN(String ebookISBN) throws Exception {
		/*
		 * select ebook_isbn from ebook where ebook_isbn = ?
		 */
		//sql문
		String sql = "select ebook_isbn from ebook where ebook_isbn = ?";
		
		// 초기화
		String returnEbookISBN = "";
		
		// db연결 , sql 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN); // 중복만 체크하는거니깐 isbn만
		System.out.println(stmt + " <-- stmt 디버깅"); // sql문 디버깅
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			returnEbookISBN = rs.getString("ebook_isbn");
		}
		
		// return
		return returnEbookISBN;
		
	}			
	
	
	
	
	// state 업데이트 메서드
	public static void updateEbookState(Ebook ebook) throws Exception {
			// sql문
			String sql = "UPDATE ebook SET ebook_state = ? where ebook_isbn = ?";
			
			// db연결 , sql 실행
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- updateEbookImg 디버깅"); // sql문 디버깅
			stmt.setString(1, ebook.getEbookState());
			stmt.setString(2, ebook.getEbookISBN()); // isbn
			
			stmt.executeUpdate();
		}
	
	
	
	
		
	// bookOne 업데이트 메서드
	public static void updateEbookOne(Ebook ebook) throws Exception {
			// sql문
			String sql = "UPDATE ebook SET category_Name = ?, ebook_title = ?, ebook_author = ?, ebook_company = ?, ebook_page_count = ?, ebook_price = ? where ebook_isbn = ?";
			
			// db연결 , sql 실행
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- updateEbookImg 디버깅"); // sql문 디버깅
			stmt.setString(1, ebook.getCategoryName());
			stmt.setString(2, ebook.getEbookTitle());
			stmt.setString(3, ebook.getEbookAuthor());
			stmt.setString(4, ebook.getEbookCompany());
			stmt.setInt(5, ebook.getEbookPageCount());
			stmt.setInt(6, ebook.getEbookPrice());
			stmt.setString(7, ebook.getEbookISBN());
			
			stmt.executeUpdate();
		}
}