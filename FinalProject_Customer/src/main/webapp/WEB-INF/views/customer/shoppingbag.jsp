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
	<c:set var="total" value="0"/>
		<c:forEach var="dlist" items="${order_detail}">
			<form action="shoppingbag.do">
			${dlist.m_name}${dlist.o_price}<br>
			<input type="hidden" value="${dlist.order_num}" name="order_num">
			<c:set var="sum" value="${dlist.o_price}"/>
			<c:set var="option1" value="${dlist.o_option1}"/>
			<c:if test="${!empty option1 }">
				${dlist.o_option1}
				${dlist.o_option1_num}개${dlist.o_option1_price}<br>
				<c:set var="sum">${sum+dlist.o_option1_price}</c:set>
			</c:if>
			<c:set var="option2" value="${dlist.o_option2}"/>
			<c:if test="${!empty option2 }">
				${dlist.o_option2}
				${dlist.o_option2_num}개${dlist.o_option2_price}<br>
				<c:set var="sum">${sum+dlist.o_option2_price}</c:set>
			</c:if>
			<c:set var="option3" value="${dlist.o_option3}"/>
			<c:if test="${!empty option3 }">
				${dlist.o_option3}
				${dlist.o_option3_num}개${dlist.o_option3_price}<br>
				<c:set var="sum">${sum+dlist.o_option3_price}</c:set>
			</c:if>
			<button value="delete" name="command">delete</button>
				${sum}	
			<c:set var="total">${total+sum}</c:set>			
		</form>
		<hr>
		</c:forEach>
		${total}
	<div>
		<input type="button" value="결제하기">
	</div>
</body>
</html>