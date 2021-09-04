<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
<script src="${ pageContext.request.contextPath }/resources/js/jquery-3.6.0.min.js"></script>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>





<script>
	let idChk = "false"
	let emailChk = "false"
	
	$(document).ready(function() {	
		$('#myMsg').hover(function() {
			$(this).css("color" , "white")
		}, function() {
			$(this).css("color", "#3A1D1D")
		})
		
		$('#id_id').change(function(){
			idChk = "false"
			outmsg = "중복확인 필요합니다...";
			if($('#id_id').val().length < 5 ){
				outmsg = "5글자 이상 필요합니다."
				$("#idCkMessage").html(outmsg)
			}else if($('#id_id').val().length > 30 ){
				outmsg = "30글자 초과 할 수 없습니다."
				$("#idCkMessage").html(outmsg)
			}else{
				let id = $("#id_id").val()
				console.log("checking id  -> " +  id );
				
				$.ajax({
					type: 'get',
					url: "${pageContext.request.contextPath }/ajax/restBody.json",
					data : {
						id : id				
					},
					contentType: "application/x-www-form-urlencoded;charset=ISO-8859-15",
					datatype: 'json',
					success: function(data){
						console.log(data)
						console.log("success")
						if(data["result"] == "true"){							 
							outmsg  = "사용 할 수 있는 아이디 입니다.";
							idChk  = "true";							
						}else{
							outmsg = "이미 사용중인 아이디 입니다."										
						}
						$("#idCkMessage").html(outmsg)
					},
					error : function(){
						outmsg  = "아이디 중복확인중 문제가 발생 했습니다."
					}			
				});
			}

		})
			
		$('#selectEmail').change(function() {
			$("#selectEmail option:selected").each(function() {
				if ($(this).val() == '1') { //직접입력일 경우 
					$("#str_email02").val(''); //값 초기화 
					$("#str_email02").attr("disabled", false); //활성화 
				} else { //직접입력이 아닐경우 
					$("#str_email02").val($(this).text()); //선택값 입력 
					$("#str_email02").attr("disabled", true); //비활성화 
				}
			});
		});		
		  $("#myModal").click(function(){
			    $(".modal").fadeIn();
		  });		  
		  $(".exiting").click(function(){
			  $(".modal").fadeOut();
		  })	
	})
	
	function firstValidate() {	
		let check = false;
		let msg = ""		
		if(idChk == "false"){
			msg = "아이디 중복확인이 필요합니다."
		}else if($("#pw1").val() == "" ){
			msg = "비밀번호를 입력 바랍니다."			
		}
		else if($('#pw1').val().length < 5 ){
			msg = "비밀번호는 최소 다섯 글자 이상 필요 합니다."			
		}
		else if($("#pw1").val() != $("#pw2").val()) {
			msg = "비빌번호를 정확히 재입력 바랍니다."
		} else if($("#id_id").legnth < 5 ){
			msg = "아이디는 최소 다섯 글자 이상 필요합니다."			
		} else{			
			check = true;
		}
		if(check){
			let fullEmail  = $("#str_email01").val() + "@" + $("#str_email02").val() 
			console.log("full Email : " + fullEmail)
			$("#hiddenEmail").val( fullEmail )
			
			let fullPhone = $("#phoneCompany").val() + $("#phoneDigits").val()
			console.log("full Phone : " + fullPhone)
			$("#hiddenPhone").val(fullPhone)						
		}else{
			//$("#sendingMyMsg").text(msg)
			//$("#myModal").trigger("click");		
			alert(msg)
		}
		return check
	}
	
</script>

</head>
<body>
	회원가입
	<form:form method="post" onsubmit="return firstValidate();" modelAttribute="memberVO">
		<table style="width: 80%;">
			<tr>
				<th><span> <i class="fa fa-id-badge"></i></span></th>
				<td><form:input path="id" placeholder="아이디" type="text" id="id_id"/><span id="idCkMessage" style="color: red;">중복 확인이 필요 합니다.</span></td>
				<form:errors path="id" class="error"/>
			</tr>
			<tr>
				<th><span> <i class="fa fa-lock"></i></span></th>
				<td><form:input path="password" placeholder="비밀번호 입력" type="password" id="pw1"/></td>
				<form:errors path="password" class="error"/>
			</tr>
			<tr>
				<th><span> <i class="fa fa-lock"></i></span></th>
				<td><input name="password2" placeholder="비밀번호 다시 입력" type="password" id="pw2"/></td>
				
			</tr>
			<tr>
				<th><span> <i class="fa fa-user"></i></span></th>
				<td><form:input path="name" placeholder="이름" type="text"/></td>
				<form:errors path="name" class="error"/>
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
				<form:input id="hiddenEmail" path="email" hidden="true"/>
				<form:errors path="email" class="error"/>
			</tr>
			
			<tr>
				<th><span> <i class="fa fa-phone"></i></span></th>
				<td><select id="phoneCompany" name="threeDigits" style="max-width: 120px;">
						<option selected>010-</option>
						<option value="1">012-</option>
						<option value="2">031-</option>
						<option value="3">017-</option>
				</select> <input id="phoneDigits" name="phoneDigits" pattern="\d{3,4}-\d{4}" placeholder="핸드폰 번호 : xxxx-xxxx 형식으로 입력하세요" type="tel"></td>
				<form:input id="hiddenPhone" path="phone" hidden="true"/> 
				<form:errors path="phone" class="error"/>
			</tr>
			<tr>
				<th></th>
				<td>
					<input id=submitButton type="submit" value="Submit" />Create Account
					<!-- <button type="submit">Create Account</button> -->
					<p>
						이미 회원 이십니까? <a href="${pageContext.request.contextPath }/signin">로그인</a>
					</p>
				</td>
			</tr>
		</table>
	</form:form>

</body>
</html>