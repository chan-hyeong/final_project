<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
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

<form action="">

	<table cellpadding=15 cellspacing=0 align="center">
		<tr>
			<!-- 주문매장 표시 -->
			<td>
				<strong>판교H스퀘어점 </strong><br> 경기도 성남시 분당구 판교역로231, 에이치스퀘어(삼평동)
			</td><!-- ${OrderMenu.s_code} 를 이용한 매장 정보도 받아와야겠구나 -->
			<td><a href="#">(변경)</a></td>
		</tr>
		
		<tr><td colspan="2"><hr></td></tr>

		<tr>
			<!-- 포장 체크 여부? -->
			<td colspan="2"><input type="checkbox" id="isTakeout"> <label
				for="isTakeout"><strong>전체 포장</strong> <br>(음료는 캐리어에, 푸드/기타는 종이백에 포장)
			</label></td>
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
		<c:forEach var="i" begin="1" end="1"> <%-- var="list" items="${orderMenuList }" --%>
			<tr>
				<td><strong>아이스 슈 크림 라떼</strong></td> <!-- ${list.name}-->
				<td><a href="#">△</a> </td>
			</tr>
			<tr>
				<td>￦ 7,000원</td><!-- ${list.price}-->
				<td></td>
			</tr>
			<tr>
				<td colspan="2"><hr></td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;ICED / Tall / 머그컵</td> <!-- ${list.option1}-->
				<td>5,800원</td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;에스프레소 샷 2</td><!-- ${list.extra1}-->
				<td>600원</td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;바닐라 시럽 4</td><!-- ${list.vege}-->
				<td>600원</td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;SBC Free Extra D/C</td><!-- ${list}.할인내역??}-->
				<td>-600원</td>
			</tr>
			<tr>
				<td colspan="2"><hr></td>
			</tr>
		</c:forEach>



		<tr bgcolor="gray">
			<td>총 주문 금액</td>
			<td>21,100원</td><!-- ${OrderMenu.totalPrice}-->
		</tr>
		<tr bgcolor="gray">
			<td>총 할인 금액</td>
			<td><font color=red>-1,200원</font></td>
		</tr>

		<tr>
			<td colspan="2"><hr></td>
		</tr>
		<tr>
			<td>최종 결제금액</td><!-- ${OrderMenu.totalPrice}-->
			<td>19,900원</td>
		</tr>

		<tr>
			<td colspan="2">
			<a href="menulist.do"><button style="width: 25%;">취 소</button></a>&nbsp;&nbsp;
			<button style="width: 70%;">결제 및 주문하기</button>
			</td>
		</tr>


	</table>
</form>


</body>
</html>