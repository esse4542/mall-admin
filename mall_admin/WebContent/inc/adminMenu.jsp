<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
	<a href="<%=request.getContextPath()%>/adminIndex.jsp">[홈]</a>
	<a href="<%=request.getContextPath()%>/manager/managerList.jsp">[운영자 관리</a>
	<a href="<%=request.getContextPath()%>/client/clientList.jsp">[고객관리]</a>
	<a href="<%=request.getContextPath()%>/category/categoryList.jsp">[상품 카테고리 관리]</a>
	<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">[ebook 관리]</a>
	<a href="<%=request.getContextPath()%>/orders/ordersList.jsp">[주문 관리]</a>
	<!-- R(list, one)-레벨 1이상, CUD-레벨 2이상 -->
	<a href="<%=request.getContextPath()%>/notice/noticeList.jsp">[공지 관리]</a>
	<a href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp">[로그아웃]</a>
</div>