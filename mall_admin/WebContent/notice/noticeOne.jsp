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

  <title>NoticeOne</title>
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
	// 수집 (noticeList에서 클릭한 공지 noticeNo)
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo+"<-- noticeOne의 noticeNo"); // 디버깅
	
	// dao연결
	Notice notice = NoticeDao.selectNoticeOne(noticeNo);
	System.out.println(notice); // 디버깅
%>

	<main id="main">
	
	<section id="about" class="about">
      <div class="container">

        <div class="section-title">
          <h2>NoticeOne</h2>
          <p>공지 관리</p>
        </div>
     
	<!-- noticeOne 테이블 생성 -->

	<table class="table table-bordered table-sm">
		<tr>
			<th class="table-dark">noticeNo</th>
			<td><%=notice.getNoticeNo()%></td>
		</tr>
		<tr>
			<th class="table-dark">noticeTitle</th>
			<td><%=notice.getNoticeTitle()%></td>
		</tr>
		<tr>
			<th class="table-dark">noticeContent</th>
			<td>
				<textarea rows="5" cols="80" readonly="readonly"><%=notice.getNoticeContent()%></textarea>
			</td>
		</tr>
		<tr>
			<th class="table-dark">managerId</th>
			<td><%=notice.getManagerId()%></td>
		</tr>
		<tr>
			<th class="table-dark">noticeDate</th>
			<td><%=notice.getNoticeDate().substring(0,11)%></td>
		</tr>
	</table>
	<a href="<%=request.getContextPath()%>/notice/updateNoticeOneForm.jsp?noticeNo=<%=notice.getNoticeNo()%>" class="btn btn-light btn-sm"> 공지 관리 수정</a>
	
	<a href="<%=request.getContextPath()%>/notice/deleteNoticeOneAction.jsp?noticeNo=<%=notice.getNoticeNo()%>"><button type="submit" class="btn btn-light btn-sm">삭제</button></a>	
	
	<br>
	
	<!-- 댓글 입력폼 -->
	<br>
	<form action="<%=request.getContextPath()%>/notice/insertCommentAction.jsp" method="post" >
		<!-- 현재 공지글 넘버 사용 -->
		<input type="hidden" name="noticeNo" value="<%=noticeNo%>" class="form-control">
		
		<div class="table-bordered table-sm">
			<!-- 세션값 사용 -->
			managerId :
			<input type="text" name="managerId" value="<%=manager.getManagerId()%>" readonly="readonly">
		</div>
		
		<div class="table-bordered table-sm"> 
			<textarea name="commentContent" rows="2" cols="80" class="form-control"></textarea>
		</div>
		<button type="submit" class="btn btn-outline-dark btn-sm">댓글 입력</button>
	</form>
	<br>
	<!--  댓글 리스트 -->
	<%
		ArrayList<Comment> commentList = CommentDao.selectCommentListByNoticeNo(noticeNo);
		for(Comment c : commentList) {
	%>
	
			<table class="table table-bordered table-sm">
				<tr>
					<td class="table-dark"><%=c.getCommentContent()%></td>
					<td><%=c.getCommentDate()%></td>
					<td  class="table-dark"><%=c.getManagerId()%></td>
					<td><a href="<%=request.getContextPath()%>/notice/deleteCommentAction.jsp?commentNo=<%=c.getCommentNo()%>&noticeNo=<%=noticeNo%>" class="btn btn-light btn-sm">삭제</a></td>
				</tr>
			</table>
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