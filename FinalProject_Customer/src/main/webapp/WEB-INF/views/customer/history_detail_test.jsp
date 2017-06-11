<!-- 2017. 6. 2. ���� 12:32:46 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
table{
	width: 90%;
	font-size:small; 
	border: 1px solid white;
	margin: 5%;
}
hr.name{
	color:black;
	border: thin solid;
}
.p01{
	padding:5px;
	font-weight: 800;
}
#menu_name{
	font-weight: 800;
}
.ch01{
	padding:15px;
}
</style>

</head>
<body>

	<!-- 세로로 보여주기 --> 
	<!-- 장바구니 테이블 -->
 <table cellpadding=0 cellspacing=0>
	 	<tr>
	 		<th colspan="2">주문 정보</th>
	 	</tr>
	 	<tr><td colspan="2"><hr class="name"></td></tr>
	    <tr id="header1">
	       <td colspan="2">주문 번호 <b style="float:right;">${order_detail_list[0].order_num }</b></td>
	    </tr>
	    <tr><td colspan="2"><hr></td></tr>
	    
	     <tr>
	       <td colspan="2">주문 시간   <b style="float:right;"> ${orderitem.order_date}</b></td>
	    </tr>
	    <tr><td colspan="2"><hr></td></tr>
<%-- 	    <tr>
	       <td><!-- order_status --><b>${orderitem.order_status}<br> 
	          ${orderitem.order_date}<fmt:formatDate value="${orderitem.order_date}" pattern="yyyy-MM-dd HH:mm"/></b>
	       </td>
	       <td style="float:right;width:45%;">지점정보 나와야함</td>
	    </tr>
	    <tr><td colspan="2"><hr></td></tr> --%>
	    
	    <tr id="header1">
	 		<th colspan="2">매장 정보</th>
	    </tr>
	    <tr><td colspan="2"><hr class="name"></td></tr>
	    
	    <tr>
	       <td colspan="2">주문 매장 <b style="float:right;"> ${store_info.s_name} 점 </b> </td>
	    </tr>
	    <tr><td colspan="2"><hr></td></tr>
	    
	    <tr>
	       <td colspan="2">매장 주소 <b style="float:right;"> ${store_info.s_address }</b> </td>
	    </tr>
	    <tr><td colspan="2"><hr></td></tr>
	    
	   <!--  <tr>
	       <td colspan="2">수령 방법 <b style="float:right;"> ----매장 내 직접 수령---- </b> </td>
	    </tr>
 -->	    
 		<tr><td colspan="2"><hr></td></tr>
	    
	    <tr id="header1">
	       <th colspan="2">주문 내역</th>
	    </tr>
	     <tr><td colspan="2"><hr class="name"></td></tr>
	 
	    <c:forEach var="list" items="${order_detail_list}" varStatus="status">
	       <tr>
	          <td id="menu_name">${list.m_name}</td>
	          <td style="float:right;" id="menu_price"><b><fmt:formatNumber>${list.o_price}</fmt:formatNumber> 원</b></td>
	       </tr>
	       <tr><td colspan="2"><hr></td></tr>
	    
	    <tr>
	       <td colspan="2" class="ch01">기본 선택
	        <div id="vege" style="float:right;">  
	        	${list.vege} / 
	        	${list.PAN} /
	        	${list.sauce}
	        </div> 
	        </td>
	    </tr>
	    <!-- 널이면 안나오게 -->
		<c:if test="${list.o_option1_num ne null}">
	     <tr>
	       <td colspan="2" class="ch01">추가 선택 
		     <div id="option" style="float:right;">
		     +가격<br>
		     <p style="font-size: x-small;">
		      (
		      ${list.o_option1_num} ${list.o_option1} ${list.o_option1_num > 0 ? '' : '' }
			  ${list.o_option2_num} ${list.o_option2} ${list.o_option2_num > 0 ? '' : '' }
			  ${list.o_option3_num} ${list.o_option3} ${list.o_option3_num > 0 ? '' : '' }
			  ${list.o_option4_num} ${list.o_option4} ${list.o_option4_num > 0 ? '' : '' }
			  ${list.o_option5_num} ${list.o_option5}
			  )
			  </div>
	       </td>
	    </tr>
	   </c:if>
	   <!--  -->
	    <tr><td colspan="2"><hr></td></tr>
	
	       
	       <tr style="display:none">
	          <td>
	          <%-- ${total_amount = total_amount + list.menu_amount}
	          ${total_price = total_price + list.total_price} --%>
	          </td>
	       </tr>
	       
	       <%-- <c:if test="${!status.last}">
	       <tr>
	          <td colspan="2"><hr></td>
	       </tr> 
	       </c:if>
	       --%>
	    </c:forEach>
	    
<%--  카드	    <tr>
		    <td colspan="2" id="option">
	    		<b><c:choose>
	    			<c:when test="${orderitem.order_payment eq 'card'}">SUBWAY CARD</c:when>
	    			<c:when test="${orderitem.order_payment eq 'credit'}">신용카드</c:when>
	    			<c:when test="${orderitem.order_payment eq 'ssg'}">SSG PAY</c:when>
	    			<c:otherwise>!! PAYMENT METHOD ERROR !!</c:otherwise>
	    		</c:choose></b>
		    	로 결제한 금액
		    </td>
	    </tr>
	    <tr><td colspan="2"><hr></td></tr> --%>

	    <tr>
	       <td colspan="2">수량 <b id="vege" style="float:right;">   ${fn:length(order_detail_list)}개 </b> </td>
	    </tr>
	    <tr><td colspan="2"><hr></td></tr>
	    
<%-- 	    <tr>
	       <td>수량  ${fn:length(order_detail_list)}개</td>
	       <td  style="float:right;" id="highlight"> <b><fmt:formatNumber>${orderitem.o_totalprice}</fmt:formatNumber></b>원</td>
	    </tr> --%>
	 </table>
	 <!-- 장바구니 테이블 end -->
	


<!-- 최종 -->

<div>
	<table cellpadding=0 cellspacing=0 style="background: rgba(0,0,0,.075);">
	    <tr id="header1">
	       <td colspan="2" class="p01">결제 수단
	        <b style="float:right;">
	       	<c:choose>
	    			<c:when test="${orderitem.order_payment eq 'card'}">SUBWAY CARD</c:when>
	    			<c:when test="${orderitem.order_payment eq 'credit'}">신용카드</c:when>
	    			<c:when test="${orderitem.order_payment eq 'ssg'}">SSG PAY</c:when>
	    			<c:otherwise>!! PAYMENT METHOD ERROR !!</c:otherwise>
	    	</c:choose>
	       </b></td>
	    </tr>
	     <tr id="header1">
	       <td colspan="2" class="p01">결제 금액 <b style="float:right;"><fmt:formatNumber>${orderitem.o_totalprice}</fmt:formatNumber>원</b></td>
	    </tr>
	</table>

</div>

	<%-- <!-- 가로로 보여주기 -->
	<table cellpadding=2 cellspacing=0 border=1>
		<th>번호</th>
		<th>메뉴명</th>
		
		<th>빵</th>
		
		<th>베이스</th>
		
		<th>옵션</th>
		
		<th>소스</th>
		
		<th>야채</th>
		
		<th>가격</th>
		
		<c:forEach items="${order_detail_list }" var="item">
			<tr>
				<td>${item.order_detail_num}</td>
				<td>${item.m_name}</td>
				<td>${item.PAN}</td>
				<td>
					${item.necessary1}
					${item.necessary2}
					${item.necessary3}
					${item.necessary4}
				</td>
				<td>
					${item.o_option1_num} ${item.o_option1} ${item.o_option1_num > 0 ? '<br>' : '' }
					${item.o_option2_num} ${item.o_option2} ${item.o_option2_num > 0 ? '<br>' : '' }	
					${item.o_option3_num} ${item.o_option3} ${item.o_option3_num > 0 ? '<br>' : '' }
					${item.o_option4_num} ${item.o_option4} ${item.o_option4_num > 0 ? '<br>' : '' }
					${item.o_option5_num} ${item.o_option5}
				</td>
				<td>${item.sauce}</td>
				<td>${item.vege}</td>
				<td align="right"><fmt:formatNumber>${item.o_price}</fmt:formatNumber> 원</td>
			</tr>
		</c:forEach>


	</table> --%>
</body>
