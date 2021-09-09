<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/layout.css" />
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/board.css" />
<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/jquery-3.6.0.min.js"></script>

</head>
<body>
 Creating Account
 
 <form:form method="post" modelAttribute="accountVO">
	 <table>
	 <tr>
	 	<th>비밀번호</th>
	 	<td>
	 		<form:input path="gcaPassword"></form:input>
	 		<form:errors path="gcaPassword"></form:errors>
	 	</td>
	 </tr>
	 <tr>
	 	<th>비밀번호 확인</th>
	 	<td>
	 		<input type="password" id="pw2">
	 	</td>
	 </tr>	 
	 <tr>
	 	<th>계좌 별칭</th>
	 	<td>
	 		<form:input path="nick"></form:input>
	 		<form:errors path="nick"></form:errors>
	 	</td>
	 </tr>
	 
	 <tr>
	 	<th>초기 입금</th>
	 	<td>
	 		<form:input path="balance"></form:input>
	 		<form:errors path="balance"></form:errors>	 		
	 	</td>
	 </tr>
	 <tr>
	 	<th></th>
	 	<td>
	 		<button type="submit">생성</button>	 		
	 	</td>
	 </tr>
	 
	 </table>
 </form:form>
 
</body>
</html>