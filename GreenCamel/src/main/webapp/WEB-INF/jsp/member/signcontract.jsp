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
<script src="${ pageContext.request.contextPath }/resources/js/jquery-3.6.0.min.js"></script>

<script>
function selectAll() {
	let tags = document.querySelectorAll(".form-check-input")
	let length = tags.length
	for (let i = 0; i < length; i++) {
		tags[i].checked = true
	}
}

function unselectAll() {
	let tags = document.querySelectorAll(".form-check-input")
	let length = tags.length
	for (let i = 0; i < length; i++) {
		tags[i].checked = false
	}
}
function toggle() {
	if ($('#chk').is(":checked")) {
		selectAll()
	} else {
		let check = true
		let tags = document.querySelectorAll(".form-check-input")
		let f = document.querySelectorAll(".form-check-input")
		let cnt = 0
		for (let i = 0; i < tags.length && tags[i].checked; i++) {
			if (tags[i].checked)
				cnt++
			else
				break
		}
		if (cnt == tags.length) {
			unselectAll()
		}
	}
}

function checkRequired() {
	let requiredTags = document.querySelectorAll(".form-check-input")
	let length = requiredTags.length
	let cnt = 0
	for (let i = 0; i < length; i++) {
		if (requiredTags[i].checked) {
			cnt++
		} else {
			break
		}
	}
	if (cnt == length) {
		location.href="${pageContext.request.contextPath }/signup/1"
	} else {
		$(".required input").css("outline", "2px solid #0d6efd")
	}
}
function checkRequired2() {
	let requiredTags = document.querySelectorAll(".form-check-input")
	let length = requiredTags.length
	let cnt = 0
	for (let i = 0; i < length; i++) {
		if (requiredTags[i].checked) {
			cnt++
		} else {
			break
		}
	}
	if (cnt == length) {
		location.href="${pageContext.request.contextPath }/signup/2"
	} else {
		$(".required input").css("outline", "2px solid #0d6efd")
	}
}
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
						<h2 class="page-title text-white">이용 약관</h2>
						<ol class="breadcrumb bg-transparent justify-content-center">
							<li class="breadcrumb-item"><a href="#" class="text-white-50"><i class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item text-white active" aria-current="page">이용 약관</li>
						</ol>
					</div>
				</div>
			</div>
		</div>
	</section>



	<!--Page content -->

	<section class="py-50">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-9 col-12">
				<input type="checkbox" name="chkAll" id="chk" class="chkAll" onclick="toggle()"><label class="form-check-label" for="chk"> 모두 동의 </label>
					<div class="box">
						<div class="row g-0">
							<div class="col-md-8 col-12">
								<div class="box-body">
									<h4>
										<a href="#">이용약관 동의(필수)</a>
									</h4>
									<p>하나금융 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 하나금융 서비스의 이용과 관련하여 하나금융 서비스를 제공하는 하나금융 주식회사(이하 ‘하나금융’)와 이를 이용하는 하나금융 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 하나금융 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.</p>

									<div class="d-flex mb-10"></div>

									<div class="form-check">
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value="" id="1"> <label class="form-check-label" for="1"> 동의 </label>
										</div>
									</div>


								</div>
							</div>
						</div>
					</div>
					<div class="box">
						<div class="row g-0">
							<div class="col-md-8 col-12">
								<div class="box-body">
									<h4>
										<a href="#">이용약관 동의(필수)</a>
									</h4>
									<p>하나금융 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 하나금융 서비스의 이용과 관련하여 하나금융 서비스를 제공하는 하나금융 주식회사(이하 ‘하나금융’)와 이를 이용하는 하나금융 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 하나금융 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.</p>

									<div class="d-flex mb-10"></div>

									<div class="form-check">
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value="" id="2"> <label class="form-check-label" for="2"> 동의 </label>
										</div>
									</div>


								</div>
							</div>
						</div>
					</div>
					<div class="box">
						<div class="row g-0">
							<div class="col-md-8 col-12">
								<div class="box-body">
									<h4>
										<a href="#">이용약관 동의(필수)</a>
									</h4>
									<p>하나금융 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 하나금융 서비스의 이용과 관련하여 하나금융 서비스를 제공하는 하나금융 주식회사(이하 ‘하나금융’)와 이를 이용하는 하나금융 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 하나금융 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.</p>

									<div class="d-flex mb-10"></div>

									<div class="form-check">
										<div class="form-check">
											<input class="form-check-input" type="checkbox" value="" id="3"> <label class="form-check-label" for="3"> 동의 </label>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<button name="submit" type="submit" value="Send" class="btn btn-primary" id="confirm-btn" onclick="checkRequired()">
						<span>일반 사용자</span>
					</button>
					
					<button name="submit" type="submit" value="Send" class="btn btn-primary" id="confirm-btn2" onclick="checkRequired2()">
						<span>사업가 사용자</span>
					</button>
					

					<button name="submit" type="submit" value="Send" id="goback" style="background-color: red; float: right;" class="btn btn-primary">
						<span>취소</span>
					</button>

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
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/OwlCarousel2/dist/owl.carousel.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/bootstrap-select/dist/js/bootstrap-select.js"></script>
<%-- 	<script src="${ pageContext.request.contextPath }/resources/home/js/particles.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/home/js/app.js"></script> --%>
	<!-- CryptoCurrency front end -->
<%-- 	<script src="${ pageContext.request.contextPath }/resources/home/js/template.js"></script> --%>
</body>
</html>