<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%
	// 로그인된 사람들만 볼 수 있음 -> 로그인 안되어 있으면 로그인창으로 감
    Manager manager = (Manager)(session.getAttribute("sessionManager"));
   if(manager == null || manager.getManagerLevel() < 1) {
      response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
      
      return; // 끝내기.
   }
%>

<%
	// 한글 깨지지 않게 인코딩
	request.setCharacterEncoding("UTF-8");
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookSummary = request.getParameter("ebookSummary");

  /*
 	// 수집 코드
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookSummary = request.getParameter("ebookSummary");
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
  */	
	//값 디버깅
	System.out.println(ebookISBN + "<--- updateEbookSummaryAction.java에서 ebookISBN");
	System.out.println(ebookSummary + "<--- updateEbookSummaryAction.java에서 ebookSummary");
	
	// 전처리 ebook.ebook~ 으로 시작하기
	Ebook ebook = new Ebook(); // 객체 선언
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookSummary(ebookSummary);
	
	
	// Dao에서 update 메서드 호출
 	EbookDao.updateEbookSummary(ebook);
 	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
%>