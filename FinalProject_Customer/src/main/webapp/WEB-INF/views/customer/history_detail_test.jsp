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
table th{
	background-color: pink;	
} */
</style>

</head>
<body>

	<!-- 세로로 보여주기 --> 
	<!-- 장바구니 테이블 -->
	 <table cellpadding=0 cellspacing=0>
	    <tr id="header1">
	       <td colspan="2">주문 번호 <b style="float:right;">${order_detail_list[0].order_num }</b></td>
	    </tr>
	    <tr><td colspan="2"><hr></td></tr>
	    
	    <tr>
	       <td><!-- order_status --><b>${orderitem.order_status}<br> 
	          ${orderitem.order_date}<%-- <fmt:formatDate value="${orderitem.order_date}" pattern="yyyy-MM-dd HH:mm"/> --%></b>
	       </td>
	       <td style="float:right;width:45%;">지점정보 나와야함</td>
	    </tr>
	    <tr><td colspan="2"><hr></td></tr>
	    
	    <tr id="header1">
	       <td colspan="2">주문 매장 정보</td>
	    </tr>
	    <tr><td colspan="2"><hr></td></tr>
	    
	    <tr>
	       <td colspan="2">
		       <b> ${orderitem.s_code } --주문매장정보가 여기 --</b>
		       <br> ----매장 내 직접 수령---- 
		       <br> ----매장 주소----
	       </td>
	    </tr>
	    <tr><td colspan="2"><hr></td></tr>
	    
	    <tr id="header1">
	       <td colspan="2">주문 상세 내역</td>
	    </tr>
	    <tr><td colspan="2"><hr></td></tr>
	 
	    <c:forEach var="list" items="${order_detail_list}" varStatus="status">
	       <tr>
	          <td id="menu_name">${list.m_code}</td>
	          <td style="float:right;" id="menu_price"><fmt:formatNumber>${list.o_price}</fmt:formatNumber> 원</td>
	       </tr>
	       <tr><td colspan="2"><hr></td></tr>
	       <tr>
	          <td id="option" style="padding-left: 5%;">
	         		<p style="float:left">${list.o_option1_num} ${list.o_option1} ${list.o_option1_num > 0 ? '<br>' : '' }</p>
					<p style="float:left">${list.o_option2_num} ${list.o_option2} ${list.o_option2_num > 0 ? '<br>' : '' }</p>	
					<p style="float:left">${list.o_option3_num} ${list.o_option3} ${list.o_option3_num > 0 ? '<br>' : '' }</p>
					<p style="float:left">${list.o_option4_num} ${list.o_option4} ${list.o_option4_num > 0 ? '<br>' : '' }</p>
					<p style="float:left">${list.o_option5_num} ${list.o_option5}</p>
	          </td>
	          <td  style="float:right;" id="option">
	          	가격 나와야함 
	          </td>
	       </tr>
	       <tr>
	          <td id="vege" style="padding-left: 5%;">
	            <p style="float:left"class="option_cup_size"> ${ list.vege} / </p>
	          </td>
	          <td  style="float:right;" id="option">
	          </td>
	       </tr>
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
	    
	    <tr>
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
	    <tr><td colspan="2"><hr></td></tr>
	
	    <tr>
	       <td>총  ${fn:length(order_detail_list)}개</td>
	       <td  style="float:right;" id="highlight"> <b><fmt:formatNumber>${orderitem.o_totalprice}</fmt:formatNumber></b>원</td>
	    </tr>
	 </table>
	 <!-- 장바구니 테이블 end -->
	




	<!-- 가로로 보여주기 -->
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


	</table>
</body>
