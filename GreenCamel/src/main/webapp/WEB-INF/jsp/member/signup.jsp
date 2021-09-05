<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
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


	let idChk = "false"
	let emailChk = "false"
	let randomDigits = null;
	$(document).ready(function() {
		let fullMsg = '${msg}'

		if (fullMsg != null && fullMsg != "") {
			myAlarm(fullMsg)
		}

		$("#str_email02").change(function() {
			emailChk = "false"
			$("#emailCkMessage").html("이메일 인증이 필요 합니다.")
			$("#emailCkMessage").css("color" , "red")
			randomDigit = null;			
		})
		$("#str_email01").change(function() {
			emailChk = "false"
			$("#emailCkMessage").html("이메일 인증이 필요 합니다.")
			$("#emailCkMessage").css("color" , "red")
			randomDigit = null;
		})
		
		

	$(".tst1").on("click", function() {
			randomDigits = generate(5);
			console.log(randomDigits)
			$.toast({heading : '인증 번호 발급',
			text : '해당 이메일을 확인 바랍니다.',
			position : 'top-right',
			loaderBg: '#ff6849',
			icon : 'error',
			hideAfter : 3500
			});
			let fullEmail = $("#str_email01").val() + "@" + $("#str_email02").val()
			console.log(fullEmail)
			$.ajax({
				type:"get",
				url : "${pageContext.request.contextPath }/ajax/sendMail.json",
				data : {
					emailAddr: fullEmail,
					digits: randomDigits
				},
				contentType : "application/x-www-form-urlencoded;charset=ISO-8859-15",
				datatype : 'json',
				success : function(data) {
					console.log(data)
					console.log("발송 성공")
					emailChk = "true"
				},
				error : function() {
					console.log("발송 실패")					
				}				
			})			
		});

		$('#id_id').change(function() {
			idChk = "false"
			outmsg = "중복확인 필요합니다...";
			if ($('#id_id').val().length < 5) {
				outmsg = "5글자 이상 필요합니다."
				$("#idCkMessage").html(outmsg)
				$("#idCkMessage").css("color" , "red")
			} else if ($('#id_id').val().length > 30) {
				outmsg = "30글자 초과 할 수 없습니다."
				$("#idCkMessage").html(outmsg)
				$("#idCkMessage").css("color" , "red")
			} else {
				let id = $("#id_id").val()
				console.log("checking id  -> " + id);
				$.ajax({type : 'get',
				url : "${pageContext.request.contextPath }/ajax/restBody.json",
				data : {id : id
				},
				contentType : "application/x-www-form-urlencoded;charset=ISO-8859-15",
				datatype : 'json',
				success : function(data) {
					console.log(data)
					console.log("success")
					if (data["result"] == "true") {
						outmsg = "사용 할 수 있는 아이디 입니다.";
						idChk = "true";
					} else {
						outmsg = "이미 사용중인 아이디 입니다."
					}
					$("#idCkMessage").html(outmsg)
					$("#idCkMessage").css("color" , "green")
				},
				error : function() {
					outmsg = "아이디 중복확인중 문제가 발생 했습니다."
					$("#idCkMessage").html(outmsg)
					$("#idCkMessage").css("color" , "red")
				}
				});
			}
		})

		$('.dropdown-item').each(function() {
			$(this).click(function() {
				if ($(this).text() == "직접 입력") {
					$("#str_email02").val('');
					$("#str_email02").attr("disabled", false);
					$("#str_email02").focus();
				} else {
					$("#str_email02").val($(this).text());
					$("#str_email02").attr("disabled", true);
				}
			})
		})
	});


	function emailChkSubmit(){
		if($('#emailChk-pwd').val() == randomDigits){
			console.log("인증성공")
			myAlarm("success:인증 완료:인증 번호가 일치 합니다.")
			$("#emailCkMessage").html("이메일 인증 완료")
			$("#emailCkMessage").css("color" , "green")
			
		}else{
			console.log("인증실패")
			myAlarm("warning:실패:인증번호가 일치 하지 않습니다.")
			$("#emailCkMessage").html("인증 번호가 일치 하지 않습니다.")
			$("#emailCkMessage").css("color" , "red")
		}
	}
		
	
	function generate(n) {
        var add = 1, max = 12 - add;   // 12 is the min safe number Math.random() can generate without it starting to pad the end with zeros.   
        if ( n > max ) {
                return generate(max) + generate(n - max);
        }
        max        = Math.pow(10, n+add);
        var min    = max/10; // Math.pow(10, n) basically
        var number = Math.floor( Math.random() * (max - min + 1) ) + min;
        return ("" + number).substring(add); 
	}

	function firstValidate() {
		let check = false;
		let msg = ""
		if (idChk == "false") {
			msg = "아이디 중복확인이 필요합니다."
		} else if(emailChk == "false"){
			msg = "이메일 인증이 필요합니다."
		} else if ($("#pw1").val() == "") {
			msg = "비밀번호를 입력 바랍니다."
		} else if ($('#pw1').val().length < 5) {
			msg = "비밀번호는 최소 다섯 글자 이상 필요 합니다."
		} else if ($("#pw1").val() != $("#pw2").val()) {
			msg = "비빌번호를 정확히 재입력 바랍니다."
		} else if ($("#id_id").legnth < 5) {
			msg = "아이디는 최소 다섯 글자 이상 필요합니다."
		} else {
			check = true;
		}
		if (check) {
			let fullEmail = $("#str_email01").val() + "@" + $("#str_email02").val()
			console.log("full Email : " + fullEmail)
			$("#hiddenEmail").val(fullEmail)

			let fullPhone = $("#phoneDigits").val()
			console.log("full Phone : " + fullPhone)
			$("#hiddenPhone").val(fullPhone)
		} else {
			myAlarm("warning:실패:" + msg)
		}
		return check
	}
</script>
</head>
<body class="hold-transition dark-skin sidebar-mini theme-warning fixed" style="background-image: url(${pageContext.request.contextPath}/resources/images/auth-bg/bg-8.jpg)">
	<!-- Content Wrapper. Contains page content -->
<%-- 
					<form:form method="post" onsubmit="return firstValidate();" modelAttribute="memberVO">
						<table style="width: 80%;">
							<tr>
								<th><span> <i class="fa fa-id-badge"></i></span></th>
								<td><form:input path="id" placeholder="아이디" type="text" id="id_id" /><span id="idCkMessage" style="color: red;">중복 확인이 필요 합니다.</span></td>
								<form:errors path="id" class="error" />
							</tr>
							<tr>
								<th><span> <i class="fa fa-lock"></i></span></th>
								<td><form:input path="password" placeholder="비밀번호 입력" type="password" id="pw1" /></td>
								<form:errors path="password" class="error" />
							</tr>
							<tr>
								<th><span> <i class="fa fa-lock"></i></span></th>
								<td><input name="password2" placeholder="비밀번호 다시 입력" type="password" id="pw2" /></td>

							</tr>
							<tr>
								<th><span> <i class="fa fa-user"></i></span></th>
								<td><form:input path="name" placeholder="이름" type="text" /></td>
								<form:errors path="name" class="error" />
							</tr>
							<tr>
								<th><span> <i class="fa fa-envelope"></i></span></th>
								<td><input type="text" id="str_email01" name="str_email01" placeholder="이메일">&nbsp; @ <input type="text" name="str_email02" id="str_email02" style="width: 30%;" disabled value="naver.com"> <select style="width: 20%; margin-right: 0px" name="selectEmail" id="selectEmail">
										<option value="1">직접입력</option>
										<option value="naver.com" selected>naver.com</option>
										<option value="hanmail.net">hanmail.net</option>
										<option value="hotmail.com">hotmail.com</option>
										<option value="nate.com">nate.com</option>
										<option value="yahoo.co.kr">yahoo.co.kr</option>
										<option value="empas.com">empas.com</option>
										<option value="dreamwiz.com">dreamwiz.com</option>
										<option value="freechal.com">freechal.com</option>
										<option value="lycos.co.kr">lycos.co.kr</option>
										<option value="korea.com">korea.com</option>
										<option value="gmail.com">gmail.com</option>
										<option value="hanmir.com">hanmir.com</option>
										<option value="paran.com">paran.com</option>
								</select></td>
								<form:input id="hiddenEmail" path="email" hidden="true" />
								<form:errors path="email" class="error" />
							</tr>

							<tr>
								<th><span> <i class="fa fa-phone"></i></span></th>
								<td><select id="phoneCompany" name="threeDigits" style="max-width: 120px;">
										<option selected>010-</option>
										<option value="1">012-</option>
										<option value="2">031-</option>
										<option value="3">017-</option>
								</select> <input id="phoneDigits" name="phoneDigits" pattern="\d{3,4}-\d{4}" placeholder="핸드폰 번호 : xxxx-xxxx 형식으로 입력하세요" type="tel"></td>
								<form:input id="hiddenPhone" path="phone" hidden="true" />
								<form:errors path="phone" class="error" />
							</tr>
							<tr>
								<th></th>
								<td><input id=submitButton type="submit" value="Submit" />Create Account <!-- <button type="submit">Create Account</button> -->
									<p>
										이미 회원 이십니까? <a href="${pageContext.request.contextPath }/signin">로그인</a>
									</p></td>
							</tr>
						</table>
					</form:form> --%>
<!-- ------------------------------------------- -->
	<div class="container h-p100">
		<div class="row align-items-center justify-content-md-center h-p100">
			<form:form method="post" onsubmit="return firstValidate();" modelAttribute="memberVO">
				<div class="col-12">
					<div class="row justify-content-center g-0">
						<div class="col-lg-5 col-md-5 col-12" style="width: 60%;">
							<div class="bg-white rounded10 shadow-lg">
								<div class="content-top-agile p-20 pb-0">
									<h2 class="text-primary">회원가입</h2>
									<p class="mb-0">Register a new membership</p>
								</div>
								<div class="p-40">
									<form action="index.html" method="post">
										<div class="form-group">
											<div class="input-group mb-3">
												<span class="input-group-text bg-transparent"><i class="ti-user"></i></span>
												<form:input path="id" class="form-control ps-15 bg-transparent" placeholder="아이디" type="text" id="id_id" />
												<form:errors path="id" class="error" />
											</div>
										</div>
										<div class="form-group">
											<div class="input-group mb-3">
												<span class="input-group-text bg-transparent"><i class="ti-layout-width-default-alt" style="visibility: hidden;"></i></span> <span id="idCkMessage" style="color: red;">중복 확인이 필요 합니다.</span>
											</div>
										</div>
										<div class="form-group">
											<div class="input-group mb-3">
												<span class="input-group-text bg-transparent"><i class="ti-user"></i></span>
												<form:input path="name" class="form-control ps-15 bg-transparent" placeholder="이름" type="text" id="name_name" />
												<form:errors path="name" class="error" />
											</div>
										</div>
										<div class="form-group">
											<div class="input-group mb-3">
												<span class="input-group-text bg-transparent"><i class="ti-email"></i></span> 
												<input class="form-control ps-15 bg-transparent" type="text" id="str_email01" name="str_email01" placeholder="이메일"> &nbsp;<strong>@</strong>&nbsp; 
												<input class="form-control ps-15 bg-transparent" type="text" name="str_email02" id="str_email02" style="width: 9%; font: bold;" disabled value="naver.com"> <span>&nbsp;</span>
												<div class="btn-group">
													<button  class="btn btn-rounded btn-warning dropdown-toggle no-caret" type="button" data-bs-toggle="dropdown">이메일 선택</button>
													<div class="dropdown-menu">
														<a class="dropdown-item" href="#">직접 입력</a> 
														<a class="dropdown-item" href="#">hanmail.net</a> 
														<a class="dropdown-item" href="#">hotmail.com</a> 
														<a class="dropdown-item" href="#">nate.com</a> 
														<a class="dropdown-item" href="#">yahoo.co.kr</a> 
														<a class="dropdown-item" href="#">gmail.com</a> 
														<a class="dropdown-item" href="#">naver.com</a>
													</div>
												</div>
												<button type="button" class="tst1 btn btn-info">번호 발급</button>
												<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal-center">인증</button>
												<form:input id="hiddenEmail" path="email" hidden="true" />
												<form:errors path="email" class="error" />
											</div>
										</div>
										<div class="form-group">
											<div class="input-group mb-3">
												<span class="input-group-text bg-transparent"><i class="ti-layout-width-default-alt" style="visibility: hidden;"></i></span><span id="emailCkMessage" style="color: red;">이메일 인증이 필요 합니다.</span>
											</div>
										</div>
										<div class="form-group">
											<div class="input-group mb-3">
												<span class="input-group-text bg-transparent"><i class="fa fa-phone"></i></span> <input class="form-control ps-15 bg-transparent" id="phoneDigits" name="phoneDigits" pattern="\d{3}-\d{3,4}-\d{4}" placeholder="핸드폰 번호 : xxx-xxxx-xxxx 형식으로 입력하세요" type="tel">												
												<form:input id="hiddenPhone" path="phone" hidden="true" />
												<form:errors path="phone" class="error" />
											</div>
										</div>
										<div class="form-group">
											<div class="input-group mb-3">
												<span class="input-group-text bg-transparent"><i class="ti-lock"></i></span>
												<form:input path="password" class="form-control ps-15 bg-transparent" placeholder="비밀번호 입력" type="password" id="pw1" />
												<form:errors path="password" class="error" />
											</div>
										</div>
										<div class="form-group">
											<div class="input-group mb-3">
												<span class="input-group-text bg-transparent"><i class="ti-lock"></i></span> <input name="password2" class="form-control ps-15 bg-transparent" placeholder="비밀번호 다시 입력" type="password" id="pw2" />
											</div>
										</div>
										<div class="row">
											<div class="col-12">
												<div class="checkbox">
													<input type="checkbox" id="basic_checkbox_1"> <label for="basic_checkbox_1">아이디 <a href="#" class="text-warning"><b>저장</b></a></label>
												</div>
											</div>
											<!-- /.col -->
											<div class="col-12 text-center">
												<button type="submit" class="btn btn-info margin-top-10">회원가입</button>
											</div>
											<!-- /.col -->
										</div>
									</form>
									<div class="text-center">
										<p class="mt-15 mb-0">
											이미 아이다가 있으세요?<a href="${pageContext.request.contextPath}/signin" class="text-danger ms-5"> 로그인</a>
										</p>
									</div>
								</div>
							</div>

							<div class="text-center">
								<p class="mt-20 text-white">- Register With -</p>
								<p class="gap-items-2 mb-20">
									<a class="btn btn-social-icon btn-round btn-facebook" href="#"><i class="fa fa-facebook"></i></a> <a class="btn btn-social-icon btn-round btn-twitter" href="#"><i class="fa fa-twitter"></i></a> <a class="btn btn-social-icon btn-round btn-instagram" href="#"><i class="fa fa-instagram"></i></a>
								</p>
							</div>
						</div>
					</div>
				</div>
			</form:form>
		</div>
	</div>


	
	<div class="modal center-modal fade" id="modal-center" tabindex="-1">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<h5 class="modal-title">인증번호 입력</h5>
			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		  </div>
		  <div class="modal-body">
			<p>인증 번호를 입력해주세요</p>
			<input type="password" id="emailChk-pwd">
		  </div>
		  <div class="modal-footer modal-footer-uniform">
			<button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
			<button onclick="emailChkSubmit()" type="button" data-bs-dismiss="modal" class="btn btn-primary float-end">확인</button>
		  </div>
		</div>
	  </div>
	</div>
	
	
	<script src="${ pageContext.request.contextPath }/resources/dash/js/vendors.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/chat-popup.js"></script>
    <script src="${ pageContext.request.contextPath }/resources/assets/icons/feather-icons/feather.min.js"></script>	
    <script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/sweetalert/sweetalert.min.js"></script>
    <script src="${ pageContext.request.contextPath }/resources/js/sweet-alert.js"></script>
 	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>		 
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/notification.js"></script> 
 </body>
</html>