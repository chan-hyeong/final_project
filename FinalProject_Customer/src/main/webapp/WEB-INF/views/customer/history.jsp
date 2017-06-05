<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	  $( function() {
		    $( ".datepicker1" ).datepicker();
		  } );
	  
	  function atest(start, end){
	    	var start=start.value; //파마리터값 가져오기 
	    	var end=end.value; //파마리터값 가져오기 
	    	
	    	var startarr=start.split('/');  //  "/" 로 나눠서 배열형태로 저장 
	    	var endarr=end.split('/');  //  "/" 로 나눠서 배열형태로 저장 
	    	
	    	var start=startarr[2]+'-'+startarr[0]+'-'+startarr[1];  //DB에 맞는 형식으로 변환 
	    	var end=endarr[2]+'-'+endarr[0]+'-'+endarr[1];  //DB에 맞는 형식으로 변환 
	    	
	    	var url ='history.do?start='+start+'&end='+end;
	   	 	window.location.href=url;
	    };
	    
	    

	$(document).ready(function(){
		console.log("history page 입니다");
		
		$('.dimmed').click(function(){
			$('.dimmed,.popup').hide();
		});
		$('.popup').click(function(){
			$('.dimmed,.popup').hide();
		});
		
		$('#selectDate').click(function(){
			alert('기간 선택');
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
	
	
	function test(){
		/* $('#order_status').each(function (index, item){
			console.log($(this));
		}); */
		var item = document.getElementsByName('order_status');
		for(var i=0; i<item.length; i++){
			//console.log(item[i].innerHTML);
			if( item[i].innerHTML == '준비완료'){
				console.log(item[i].innerHTML + " : " + i);
				//이거의 부모를 선택해서 
				//show 나머지는 hide
			}
		}
	}
				
	

</script>
</head>


<body>
<a href="main.do">메인으로 돌아가기</a><br>

<h1>인엽이형이 수정할 히스토리 페이지 </h1>
	<fieldset >
	<legend>
		<h3>
			날짜 선택 
		</h3>
	</legend>
		<input type="text" placeholder="시작 날짜" id="datepicker" class="datepicker1">
		<input type="text" placeholder="끝 날짜" id="datepicker2" class="datepicker1">
		<button onclick="atest(datepicker, datepicker2)">조회 방법1</button>
		<hr><br>
		
		<input type="date" placeholder="시작 날짜" id="dateinput">
		<input type="date" placeholder="끝 날짜" id="dateinput2">
		<button onclick="atest(dateinput, dateinput2)">조회 방법2</button>
		<hr><br>
		
		<input type="date" placeholder="시작 날짜" id="dinput">
		<input type="date" placeholder="끝 날짜" id="dinput2">
		<button onclick="atest(dinput, dinput2)">조회 방법3</button><br>
		<input type="radio" name="period" id="amonth"><label for="amonth">1개월</label> 
		<input type="radio" name="period" id="ayear"><label for="ayear">1년</label>
		<input type="radio" name="period" id="custom"><label for="custom">기간설정</label>
		<hr>
	</fieldset>
	
	<fieldset >
	<legend><h3>status셀렉</h3></legend>
            <select name="statuscheck" style="width:200px;" onchange="">
               <option value="all">(주문상태) 전체</option>
               <option value="paid">결제완료</option>
               <option value="complete">준비완료</option>
               <option value="canceld">결제취소</option>
            </select>
            
            <button onclick="test();">확인버튼 </button>
	</fieldset>
<hr>
<br>

<table style="align:center; width:90%;"> 
      <tr>
         <td colspan="2">
            <!-- <select name="statuscheck" style="width:200px;" onchange="">
               <option value="all">(주문상태) 전체</option>
               <option value="paid">결제완료</option>
               <option value="complete">준비완료</option>
               <option value="canceld">결제취소</option>
            </select> -->
         </td>
      </tr>
      <tr><td colspan="2"><hr></td></tr>
      
      <tr>
         <td align="left">설정된 기간이 나올거임</td>
         <td align="right" width="45%">
            <button class="myButton" id="selectDate">기간 설정</button>
         </td>
      </tr>
      <tr><td colspan="2"><hr></td></tr>

	<c:forEach var="list" items="${ orderlist }" varStatus="status">
      <tr>
         <td colspan="2">
            <button name="listitem" style="border:none; width:100%;" id="listitem" onclick="historydetail(${ list.order_num }, this)">
               <p style="float:left;"><b>[${ list.num_of_item} 개] &nbsp;${ list.m_code }&nbsp;</b></p><br><br>
               
               <div style="float:right;">
               <div name="order_status">${list.order_status }</div>
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