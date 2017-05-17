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
	<h1>결제창으로 옴 </h1>
	
	<img src="${pageContext.request.contextPath}/img/${menudto.m_code}.png">
	${menudto.m_explain}<br>
	${menudto.m_name}<br>
 	<div>
 		<c:forEach var="olist" items="${option}" begin="0" end="8">
 			<input type="checkbox" name="${olist.m_code}" value="${olist.m_name}">${olist.m_name}&nbsp;
 		</c:forEach>
 	</div>
 	<div> 		
		<select>
			<option>빵선택</option>
			<c:forEach var="olist" items="${option}" begin="9" end="14">
				<option  value="${ olist.m_code }">${olist.m_name}</option>
			</c:forEach>
		</select> 		
 	</div>
 	<div> 		
		<select>
			<option>소스선택</option>
			<c:forEach var="olist" items="${option}" begin="15" end="31">
				<option  value="${ olist.m_code }">${olist.m_name}</option>
			</c:forEach>
		</select>
		<select>
			<option>소스선택</option>
			<c:forEach var="olist" items="${option}" begin="15" end="31">
				<option  value="${ olist.m_code }">${olist.m_name}</option>
			</c:forEach>
		</select> 
 	</div>
 	<div>
 		<select>
			<option>옵션</option>
			<c:forEach var="olist" items="${option}" begin="32" end="36">
				<option  value="${ olist.m_code }">${olist.m_name}</option>
			</c:forEach>
		</select> 
 	</div>
	<div>
		<a href="history.do">결제</a>&nbsp;
		<a href="menulist.do">취소</a>&nbsp;
		<a href="shoppingbag.do">장바구니담기</a>&nbsp;
	</div>
</body>
</html>