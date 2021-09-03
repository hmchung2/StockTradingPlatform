<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	<c:forEach items="${ list }" var="accountVO" varStatus="loop">
		<form action="${pageContext.request.contextPath }/account/${map.destination }" method="post">
			<table border="1">
				<tr>
					<th>별칭</th>
					<td>${accountVO.nick }
						<input name="nick"  value="${accountVO.nick }" hidden="true"/>
					</td>					
				</tr>
				<tr>
					<th>계좌번호</th>
					<td>${accountVO.gcaNumber }
						<input name="gcaNumber" value="${accountVO.gcaNumber }" hidden="true"/>
					</td>
				</tr>
				<tr>
					<th>잔액</th>
					<td>${accountVO.balance }
						<input name="balance" value="${accountVO.balance }" hidden="true"/>
					</td>
				</tr>
				<tr>
					<th>계좌 생성일</th>
					<td>${accountVO.regDate }
						<input name="regDate" value="${accountVO.regDate }" hidden="true"/>
					</td>
				</tr>
				
				<tr>
					<th>${map.directMsg}</th>
					<td>
						<input type="text" name="gcaPassword" placeholder="비밀번호" />
						<button type="submit">입력</button>						
					</td>				
				</tr>				
			</table>
		</form>
	</c:forEach>
</div>
		
</body>
</html>