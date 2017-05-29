<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
div#menulist {
	background-color : #009664;
	border: 1px black solid;
	padding : 5px;
}
</style>
</head>
<body>
	<h1>메뉴리스트</h1>
	<c:forEach var="list" items="${menulist}">
		<div id="menulist">
			<a href="orderdetail.do?m_code=${ list.m_code }">
			<img src="${pageContext.request.contextPath}/img/${ list.m_code }.png" style="width: 30%;">
			
			${list.m_name}<br>
			<fmt:formatNumber currencySymbol="￦">${list.m_price }</fmt:formatNumber>원
			</a>
		</div><br>
	</c:forEach>
	<!-- <a href="payment.do">클릭하면 해당상품 결제</a> -->
</body>
</html>