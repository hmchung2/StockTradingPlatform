<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style>
#headLogo{
-moz-transform:scale(0.75);
-webkit-transform:scale(0.75);
transform:scale(0.75);
}

</style> 

<script src="${ pageContext.request.contextPath }/resources/js/jquery-3.6.0.min.js"></script>
<script>

</script>

<nav hidden class="nav-white nav-transparent dark-overlay">
	<div class="nav-header" style="max-height:63px;"> <a href="${ pageContext.request.contextPath }/" style="margin-top:0px; padding-top:0px; padding-bottom:20px;" class="brand"> <img id="headLogo" src="${ pageContext.request.contextPath }/resources/images/gc_transparent2.png" alt="" /></a>						
		<button class="toggle-bar">
			<span class="ti-menu"></span>
		</button>
	</div>
	<ul class="menu">
	<%-- 	<li class="dropdown"><a href="#">계좌</a>
			<ul class="dropdown-menu">
				<li><a href="${pageContext.request.contextPath}/signin">로그인</a></li>
				<li><a href="${pageContext.request.contextPath}/signout">로그아웃</a></li>
				<li><a href="${pageContext.request.contextPath}/signcontract">회원가입</a></li>
				<li><a href="index4.html">설정 변경</a></li>
			</ul></li> --%>
<%-- 		<li><a href="buy_sell.html">Instant Buy & Sell</a></li>
		<li><a href="${pageContext.request.contextPath}/account/contract">모의 투자</a></li> --%>
		<li class="dropdown"><a href="#">사용자 페이지</a>
			<ul class="dropdown-menu">
				<li><a href="${pageContext.request.contextPath}/signin">로그인</a></li>
				<li><a href="${pageContext.request.contextPath}/signout">로그아웃</a></li>
				<li><a href="${pageContext.request.contextPath}/signcontract">회원가입</a></li>
				<li><a href="${pageContext.request.contextPath}/modifyinfo">회원정보 수정</a></li>
			</ul></li>
		<li class="megamenu"><a href="#">페이지</a>
			<div class="megamenu-content">
				<div class="row">
					<div class="col-lg-3 col-12">
						<ul class="list-group">
							<li><h4 class="menu-title">User Pages</h4></li>
							<li><a href="${pageContext.request.contextPath}/signin"><i class="ti-arrow-circle-right me-10"></i>로그인</a></li>
							<li><a href="${pageContext.request.contextPath}/signout"><i class="ti-arrow-circle-right me-10"></i>로그아웃</a></li>
							<li><a href="${pageContext.request.contextPath}/signcontract"><i class="ti-arrow-circle-right me-10"></i>회원가입</a></li>
							<li><a href="testimonial.html"><i class="ti-arrow-circle-right me-10"></i>회원 정보 수정</a></li>
							<li><a href="about.html"><i class="ti-arrow-circle-right me-10"></i>About</a></li>
							<li><a href="404.html"><i class="ti-arrow-circle-right me-10"></i>404</a></li>
							<li><a href="500.html"><i class="ti-arrow-circle-right me-10"></i>500</a></li>
						</ul>
					</div>
					<div class="col-lg-3 col-12">
						<ul class="list-group">
							<li><h4 class="menu-title">계좌</h4></li>
							<li><a href="${pageContext.request.contextPath}/account/contract"><i class="ti-arrow-circle-right me-10"></i>계좌 생성</a></li>
							<li><a href="${pageContext.request.contextPath}/account/hts"><i class="ti-arrow-circle-right me-10"></i>웹트레이딩</a></li>
							<li><a href="${pageContext.request.contextPath}/account/log"><i class="ti-arrow-circle-right me-10"></i>계좌 조회</a></li>
							<li><a href="register_login.html"><i class="ti-arrow-circle-right me-10"></i>Register & Login</a></li>
							<li><a href="forgot_pass.html"><i class="ti-arrow-circle-right me-10"></i>Forgot Password</a></li>
							<li><a href="lockscreen.html"><i class="ti-arrow-circle-right me-10"></i>Lock Screen</a></li>
							<li><a href="maintenance.html"><i class="ti-arrow-circle-right me-10"></i>Under Constructions</a></li>
						</ul>
					</div>
					<div class="col-md-3 col-12">
						<ul class="list-group">
							<li><h4 class="menu-title">Footer</h4></li>
							<li><a href="footer_style1.html"><i class="ti-arrow-circle-right me-10"></i>Footer One</a></li>
							<li><a href="footer_style2.html"><i class="ti-arrow-circle-right me-10"></i>Footer Two</a></li>
							<li><a href="footer_style3.html"><i class="ti-arrow-circle-right me-10"></i>Footer Three</a></li>
							<li><a href="footer_style4.html"><i class="ti-arrow-circle-right me-10"></i>Footer Four</a></li>
							<li><a href="footer_style5.html"><i class="ti-arrow-circle-right me-10"></i>Footer Five</a></li>
							<li><a href="footer_style6.html"><i class="ti-arrow-circle-right me-10"></i>Footer Six</a></li>
						</ul>
					</div>
					<div class="col-lg-3 col-12">
						<ul class="list-group">
							<li><h4 class="menu-title">Header</h4></li>
							<li><a href="header_default.html"><i class="ti-arrow-circle-right me-10"></i>Header One</a></li>
							<li><a href="header_style2.html"><i class="ti-arrow-circle-right me-10"></i>Header Two</a></li>
							<li><a href="header_style3.html"><i class="ti-arrow-circle-right me-10"></i>Header Three</a></li>
							<li><a href="header_style4.html"><i class="ti-arrow-circle-right me-10"></i>Header Four</a></li>
							<li><a href="header_style5.html"><i class="ti-arrow-circle-right me-10"></i>Header Five</a></li>
						</ul>
					</div>
				</div>
			</div></li>
		<li class="dropdown"><a href="#">Blog</a>
			<ul class="dropdown-menu">
				<li class="dropdown"><a href="#">Grid Blog</a>
					<ul class="dropdown-menu">
						<li><a href="blog_grid_2.html">Grid 2 colunm</a></li>
						<li><a href="blog_grid_3.html">Grid 3 colunm</a></li>
						<li><a href="blog_grid_left_sidebar.html">blog left sidebar</a></li>
						<li><a href="blog_grid_right_sidebar.html">blog right sidebar</a></li>
					</ul></li>
				<li class="dropdown"><a href="#">List Blog</a>
					<ul class="dropdown-menu">
						<li><a href="blog_list.html">Blog List</a></li>
						<li><a href="blog_list_left_sidebar.html">Blog List Left Sidebar</a></li>
						<li><a href="blog_list_right_sidebar.html">Blog List right Sidebar</a></li>
					</ul></li>
				<li class="dropdown"><a href="#">Single Blog Post</a>
					<ul class="dropdown-menu">
						<li><a href="blog_single_grid_post.html">Single Grid Post</a></li>
						<li><a href="blog_single_html5video_post.html">Single html5 Video-post</a></li>
						<li><a href="blog_single_image_post.html">Single Image Post</a></li>
						<li><a href="blog_single_slider_post.html">Single Slider Post</a></li>
						<li><a href="blog_single_soundcloud_post.html">Single SoundCloud Post</a></li>
						<li><a href="blog_single_vimeo_post.html">Single Vimeo Post</a></li>
						<li><a href="blog_single_post.html">Single without image post</a></li>
						<li><a href="blog_single_youtube_post.html">Single Youtube Post</a></li>
					</ul></li>
			</ul></li>
		<li><a href="contact_us.html">Contact</a></li>
	</ul>
	<ul class="attributes">
	<c:if test="${ empty userVO }">
			<li class="d-md-block d-none"><a href="${pageContext.request.contextPath}/signcontract" class="px-10 pt-15 pb-10"><div class="btn btn-primary py-5">회원가입</div></a></li>	
	</c:if>
	<c:if test="${not empty userVO }">
			<li class="d-md-block d-none"><a href="${pageContext.request.contextPath}/account/hts" class="px-10 pt-15 pb-10"><div class="btn btn-primary py-5">웹 트레이딩 시작</div></a></li>	
	</c:if>
		<li><a href="#" class="toggle-search-fullscreen"><span class="ti-search"></span></a></li>
	</ul>
	<div class="wrap-search-fullscreen">
		<div class="container">
			<button class="close-search">
				<span class="ti-close"></span>
			</button>
			<input type="text" placeholder="Search..." />
		</div>
	</div>
</nav>