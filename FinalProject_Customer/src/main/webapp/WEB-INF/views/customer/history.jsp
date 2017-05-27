<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>History page</title>
</head>
<body>
<a href="main.do">메인으로 돌아가기</a><br>


<h1>히스토리 페이지 </h1>
<a href="orderdetail.do">상세페이지</a><br>

<table border="0" style="align:center;width:90%;"> 
      <tr>
         <td colspan="2">
            <select name="category" style="width:200px;">
               <option>(주문상태) 전체</option>
               <option>결제완료</option>
               <option>준비완료</option>
               <option>결제취소</option>
            </select>
         </td>
      </tr>
      <tr><td colspan="2"><hr></td></tr>
      
      <tr>
         <td align="left">설정된 기간이 나올거임</td>
         <td align="right" width="45%">
            <button class="myButton">기간 설정</button>
         </td>
      </tr>
      <tr><td colspan="2"><hr></td></tr>

      <tr>
         <td colspan="2">
         <c:forEach var="list" items="${ orderlist }" varStatus="status">
         <a href="history_detail.do?order_num=${list.order_num}">
            <button style="border:none;background-color:white;width:100%;" 
                  id="listitem" value="${list.order_num }">
               <img style="width:60px;float:left"src="${pageContext.request.contextPath}/img/${status.count}.png">
               <p style="float:right;">${ list.order_status}</p>
               <p style="float:right;"><b>${ '메뉴 이름이 나올자리'}&nbsp; [${ '수량'}]</b></p><br><br>
               
               <div style="float:right">
               <fmt:formatDate value="${ list.order_date }" pattern="yyyy-MM-dd"/> / 
               ${ list.o_totalprice }원
               </div>
            </button>
         </a>
            <hr>
         </c:forEach>
         </td>
      </tr>
   </table>
   
   <%
   		out.println("<h1>여기서 출력해볼거임</h1>");
   		Enumeration<String> anames = request.getAttributeNames();
   		
   		while(anames.hasMoreElements()){
   			String name = anames.nextElement();
   			Object value = request.getAttribute(name);
   			out.println(name + " : <font color=red>" + value.toString() + "</font><br>");
   		}
   		
   		Map map = request.getParameterMap();
   		Set keyset = map.keySet();
   		Iterator i = keyset.iterator();
   		while (i.hasNext()){
   			Object key = i.next();
   			Object val = map.get(key);
   			out.println(key + " : <font color=red>" + val + "</font><br>");
   			
   		}
   %>


</body>
</html>