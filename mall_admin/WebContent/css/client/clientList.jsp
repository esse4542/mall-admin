<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@page import="java.util.*"%>
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
<meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>AdminIndex</title>
  <meta content="" name="description">
  <meta content="" name="keywords">
  <!-- Favicons -->
  <link href="<%=request.getContextPath()%>/css/assets/img/favicon.png" rel="icon">
  <link href="<%=request.getContextPath()%>/css/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="<%=request.getContextPath()%>/css/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/css/assets/vendor/icofont/icofont.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/css/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/css/assets/vendor/venobox/venobox.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/css/assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/css/assets/vendor/aos/aos.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="<%=request.getContextPath()%>/css/assets/css/style.css" rel="stylesheet">
</head>
<body>
<!-- ======= 모바일 탐색 토글 버튼 ======= -->
  <button type="button" class="mobile-nav-toggle d-xl-none"><i class="icofont-navigation-menu"></i></button>

  <!-- ======= Header ======= -->
  <header id="header">
    <div class="d-flex flex-column">

      <div class="profile">
        <img src="<%=request.getContextPath()%>/img/MJ_NAM.jpg" alt="" class="img-fluid rounded-circle">
        <h1 class="text-light"><a href="<%=request.getContextPath()%>/adminIndex.jsp">MJ_NAM</a></h1>
        <div class="social-links mt-3 text-center">
      </div>
      </div>

      <nav class="nav-menu">
        <ul>
          <li class="active"><a href="<%=request.getContextPath()%>/adminIndex.jsp"><i class="bx bx-home"></i> <span>Home</span></a></li>
          <li><a href="#about"><i class="bx bx-user"></i> <span>About</span></a></li>
          <li><a href="<%=request.getContextPath()%>/manager/managerList.jsp"><i class="bx bx-file-blank"></i> <span>운영자 관리</span></a></li>
          <li><a href="<%=request.getContextPath()%>/client/clientList.jsp"><i class="bx bx-book-content"></i> 고객관리</a></li>
          <li><a href="<%=request.getContextPath()%>/category/categoryList.jsp"><i class="bx bx-server"></i> 상품카테고리 관리</a></li>
          <li><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp"><i class="bx bx-envelope"></i> Ebook 관리</a></li>
          <li><a href="<%=request.getContextPath()%>/orders/ordersList.jsp"><i class="bx bx-book-content"></i> 주문 관리</a></li>
          <li><a href="<%=request.getContextPath()%>/notice/noticeList.jsp"><i class="bx bx-server"></i> 공지관리</a></li>
          <li><a href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp"><i class="bx bx-envelope"></i>Logout</a></li>
          

        </ul>
      </nav><!-- 탐색 메뉴 -->
      <button type="button" class="mobile-nav-toggle d-xl-none"><i class="icofont-navigation-menu"></i></button>

    </div>
  </header><!-- End Header -->


 <!-- ======= Hero Section ======= -->
  <section id="" class="d-flex flex-column justify-content-center align-items-center">
    <div class="hero-container" data-aos="fade-in">
      <h1>Mall_Admin</h1>
      <p> <span class="typed" data-typed-items="Hello, List, product, "></span></p>
    </div>
  </section><!-- End Hero -->

  <main id="main">
  
	<section id="about" class="about">
      <div class="container">

        <div class="section-title">
          <h2>clientList</h2>
          <p></p>
        </div>
	
	<%
		// 현재 페이지를 바꿔준다.
		int currentPage = 10; // 10행 보여준다.
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		// 페이지당 행의 수를 바꿔준다.
		int rowPerPage = 10; // 10행을 보여준다.
		if(request.getParameter("rowPerPage") != null) {
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		
		String searchWord = "";
		if(request.getParameter("searchWord") != null) {
			searchWord = request.getParameter("searchWord");
		}	
		
		// 시작행
		int beginRow = (currentPage -1) * rowPerPage;
		
		// 전체 데이터의 개수
		int totalRow = ClientDao.totalCount(searchWord); 
		System.out.println(totalRow); // totalRow를 받아오는지 디버깅
		
		// 리스트 생성
		ArrayList<Client> list = ClientDao.selectClientListByPage(rowPerPage, beginRow, searchWord);
	%>
	
	<form action="<%=request.getContextPath()%>/client/clientList.jsp" method="post">
		<input type="hidden" name="searchWord" value="<%=searchWord%>">
		<select name="rowPerPage">
			<%
				for(int i=10; i<=30; i+=5) { // i는 5씩 커진다
					if(rowPerPage == i) {
			%>
						<option value="<%=i%>" selected="selected"><%=i%></option>
			<%		
					} else {
			%>
						<option value="<%=i%>"><%=i%></option>
			<%			
					}
				}
			%>
		</select>
		<button type="submit">보기</button>
	</form>
	
	<table border="1">
		<thead>
			<tr>
				<th>clientMail</th>
				<th>clientDate</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		
		<tbody>
			<%						   // c라는 객체를 만들고
				for(Client c : list) { // c객체 안의 변수에 list를 넣는 과정
			%>
					<tr>
						<td><%=c.getClientMail() %></td>
						<td><%=c.getClientDate().substring(0,11)%></td> <!-- .substring(0,11)를 넣으면 시분초빼고 년월일 나옴 -->
						<td><a href="<%=request.getContextPath()%>/client/updateClientForm.jsp?clientMail=<%=c.getClientMail()%>"><button type="submit">수정</button></a></td>
						<td><a href="<%=request.getContextPath()%>/client/deleteClientAction.jsp?clientMail=<%=c.getClientMail()%>"><button type="submit">삭제</button></a></td>
					</tr>
			<%		
				}
			%>	
		</tbody>
	</table>
	<%
		if(currentPage > 1) { // currentPage가 1보다 작을때
			
	%>      <!-- list.jsp가 폴더 안에 있을땐 폴더명도 같이 작성  -->
			<a role="button" href="<%=request.getContextPath()%>/client/clientList.jsp?cyrrentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">이전</a>
	<%			
		}
	
		int lastPage = totalRow / rowPerPage; // 마지막 페이지
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		System.out.println("lastPage : " + lastPage); // 디버깅
		
		if(currentPage < lastPage) { // currentPage가 1보다 클때
	%>
			<a role="button" href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">다음</a>
	<% 		
		}
	%>
	<form action="<%=request.getContextPath()%>/client/clientList.jsp" method="post">
		<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
		<div>
			clientMail :
			<input type="text" name="searchWord">
			<button type="submit">검색</button>
		</div>
	</form>
	</div>
	</section>
	</main>
	
	<!-- Vendor JS Files -->
  <script src="<%=request.getContextPath()%>/css/assets/vendor/jquery/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/css/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="<%=request.getContextPath()%>/css/assets/vendor/jquery.easing/jquery.easing.min.js"></script>
  <script src="<%=request.getContextPath()%>/css/assets/vendor/php-email-form/validate.js"></script>
  <script src="<%=request.getContextPath()%>/css/assets/vendor/waypoints/jquery.waypoints.min.js"></script>
  <script src="<%=request.getContextPath()%>/css/assets/vendor/counterup/counterup.min.js"></script>
  <script src="<%=request.getContextPath()%>/css/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="<%=request.getContextPath()%>/css/assets/vendor/venobox/venobox.min.js"></script>
  <script src="<%=request.getContextPath()%>/css/assets/vendor/owl.carousel/owl.carousel.min.js"></script>
  <script src="<%=request.getContextPath()%>/css/assets/vendor/typed.js/typed.min.js"></script>
  <script src="<%=request.getContextPath()%>/css/assets/vendor/aos/aos.js"></script>

  <!-- Template Main JS File -->
  <script src="<%=request.getContextPath()%>/css/assets/js/main.js"></script>
	
</body>
</html>