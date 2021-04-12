<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 로그인된 사람들만 볼 수 있음 -> 로그인 안되어 있으면 로그인창으로 감
    Manager manager = (Manager)(session.getAttribute("sessionManager"));
   if(manager == null || manager.getManagerLevel() < 1) {
      response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
      
      return; // 끝내기.
   }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>UpdateEbookStateForm</title>
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
  <section id="hero" class="d-flex flex-column justify-content-center align-items-center">
    <div class="hero-container" data-aos="fade-in">
       <h1>EbookStore</h1>
      <p> <span class="typed" data-typed-items="List, Manager, Client, Category, Ebook, Orders, notice  "></span></p>
    </div>
  </section><!-- End Hero -->
  
	<%
		// 선언 및 초기화
		String[] ebookStateList = {"판매중","품절","절판","구판절판"};	
		String rowPerPage = request.getParameter("rowPerPage");
		
		Ebook ebook = new Ebook();
		String ebookISBN = request.getParameter("ebookISBN");
		String ebookState = request.getParameter("ebookState");
		ebook.setEbookISBN(ebookISBN);
		
		System.out.println("ebookISBN : " + ebookISBN); // ebookISBN 값 확인
		System.out.println("rowPerPage : " + rowPerPage); // rowPerPage 확인
		System.out.println("ebookState : " + ebookState);
	%>
	
	<main id="main">
	
	<section id="about" class="about">
      <div class="container">

        <div class="section-title">
          <h2>UpdateEbookStateForm</h2>
          <p></p>
        </div>
	
	<div>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?ebookISBN=<%=ebookISBN%>" class="btn btn-outline-primary btn-sm">Ebook홈</a>
	</div>
	<br>

	<form action="<%=request.getContextPath()%>/ebook/updateEbookStateAction.jsp" method="post">
		<input type="hidden" name = "ebookISBN" value="<%=ebookISBN%>" class="form-control">
		<input type="hidden" name = "rowPerPage" value="<%=rowPerPage%>" class="form-control">
		<table class="table-bordered table-sm">
			<tr>
				<td>EbookState</td>
				<td>
					<select name="ebookState">
						<option value="<%=ebookState%>">선택</option>
						<%
							for(String cn : ebookStateList){
						%>
								<option value="<%=cn%>"><%=cn%></option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
		</table>
		<br>
		<button type="submit" class="btn btn-outline-dark btn-sm">책 요약 수정</button>
		<a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=ebookISBN%>"><button type="button" class="btn btn-outline-dark btn-sm">취소</button></a>
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