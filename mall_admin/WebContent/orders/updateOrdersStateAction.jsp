<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="gdu.mall.vo.*"%>
<%
	//관리자 인증 코드
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	// 입력했을 때 한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");
	
	//수집 ordersNo, ordersState +)beginRow, currentPage
	request.setCharacterEncoding("UTF-8");
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String ordersState = request.getParameter("ordersState");
		
	// 디버깅	
	System.out.println("ordersNo-> "+ordersNo);
	System.out.println("ordersState-> "+ordersState);
		
	//vo에 값 넣어주기
	Orders orders = new Orders();
	orders.setOrdersNo(ordersNo);
	orders.setOrdersState(ordersState);
	
	// Dao 호출
	OrdersDao.updateOrdersState(orders);
		
	// 공지 수정 후 해당 noticeOne으로 재요청
	response.sendRedirect(request.getContextPath()+"/orders/ordersList.jsp");
%>