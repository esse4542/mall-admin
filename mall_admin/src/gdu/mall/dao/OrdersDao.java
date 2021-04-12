package gdu.mall.dao;

import java.sql.*;
import java.util.*;

import gdu.mall.util.*;
import gdu.mall.vo.*;

public class OrdersDao {
	// orders의 리스트 x --> orders join ebook join client 리스트o
	/*
	 * 	SELECT 
		o.orders_no ordersNo,
		o.ebook_no ebookNo,
		e.ebook_title ebookTitle,
		o.client_no clientNo,
		c.client_mail clientMail,
		o.orders_date ordersDate,
		o.orders_state ordersState
		FROM orders o INNER JOIN ebook e INNER JOIN client c
		ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no
		ORDER BY o.orders_no DESC
	 */
	
	// orders join ebook join client 리스트o
	public static ArrayList<OrdersAndEbookAndClient> selectOrdersListByPage(int rowPerPage, int beginRow) throws Exception {
		// SQL
		String sql = "SELECT o.orders_no ordersNo, o.ebook_no ebookNo, e.ebook_title ebookTitle, e.ebook_isbn ebookISBN, o.client_no clientNo, c.client_mail clientMail, o.orders_date ordersDate, o.orders_state ordersState FROM orders o INNER JOIN ebook e INNER JOIN client c ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no ORDER BY o.orders_no DESC limit ?,?";
		
		// 초기화
		ArrayList<OrdersAndEbookAndClient> list = new ArrayList<>();
		
		// DB연결 및 SQL실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, rowPerPage);
		stmt.setInt(2, beginRow);
		System.out.println("ordersList stmt-> "+stmt);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			OrdersAndEbookAndClient oec = new OrdersAndEbookAndClient();
			
			Orders o = new Orders();
			o.setOrdersNo(rs.getInt("ordersNo"));
			o.setEbookNo(rs.getInt("ebookNo"));
			o.setOrdersDate(rs.getString("ordersDate"));
			o.setOrdersState(rs.getString("ordersState")); 
			oec.setOrders(o);
			
			Ebook e = new Ebook();
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookISBN(rs.getString("ebookISBN"));
			oec.setEbook(e);
			
			Client c = new Client();
			o.setClientNo(rs.getInt("clientNo"));
			c.setClientMail(rs.getString("clientMail"));
			oec.setClient(c);
			
			list.add(oec);
		}
		// return
		return list;
	}			
	
	
	
	// 주문상태 수정
	public static void updateOrdersState(Orders orders) throws Exception {
		// SQL
		String sql = "UPDATE orders SET orders_state=? WHERE orders_no = ?";
		
		// DB연결 및 SQL실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, orders.getOrdersState());
		stmt.setInt(2, orders.getOrdersNo());
		System.out.println("updateOrdersState stmt-> "+stmt);
		
		stmt.executeQuery();
	}
	
	
	
	//totalRow 구하는 메소드, 전체 행의 수
	public static int totalCount() throws Exception {
		// SQL	
		String sql = "SELECT COUNT(*) cnt FROM orders";
		
		// 초기화
		int totalRow = 0;
		
		// DB연결 및 SQL실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("totalRow stmt-> "+stmt);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			totalRow = rs.getInt("cnt");
		}
		
		// return
		return totalRow;
	}
	
	
}