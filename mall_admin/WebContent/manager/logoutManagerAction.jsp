<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// managerLogout
	session.invalidate(); //session을 재요청 , 기존의 세션을 초기화(로그인 정보도 사라지게 된다 -> 로그아웃)
	response.sendRedirect(request.getContextPath()+"/adminIndex.jsp"); //로그아웃 기능
%>