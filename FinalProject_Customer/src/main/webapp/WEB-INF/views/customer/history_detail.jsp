<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>History detail page</title>
</head>
<body>
<a href="main.do">메인으로 돌아가기</a><br>


<h1>히스토리 페이지 </h1>
<a href="history.do">히스토리로 </a><br>


   <!-- 장바구니 테이블 -->
   <table border="0" style="align:center;width:90%;">
      <tr id="header1">
         <td colspan="2">주문 번호 <b style="float:right;">${orderdetail[0].order_num }</b></td>
      </tr>
      <tr><td colspan="2"><hr></td></tr>
      
      <tr>
         <td>order_status<%-- ${orderdetail[0].status} --%><br> 
            <fmt:formatDate value="<%-- ${orderdetail[0].payment_date} --%>" pattern="yyyy-MM-dd"/>
         </td>
         <td style="float:right;width:45%;">지점정보 나와야함</td>
      </tr>
      <tr><td colspan="2"><hr></td></tr>
      
      <tr id="header1">
         <td colspan="2">주문 매장 정보</td>
      </tr>
      <tr><td colspan="2"><hr></td></tr>
      
      <tr>
         <td colspan="2"><b>----주문매장정보가 여기 나와야함----</b><br> ----매장 내
            직접 수령---- <br> ----매장 주소----</td>
      </tr>
      <tr><td colspan="2"><hr></td></tr>
      
      <tr id="header1">
         <td colspan="2">주문 상세 내역</td>
      </tr>
      <tr><td colspan="2"><hr></td></tr>
      
      <c:set var="total_price" value="0"></c:set>
      <c:set var="total_amount" value="0"></c:set>
   
      <c:forEach var="list" items="${orderdetail}" varStatus="status">
         <tr>
            <td id="menu_name">${list.m_code} X 수량</td>
            <td style="float:right;" id="menu_price">${list.o_price} 원</td>
         </tr>
         <tr><td colspan="2"><hr></td></tr>
         <tr>
            <td id="option">
                 <p style="float:left"class="option_cup_size"> ${ list.o_option1} / </p>
            <p style="float:left"class="option_cup_size"> &nbsp;${ list.o_option2 } </p>
            <p style="float:left"class="option_bake"> ${ list.o_option3 } </p>
            </td>
            <td  style="float:right;" id="option"></td>
         </tr>
         <tr><td colspan="2"><hr></td></tr>
         
         <tr style="display:none">
            <td>
            <%-- ${total_amount = total_amount + list.menu_amount}
            ${total_price = total_price + list.total_price} --%>
            </td>
         </tr>
         
         <c:if test="${!status.last}">
         <tr>
            <td colspan="2"><hr></td>
         </tr>
         </c:if>
         
      </c:forEach>
      
      <tr><td colspan="2" id="option">---결제수단 -- 으로 결제한 금액</td>   </tr>
      <tr><td colspan="2"><hr></td></tr>

   
      <tr>
         <td>총 ${total_amount}개</td>
         <td  style="float:right;" id="highlight">${total_price}원</td>
      </tr>
   </table>
   <!-- 장바구니 테이블 end -->


   <%
   		out.println("<h1>여기서 출력해볼거임</h1>");
   		Enumeration<String> anames = request.getAttributeNames();
   		
   		while(anames.hasMoreElements()){
   			String name = anames.nextElement();
   			Object value = request.getAttribute(name);
   			out.println(name + " : <font color=red>" + value.toString() + "</font><br>");
   		}
   		
   %>


</body>
</html>