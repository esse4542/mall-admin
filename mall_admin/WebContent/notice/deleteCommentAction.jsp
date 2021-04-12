<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
	
	// 입력했을 때 한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");
	
	// 수집 (commentNo, managerId, noticeNo)
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String managerId = request.getParameter("managerId");
		
	// 디버깅
	System.out.println(commentNo+"<-- deleteCommentAction의 commentNo");
	System.out.println(noticeNo+"<-- deleteCommentAction의 noticeNo");
	System.out.println(managerId+"<-- deleteCommentAction의 managerId");
		
	
	// 매소드 실행 
	if(manager.getManagerLevel() > 1) { //manager.managerLevel == 2, 관리자면 그냥 삭제 가능
		// dao 호출
		CommentDao.deleteComment(commentNo);
	} else if(manager.getManagerLevel() > 0) { // manager.managerLevel == 0, 일반관리자일때 자신의 코멘트인지 확인필요
		// dao 호출	
		CommentDao.deleteComment(commentNo, managerId); 
	}
	
	
	//재실행
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
%>