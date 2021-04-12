<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.Manager" %>
<%@ page import="gdu.mall.dao.ManagerDao" %>
<%
// 1. 요청 수집(전처리)
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	System.out.println(managerId+" <-- param managerId");
	System.out.println(managerPw+" <-- param managerPw");
	
	// 2. 처리	
	Manager manager = ManagerDao.login(managerId, managerPw);
	if(manager !=null) { // 만약 null값이 아니면
		System.out.println();
		session.setAttribute("sessionManager", manager);
	}
	
	// 3. 출력 or 재요청(redirect)
	response.sendRedirect(request.getContextPath()+"/adminIndex.jsp"); // 로그인 실패시 여기로 옴
%>