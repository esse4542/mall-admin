<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 로그인된 사람들만 볼 수 있음 -> 로그인 안되어 있으면 로그인창으로 감
    Manager manager = (Manager)(session.getAttribute("sessionManager"));
   if(manager == null || manager.getManagerLevel() < 1) {
      response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
      
      return; // 끝내기.
   }
   
	// 한글 깨지지 않게 인코딩
	request.setCharacterEncoding("UTF-8");


	
	// 수집코드
	String ebookISBN = request.getParameter("ebookISBN");
	String categoryName = request.getParameter("categoryName");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	String ebookSummary = request.getParameter("ebookSummary");
	String ebookState = request.getParameter("ebookState");
	
	
	// 받아온 값 디버깅
	System.out.println("ebookISBN : " + ebookISBN); 
	System.out.println("categoryName : " + categoryName);
	System.out.println("ebookTitle : " + ebookTitle); 
	System.out.println("ebookAuthor : " + ebookAuthor);
	System.out.println("ebookCompany : " + ebookCompany); 
	System.out.println("ebookPageCount : " + ebookPageCount); 
	System.out.println("ebookPrice : " + ebookPrice); 
	System.out.println("ebookAuthor : " + ebookSummary);
	System.out.println("ebookCompany : " + ebookState); 

	
	// Ebook 객체 생성 및 전처리
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setCategoryName(categoryName);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookSummary(ebookSummary);
	ebook.setEbookState(ebookState);
	
	
	// 2. Dao에서 수정 메서드 호출
	EbookDao.updateEbookOne(ebook);
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
%>