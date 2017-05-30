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
	border: 1px black solid;
	padding : 5px;
	width: 50%;
}
</style>
</head>
<body>
	<a href="shoppingbag.do"><h3>장바구니로 가기</h3></a>
	<a href="main.do"><h3>메인으로 가기</h3></a>

	<h1>메뉴리스트</h1>
	<c:forEach var="list" items="${menulist}">
		<a href="orderdetail.do?m_code=${ list.m_code }">
			<div id="menulist" style="display: inline-table;">
			<img src="${pageContext.request.contextPath}/img/${ list.m_code }.png" style="width: 65%;" >
			
			<div>
				<h2>
				${list.m_name}<br>
				<fmt:formatNumber currencySymbol="￦">${list.m_price }</fmt:formatNumber>원
				</h2>
			</div>
			</div>
		</a>
		<br><br>
	</c:forEach>
</body>
</html>
	<!-- <a href="payment.do">클릭하면 해당상품 결제</a> -->