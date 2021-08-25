<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

	window.onload = function(){

		if('${msg}' !=  "")
			alert('${msg}')
	} 
	function isNull(obj ,str){
		if(obj.value ==""){
			alert(str)
			obj.focus()
			return true
		}
		return false
	}
	
	function checkForm(){
		let f = document.loginForm
		if(isNull(f.id , "아이디를 입력하세요")){
			return false
		}			
		if(isNull(f.password , "비밀번호를 입력하세요")){
			return false
		}				
		return true
	}
</script>

</head>


<body>
<header>
<%-- 	<jsp:include page="/jsp/include/topMenu.jsp" /> --%>
	</header>
	
	
	<section>
		<div align="center">
			<hr>
			<h2>로그인</h2>
			<hr>
			<br>
			<form method="post" onsubmit="return checkForm()">
				<table>
					<tr>
						<th>ID</th>
						<td><input type="text" name="id"></td>
					</tr>
					<tr>
						<th>PASSWORD</th>
						<td><input type="password" name="password"></td>
					</tr>					
					<tr>
						<td colspan="2">
							<input type="checkbox"> 아이디 저장
						</td>
					</tr>					
				</table>
				<br>
				<input type="submit" value="로그인">				
			</form>
		</div>
		<hr>
		
	</section>	
	<footer>
<%-- 		<%@ include file="/jsp/include/bottom.jsp" %>		 --%>
	</footer>
</body>
</html>