<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/dash/css/vendors_css.css">

<!-- Style-->
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/dash/css/style.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/dash/css/skin_color.css">
<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		let fullMsg = '${msg}'
		if (fullMsg != null && fullMsg != "") {			
			myAlarm(fullMsg)
		}
		
		
		// 자바스크립트 여기
		$(".goto-htc").click(function(){
			index = this.id.split("_")[1] 
			console.log("selected index : " + index)
			current_bal =  $("#balance_"+ index ).val()
			current_nick = $("#nick_" + index).html()
			current_regDate = $("#regDate_" + index).html()
			current_gcaNumber = $("#gcaNumber_" + index).html()			
			console.log(current_bal)
			console.log(current_gcaNumber)
			console.log(current_regDate)
			$("#form-nick").val(current_nick)
			$("#form-balance").val(current_bal)
			$("#form-gcaNumber").val(current_gcaNumber)
			$("#form-regDate").val(current_regDate)
			console.log($("#form-regDate").val())
		})
		
	
		
	})
</script>

</head>
<body class="hold-transition dark-skin sidebar-mini theme-warning fixed">
	<div class="wrapper">
		<div id="loader"></div>
		<header class="main-header">
			<jsp:include page="/resources/dash/include/header.jsp" />
		</header>
	</div>
	<aside class="main-sidebar">
		<jsp:include page="/resources/dash/include/sidebar.jsp" />
	</aside>
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<div class="container-full">
			<div class="content-header">
				<div class="d-flex align-items-center">
					<div class="me-auto">
						<h4 class="page-title">보유 계좌</h4>
						<div class="d-inline-block align-items-center">
							<nav>
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
									<li class="breadcrumb-item" aria-current="page">보유 계좌</li>
									<li class="breadcrumb-item active" aria-current="page">계좌 선택</li>
								</ol>
							</nav>
						</div>
					</div>

				</div>
			</div>
			<!-- Main content -->
			<section class="content">
				<div class="row">
					<c:forEach items="${ list }" var="accountVO" varStatus="loop">
						<c:choose>
							<c:when test="${(loop.count % 3) == 2 }">
								<div class="col-lg-4">

									<div class="box cabox box-inverse bg-gradient-success">
										<div class="box-body text-center">
											<h5 class="text-uppercase text-muted">
												<span id="nick_${loop.count }">${accountVO.nick }</span>&nbsp;
											</h5>

											<br>
											<p class="price" style="font-size: xxx-large;">
												<sup>₩</sup>${accountVO.balance } <span>&nbsp;</span>
												<input value="${accountVO.balance }" id="balance_${loop.count }" hidden="true">
											</p>
											<hr>
											<p>
												<strong>번호:&nbsp;</strong><span id="gcaNumber_${loop.count }">${accountVO.gcaNumber }</span>
											</p>

											<p>
												<strong>생성 날짜:&nbsp;</strong><span id="regDate_${loop.count }">${accountVO.regDate }</span>
											</p>
											<br> <br>
											<button id="listindex_${loop.count }" type="button" style="background-color: transparent; border-color: white;" class="btn btn-primary goto-htc" data-bs-toggle="modal" data-bs-target="#modal-center">계좌 선택</button>
										</div>
									</div>

								</div>
							</c:when>

							<c:when test="${(loop.count % 3) == 0 }">
								<div class="col-lg-4">
									<div class="box card-shadowed box-inverse bg-gradient-danger">
										<div class="box-body text-center">
											<h5 class="text-uppercase text-muted">
												<span id="nick_${loop.count }">${accountVO.nick }</span>&nbsp;
											</h5>

											<br>
											<p class="price" style="font-size: xxx-large;">
												<sup>₩</sup>${accountVO.balance } <span>&nbsp;</span>
												<input value="${accountVO.balance }" id="balance_${loop.count }" hidden="true">
											</p>
											<hr>
											<p>
												<strong>번호:&nbsp;</strong><span id="gcaNumber_${loop.count }">${accountVO.gcaNumber }</span>
											</p>

											<p>
												<strong>생성 날짜:&nbsp;</strong><span id="regDate_${loop.count }">${accountVO.regDate }</span>
											</p>
											<br> <br>
											<button id="listindex_${loop.count }" type="button" style="background-color: transparent; border-color: white;" class="btn btn-primary goto-htc" data-bs-toggle="modal" data-bs-target="#modal-center">계좌 선택</button>
										</div>
									</div>

								</div>

							</c:when>

							<c:when test="${(loop.count % 3) == 1 }">
								<div class="col-lg-4">
									<div class="box box-inverse bg-gradient-primary">
										<div class="box-body text-center">
											<h5 class="text-uppercase text-muted">
												<span id="nick_${loop.count }">${accountVO.nick }</span>&nbsp;
											</h5>

											<br>
											<p class="price" style="font-size: xxx-large;">
												<sup>₩</sup>${accountVO.balance } <span>&nbsp;</span>
												<input value="${accountVO.balance }" id="balance_${loop.count }" hidden="true">
											</p>
											<hr>
											<p>
												<strong>번호:&nbsp;</strong><span id="gcaNumber_${loop.count }">${accountVO.gcaNumber }</span>
											</p>

											<p>
												<strong>생성 날짜:&nbsp;</strong><span id="regDate_${loop.count }">${accountVO.regDate }</span>
											</p>
											<br> <br>
											<button id="listindex_${loop.count }" type="button" style="background-color: transparent; border-color: white;" class="btn btn-primary goto-htc" data-bs-toggle="modal" data-bs-target="#modal-center">계좌 선택</button>
										</div>
									</div>

								</div>
							</c:when>
						</c:choose>
					</c:forEach>
				</div>
				<hr>
				<div class="content-header">
					<div class="d-flex align-items-center">
						<div class="me-auto">
							<h4 class="page-title">리그 계좌</h4>
							<div class="d-inline-block align-items-center">
								<nav>
									<ol class="breadcrumb">
										<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
										<li class="breadcrumb-item" aria-current="page">리그 계좌</li>
										<li class="breadcrumb-item active" aria-current="page">리그 계좌</li>
									</ol>
								</nav>
							</div>
						</div>
					</div>
				</div>
				<section class="content">
					<div class="row">
						<c:if test="${empty leagueAccountVO }">
							<div class="col-12 col-lg-5 col-xl-5">
								<div class="box box-widget widget-user">
									<div class="widget-user-header bg-img bbsr-0 bber-0" style="background: url('${ pageContext.request.contextPath }/resources/images/gallery/full/10.jpg') center center;" data-overlay="5">
										<h3 class="widget-user-username text-white">${userVO.id }</h3>
										<h6 class="widget-user-desc text-white">${userVO.userType }</h6>
									</div>
									<div class="widget-user-image">
										<img class="rounded-circle" src="${ pageContext.request.contextPath }/resources/images/avatar/avatar-12.png" alt="User Avatar">
									</div>
									<div class="box-footer">
										<form action="${ pageContext.request.contextPath }/account/createLeagueAcc" method="post">
											<button type="submit" id="start_league" class="waves-effect waves-light btn btn-danger btn-lg">새로 시작하기</button>
										</form>										
									</div>
								</div>
							</div>
						</c:if>
						<c:if test="${not empty leagueAccountVO }">
							<div class="col-12 col-lg-5 col-xl-5">
								<div class="box box-widget widget-user">
									<div class="widget-user-header bg-img bbsr-0 bber-0" style="background: url('${ pageContext.request.contextPath }/resources/images/gallery/full/10.jpg') center center;" data-overlay="5">
										<h3 class="widget-user-username text-white">${userVO.id }</h3>
										<h6 class="widget-user-desc text-white">${userVO.userType }</h6>
									</div>
									<div class="widget-user-image">
										<img class="rounded-circle" src="${ pageContext.request.contextPath }/resources/images/avatar/avatar-12.png" alt="User Avatar">
									</div>
									<div class="box-footer">
										<div class="row mb-15">
											<div class="col-sm-4 text-center">
												<div class="description-block">
													<h5 class="description-header">${fn:length(leagueFollowList)}</h5>
													<span class="description-text">구독자 수</span>
												</div>
												<button type="button" class="waves-effect waves-light btn btn-info btn-xs">구독 조회</button>
											</div>
											<!-- /.col -->
											<div class="col-sm-4 be-1 bs-1 text-center">
												<div class="description-block">
													<h5 class="description-header">${leagueAccountVO.followPrice }</h5>
													<span class="description-text">구독 가격</span>
												</div>
												<button type="button" class="waves-effect waves-light btn btn-info btn-xs">조정</button>
											</div>
											<!-- /.col -->
											<div class="col-sm-4 text-center">
												<div class="description-block">
													<h5 class="description-header">잔액</h5>
													<span class="description-text">${leagueAccountVO.balance }</span>
												</div>
												<button type="button" class="waves-effect waves-light btn btn-info btn-xs">내역 확인</button>
											</div>
											<!-- /.col -->
										</div>
										<!-- /.row -->
										<div class="row mb-30 bt-1">
											<h4 class="title w-p100 mt-10 mb-0 p-20 text-primary">리그 정보</h4>
											<h5 class="p-15 mb-0">
												<strong>시작 날짜:</strong> ${leagueAccountVO.regDate }
											</h5>
											<h5 class="p-15 mb-0">
												<strong>주식 보유 개수:</strong> 0개
												<button type="button" class="waves-effect waves-light btn btn-info btn-xs">조회</button>
											</h5>
											<h5 class="p-15 mb-0">
												<strong>구독 정보:</strong> 0명
												<button type="button" class="waves-effect waves-light btn btn-info btn-xs">조회</button>
											</h5>
										</div>
										<div class="row mb-30">
											<div class="clearfix">
												<button type="submit" id="refresh_league" class="waves-effect waves-light btn btn-danger mb-5">초기화</button>
												<button type="submit" id="start_league" class="waves-effect waves-light btn btn-success mb-5" data-bs-toggle="modal" data-bs-target="#modal-center2">계좌 선택</button>

											</div>
										</div>

									</div>
								</div>
							</div>
						</c:if>
					</div>
				</section>
				<hr>
			</section>
		</div>
	</div>



	<footer class="main-footer">
		<jsp:include page="/resources/dash/include/footer.jsp" />
		&copy; 2021 <a href="https://www.multipurposethemes.com/">Multipurpose Themes</a>. All Rights Reserved.
	</footer>
	<aside class="control-sidebar">
		<jsp:include page="/resources/dash/include/control-sidebar.jsp" />
	</aside>




	<!-- Modal -->
	<div class="modal center-modal fade" id="modal-center" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">비밀번호 입력</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
					계좌 비밀번호를 입력해주세요.
				<form method="post">
					<input name="nick" hidden="true" id="form-nick">
					<input name="balance" hidden="true" id="form-balance">
					<input name="gcaNumber" hidden="true" id="form-gcaNumber">
					<input name="regDate" hidden="true" id="form-regDate">
					<br>
					<br>
					<input name="gcaPassword" type="password" id="form-password">
					<div class="modal-body"></div>
					<div class="modal-footer modal-footer-uniform">
						<button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary float-end">확인</button>
					</div>
				</form>
			</div>
		</div>
	</div>



	<div class="modal center-modal fade" id="modal-center2" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">리그 계좌 로그인</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<form method="post" action="${pageContext.request.contextPath}/account/leagueSignin">
				<div class="modal-body">
					<p>회원 비밀번호를 입력해주세요</p>					
						<input name="password" type="password" id="user_password">					
				</div>
				<div class="modal-footer modal-footer-uniform">
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary float-end">확인</button>
				</div>
				</form>
			</div>
			
		</div>
	</div>



	<div class="control-sidebar-bg"></div>
	<!-- Vendor JS -->
	<script src="${ pageContext.request.contextPath }/resources/dash/js/vendors.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/chat-popup.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/icons/feather-icons/feather.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/Flot/jquery.flot.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/Flot/jquery.flot.resize.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/Flot/jquery.flot.pie.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/Flot/jquery.flot.categories.js"></script>
	<script src="http://www.amcharts.com/lib/3/amcharts.js" type="text/javascript"></script>
	<script src="http://www.amcharts.com/lib/3/gauge.js" type="text/javascript"></script>
	<script src="http://www.amcharts.com/lib/3/serial.js" type="text/javascript"></script>
	<script src="http://www.amcharts.com/lib/3/amstock.js" type="text/javascript"></script>
	<script src="http://www.amcharts.com/lib/3/pie.js" type="text/javascript"></script>
	<script src="https://www.amcharts.com/lib/3/plugins/dataloader/dataloader.min.js"></script>
	<script src="http://www.amcharts.com/lib/3/plugins/animate/animate.min.js" type="text/javascript"></script>
	<script src="http://www.amcharts.com/lib/3/plugins/export/export.min.js" type="text/javascript"></script>
	<script src="http://www.amcharts.com/lib/3/themes/patterns.js" type="text/javascript"></script>
	<script src="http://www.amcharts.com/lib/3/themes/light.js" type="text/javascript"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/Web-Ticker-master/jquery.webticker.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/echarts-master/dist/echarts-en.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/echarts-liquidfill-master/dist/echarts-liquidfill.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/datatable/datatables.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.js"></script>

	<!-- Crypto Admin App -->
	<script src="${ pageContext.request.contextPath }/resources/dash/js/template.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/dashboard.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/dashboard-chart.js"></script>

	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/chat-popup.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/icons/feather-icons/feather.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/sweetalert/sweetalert.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/js/sweet-alert.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/notification.js"></script>

</body>
</html>