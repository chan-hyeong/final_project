<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>

<script type="text/javascript">
	var total_extra = 0;
	function extra_add(params1, params2, params3){
		/* alert(params);
		alert(params.value); */
		if(total_extra >= 5){ 
			alert("extra는 5개 이상 못해요");	
			return false;
		}
		params1.value++; 
		params2.value = eval(params2.value) + eval(params3.value);
		document.getElementsByName('o_price')[0].value = eval(document.getElementsByName('o_price')[0].value) + eval(params2.value );
		document.getElementsByName('o_price')[1].innerHTML = document.getElementsByName('o_price')[0].value  
		total_extra ++;
	}
	function extra_sub(params1, params2, params3){
		/* alert(params);
		alert(params.value); */
		
		if(total_extra <= 0 || params1.value <= 0){ 
			return false;
		}
		params1.value--; 
		params2.value = eval(params2.value) - eval(params3.value);
		document.getElementsByName('o_price')[0].value = eval(document.getElementsByName('o_price')[0].value) - eval(params2.value );
		document.getElementsByName('o_price')[1].innerHTML = document.getElementsByName('o_price')[0].value  
		total_extra --;
	}

	
	var option_num = 0;
	function test(params){
 		if ( option_num >= 3) return false;
 		alert(document.getElementById('option').innerHTML);
 		option_num++;
 		var d = "div_" + option_num;
		var code1 = "<select>";
			 code1 += "<option value=\"dc\">더블치즈</option>";	
			 code1 += "<option value=\"ac\">아보카도</option>";	
			 code1 += "<option value=\"dm\">더블미트</option>";
			 code1 += "<option value=\"em\">에그마요</option>";
			 code1 += "<option value=\"bk\">베이컨</option>";
			 code1 += "</select>";
		var code2 = "<select><option value=1>1</option><option value=2>2</option><option value=3>3</option></select>";
		var code = code1+code2+"<button value=1 onclick=\"delete_div(div_"+option_num+")\">X</button>";
		document.getElementById(d).innerHTML += code;
		return;
	}
	
	function delete_div(params){
		var name = params;
		alert("눌린버튼 : " + name);
		name.innerHTML = "";
		option_num --;
	}
	
	function  sauce_select(params){
		var o_sauce1 = document.getElementsByName('o_sauce1')[0].value;
		var o_sauce2 = document.getElementsByName('o_sauce2')[0].value;
		
		if(o_sauce1=='none'){ 
			alert("소스 선택해라");
			return false;
		}
		if(o_sauce1==o_sauce2) {
			alert("다른 소스를 선택하라 ");
			params.value='none';
			return false;
		}
		return true;
	}

	function check(){
		if( document.testfrm.o_pan.value == 'none' ) {
			alert("빵을 선택해주세여함");
			return false;
		}
		if( !sauce_select(document.testfrm.o_sauce2)){
			alert("소스를 다른거 선택하삼");
			return false;
		}
		return true;
		
	}
	
</script>
<style type="text/css">
input{
	width: 50px;
}

</style>
</head>
<body>	

	<img src="${pageContext.request.contextPath}/img/${menudto.m_code}.png">
	${menudto.m_explain}<br>
	${menudto.m_name}<br>
	<br>
 <%-- 	<div>
 		<c:forEach var="olist" items="${option}" begin="0" end="8" varStatus="i">
 			<input type="checkbox" id="${olist.m_code}" name="${olist.m_code}" value="${olist.m_name}" checked="true"><label for="${olist.m_code}">${olist.m_name}</label>&nbsp;
 			<input type="checkbox" id="${olist.m_code}" name="o_vage${i.count}" value="o" checked="true"><label for="${olist.m_code}">${olist.m_name}</label>&nbsp;
 		</c:forEach>
 	</div>
 	<br>
 	<div>
		<select name="o_pan">
			<option >빵선택</option>
			<c:forEach var="olist" items="${option}" begin="9" end="14">
				<option  value="${ olist.m_code }">${olist.m_name}</option>
			</c:forEach>
		</select> 		
 	</div>
 	<br>
 	
 	
 	
 	<div> 		
		<select>
			<option>소스선택</option>
			<c:forEach var="olist" items="${option}" begin="15" end="31">
				<option  value="${ olist.m_code }">${olist.m_name}</option>
			</c:forEach>
		</select>
		<select>
			<option>소스선택</option>
			<c:forEach var="olist" items="${option}" begin="15" end="31">
				<option  value="${ olist.m_code }">${olist.m_name}</option>
			</c:forEach>
		</select>		
 	</div>
 	<br>
 	
 	
 	
  	<div>
		<c:forEach var="olist" items="${option}" begin="32" end="36" varStatus="status">
		<div>
			${olist.m_name} <input name="price" value="0"/>
			<input type="hidden" value="${ olist.m_price }" name="h_price"/>
			<input type="button" value="-" id="${status.count}" onclick="minus(this)"/>
			<input readonly="readonly" value="1" id="o_option${status.count }_num">
			<input type="button" value="+" id="${status.count}" onclick="plus(this)"/>
		</div>
		</c:forEach>
 	</div> 
 	<div>
 		<input value="${ menudto.m_price }" id="totalprice"/> 		
 	</div>
 	<br>
	<div>
		<a href="shoppingbag.do">장바구니담기</a>&nbsp;
		<a href="menulist.do">취소</a>&nbsp;
		<a href="payment.do">결제</a>&nbsp;
	</div>
	
	<hr> --%>
	
 	<button onclick="test()">테스트버튼 </button>
 	<br>
 	<div id="option">
 		<div id="div_1"></div>
 		<div id="div_2"></div>
 		<div id="div_3"></div>
	</div>
	
	<hr>
	테스트 폼 :<br>
	
	<form name="testfrm" action="paymentform.do" method="post" onsubmit="return check();">
	
	
		사용자 id : <input type="text" name="c_id" value="${id }"><br>
		매장 코드 : <input type="text" name="s_code" value="d004"><br>
		기본 가격 : <input type="text" name="o_totalprice" value="${ menudto.m_price }">원<br>
		<br>
		메뉴 코드 : <input type="text" name="m_code" value="${menudto.m_code }"><br>
		빵 선택 : 
		<select name="o_pan">
			<option value="none">빵선택</option>
			<c:forEach var="olist" items="${option_bread}">
				<option  value="${ olist.m_code }">${olist.m_name}</option>
			</c:forEach>
		</select> 		
		<br>
		
		<br>필수 : <br>
		<input type="hidden" name="m_necessary1" value="${menudto.m_necessary1 }"><label>${menudto.m_necessary1_name }</label>
		<input type="hidden" name="m_necessary1_num" value="${menudto.m_necessary1_num }"><label>${menudto.m_necessary1_num}개</label><br>
		
		<input type="hidden" name="m_necessary2" value="${menudto.m_necessary2}"><label>${menudto.m_necessary2_name }</label>
		<input type="hidden" name="m_necessary2_num" value="${menudto.m_necessary2_num}"><label>${menudto.m_necessary1_num}개</label><br>
		
		<input type="hidden" name="m_necessary3" value="${menudto.m_necessary3}"><label>${menudto.m_necessary3_name }</label>
		<input type="hidden" name="m_necessary3_num" value="${menudto.m_necessary3_num}"><label>${menudto.m_necessary3_num}개</label><br>
		
		<input type="hidden" name="m_necessary4" value="${menudto.m_necessary4 }"><label>${menudto.m_necessary4_name }</label>
		<input type="hidden" name="m_necessary4_num" value="${menudto.m_necessary4_num }"><label>${menudto.m_necessary4_num}개</label><br>
		
		 	
 	<div> 		
		<select name="o_sauce1" onchange="sauce_select(o_sauce1)">
			<option value="none">소스선택</option>
			<c:forEach var="olist" items="${option_sauces}">
				<option value="${ olist.m_code }">${olist.m_name}</option>
			</c:forEach>
		</select>
		<select name="o_sauce2" onchange="sauce_select(o_sauce2)">
			<option value="none">소스선택</option>
			<c:forEach var="olist" items="${option_sauces}">
				<option value="${ olist.m_code }">${olist.m_name}</option>
			</c:forEach>
		</select>		
 	</div>
		
 		<br>옵션 : <br>
 	<div>
		<c:forEach var="olist" items="${option_extra}" varStatus="i">
			<div>
				${olist.m_name} 
				<input id="price${i.count }" value="0"/>
				<input type="hidden" value="${ olist.m_code}" name="o_option${i.count }"/>|
				<input type="hidden" value="${ olist.m_price }" id="h_price${i.count }"/>
				<input type="button" value="▼" id="${i.count}" onclick="extra_sub(o_option${i.count }_num, price${i.count }, h_price${i.count })"/>
				<input readonly="readonly" value="0" name="o_option${i.count }_num">
				<input type="button" value="▲" id="${i.count}" onclick="extra_add(o_option${i.count }_num, price${i.count }, h_price${i.count })"/>
			</div>
		</c:forEach>
 	</div>
		
		<br>채소 : <br>
		<!-- 채소 정보만 넘겨주는 option  -->
<%-- 		<c:forEach var="olist" items="${option}" varStatus="i">  --%>
		<c:forEach var="olist" items="${option_vege}" varStatus="i"> 
 			<input type="checkbox" id="${olist.m_code}" name="o_vege${i.count}" value="${olist.m_code}" checked="checked" ><label for="${olist.m_code}">${olist.m_name}</label>&nbsp; 
 			<c:if test="${i.count%4 == 0 }"><br></c:if>
 		</c:forEach>
		
		<br>총 가격 : 
		<input hidden="hidden" type="text" name="o_price" value="${ menudto.m_price }"> <label name="o_price">${ menudto.m_price } 원</label>
		<br>
		<button value="basket" name="command">장바구니</button>
		<button value="payment" name="command">결제</button>
	</form>
	
	
	
</body>
</html>