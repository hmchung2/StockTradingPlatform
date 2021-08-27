<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
hello <br>
<c:if test="${ empty userVO }">
	<a href="${pageContext.request.contextPath}/signin">로그인</a><br>
</c:if>
<c:if test="${ not empty userVO }">
	<a href="${pageContext.request.contextPath}/signout">로그아웃</a><br>	
	<a href="${pageContext.request.contextPath}/account/contract">계좌개설</a><br>	
	<a href="${pageContext.request.contextPath}/account/showall">계좌조회</a><br>	
</c:if>

<a href="${pageContext.request.contextPath}/signcontract">회원가입 하기</a><br>

</body>
</html>