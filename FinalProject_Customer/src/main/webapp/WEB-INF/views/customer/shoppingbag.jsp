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
	<form action="shoppingbag.do">
	<c:set var="index" value="0"/>
		<c:forEach var="dlist" items="${order_detail}">			
			${dlist.m_name}${dlist.o_price}<br>
			<input type="text" value="${dlist.order_num}" name="order_num">
			<input type="text" value="${dlist.order_detail_num}" name="order_detail_num">
			<c:set var="sum" value="${dlist.o_price}"/>
			<br>
			<c:if test="${dlist.o_option1_num > 0 }">
				${dlist.o_option1}
				${dlist.o_option1_num}개${dlist.o_option1_price}<br>
				<c:set var="sum">${sum+dlist.o_option1_price}</c:set>
			</c:if>
			<c:if test="${dlist.o_option2_num > 0 }">
				${dlist.o_option2}
				${dlist.o_option2_num}개${dlist.o_option2_price}<br>
				<c:set var="sum">${sum+dlist.o_option2_price}</c:set>
			</c:if>
			<c:if test="${dlist.o_option3_num > 0 }">
				${dlist.o_option3}
				${dlist.o_option3_num}개${dlist.o_option3_price}<br>
				<c:set var="sum">${sum+dlist.o_option3_price}</c:set>
			</c:if>
			<c:if test="${dlist.o_option4_num > 0}">
				${dlist.o_option4}
				${dlist.o_option4_num}개${dlist.o_option4_price}<br>
				<c:set var="sum">${sum+dlist.o_option4_price}</c:set>
			</c:if>
			<c:if test="${dlist.o_option5_num > 0}">
				${dlist.o_option5}
				${dlist.o_option5_num}개${dlist.o_option5_price}<br>
				<c:set var="sum">${sum+dlist.o_option5_price}</c:set>
			</c:if>
			<button value="delete/${index}" name="command">delete</button>
				${sum}
			<c:set var="total">${total+sum}</c:set>
			<c:set var="index">${index+1}</c:set>
		<hr>
		</c:forEach>
		${total}
		</form>
	<div>
		<input type="button" value="결제하기">
		<a href="main.do">main</a>
	</div>
</body>
</html>