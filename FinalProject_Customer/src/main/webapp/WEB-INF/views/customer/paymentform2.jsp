<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>this is payment form .jsp</title>

<style type="text/css">
table {
	border: 1px black solid;
}
input#card, #credit, #ssg{
	width: 20px;
	height: 20px;
}

</style>

</head>
<body>
	<h1>페이먼트 폼 페이지</h1>

<form action="payment.do">
<input type="hidden" name="order_num" value="${list_dto.order_num}"> 
	<table cellpadding=15 cellspacing=0 align="center">
		<tr>
			<!-- 주문매장 표시 -->
			<td>
				<strong>${list_dto.s_code } 판교H스퀘어점 </strong><br>
				주소자리 :  경기도 성남시 분당구 판교역로231, 에이치스퀘어(삼평동)
			</td><!-- ${OrderMenu.s_code} 를 이용한 매장 정보도 받아와야겠구나 -->
			<td><a href="#">(변경)</a></td>
		</tr>
		
		<tr><td colspan="2"><hr></td></tr>

		<tr>
			<!-- 포장 체크 여부? -->
			<td colspan="2">
				<input type="checkbox" id="isTakeout"> 
				<label for="isTakeout"><strong>전체 포장</strong> <br>(음료는 캐리어에, 푸드/기타는 종이백에 포장)</label>
				<br><br>
				<input type="checkbox" id="isCutting"> 
				<label for="isCutting"><strong>커팅</strong> <br>(30cm 이상 샌드위치만 보여줄거임)</label>
			</td>
		</tr>
		
		<tr><td colspan="2"><hr></td></tr>

		<tr>
			<!-- 결제수단 -->
			<td colspan="2"><b>결제 수단 </b> <br> <input type="radio"
				name="paymentMethod" id="card" value="card" checked="checked"> <label
				for="card">스타벅스카드 </label> &nbsp; <input type="radio"
				name="paymentMethod" id="credit" value="credit"> <label
				for="credit">신용카드 </label> &nbsp; <input type="radio"
				name="paymentMethod" id="ssg" value="ssg"> <label for="ssg">SSG
					PAY </label> &nbsp;</td>
		</tr>
		

		<tr><td colspan="2"><hr></td></tr>

		<tr>
			<!-- 쿠폰 사용  -->
			<td><b>쿠폰 사용</b></td>
			<td><strong><a href="#">></a></strong></td>
		</tr>
		
		<tr><td colspan="2"><hr></td></tr>

		<tr>
			<!-- 제휴할인 -->
			<td><b>제휴 할인</b></td>
			<td><strong><a href="#">></a></strong></td>
		</tr>

		<tr><td colspan="2"><hr></td></tr>

		<tr>
			<td colspan="2" bgcolor="gray">최종 결제할 메뉴</td>
		</tr>

			<!-- 선택한 메뉴 정보를 리스트로 받아서 반복문 돌림  -->
			<c:forEach var="item" items="${detail_dto_list}" varStatus="index"> <%-- var="list" items="${orderMenuList }" --%>
				<tr>
					<td style="padding-left: 10px;"><strong>이름 : ${item.m_code }</strong></td> <!-- ${list.name}-->
					<td><a href="#">△</a> </td>
				</tr>
 				<tr>
					<td>￦ 7,000원
					<fmt:formatNumber> ${item.o_price}</fmt:formatNumber> 원
					</td>
					<td></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;${item.o_pan } / 
					<b>${item.m_necessary1} 
					<c:if test="${item.m_necessary2_num>0}">+ ${item.m_necessary2}</c:if>
					<c:if test="${item.m_necessary3_num>0}">+ ${item.m_necessary3}</c:if>
					<c:if test="${item.m_necessary4_num>0}">+ ${item.m_necessary4}</c:if></b>
					/ <i>${item.o_sauce1} + ${item.o_sauce2}</i> </td> 
					<td>5,800원 기본가격</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;에스프레소 샷 2</td><%-- ${item.extra1} --%>
					<td>600원</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;바닐라 시럽 4</td><%-- ${item.vege} --%>
					<td>600원</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;SBC Free Extra D/C</td><%-- ${item}.할인내역??} --%>
					<td>-600원</td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr> 
			</c:forEach>
		<tr bgcolor="gray">
			<td>총 주문 금액</td>
			<td><fmt:formatNumber>${list_dto.o_totalprice }</fmt:formatNumber> 원</td><!-- ${OrderMenu.totalPrice}-->
		</tr>
		<!-- <tr bgcolor="gray">
			<td>총 할인 금액</td>
			<td><font color=red>원</font></td>
		</tr> -->

		<tr>
			<td colspan="2"><hr></td>
		</tr>
		<tr>
			<td>최종 결제금액</td><!-- ${OrderMenu.totalPrice}-->
			<td><fmt:formatNumber> ${list_dto.o_totalprice }</fmt:formatNumber> 원</td>
		</tr>

		<tr>
			<td colspan="2">
			<a href="main.do"><input type="button" value="취 소" style="width: 25%;"></a>&nbsp;&nbsp;<!-- javascript:history.back() -->
			<button name="command" value="${command }" style="width: 70%;">결제 및 주문하기</button>
			</td>
		</tr>


	</table>
</form>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>