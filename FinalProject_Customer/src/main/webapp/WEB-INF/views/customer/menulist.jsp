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
	<h1>메뉴리스트</h1>
	<c:forEach var="list" items="${menulist}">
		<div>
			<a href="payment.do?m_code=${ list.m_code }"><img
				src="${pageContext.request.contextPath}/img/${ list.m_code }.png"></a>
			${list.m_name}
		</div>
	</c:forEach>
	<a href="payment.do">클릭하면 해당상품 결제</a>
</body>
</html>