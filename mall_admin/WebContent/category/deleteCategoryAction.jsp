<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.util.*"%>
<%
	//세션확인후 레벨에 해당되지 않으면 adminIndex.jsp로
	// deleteManagerAction과 동일한 코드
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 멈춤
	}

	
	// 수집 코드 구현
	request.setCharacterEncoding("UTF-8");
	String categoryName = request.getParameter("categoryName"); // mail은 문자
	System.out.println(categoryName + "<-- deleteCategoryAction.jsp에서 categoryName"); // 디버깅 코드
	
	
	// dao삭제 매소드 호출 코드 구현
	CategoryDao.deleteCategory(categoryName); // deleteManagerAction삭제 코드와 이름만 다르게
	
	// categoryList로 돌아가기
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>