<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	// 입력했을 때 한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");
	
	// 수집 (commentNo, managerId, commentConent)
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String managerId = request.getParameter("managerId");
	String commentContent = request.getParameter("commentContent");
	
	// 디버깅
	System.out.println(noticeNo+"<-- InsertCommentAction의 managerId");
	System.out.println(managerId+"<-- InsertCommentAction의 noticeTitle");
	System.out.println(commentContent+"<-- InsertCommentAction의 noticeContent");
	
	// 데이터 전처리
	Comment comment = new Comment();
	comment.setNoticeNo(noticeNo);
	comment.setManagerId(managerId);
	comment.setCommentContent(commentContent);
	
	// Dao 호출
	CommentDao.insertComment(comment);
	
	// 댓글 추가 후 재요청
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);

%>
