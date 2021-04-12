<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	// deleteManagerAction
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if( manager == null) {	
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	// 수집 코드 구현
	request.setCharacterEncoding("UTF-8"); 
	int managerNo = Integer.parseInt(request.getParameter("managerNo")); // no는 int
	System.out.println(managerNo + "<-- managerNo"); // 디버깅 코드
	
	// dao 삭제 매소드 호출 코드 구현
	ManagerDao.deleteManager(managerNo); //updateManagerlevelAction과 똑같은 문장이 오지만
	                                          // ManagerDao.deleteManager(삭제할 no만 넣기)
	
	// managerList로 돌아가기
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp"); 
%>