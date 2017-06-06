<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>
<script type="text/javascript">

function Coincharge() { 
	//당 회사 결제 코드 불러오기
	IMP.init('imp42758107');
	
	var coin = $("#coin").val();
	var name = $('#c_name').val();
	var email = $('#c_email').val();
	var c_id = $('#c_id').val();
	/* 결제창 여는부분 */
	IMP.request_pay({
	    pg : "'html5_inicis':이니시스(웹표준결제)",
	    pay_method : "'card':신용카드",
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : 'CoinCharge',
	    amount : coin,
	    buyer_email : email,
	    buyer_name : name,
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울특별시 강남구 삼성동',
	    buyer_postcode : '123-456'
	    //m_redirect_url : 'https://www.yourdomain.com/payments/complete'
	}, function(rsp) {
		alert(rsp.success);
		
		
		
		
	    if ( rsp.success ) {
	    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
	    	jQuery.ajax({
	    		url: "payments.do", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
	    		type: 'get',
	    		dataType: 'json',
	    		/* contentType : "application/x-www-form-urlencoded; charset=UTF-8",  */
	    		 data: {
		    		"imp_uid" : rsp.imp_uid,
		    		"coin" : coin,
		    		"c_id" : c_id
		    		//기타 필요한 데이터가 있으면 추가 전달
	    		},
	    		success: function(data) {
	    			var success = data.success;
		    		var rsp = data.rsp;
		    		alert(success);
		    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
		    		if ( success ) {
		    			var msg = '결제가 완료되었습니다.';
		    			msg += '\n고유ID : ' + rsp.impUid;
		    			msg += '\n상점 거래ID : ' + rsp.merchantUid;
		    			msg += '\n결제 금액 : ' + rsp.paidAmount;
		    			msg += '\n카드 승인번호 : ' + rsp.applyNum;
		    			
		    			alert(msg);
		    			
		    			location.reload(true);
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
<title>Insert title here</title>
</head>
<body>
<form method="post" >
ID: <input type="text" id="c_id" value="${info.c_id}" readonly/><br>
이름: <input type="text" id="c_name" value="${info.c_name}"/><br>
이메일: <input type="text" id="c_email" value="${info.c_email}"/><br>
적립금 : ${info.c_coin} &nbsp;
충전할 금액 : <select id="coin">
			<option value="5000">5000원</option>
			<option value="10000">10000원</option>
			<option value="15000">15000원</option>
			<option value="20000">20000원</option>
			<option value="25000">25000원</option>
		  </select>
<input type="button" value="코인 충전하기" onclick="Coincharge()">
</form>




<h3>
<a href="menulist.do">주문</a><br>
</h3>
</body>
</html>