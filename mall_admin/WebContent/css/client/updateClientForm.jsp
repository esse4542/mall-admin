<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.util.*"%>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 끝내야함
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateClientForm</title>
</head>
<body>
	<%
	String clientMail= request.getParameter("clientMail");
	%>
	
	<!-- 관리자화면 메뉴 -->
	<div>
		<a href="<%=request.getContextPath()%>/adminIndex.jsp">운영자 홈</a>
		<a href="<%=request.getContextPath()%>/manager/managerList.jsp">운영자 관리</a>
		<a href="<%=request.getContextPath()%>/client/clientList.jsp">고객 관리</a>
	</div>
	<h2>updateClientForm</h2>
	
	<form action="<%=request.getContextPath()%>/client/updateClientAction.jsp" method="post">
		<table border="1">
			<thead>
				<tr>
					<th>clientMail</th>
					<th>clientPw</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td><%=clientMail%></td>
					<td>
						<input type="hidden" name="clientMail" placeholder="변경할 비밀번호 입력" value="<%=clientMail%>">
						<input type="password" name="clientPw">
					</td>
				</tr>
			</tbody>
		</table>
		<button type="submit">비밀번호 수정</button>
	</form>	
</body>
</html>