<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>this is payment form .jsp</title>

<style type="text/css">
table {
   border: 1px rgba(0,0,0,.25) solid;
}
input#card, #credit, #ssg{
   width: 20px;
   height: 20px;
}
table, td, th {
    padding: 0;
    padding: 7px;
}
.ta01{
   padding: 7px;
}
 div.tit01{font:bold 24px/30px "malgun gothic","Dotum"," Gulim","Arial","verdana","Helvetica",sans-serif;  color:#111; text-align:center;}

</style>

</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div style="margin-top: 10%;">
    <div class="tit01">${id } 회원님의 결제</div><br><br>
<form action="payment.do">
<input type="hidden" name="order_num" value="${list_dto.order_num}"> 
   <table cellpadding=15 cellspacing=0 align="center" style="height: 500px;">
      <tr>
         <!-- 주문매장 표시 -->
         <td class="ta01">
            <strong>${selected_store.s_name } 점 </strong><br>
            ${selected_store.s_address} 
         </td><!-- ${OrderMenu.s_code} 를 이용한 매장 정보도 받아와야겠구나 -->
         <td><a href="#">(변경)</a></td>
      </tr>
      <tr><td colspan="2"><hr></td></tr>
     <!--  <tr>
         포장 체크 여부?
         <td colspan="2" class="ta01">
            <input type="checkbox" id="isTakeout"> 
            <label for="isTakeout"><strong>전체 포장</strong> <br>(음료는 캐리어에, 푸드/기타는 종이백에 포장)</label>
            <br><br>
            <input type="checkbox" id="isCutting"> 
            <label for="isCutting"><strong>커팅</strong> <br>(30cm 이상 샌드위치만 보여줄거임)</label>
         </td>
      </tr> 
      <tr><td colspan="2"><hr></td></tr>
      -->
      <tr>
         <!-- 결제수단 -->
         <td colspan="2" class="ta01"><b>결제 수단 </b> <br> 
         	<input type="radio" name="paymentMethod" id="card" value="card" checked="checked"> <label
            for="card">서브웨이 카드 </label> &nbsp; 
            
            <input type="radio" name="paymentMethod" id="credit" value="credit"> <label
            for="credit">신용카드 </label> &nbsp; 
            <!-- <input type="radio"
            name="paymentMethod" id="ssg" value="ssg"> <label for="ssg">SSG
               PAY </label> &nbsp; -->
         </td>
      </tr>
      

<!--       <tr><td colspan="2"><hr></td></tr>

      <tr>
         쿠폰 사용 
         <td class="ta01"><b>쿠폰 사용</b></td>
         <td class="ta01"><strong><a href="#">></a></strong></td>
      </tr>
      
      <tr><td colspan="2"><hr></td></tr>

      <tr>
         제휴할인
         <td class="ta01"> <b>제휴 할인</b></td>
         <td><strong><a href="#">></a></strong></td>
      </tr>
      <tr><td colspan="2"><hr></td></tr> -->
      

      <tr>
         <td colspan="2" class="ta01" style="background: #dff0d8;font-weight: 800;">최종 결제할 메뉴</td>
      </tr>

         <!-- 선택한 메뉴 정보를 리스트로 받아서 반복문 돌림  -->
         <c:forEach var="item" items="${detail_dto_list}" varStatus="index"> <%-- var="list" items="${orderMenuList }" --%>
            <tr>
               <td style="padding-left: 10px;" class="ta01"><strong> ${item.m_code } </strong>
               <br>
               <div style="font-size: small;">&nbsp;&nbsp;${item.o_pan } / 
               	${item.m_necessary1} 
	              <c:if test="${item.m_necessary2_num>0}">+ ${item.m_necessary2}</c:if>
	              <c:if test="${item.m_necessary3_num>0}">+ ${item.m_necessary3}</c:if>
	              <c:if test="${item.m_necessary4_num>0}">+ ${item.m_necessary4}</c:if>
	              / ${item.o_sauce1} + ${item.o_sauce2}</div>
               </td> <!-- ${list.name}-->
               
               <td>
               	<fmt:formatNumber> ${item.o_price}</fmt:formatNumber> 원
               	<br>
               	<br>
                
               </td>
            </tr>
    
            <tr>
               <td colspan="2"><hr></td>
            </tr>
         
         </c:forEach>
      <tr style="background: #dff0d8; font-weight: 800;">
         <td class="ta01">총 주문 금액</td>
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
         <td class="ta01" style="font-size: large; font-weight: 900;">최종 결제금액</td><!-- ${OrderMenu.totalPrice}-->
         <td style="font-size: large; font-weight: 900;"><fmt:formatNumber> ${list_dto.o_totalprice }</fmt:formatNumber> 원</td>
      </tr>

      <tr>
         <td colspan="2" class="ta01">
         <a href="main.do"><input type="button" value="취 소" style="width: 25%;" class="btn btn-default"></a>&nbsp;&nbsp;<!-- javascript:history.back() -->
         <button name="command" value="${command }" style="width: 70%;" class="btn btn-default">결제 및 주문하기</button>
         </td>
      </tr>


   </table>
</form>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>