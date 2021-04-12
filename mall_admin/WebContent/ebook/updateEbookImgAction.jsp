<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<!-- 중복 x -->
<%
	// updateEbookImgAction
	
	//String ebookISBN = request.getParameter("ebookISBN");
	//String ebookImg = request.getParameter("ebookImg");
	//System.out.println(ebookISBN); // WHY NULL?
	//System.out.println(ebookImg); // ent멀티타입으로 넘겼기 때문에
	
	// 파일을 다운로드 받을 위치
	// 새로고침 바로 확인 가능하나 폴더에서는 확인 o
	// String path = applicateion.getRealPath("img"); 
	// 새로고침 바로 확인 가능하나 폴더에서는 확인 x
	                     // img라는 폴더의 os상의 실제 폴더
	String path = "D:/goode/web/mall_admin/WebContent/img"; //폴드 위치 지정, application->톰캣 , 문자로 받음
	System.out.println(path);
	
	// 사이즈
	int size = 1024 * 1024 * 1024; //1kbyte, 1Mbyte, 1Gbyte, 
	// 1000 * 60 * 60 * 24 (하루)
	
	// MultipartRequest라는 객체 만들기                   위임  ,  지정 되는곳 , 파일 크기(byte단위) ,인코딩(해석), 중복되어 있으면 정한 방법대로 정해짐 (메커니즘)
	MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy()); // MultipartRequest를 request로위임, 매개변수 5개로 넣어야함
	String ebookISBN = multi.getParameter("ebookISBN");
	String ebookImg = multi.getFilesystemName("ebookImg"); // 파일이라 다른이름
	System.out.println(ebookISBN);
	System.out.println(ebookImg);
	
	
	// 호출해야 하는 매소드
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
 	ebook.setEbookImg(ebookImg);		
	EbookDao.updateEbookImg(ebook);
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
%>
