<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>${id} 님의 장바구니</title>

<style type="text/css">

div#item{
	border: 1px solid gray;
    width: 70%;
	padding: 10px;
	margin-left: 15%;
}
div#nameprice{	
	font-weight: bold;
	display: inline-block;
	float: left;
}

div#total{
	border: 1px solid gray;
    width: 70%;
    padding: 10px;
    font-weight: bold;
    margin-left: 15%;
    text-align: center;
}
  div.tit01{font:bold 24px/30px "malgun gothic","Dotum"," Gulim","Arial","verdana","Helvetica",sans-serif;  color:#111; text-align:center;}

.flip{
	cursor: pointer;
    width: 80%;
    margin-left: 10%;
	height: 20px;
}
hr{
	width: 80%;
}
body{
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
    background: url(${pageContext.request.contextPath}/css/m03.png);
    background-repeat: no-repeat;
    background-position: top center;
}
div.left{
	float:left; margin-left: 20%;
}
div.right{
	float:right; margin-right: 20%;
}
div.11{
	border: solid;
}
.btnBottom{
	width: 100%;
    position: fixed;
    bottom: 0;
}
</style>
<script> 
$(document).ready(function(){
   $(".11").hide();
});

function flip(data) {
	var name = data;
	var down = document.getElementById('down');
	$("#panel"+ name +"").slideToggle("slow");
	
}

</script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div style="margin-top: 10%;">
	 <div class="tit01">${id } 회원님의 장바구니</div>
	<br>
	<c:choose>
		<c:when test="${fn:length(detail_list) == '' || fn:length(detail_list) < 1 }">
		<center><div >
			<h3>
			장바구니가 비었습니다.<br>
			<a href="menulist.do">"주문하러가기 "☜</a>
			</h3>
		</div>
		</center>
	</c:when>
	
	<c:otherwise>
		<!-- 장바구니 항목 출력 -->
		<form action="shoppingbag.do" method="post">
		<div style="margin-left: 5%;">
			
			<br><br>
			<!-- 장바구니 리스트 출력 -->
			<c:forEach var="item" items="${detail_list}" varStatus="index">					
					<!-- 인덱스 -->
				<div class="flip" onclick="flip(${ index.index });">
					<div id="nameprice">
					${index.count} - 
					${item.m_code } &nbsp;&nbsp; <fmt:formatNumber>${item.o_price}</fmt:formatNumber>원
					</div>
					<button name="delete_order_detail_num" value="${item.order_detail_num }" class="btn btn-default"
						onclick="javascript:return confirm('${item.m_code } 을 삭제하시겠습니까?')" style="float: right;">내려놓기</button>
				</div>
			<hr>
					<!-- 코드, 네임 -->
				<div class="11" id="panel${index.index }" style="width: 60%;
    padding: 1%;
    font-weight: 800;
    background: rgba(0,0,0,.075);
    margin-left: 20%;">	
						빵 
						<b style="float:right;">${item.o_pan }</b>
						<br>
							필수옵션
							<b style="float:right;">${item.m_necessary1} 
							<c:if test="${item.m_necessary2_num>0}">+ ${item.m_necessary2}</c:if>
							<c:if test="${item.m_necessary3_num>0}">+ ${item.m_necessary3}</c:if>
							<c:if test="${item.m_necessary4_num>0}">+ ${item.m_necessary4}</c:if></b>	
						<br>
							소스
						<b style="float:right;">	${item.o_sauce1} + ${item.o_sauce2}</b>
						<br>
							추가 옵션 
						<b style="float:right;">	
						<c:if test="${item.o_option1_num>0}">
							&nbsp;${item.o_option1_num} x ${item.o_option1} 
							</c:if>
							<c:if test="${item.o_option2_num>0}">
							&nbsp;${item.o_option2_num} x ${item.o_option2}
							</c:if>
							<c:if test="${item.o_option3_num>0}">
							&nbsp;${item.o_option3_num} x ${item.o_option3}
							</c:if>
							<c:if test="${item.o_option4_num>0}">
							&nbsp;${item.o_option4_num} x ${item.o_option4}
							</c:if>
							<c:if test="${item.o_option5_num>0}">
							&nbsp;${item.o_option5_num} x ${item.o_option5}
							</c:if>
						</b>
						<br>
						
							기본야채
						<b style="float:right;">
						${item.o_vege1 eq '0'? '' : item.o_vege1}
						${item.o_vege2 eq '0'? '' : item.o_vege2}
						${item.o_vege3 eq '0'? '' : item.o_vege3} 
						${item.o_vege4 eq '0'? '' : item.o_vege4} 
						${item.o_vege5 eq '0'? '' : item.o_vege5} 
						${item.o_vege6 eq '0'? '' : item.o_vege6} 
						${item.o_vege7 eq '0'? '' : item.o_vege7} 
						${item.o_vege8 eq '0'? '' : item.o_vege8} </b>
						<br>
						<br>	
				</div>
			</c:forEach>
			
			<br>
			<div id="total">
				총 수량 : ${fn:length(detail_list) } 개
				<br>
				합계 : 
				<fmt:formatNumber>
				${list_dto.o_totalprice}
				</fmt:formatNumber>원
			</div>
			<br>
			<div style="text-align: center;">
			<button id="btn" name="command" value="deleteAll" class="btn btn-default"
				onclick="javascript:return confirm('장바구니를 전부 다 비우시겠습니까?');">장바구니 비우기</button>
			<button id="btn" name="command" value="basketpayment" class="btn btn-default"
				onclick="return session();">장바구니 통 결제</button>
			</div>
		</div>
		</form>
		</c:otherwise>
	</c:choose>
	
			<!--------------매장 선택 정보--------------------------------------- -->
		<a href="store2.do" onclick="return store();">
			<button class="btnBottom btn-warning" style="height: 8%;">
					<font color="white">
					<c:choose>
						<c:when test="${selected_store eq null}">
							주문하실 매장을 먼저 선택해주세요
						</c:when>
						<c:otherwise>
							현재 선택된 매장은 <font size="5">${selected_store.s_name}</font><%-- (${selected_store.s_address})--%> 점 입니다
						</c:otherwise>
					</c:choose>
					</font>
			</button>
		</a>		
		<!---------------------------------------------------------------- -->
</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>

<script>
function session(){
	var id = "${id}";
	var selected_store = "${selected_store.s_code}";
	var selected_store_name = "${selected_store.s_name}";
	
	if(selected_store == ""){
		if ( confirm('매장을 먼저 선택해주세요') ) window.location.href="store2.do";
		return false; 
	}
	
	return confirm(selected_store_name + ' 지점에서 장바구니 내역을 결제합니다.') ;
}//end function 

</script>