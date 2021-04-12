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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>OrdersList</title>
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
          <li><a href="<%=request.getContextPath()%>/adminIndex.jsp"><i class="bx bx-home"></i> <span>Home</span></a></li>
          <li><a href="#about"><i class="bx bx-user"></i> <span>About</span></a></li>
          <li><a href="<%=request.getContextPath()%>/manager/managerList.jsp"><i class="bx bx-file-blank"></i> <span>운영자 관리</span></a></li>
          <li><a href="<%=request.getContextPath()%>/client/clientList.jsp"><i class="bx bx-book-content"></i> 고객관리</a></li>
          <li><a href="<%=request.getContextPath()%>/category/categoryList.jsp"><i class="bx bx-server"></i> 상품카테고리 관리</a></li>
          <li><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp"><i class="bx bx-envelope"></i> Ebook 관리</a></li>
          <li class="active"><a href="<%=request.getContextPath()%>/orders/ordersList.jsp"><i class="bx bx-book-content"></i> 주문 관리</a></li>
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
       <h1>EbookStore</h1>
      <p> <span class="typed" data-typed-items="List, Manager, Client, Category, Ebook, Orders, notice  "></span></p>
    </div>
  </section><!-- End Hero -->

  <main id="main">
  
	<section id="about" class="about">
      <div class="container">

        <div class="section-title">
          <h2>OrderList</h2>
          <p></p>
        </div>

	
	<!-- rowPerPage별 페이징 -->
	<%
		// 현재 페이지
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage")); // 받아온 값 정수로 변환
		}
		
		// 페이지 당 행의 수
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage") != null) {
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage")); // 받아온 값 정수로 변환
		}
		
		// 시작 행
		int beginRow = (currentPage - 1) * rowPerPage;
		
		// 전체 행의 개수
		int totalRow = OrdersDao.totalCount();
		System.out.println(totalRow+"<-- OrdersDao의 totalRow"); // 디버깅
		
		// list 생성	
		ArrayList<OrdersAndEbookAndClient> list = OrdersDao.selectOrdersListByPage(beginRow, rowPerPage);
		
		
	%>
	 <!-- 한 페이지당 몇 개씩 볼건지 선택하는 기능 -->
      <form action="<%=request.getContextPath()%>/orders/ordersList.jsp" method="post">
         <select name="rowPerPage">
            <%
               for(int i=10; i<31; i+=5) {
                  if(rowPerPage == i) {
            %>
                  <!-- 옵션에서 선택한 개수만큼의 행이 보이게 함 -->
                  <option value=<%=i%> selected="selected"><%=i%></option> 
            <%
                  } else {
            %>
                  <!-- 옵션 선택이 되어 있지 않으면 rowPerPage 설정 값으로 보이게 함 -->
                  <option value=<%=i%>><%=i%></option>
            <%   
                  }
               }
            %>
         </select>
         <button type="submit" class="btn btn-light btn-sm">보기</button>
      </form>
	  <br>	
	<!-- 공지 목록 테이블 -->
	<table class="table table-bordered table-sm">
		<thead>
			<tr class="table-primary">
				<th>ordersNo</th>
				<th>ebookNo</th>
				<th>clientNo</th>
				<th>ebookTitle</th>
				<th>clientMail</th>
				<th>ordersDate</th>
				<th>ordersState</th>
			</tr>
		</thead>
		
		<tbody>
			<%
				for(OrdersAndEbookAndClient oec : list) { // for each문
			%>
				<tr>
					<td><%=oec.getOrders().getOrdersNo()%></td>
					<td><%=oec.getOrders().getEbookNo()%></td>
					<td><%=oec.getOrders().getClientNo()%></td>
					<td><a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=oec.getEbook().getEbookISBN()%>"><%=oec.getEbook().getEbookTitle() %></a></td>
					<td><%=oec.getClient().getClientMail()%></td>
					<td><%=oec.getOrders().getOrdersDate().substring(0,10)%></td>
					<td>
						<form action="<%=request.getContextPath()%>/orders/updateOrdersStateAction.jsp?" method="post">
							<input type="hidden" name="ordersNo" value="<%=oec.getOrders().getOrdersNo()%>">
								<select name="ordersState">
									<%
									 String[] state = {"주문완료","주문취소"};
										for(String s : state){
											if(s.equals(oec.getOrders().getOrdersState())){
									%>
												<option value="<%=s%>" selected="selected"><%=s%></option>
									<%
											} else {
									%>
												<option value="<%=s%>"><%=s%></option>
									<%
											}
												
										}
									%>
								</select>
								<br>
								<button type="submit" class="btn btn-light btn-sm">수정</button>	
						</form>	
					</td>
				</tr>
				
			<%
				}
			%>			
		</tbody>	
	</table>
	
	<!-- 페이징(이전,다음) 만들기 -->
	<% 
		// 맨 첫 페이지에서 이전 버튼이 나오지 않게 함
		if(currentPage != 1) {
	%>
				<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>" class="btn btn-outline-dark btn-sm">이전</a>
	<%
		}
	%>
		<%-- // 맨 마지막 페이지에서 다음 버튼이 보이지 않도록 함
		int lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1; // lastPage = lastPage+1; lastPage++;
		} --%>
	<%	
		// 맨 마지막 페이지에서 다음 버튼이 보이지 않도록 함
		if(currentPage < (OrdersDao.totalCount()/rowPerPage) + 1){ //나머지 부분도 출력하기 위한 +1
	%>
				<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>" class="btn btn-outline-dark btn-sm">다음</a>
	<%
		}
	%>
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