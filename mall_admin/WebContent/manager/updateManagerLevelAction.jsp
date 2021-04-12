<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.ManagerDao" %>
<%
	// updateManagerLevelAction
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if( manager == null) {	
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	// 수집 코드 구현, no와 level은 int
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	int managerLevel = Integer.parseInt(request.getParameter("managerLevel"));
	System.out.println(managerNo + "<-- managerNo"); // managerNo 디버깅 코드 
	System.out.println(managerLevel + "<-- managerLevel"); // managerLevel 디버깅 코드
	
	// dao 수정 매소드 호출 코드 구현
	ManagerDao.updateManagerLevel(managerNo, managerLevel); // ManagerDao.updateManagerLevel(수정할 no,level넣기)
	
	// managerList로 돌아가기
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp"); 
%>