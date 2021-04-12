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

	// 수집코드
	request.setCharacterEncoding("UTF-8");
	String ebookState = request.getParameter("ebookState");
	String ebookISBN = request.getParameter("ebookISBN");
	
	//수집 된 값 디버깅
	System.out.println(ebookState + "<--updateEbookStateAction.jsp 에서 ebookState");
	System.out.println(ebookISBN + "<--updateEbookStateAction.jsp 에서 ebookISBN");

	
	// Ebook 객체 생성 및 전처리
	Ebook ebook = new Ebook();
	ebook.setEbookState(ebookState);
	ebook.setEbookISBN(ebookISBN);
	
	
	// Dao에서 수정 메서드 호출
	EbookDao.updateEbookState(ebook);
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN=" + ebookISBN);
%>