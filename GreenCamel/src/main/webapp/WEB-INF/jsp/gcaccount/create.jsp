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
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/home/css/skin_color.css">
<%-- <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/dash/css/vendors_css.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/dash/css/style.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/dash/css/skin_color.css">
 --%>
<style>

.center {
  margin: auto;
  width: 55%;
  padding: 10px;
}
.container {
    position: relative;
    margin: auto;
 	width: 95%;
	padding: 10px;   
}
</style>
<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/jquery-3.6.0.min.js"></script>	
    <script>
     $(document).ready(function() {     	
     	let fullMsg = '${msg}'
     	if (fullMsg != null && fullMsg != "") {
     		myAlarm(fullMsg)
     	}
     })
     </script> 

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
						<h2 class="page-title text-white">계좌 생성</h2>
						<ol class="breadcrumb bg-transparent justify-content-center">
							<li class="breadcrumb-item"><a href="#" class="text-white-50"><i class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item text-white active" aria-current="page">계좌 생성</li>
						</ol>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<section class="py-50">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 col-12 center">
					<div class="box">
						<div class="box-header with-border">
						  <h4 class="box-title">모의 투자 계좌</h4>
						</div>
						<div class="box-body">
							<ul class="nav nav-tabs" role="tablist">
								<li class="nav-item"> <a class="nav-link active" data-bs-toggle="tab" href="#market" role="tab">계좌 정보</a> </li>				
							</ul>
							<div class="tab-content p-10 tabcontent-border">
								<div class="tab-pane active" id="market" role="tabpanel">
									<form class="dash-form" method="post">							
										<div class="input-group mb-10">
											<span style="min-width: 130px;" class="input-group-addon">별칭</span>
											<input type="text" name="nick" class="form-control">
										</div>
										<div class="input-group mb-10">
											<span style="min-width: 130px;" class="input-group-addon">비밀번호</span>
											<input id="pw1" name="gcaPassword" type="password" class="form-control">
										</div>
										<div class="input-group mb-10">
											<span style="min-width: 130px;" class="input-group-addon">비밀번호 확인</span>
											<input id="pw2" type="password" class="form-control">
										</div>
										<div class="input-group mb-10">
											<span style="min-width: 130px;"  class="input-group-addon">초기 입금</span>
											<input name="balance" type="number" class="form-control" placeholder="1000000">
										</div>									
										<button type="submit" class="btn btn-block btn-success mt-20">계좌 생성</button>
									</form>
								</div>
								
							</div>
						</div>
					  </div>
				</div>
		
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
	<%-- <script src="${ pageContext.request.contextPath }/resources/home/js/template.js"></script --%>>	
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/chat-popup.js"></script>
    <script src="${ pageContext.request.contextPath }/resources/assets/icons/feather-icons/feather.min.js"></script>	
    <script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/sweetalert/sweetalert.min.js"></script>
    <script src="${ pageContext.request.contextPath }/resources/js/sweet-alert.js"></script>
    <script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>		 
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/notification.js"></script> 	
</body>
</html>