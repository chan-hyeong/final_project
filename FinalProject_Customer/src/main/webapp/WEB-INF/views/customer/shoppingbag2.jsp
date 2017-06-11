<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>



<style type="text/css">
#btn{
 	/* width: 200px; */
 	height: 50px;
 	font-size: x-large;
 	font-weight: bold;
 	margin: 5px;
}
div#item{
	border: 1px solid gray;
	width: 90%;
	padding: 10px;
}
div#nameprice{
	font-size: x-large;
	font-weight: bold;
	display: inline-block;
}
div#necessary, div#extra, div#vege{
	font-size: medium;
	margin-left: 15px;
	margin-right: 20%;
}
div#necessary{
	background-color: #fddee3;
}
div#extra{
	background-color: #d9e7ff;
}
div#vege{
	background-color: #efffd9;
}
div#total{
	border: 1px solid gray;
	width: 90%;
	padding: 10px;
	font-size: xx-large;
	font-weight: bold;
}

</style>



<title>${id} 님의 장바구니</title>


</head>
<body>
<!-- header -->
<jsp:include page="header.jsp"></jsp:include>
<br>
<br>
<br>
<br>
<br>
<br>
<br>


	<h1>장바구니</h1>



	<c:choose>
		<c:when test="${fn:length(detail_list) == '' || fn:length(detail_list) < 1 }">
			<h3>
			장바구니가 비었습니다.<br>
			<a href="menulist.do">"주문하러가기 "☜</a>
			</h3>

	</c:when>
		<c:otherwise>
		<!-- 장바구니 항목 출력 -->
		<form action="shoppingbag.do" method="post">
		<div style="border:1px solid gray; padding: 15px; " >
			<button id="btn" name="command" value="deleteAll" 
				onclick="javascript:return confirm('장바구니를 전부 다 비우시겠습니까?');">장바구니 비우기</button>
			<button id="btn" name="command" value="basketpayment" 
				onclick="javascript:return confirm('장바구니 내역을 결제합니다.');">장바구니 통 결제</button>
			<div id="total">
				총 ${fn:length(detail_list) } 개
				= 
				<fmt:formatNumber>
				${list_dto.o_totalprice}
				</fmt:formatNumber>원
			</div>
			<br><br>
			<!-- 장바구니 리스트 출력 -->
			<c:forEach var="item" items="${detail_list }" varStatus="index">
				<%-- <c:set var="vegeList">
					${item.o_vege1 eq '0'? '' : item.o_vege1}, 
					${item.o_vege2 eq '0'? '' : item.o_vege2}, 
					${item.o_vege3 eq '0'? '' : item.o_vege3}, 
					${item.o_vege4 eq '0'? '' : item.o_vege4}, 
					${item.o_vege5 eq '0'? '' : item.o_vege5}, 
					${item.o_vege6 eq '0'? '' : item.o_vege6}, 
					${item.o_vege7 eq '0'? '' : item.o_vege7}, 
					${item.o_vege8 eq '0'? '' : item.o_vege8} 
					</c:set> --%>
					
				<div id="item" >
					<!-- 인덱스 -->
					<div id="nameprice">
					${index.count} - 
					${item.m_code } &nbsp;&nbsp; <fmt:formatNumber>${item.o_price}</fmt:formatNumber>원
					<button name="delete_order_detail_num" value="${item.order_detail_num }" 
						onclick="javascript:return confirm('${item.m_code } 을 삭제하시겠습니까?')">내려놓기</button>
					</div>
					<!-- 코드, 네임 -->
					
					<div id="necessary">
					<hr>
						${item.o_pan } / 
						<b>${item.m_necessary1} 
						<c:if test="${item.m_necessary2_num>0}">+ ${item.m_necessary2}</c:if>
						<c:if test="${item.m_necessary3_num>0}">+ ${item.m_necessary3}</c:if>
						<c:if test="${item.m_necessary4_num>0}">+ ${item.m_necessary4}</c:if></b>
						/ <i>${item.o_sauce1} + ${item.o_sauce2}</i> 
						
						&lt;------- 기본가격도 여기 표시해주면 좋을듯
						<br>
					
					</div>
					
					<div id="extra">
					<hr>
						<c:if test="${item.o_option1_num>0}">
						└&nbsp;${item.o_option1_num} x ${item.o_option1} 
						&lt;------- 옵션별 가격 표시
						<br>
						</c:if>
						<c:if test="${item.o_option2_num>0}">
						└&nbsp;${item.o_option2_num} x ${item.o_option2}<br>
						</c:if>
						<c:if test="${item.o_option3_num>0}">
						└&nbsp;${item.o_option3_num} x ${item.o_option3}<br>
						</c:if>
						<c:if test="${item.o_option4_num>0}">
						└&nbsp;${item.o_option4_num} x ${item.o_option4}<br>
						</c:if>
						<c:if test="${item.o_option5_num>0}">
						└&nbsp;${item.o_option5_num} x ${item.o_option5}<br>
						</c:if>
					</div>
						
					<div id="vege">
					<hr>
					<%-- <c:forTokens var="v" items="${vegeList}" delims="," varStatus="i">
						${v} &nbsp;
						<c:if test="${i.count%3==0}">
							<br>
						</c:if>
					</c:forTokens> --%>
						${item.o_vege1 eq '0'? '' : item.o_vege1}
						${item.o_vege2 eq '0'? '' : item.o_vege2}
						${item.o_vege3 eq '0'? '' : item.o_vege3} 
						${item.o_vege4 eq '0'? '' : item.o_vege4} 
						${item.o_vege5 eq '0'? '' : item.o_vege5} 
						${item.o_vege6 eq '0'? '' : item.o_vege6} 
						${item.o_vege7 eq '0'? '' : item.o_vege7} 
						${item.o_vege8 eq '0'? '' : item.o_vege8} 
					
					</div>
				</div>
				<br>
			</c:forEach>
		</div>
		</form>
		</c:otherwise>
	</c:choose>
	
	<br>
	<br>
	<br>
	<br>
	<!-- footer -->
		<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>