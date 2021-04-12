<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%
	// 관리자 인증 코드
	
	
	// 로그인된 사람들만 볼 수 있음 -> 로그인 안되어 있으면 로그인창으로 감
    Manager manager = (Manager)(session.getAttribute("sessionManager"));
   if(manager == null || manager.getManagerLevel() < 1) {
      response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
      
      return; // 끝내기.
   }

	
	// 1 수집코드
	request.setCharacterEncoding("UTF-8");
	
	String ebookISBN = request.getParameter("ebookISBN");
	String categoryName = request.getParameter("categoryName");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	String ebookSummary = request.getParameter("ebookSummary");	
	
	// 디버깅 확인
	System.out.println("ebookISBN: "+ebookISBN);
	System.out.println("categoryName: "+categoryName);
	System.out.println("ebookTitle: "+ebookTitle);
	System.out.println("ebookAuthor: "+ebookAuthor);
	System.out.println("ebookCompany: "+ebookCompany);
	System.out.println("ebookPageCount: "+ebookPageCount);
	System.out.println("ebookPrice: "+ebookPrice);
	System.out.println("ebookSummary: "+ebookSummary);
	

	
	// 2 중복된 ISBN이 있는지 확인 -> 중복되어 있다면 다시 insertEbookForm 사이트로 돌아감
	String returnEbookISBN = EbookDao.selectEbookISBN(ebookISBN); //dao에서 했던 중복확인
	System.out.println(returnEbookISBN + " <-- returnEbookISBN"); // 디버깅
	if(returnEbookISBN != "") { // ISBN이 존재한다면
		System.out.println("사용중인 ISBN 입니다");
		response.sendRedirect(request.getContextPath()+"/ebook/insertEbookForm.jsp");
		return;
	}

	// 전처리
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setCategoryName(categoryName);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookSummary(ebookSummary);
		
	// dao에서 ebookList 매소드 호출
	EbookDao.insertEbook(ebook);
	response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp?ebookISBN="+ebookISBN);
%>
