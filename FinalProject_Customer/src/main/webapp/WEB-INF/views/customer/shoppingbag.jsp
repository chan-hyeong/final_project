<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>장바구니</h1>



	<form action="paymentform.do">
		<table>
			<c:forEach var="i" items="${detail_list }">
				<tr>
					<td>${i }<br>
					</td>
					<td></td>
				</tr>
			</c:forEach>
			<tr>
				<td></td>
				<td><button name="command" value="basketpayment">장바구니 통 결제</button></td>
			</tr>
		</table>

	</form>
</body>
</html>