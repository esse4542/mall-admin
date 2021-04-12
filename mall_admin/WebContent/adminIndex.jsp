<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.sql.*" %>
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
        <img src="img/MJ_NAM.jpg" alt="" class="img-fluid rounded-circle">
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
      <button type="submit" class="mobile-nav-toggle d-xl-none"><i class="icofont-navigation-menu"></i></button>

    </div>
  </header><!-- End Header -->
  
  <!-- ======= Hero Section ======= -->
  <section id="hero" class="d-flex flex-column justify-content-center align-items-center">
  <main id="main">
    <img src="<%=request.getContextPath()%>/css/assets/img/beep.jpg" width="1000" height="700">
  </main>  
    <br>
    <div class="hero-container" data-aos="fade-in">
      <h1>EbookStore</h1>
      <p> <span class="typed" data-typed-items="List, Manager, Client, Category, Ebook, Orders, notice  "></span></p>
    </div>
  </section><!-- End Hero -->

  <main id="main">
  
   <!-- ======= About Section ======= -->
    <section id="about" class="about">
      <div class="container">

        <div class="section-title">
          <h2>AdminIndex</h2>
          <p></p>
        </div>
        
  
	<!-- 
		- 2가지 화면을 분기
		- 로그인 정보는 Manager자료형 세션변수(sessionManager)를 이용 ,      타입-> 매니저 타입
		1) 관리자 로그인 폼
		2) 관리자 인증 화면 & 몰 메인페이지
	 -->
<%
	if(session.getAttribute("sessionManager") == null ) {
%>

   
		<form action="<%=request.getContextPath()%>/manager/loginManagerAction.jsp" method="post"> 
			<table class="table-bordered table-sm">
				<tr>
					<td class="table-primary">ID</td>
					<td><input type="text" name="managerId" class="form-control"></td>
				</tr>
				
				<tr>
					<td class="table-primary">PW</td>
					<td><input type="password" name="managerPw" class="form-control"></td>
				</tr>
			</table>	
			 <br>
				<button type="submit" class="btn btn-outline-primary btn-sm">로그인</button>
				<a href="<%=request.getContextPath()%>/manager/insertManagerForm.jsp" type="submit" class="btn btn-outline-dark btn-sm">매니저 등록</a> <!-- 절대 주소 -->	
			
		</form>
		<br>
		<br>
	 <div class="section-title">
          <h2>승인대기 중인 매니저 목록</h2>
          <p></p>
     </div>	     
		<table class="table table-bordered table-sm">
			<thead>
				<tr class="thead-dark">
					<th>managerId</th>
					<th>managerDate</th>
				</tr>
			</thead>
			<tbody>
	 	
	
<% 		
			ArrayList<Manager> list = ManagerDao.selectManagerList();
			for(Manager m : list) {
%>		
				<tr>
					<td><%=m.getManagerId()%></td>
					<td><%=m.getManagerDate().substring(0,10)%></td>
				</tr>
<%			
		}
%>
			</tbody>
		</table>
<%			
	} else {
		Manager manager = (Manager)(session.getAttribute("sessionManager"));
%>
		
		<div>
			<%=manager.getManagerName()%>님 반갑습니다.
			레벨 : <%=manager.getManagerLevel()%>
		</div>
		
		
		<%
			ArrayList<Notice> noticeList = NoticeDao.selectNoticeListByPage(5, 0);
			//  ManagerDao.selectManagerListByZero(); 매소드 페이징 기능 추가
			ArrayList<Manager> managerList = ManagerDao.selectManagerListByPage(0, 5);
			ArrayList<Client> clientList = ClientDao.selectClientListByPage(5, 0, "");
			ArrayList<Ebook> ebookList = EbookDao.selectEbookListByPage(5, 0,""); // 이름 수정
			ArrayList<OrdersAndEbookAndClient> oecList = OrdersDao.selectOrdersListByPage(0, 5);
			
			
		%>
		</div>
		</section>
		
		
	<section id="services" class="services">
	  <div class="container">
		
		<div class="section-title">
		<h2>List</h2>
		</div>
		
	  <!-- 최근 가입한 관리자 5명 -->
	  <div class="row">
		<div class="col-lg-4 col-md-6 icon-box" data-aos="fade-up">
        <div class="icon"><i class="icofont-computer"></a></i></div>
			<h1 class="title">ManagerList<a href="<%=request.getContextPath()%>/manager/managerList.jsp"><button type="submit" class="btn btn-outline-light btn-sm"> more</button></a></h1>
			<p class="description">
			<table class="table table-bordered table-sm">
				<%
					for(Manager m : managerList) {
				%>
					<tr>
						<td class="table-primary"><%=m.getManagerId()%></td>
						<td><%=m.getManagerName()%></td>
					</tr>
				<%		
					}
				%>
			</table>
		</div>	
		
		<!-- 최근 가입한 고객 5명 -->
	   <div class="col-lg-4 col-md-6 icon-box" data-aos="fade-up">
        <div class="icon"><i class="icofont-computer"></a></i></div>
			<h1 class="title">ClientList<a href="<%=request.getContextPath()%>/client/clientList.jsp"><button type="submit" class="btn btn-outline-light btn-sm"> more</button></a></h1>
			<p class="description">
			<table class="table table-bordered table-sm">
					<%
						for(Client c : clientList) {
					%>
						<tr>
							<td class="table-primary"><%=c.getClientMail()%></td>
							<td><%=c.getClientDate().substring(0,10) %></td>
						</tr>
					<%		
						}
					%>
				</table>
		</div>		
		
		<!-- 최근 등록한 상품(ebook) 5개 -->
	   <div class="col-lg-4 col-md-6 icon-box" data-aos="fade-up">
        <div class="icon"><i class="icofont-computer"></a></i></div>
			<h1 class="title">EbookList<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp"><button type="submit" class="btn btn-outline-light btn-sm"> more</button></a></h1>
			<p class="description">
			<table class="table table-bordered table-sm">
					<%
						for(Ebook e : ebookList) {
					%>
						<tr>
							<td class="table-primary"><%=e.getEbookTitle()%></td>
							<td><%=e.getEbookPrice()%></td>
						</tr>
					<%		
						}
					%>
				</table>
		</div>		
				
		
	   <!-- 최근 주문한 주문 5개 -->
	   <div class="col-lg-4 col-md-6 icon-box" data-aos="fade-up">
        <div class="icon"><i class="icofont-computer"></a></i></div>
			<h1 class="title">OrdersList<a href="<%=request.getContextPath()%>/orders/ordersList.jsp"><button type="submit" class="btn btn-outline-light btn-sm"> more</button></a></h1>
			<p class="description">
			<table class="table table-bordered table-sm">
					<%
						for(OrdersAndEbookAndClient oec : oecList) {
					%>
						<tr>
							<td class="table-primary"><%=oec.getOrders().getOrdersNo()%></td>
							<td><%=oec.getEbook().getEbookTitle() %></td>
						</tr>
					<%		
						}
					%>
				</table>
			</div>	
			
				
		<!-- 최근 등록한 공지 5개 -->
	   <div class="col-lg-4 col-md-6 icon-box" data-aos="fade-up">
        <div class="icon"><i class="icofont-computer"></a></i></div>
			<h1 class="title">NoticeList<a href="<%=request.getContextPath()%>/notice/noticeList.jsp"><button type="submit" class="btn btn-outline-light btn-sm"> more</button></a></h1>
			<p class="description">
			<table class="table table-bordered table-sm">
				<%
					for(Notice n : noticeList) {
				%>
					<tr>
						<td class="table-primary"><%=n.getNoticeTitle()%></td>
						<td><%=n.getManagerId()%></td>
					</tr>
				<%		
					}
				%>
			</table>
			</p>		
		 
		
		 		
	<%		
		}
	%>				
	 
		</div>	
	</div>
    </section><!-- End Services Section -->
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