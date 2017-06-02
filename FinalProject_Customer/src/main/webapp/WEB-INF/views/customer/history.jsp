<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${id }님의 히스토리입니다.</title>

<style type="text/css">
body {
	margin: 0;
	padding: 0;
	font-family: '맑은고딕';
	font-size: 15px;
}

.dimmed {
	display: none;
	position: fixed;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background: black;
	opacity: 0.3;
	z-index: 1000;
}

.popup {
	display: none;
	position: fixed;
	left: 0;
	top: 0;
	width: 90%;
	height: 40%;
	border: 1px solid #ddd;
	background: #fff;
	z-index: 1500;
	font-size: 10px;
	overflow-y : auto;
	-webkit-overflow-scrolling: touch;
}
.close {
	float: right;
	width: 50px;
	height: 25px;
	margin: 5px 5px 0 0;
	border: 1px solid #ddd;
	cursor: pointer;
}

table tr td button{
	background-color: white;
	color:black;
	font-weight: white;
}
table tr td button:HOVER {
	background-color: gray;
	color:white;
	font-weight: bold;
}
</style>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		console.log("history page 입니다");
		
		$('.dimmed').click(function(){
			$('.dimmed,.popup').hide();
		});
		$('.popup').click(function(){
			$('.dimmed,.popup').hide();
		});
	});
	
	function popupCenter(params1){
			var width = $('.popup').width();
			var height = $('.popup').height();
			
 			$('.popup').css({'left':(($(window).width() - width) / 2), 
							 'top':(($(window).height() - height) / 2)}); 
	} 
	
	
	function historydetail(order_num, params1){
		console.log("\najax 테스트 넘어왔다");
		
		 $.ajax({
			type: "get",
			url: "historydetailtest.do",
			data: {"order_num" : order_num },
			success : function(data){
				/* $('#testdiv').html(data); */
				$('#historydetail').html(data);
				popupCenter(params1);
				$('.dimmed,.popup').show();
			/* 	$(window).resize(function(){
					  popupCenter();
				  }); */
			}
		})
		/* scroll(0, document.getElementById('historydetail').scollHeight); */
		console.log("\t ajax 끝났다");
	}
				
	function historydetail1(order_num){
		 $.ajax({
			type: "get",
			url: "historydetail.do",
			data: {"order_num" : order_num },
			success : function(data){
				
				var historydetail =JSON.parse(JSON.stringify(data));
				
				var detail_data = "";
				detail_data += "<table sytle=font-size: 10px; text-align: center;>";
				detail_data += "<tr>";
				detail_data += "<td>주문번호</td>";
				detail_data += "<td>메뉴명</td>";
				detail_data += "<td>빵</td>";
				detail_data += "<td>베이스1</td>";
				detail_data += "<td>베이스2</td>";
				detail_data += "<td>베이스3</td>";
				detail_data += "<td>베이스4</td>";
				detail_data += "<td>옵션1</td>";
				detail_data += "<td>옵션2</td>";
				detail_data += "<td>옵션3</td>";
				detail_data += "<td>옵션4</td>";
				detail_data += "<td>옵션5</td>";
				detail_data += "<td>소스</td>";
				detail_data += "<td>야채</td>";
				detail_data += "<td>가격</td>";
				
				
				detail_data += "</tr>";
				
				for(var i = 0 ; i < historydetail.length ; i++){
					
					
					var detail = historydetail[i];
					
					detail_data += "<tr>";
					detail_data += "<td>"  + detail.order_no +  "</td>";
					detail_data += "<td>"  + detail.m_name +  "</td>";
					detail_data += "<td>"  + detail.PAN +  "</td>";
					detail_data += "<td>"  + detail.necessary1 +  "</td>";
					detail_data += "<td>"  + detail.necessary2 +  "</td>";
					detail_data += "<td>"  + detail.necessary3 +  "</td>";
					detail_data += "<td>"  + detail.necessary4 +  "</td>";
					detail_data += "<td>"  + detail.o_option1 + ":" + detail.o_option1_num +  "</td>";
					detail_data += "<td>"  + detail.o_option2 + ":" + detail.o_option2_num +  "</td>";
					detail_data += "<td>"  + detail.o_option3 + ":" + detail.o_option3_num +  "</td>";
					detail_data += "<td>"  + detail.o_option4 + ":" + detail.o_option4_num +  "</td>";
					detail_data += "<td>"  + detail.o_option5 + ":" + detail.o_option5_num +  "</td>";
					detail_data += "<td>"  + detail.sauce +  "</td>";
					detail_data += "<td>"  + detail.vege +  "</td>";
					detail_data += "<td>"  + detail.o_price +  "</td>";
					
					detail_data += "</tr>";
					
				}
				detail_data += "</table>";
				
				$('#historydetail').html(detail_data);
				/*var m_value=m_name.value(1);
				alert(m_value); */
				
				/*alert(data.list);
				alert(data.list.length);
				alert(data.list[0].order_num); */
				
				popupCenter();
				$('.dimmed,.popup').show();
				
				  $(window).resize(function(){
				  popupCenter();
			  })
			 }
		})
		  
		}
	

</script>
</head>


<body>
<a href="main.do">메인으로 돌아가기</a><br>

<h1>인엽이형이 수정할 히스토리 페이지 </h1>

<table style="align:center; width:90%;"> 
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

	<c:forEach var="list" items="${ orderlist }" varStatus="status">
      <tr>
         <td colspan="2">
            <button style="border:none; width:100%;"
                  id="listitem" onclick="historydetail(${ list.order_num }, this)">
               <p style="float:left;"><b>[${ list.num_of_item} 개] &nbsp;${ list.m_code }&nbsp;</b></p><br><br>
               
               <div style="float:right">
               <fmt:formatDate value="${ list.order_date }" pattern="yyyy-MM-dd HH:mm:ss"/> / 
               <fmt:formatNumber>${ list.o_totalprice }</fmt:formatNumber> 원
               </div>
            </button>
         </a>
            <hr>
         </td>
      </tr>
		</c:forEach>
   </table>
   
   
   <div class="dimmed"></div>
   <div class="popup">
   		<div class="historydetail" id="historydetail">
   		</div>
   			<input type="button" class="close" value="닫기">
   </div>
   
   
   <fieldset>
   <legend><h3>param, attrb 체크 </h3></legend>
   
   </fieldset>


</body>
</html>