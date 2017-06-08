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

</head>


<body>
<!-- header -->
<div class="header">
	<jsp:include page="header.jsp"/>
</div>
<br>
<br>
<br>
<br>
<br>
<br>

<h1>수정해야할 히스토리 페이지 </h1>

<fieldset >
	<legend>
		<h3>
			날짜 선택 
		</h3>
	</legend>
	<form name="frmhistory" action="history.do" onsubmit="return setDate(startdate, enddate);" method="post">
		<input type="text" name="start" placeholder="시작 날짜" id="startdate" class="datepicker" value="${start}" readonly="readonly" >
		<input type="text" name="end" placeholder="끝 날짜" id="enddate" class="datepicker" value="${end}" readonly="readonly">
		<button>조회 방법1</button>
		<br>
		<!-- <input type="date" placeholder="시작 날짜" id="dateinput">
		<input type="date" placeholder="끝 날짜" id="dateinput2">
		<button onclick="setDate(dateinput, dateinput2)">조회 방법2</button>
		<hr><br>
		
		<input type="date" placeholder="시작 날짜" id="dinput">
		<input type="date" placeholder="끝 날짜" id="dinput2">
		<button onclick="setDate(dinput, dinput2)">조회 방법3</button><br> -->
				
		<input type="radio" name="period" id="amonth" onchange="set_default_date('amonth', startdate, enddate);">
		<label for="amonth">1개월</label> 
		
		<input type="radio" name="period" id="ayear" onchange="set_default_date('ayear', startdate, enddate);">
		<label for="ayear">1년</label>
		
		<input type="radio" name="period" id="custom" onchange="set_default_date('custom', startdate, enddate);">
		<label for="custom">기간설정</label>
		
		<br>
		<hr>
		
		<select id="sts" name="statuscheck" style="width:200px;" onchange="">
			<option value="all">(주문상태) 전체</option>
			<option value="paid">결제완료</option>
			<option value="complete">준비완료</option>
			<option value="canceld">결제취소</option>
		</select>
		
		<button>확인버튼 </button>
	</form>
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
            <button name="listitem" style="border:none; width:100%;" id="listitem" onclick="historydetail(${ list.order_num })">
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
   
	<br>
	<br>
	<br>
	<br>
	<br>
	<!-- footer -->
	<div class="footer">
 		<jsp:include page="footer.jsp"/> 
	</div>
</body>
</html>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	  $( function() {
		    $( ".datepicker" ).datepicker();
		  } );

	  //페이지 진입시 
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
			
			//select 된 status 상태 나타내기
			$("#sts").val("${statuscheck}"); 
			
			///////
			var order_num = '${order_num}';
			if (order_num > 0 ) {
				historydetail(order_num);
			}
			  
		});
	  
  
	  
	  
	  function setDate(pstart, pend){//onsubmit
	    	if ( pstart.value == "" || pend.value == "" ) {
	    		pstart.focus();
	    		return false;
	    	}
	    	
	    	var start=pstart.value; //파마리터값 가져오기 
	    	var end=pend.value; //파마리터값 가져오기 
	    	
	    	if( (new Date(pend.value)).getTime()-(new Date(pstart.value)).getTime() < 0 ) {alert("날짜범위가 잘못지정되었습니다. \n다시 선해주세요") ; return false;}
	    	
	    	var startarr=start.split('/');  //  "/" 로 나눠서 배열형태로 저장 
	    	var endarr=end.split('/');  //  "/" 로 나눠서 배열형태로 저장 
	    	
	    	//DB에 맞는 형식으로 변환 
	    	if ( startarr.length > 2)
	    		start=startarr[2]+'-'+startarr[0]+'-'+startarr[1];  
	    	if ( endarr.length > 2)
		    	end=endarr[2]+'-'+endarr[0]+'-'+endarr[1];   
	    	
	    	//form 으로 전송하니까 
		  	pstart.value=start;
		   	pend.value=end;
 	    };
 	    
 	    function date_formating(option){
 	    	var result= new Date(new Date().getTime() - (1000*60*60*24*eval(option)));
 	    	
	    	var year = result.getFullYear();
	    	var month = result.getMonth()+1;
	    	var date = result.getDate(); 
	    	
	    	if(parseInt(month) < 10)  // 월이 한자리 수인 경우 (예: 1, 3, 5) 앞에 0을 붙여주기 위해, 즉 01, 03, 05
	    		month = "0" + month;
	    	if(parseInt(date) < 10)       // 일이 한자리 수인 경우 앞에 0을 붙여주기 위해
	    		date = "0" + date;
	    		
	    	return year+"-"+month+"-"+date;
 	    }//end function
 	    
 	    function set_default_date(option, datepicker, datepicker2){
 	    	var start, end;
 	    	if ( option == 'amonth'){//기간을 한달로 설정 
 	    		var amonth_ago=date_formating(30); 
 	    		console.log("한달 선택 : " + amonth_ago);
 	    		datepicker.value=amonth_ago;
 	    		datepicker2.value=date_formating(0);
 	    	}else if(option == 'ayear'){ //일년
 	    		var ayear_ago= date_formating(365);
 	    		console.log("일년 선택 : " + ayear_ago)

 	    		datepicker.value=ayear_ago;
 	    		datepicker2.value=date_formating(0);
 	    	}else{
 	    		datepicker.value=""; 
 	    		datepicker2.value="";
 	    		datepicker.focus();
 	    	}
 	    }//end function
	    

	function popupCenter(){
			var width = $('.popup').width();
			var height = $('.popup').height();
			
 			$('.popup').css({'left':(($(window).width() - width) / 2), 
							 'top':(($(window).height() - height) / 2)}); 
	} 
	
	
	function historydetail(order_num){
		console.log("\najax 테스트 넘어왔다");
		
		 $.ajax({
			type: "get",
			url: "historydetailtest.do",
			data: {"order_num" : order_num },
			success : function(data){
				/* $('#testdiv').html(data); */
				$('#historydetail').html(data);
				popupCenter();
				$('.dimmed,.popup').show();
			/* 	$(window).resize(function(){
					  popupCenter();
				  }); */
			}
		})
		/* scroll(0, document.getElementById('historydetail').scollHeight); */
		console.log("\t ajax 끝났다");
	}
	
</script>