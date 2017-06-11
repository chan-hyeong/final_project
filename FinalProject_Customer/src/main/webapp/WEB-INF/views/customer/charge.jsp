<!-- 2017. 6. 7. ���� 8:24:32 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>	
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>
<script type="text/javascript">
	$(document).ready( function(){
		//alert('${RequestURI}');
		//alert('${RequestURL}');
	});

	function Coincharge() {
		//당 회사 결제 코드 불러오기
		IMP.init('imp42758107');

		var coin = $('input:radio[name="coin"]:checked').val();//$("#coin").val();
		var name = $('#c_name').val();
		var email = $('#c_email').val();
		var c_id = $('#c_id').val();
		var m_redirect_url = '${RequestURL}';
			
		/* 결제창 여는부분 */
		IMP.request_pay({
			pg : "'html5_inicis':이니시스(웹표준결제)",
			pay_method : "'card':신용카드",
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : 'CoinCharge',
			amount : coin,
			buyer_email : ${'info.c_email'},//email,
			buyer_name : name,
			buyer_tel : '010-1234-5678',
			buyer_addr : '서울특별시 강남구 삼성동',
			buyer_postcode : '123-456'
			, m_redirect_url : m_redirect_url 
			//, m_redirect_url : 'http://192.168.0.138:8080/customer/main.do'
			//, m_redirect_url : 'https://www.yourdomain.com/payments/complete'
		}, function(rsp) {
			alert(rsp.success);

			if (rsp.success) {
				//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
				jQuery.ajax({
					url : "payments.do", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
					type : 'get',
					dataType : 'json',
					/* contentType : "application/x-www-form-urlencoded; charset=UTF-8",  */
					data : {
						"imp_uid" : rsp.imp_uid,
						"coin" : coin,
						"c_id" : c_id
					//기타 필요한 데이터가 있으면 추가 전달
					},
					success : function(data) {
						var success = data.success;
						var rsp = data.rsp;
						alert(success);
						//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
						if (success) {
							var msg = '결제가 완료되었습니다.';
							msg += '\n고유ID : ' + rsp.impUid;
							msg += '\n상점 거래ID : ' + rsp.merchantUid;
							//msg += '\n결제 금액 : ' + rsp.paidAmount;
							msg += '\n테스트 : ' + rsp.amount;//테스트
							msg += '\n카드 승인번호 : ' + rsp.applyNum;

							alert(msg);
							
							window.location.href="main.do";
						} else {
							alert("아직 제대로 결제가 되지 않았습니다.");
							//[3] 아직 제대로 결제가 되지 않았습니다.
							//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
						}
					}
				})
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
	
				alert(msg);
			}
		});

	};
</script>
<title>${id} 님 카드를충전합니다</title>


</head>
<body>
	<!-- header -->
	<div class="header">
		<jsp:include page="header.jsp" />
	</div>
	<br>
	<br>
	<br>
	<br>
	
	<div id="content" style="background-color: black;">
		<div style="width: 100%; text-align: center; padding: 10px 0px 10px 0px; color: white; font-size: large; font-weight: bold;">
			충전하기 <!-- 아좀 깔끔하게 나왔으면 좋겠다  -->
			
		</div>
		<!-- <div>충전하기</div> -->
			<div id="info" style="padding: 10px; background-color: white;">
				<label for="c_id" style="font-size: xx-large;">${info.c_id}</label> 
				<!-- id :  --><input type="hidden" id="c_id" value="${info.c_id}" readonly />
				
				<label for="c_name">( '${info.c_name}' 님 )</label> 
				<!-- 이름:  --><input type="hidden" id="c_name" value="${info.c_name}" /><br>
				
				<!-- 이메일:  --><input type="hidden" id="c_email" value="${info.c_email}" />
				
				<label style="font-size: xx-large; float: right;">현재 잔액 : <fmt:formatNumber>${info.c_coin}</fmt:formatNumber> 원 </label><br>
				
				<br>
				<hr>
			</div>
			
			<!-- 충전가능한 금액 목록 , ul li 써서 정리하고싶다  --> 
			<div style="background-color: #f3f3f3; padding: 15px;">
			<label>충전 금액</label><br>
				<c:forEach begin="0" end="5" step="1" varStatus="index">
					<label name="coin_option_lb" class="coin_option_lb${index.first? ' coin_option_lb_selected':''}">
						<input style="display: none;" name="coin" type="radio" ${index.first?' checked="checked"':'' } 
							value="${index.count*5000 }" onchange="selectbutton(this.parentNode, this);">
						<fmt:formatNumber>${index.count*5000 }</fmt:formatNumber>원 
					</label> &nbsp;&nbsp;
				</c:forEach><br><br><br>
			<!-- 충전가능한 금액 목록  -->
			
			<label>결제 수단</label><br>
				<label for="card"><input type="radio" name="paymentMethod" value="card" id="card" checked="checked"> 서브웨이 카드</label>&nbsp;&nbsp;
				<!-- <label for="credit"><input type="radio" name="paymentMethod" value="credit" id="credit"> 신용카드</label>&nbsp;&nbsp;
				<label for="ssg"><input type="radio" name="paymentMethod" value="ssg" id="ssg"> SSG PAY</label> --><br>
				<font color="gray" size="2"> ※ 현재는 신용카드를 이용한 충전만 가능합니다. ※ </font>
			</div>
			<!-- 다운받은거 써보자 -->
			
			<div style="background-color: white;">
				<center><font size="4">충전 후 예상 카드 잔액</font>&nbsp;&nbsp;
				<label for="coin" id="expectedCoin"><font size="6" color="green"><fmt:formatNumber>${info.c_coin}</fmt:formatNumber> 원</font></label> <!-- 원 아 이거 , 어케 찍지 -->
				</center>
				<button class="btn success" onclick="Coincharge()">충 전 하 기</button>
			</div>
	</div>
		
		
		
		<br> <br>
		<!-- footer -->
		<div class="footer">
			<jsp:include page="footer.jsp" />
		</div>
</body>
</html>
<script>

	$('document').ready(function(){
	});
	
	function selectbutton(parent, self){
		var coin_radio_arr = document.getElementsByName('coin');
		for ( var i =0 ;i< coin_radio_arr.length; i++){
			var parentLabel = coin_radio_arr[i].parentNode ;
			$(parentLabel).removeClass();
			$(parentLabel).addClass('coin_option_lb');
			$(parent).addClass('coin_option_lb_selected');
		}//end for 
		
		var coin = eval('${info.c_coin eq null ? 0 : info.c_coin}') + eval(self.value);
		coin = String(coin);
		coin = coin.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		$('#expectedCoin').html("<font size='6' color='green'>"+ coin + " 원</font>");
		
	}//end class
</script>
<style type="text/css">
.btn {
    border: none; /* Remove borders */
    color: white; /* Add a text color */
    padding: 14px 28px; /* Add some padding */
    cursor: pointer; /* Add a pointer cursor on mouse-over */
    width: 100%;
    font-size: x-large;
    margin-top: 10%;
}
.success {background-color: #066947;} /* Green */
.success:hover {background-color: #ffd307;color: black;}


label{
	font-size:large;
	padding: 5px 15px 5px 0px;
	
}

input[type="radio"][name="paymentMethod"]{
	width: 15px;
	height: 15px;
}
input[type="radio"][name="coin_option"]{
	display:none;
}

label.coin_option_lb{
	width:120px;
    font-size: large;
    border: 2px solid gray;
    padding: 5px 15px 5px 15px;
    margin-right: 5px;
    margin-bottom: 5px;
    border-radius: 5%;
}
label.coin_option_lb_selected,
label.coin_option_lb:HOVER,
label.coin_option_lb:ACTIVE{
	width:120px;
    font-size: large;
    border: 2px solid gray;
    padding: 5px 15px 5px 15px;
    margin-right: 5px;
    margin-bottom: 5px;
    border-radius: 5%;
    color: white;
    font-weight: bold;
    background-color: gray;
}

</style>