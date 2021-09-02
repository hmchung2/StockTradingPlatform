<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="${ pageContext.request.contextPath }/resources/images/favicon.ico">
<title>GreenCamel</title>
<!-- Vendors Style-->
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/home/css/vendors_css.css">
<!-- Style-->
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/home/css/style.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/home/css/skin_color.css">
</head>
<body class="theme-warning">
	<header>
		<jsp:include page="/resources/home/include/header.jsp" />
	</header>


 	<section class="bg-img pt-150 pb-20" data-overlay="7" style="background-image: url(${ pageContext.request.contextPath }/resources/images/front-end-img/background/bg-8.jpg);">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="text-center">						
						<h2 class="page-title text-white">페이지 이름</h2>
						<ol class="breadcrumb bg-transparent justify-content-center">
							<li class="breadcrumb-item"><a href="#" class="text-white-50"><i class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item text-white active" aria-current="page">페이지이름</li>
						</ol>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	
	
	
	<section class="py-50 bg-white">
		<div class="container">
			<div class="row align-items-center justify-content-between">
	
	
	
	
			</div>
		</div>
	</section>



	<footer class="footer_four footer_white">
		<jsp:include page="/resources/home/include/footer.jsp" />
	</footer>



	<script src="${ pageContext.request.contextPath }/resources/home/js/vendors.min.js"></script>
	<!-- Corenav Master JavaScript -->
	<script src="${ pageContext.request.contextPath }/resources/home/corenav-master/coreNavigation-1.1.3.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/home/js/nav.js"></script>
	<%--  <script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/OwlCarousel2/dist/owl.carousel.js"></script> --%>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/bootstrap-select/dist/js/bootstrap-select.js"></script>
	<%-- 	<script src="${ pageContext.request.contextPath }/resources/home/js/particles.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/home/js/app.js"></script> --%>
	<!-- CryptoCurrency front end -->
	<script src="${ pageContext.request.contextPath }/resources/home/js/template.js"></script>
</body>
</html>