<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	
	// 레벨이 1보다 작으면 권한 x -> adminIndex페이지로 돌아감
	Manager manager = (Manager) session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}	
	
	// 1. 수집 form에서 받은 2개 수집
	String categoryName = request.getParameter("categoryName");
	int categoryWeight = Integer.parseInt(request.getParameter("categoryWeight"));
	// 디버깅
	System.out.println(categoryName + "<-- categoryName"); // 디버깅
	System.out.println(categoryWeight + "<-- categoryWeight");
	
	//2.중복된 카테고리 생성 불가
		String returnCategoryName = CategoryDao.overlapCategory(categoryName);//categoryDao에 중복된지 확인 코드
		if(returnCategoryName != null){//카테고리 사용중
			System.out.println("사용중인 카테고리 입니다.");
			response.sendRedirect(request.getContextPath()+"/category/insertCategoryForm.jsp");
			return;
		}
		
	// 3. 삽입 매소드 출력
	CategoryDao.insertCategory(categoryName, categoryWeight); // 중복된 카테고리 없으면 생성
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>

	
</body>
</html>