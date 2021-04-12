<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	// 로그인된 사람들만 볼 수 있음 -> 로그인 안되어 있으면 로그인창으로 감
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager == null || manager.getManagerLevel() < 1) {
	  response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
	  
	  return; // 끝내기.
	}

	// 수집 코드 구현
	request.setCharacterEncoding("UTF-8");
	String ebookISBN = request.getParameter("ebookISBN"); // mail은 문자
	System.out.println(ebookISBN + "<-- deleteEbookAction.jsp에서 ebookISBN"); // 디버깅 코드
		
		
	// dao삭제 매소드 호출 코드 구현
	EbookDao.deleteEbookOne(ebookISBN); // deleteManagerAction삭제 코드와 이름만 다르게
	
	// categoryList로 돌아가기
	response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");
%>
