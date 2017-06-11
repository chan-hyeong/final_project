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
	height: 70%;
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
#date{
    text-align: center;
    width: 80%;
    border: 3px solid rgba(0,0,0,.075);
    padding: 2%;
    border-style: groove;
    margin-left: 10%;
}
.01{
	float: left;
}
.02{
	float: right;
}
  div.tit01{font:bold 24px/30px "malgun gothic","Dotum"," Gulim","Arial","verdana","Helvetica",sans-serif;  color:#111; text-align:center;}
</style>
</head>


<body>
<!-- header -->
<div class="header">
	<jsp:include page="header.jsp"/>
</div>
<!-- header -->

<div style="margin-top: 15%;">
<div class="tit01">${id } 회원님의 결제 내역입니다. </div><br>
<!-- 기간 선택 -->
<!-- 날짜나 상태로 필터링 -->
<fieldset id="date">
	<form name="frmhistory" action="history.do" onsubmit="return setDate(startdate, enddate);" method="post">
		<div class="01">
			<input type="text" name="start" placeholder="시작 날짜" id="startdate" class="datepicker" value="${start}" readonly="readonly" >
			<input type="text" name="end" placeholder="끝 날짜" id="enddate" class="datepicker" value="${end}" readonly="readonly">
			<button class="btn btn-default">조 회</button>
			<br>
					
			<input type="radio" name="period" id="amonth" onchange="set_default_date('amonth', startdate, enddate);">
			<label for="amonth">1개월</label> 
			
			<input type="radio" name="period" id="ayear" onchange="set_default_date('ayear', startdate, enddate);">
			<label for="ayear">1년</label>
			
			<input type="radio" name="period" id="custom" onchange="set_default_date('custom', startdate, enddate);">
			<label for="custom">기간설정</label>
		</div>
		<br>
		
		<div class="02">	
			<select id="sts" name="statuscheck" style="width:200px;" onchange="submit();">
				<option value="all">(주문상태) 전체</option>
				<option value="paid">결제완료</option>
				<option value="complete">준비완료</option>
				<option value="canceld">결제취소</option>
			</select>
		</div>
	</form>
</fieldset>
<!-- 날짜나 상태로 필터링 끝  -->

<br>
<table style="width:80%; margin-left: 10%;"> 
      <tr>
         <td colspan="2">
         </td>
      </tr>
      <tr><td colspan="2"><hr></td></tr>
      
      <tr><td colspan="2"><hr></td></tr>

	<c:forEach var="list" items="${ orderlist }" varStatus="status">
      <tr>
         <td colspan="2">
            <button name="listitem" style="border:none; width:100%;" id="listitem" onclick="historydetail(${ list.order_num })">
               <p style="float:left; color:black;"><b>[${ list.num_of_item} 개] &nbsp;
               <c:forTokens var="item" items="${ list.m_code }" delims=";" varStatus="index">
               		<c:if test="${index.first}">${item }</c:if>
               		<c:if test="${index.last}">&nbsp;등 ${index.count} 개</c:if>
               </c:forTokens>
               &nbsp;</b></p><br><br>
               
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
   
   
	
	<br>
	<!-- footer -->
	<div class="footer">
 		<jsp:include page="footer.jsp"/> 
	</div>
	<!-- footer -->
</body>
</html>



<!-- 스크립트 가 위에있으면 실행이 안된다!! -->
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
	    	
	    	var test_start = new Date(start);
	    	test_start = new Date(test_start.getFullYear(), test_start.getMonth(), test_start.getDate(), 0, 0, 0);  
	    	var test_end = new Date(end); 
	    	if( test_end.getTime() < test_start.getTime() ){
	    		alert("날짜범위가 잘못지정되었습니다. \n다시 선해주세요") ; 
	    		return false;
	    	}
	    	
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
				$('#historydetail').html(data);
				popupCenter();
				$('.dimmed,.popup').show();
			}
		})
		/* scroll(0, document.getElementById('historydetail').scollHeight); */
		console.log("\t ajax 끝났다");
	}
	
</script>