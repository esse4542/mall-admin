<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*"%>
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

  <title>EbookList</title>
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
          <li class="active"><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp"><i class="bx bx-envelope"></i> Ebook 관리</a></li>
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
       <h1>EbookStore</h1>
      <p> <span class="typed" data-typed-items="List, Manager, Client, Category, Ebook, Orders, notice  "></span></p>
    </div>
  </section><!-- End Hero -->
  

  <main id="main">
  
	<section id="about" class="about">
      <div class="container">

        <div class="section-title">
          <h2>EbookList</h2>
          <p>책</p>
        </div>
	
	
	<!-- 카테고리별 목록을 볼 수 있는 메뉴(네비게이션) -->
	<div>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp" class="btn btn-outline-dark btn-sm">전체</a>
		<%
			ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
			for(String s : categoryNameList) {
		%>
				<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=s%>" class="btn btn-outline-dark btn-sm"><%=s%></a>	
				
		<%		
			}
		%>
		
		
		
	<br>	
	</div>
	<br>
	<a href="<%=request.getContextPath()%>/ebook/insertEbookForm.jsp"><button type="submit" class="btn btn-outline-primary btn-sm">ebook 추가</button></a>
	
	<br>
	<!-- rowPerPage 페이징 -->
	<%
		// 현재 페이지, 값이 존재하면 그 값으로 초기화
		int currentPage = 1;
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		// 페이지당 행의 수, 값이 존재하면 그 값으로 초기화
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage") != null){
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		
		// 시작 행
		int beginRow = (currentPage - 1 ) * rowPerPage;
		
		// 전체 데이터의 개수
		int totalRow = EbookDao.totalCount();
		System.out.println(totalRow);
		
		
	    // 카테고리별 목록
	    String categoryName ="";
	    if(request.getParameter("categoryName") != null){
	       categoryName = request.getParameter("categoryName");
	    }
	    System.out.println("categoryName : " + categoryName);


		// list 생성
		ArrayList<Ebook> list = EbookDao.selectEbookListByPage(rowPerPage, beginRow, categoryName);
	%>
	<br>
	<!-- 몇 페이지씩 보여줄 지 결정해주는 select문 -->
	<form action="<%=request.getContextPath()%>/ebook/ebookList.jsp" method="post">
		<select name="rowPerPage">
			<%
				for(int i=10;i<31;i+=5){
					if(rowPerPage==i){
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
		<button type="submit" class="btn btn-light btn-sm">보기</button>
	</form>
	
	<table class="table table-bordered table-sm">
		<thead>
			<tr class="table-primary">
				<th>categoryName</th>
				<th>ebookISBN</th>
				<th>ebookTitle</th>
				<th>ebookAuthor</th>
				<th>ebookDate</th>
				<th>ebookPice</th>
			</tr>
		</thead>
		
		<tbody>
			<%
				for(Ebook e : list){
			%>
					<tr>
						<td><%=e.getCategoryName() %></td>
						<td><%=e.getEbookISBN() %></td>
						<td><a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=e.getEbookISBN()%>"><%=e.getEbookTitle() %></a></td>
						<td><%=e.getEbookAuthor() %></td>
						<td><%=e.getEbookDate().substring(0, 11) %></td> <!-- 년월일만 나오게 함 -->
						<td><%=e.getEbookPrice() %></td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
	<!--  페이징 -->
	<%
		if(currentPage >1){
	%>
			<!-- List.jsp가 폴더 안에 있을 때 폴더명도 꼭 입력하기 -->
			<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>" class="btn btn-outline-dark btn-sm">이전</a>
	<%		
		}
		System.out.println("currentPage: " + currentPage);
		
		int lastPage = totalRow / rowPerPage; //마지막 페이지
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		
		if (currentPage < lastPage){
	%>
    		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>" class="btn btn-outline-dark btn-sm">다음</a>
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