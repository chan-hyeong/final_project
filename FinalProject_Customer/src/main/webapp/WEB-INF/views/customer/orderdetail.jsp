<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>

<script type="text/javascript">
	
	var option_num = 0;
	function test(params){
 		if ( option_num >= 3)return false;
 		alert(document.getElementById('option').innerHTML);
 		option_num += 1;
		var code1 = "<select>";
			 code1 += "<option value=\"dc\">더블치즈</option>";	
			 code1 += "<option value=\"ac\">아보카도</option>";	
			 code1 += "<option value=\"dm\">더블미트</option>";
			 code1 += "<option value=\"em\">에그마요</option>";
			 code1 += "<option value=\"bk\">베이컨</option>";
			 code1 += "</select>";
		var code2 = "<select><option value=1>1</option><option value=2>2</option><option value=3>3</option></select>";
		var code = "<div id=\"div_"+option_num+"\">"+code1+code2+"<button value=1 onclick=\"delete_div("+option_num+")\">X</button><div>";
		document.getElementById('option').innerHTML += code+"<br>";
		return;
	}
	
	function delete_div(params){
		var name = "div_" + params;
		alert("눌린버튼 : " + name);
		document.getElementById(name).innerHTML = "";
		option_num -= 1;
	}
	
	function before_submit(){
		
	}

	function plus(params) {
		//var quantity=document.getElementsByName('quantity');
		var name = "o_option" + params.id + "_num";
		alert("이렇게 되나 " + name);
		var test = document.getElementById(name);

		alert("이게 나와야지 되는거임 " + test.value);
		
		
		
		
		
		var change = Number(quantity[params.id - 1].value);
		if (change < 5) {
			var total = 0;
			for (var i = 0; i < quantity.length; i++) {
				total = total + Number(quantity[i].value);
				if (total >= 5) {
					alert("option이 너무 많습니다");
					return;
				}
			}
			quantity[params.id - 1].value = change + 1;
			document.getElementsByName('price')[params.id - 1].value = quantity[params.id - 1].value
					* document.getElementsByName('h_price')[params.id - 1].value;
			total = eval(document.getElementById('totalprice').value);
			total = total
					+ Number(document.getElementsByName('h_price')[params.id - 1].value);
			document.getElementById('totalprice').value = total;
		} else {
			return;
		}
	}
	function minus(params) {
		var quantity = document.getElementsByName('quantity');
		var change = Number(quantity[params.id - 1].value);
		if (change > 0) {
			quantity[params.id - 1].value = change - 1;
			document.getElementsByName('price')[params.id - 1].value = quantity[params.id - 1].value
					* document.getElementsByName('h_price')[params.id - 1].value
			total = eval(document.getElementById('totalprice').value);
			total = total
					- Number(document.getElementsByName('h_price')[params.id - 1].value);
			document.getElementById('totalprice').value = total;
		} else {
			return;
		}
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
 	<div>
 		<c:forEach var="olist" items="${option}" begin="0" end="8" varStatus="i">
 <%-- 			<input type="checkbox" id="${olist.m_code}" name="${olist.m_code}" value="${olist.m_name}" checked="true"><label for="${olist.m_code}">${olist.m_name}</label>&nbsp; --%>
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
 	
 	<button onclick="test()">테스트버튼 </button>
 	<br>
 	
 	<div id="option">
 	
 	</div>
 	
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
	
	<hr>
	
	-------------------
	
	
	
	<form action="payment.do" onsubmit="before_submit()">
	
	
		사용자 id : <input type="text" name="c_id" value="${id }"><br>
		매장 코드 : <input type="text" name="s_code" value="testscode"><br>
		기본 가격 : <input type="text" name="o_totalprice" value="${ menudto.m_price }">원<br>
		<br>
		메뉴 코드 : <input type="text" name="m_code" value="${menudto.m_code }"><br>
		빵 선택 : 
		<select name="o_pan">
			<option >빵선택</option>
			<c:forEach var="olist" items="${option}" begin="9" end="14">
				<option  value="${ olist.m_code }">${olist.m_name}</option>
			</c:forEach>
		</select> 		
		<br>
		
		<br>필수 : <br>
		<%-- <c:forEach var="i" begin="1" end="4" varStatus="s">
			<input type="text" name="m_necessary${i}" value="">
			<input type="text" name="m_necessary${i}_num" value="">
			<input type="text" name="m_necessary${i}_num" value="${menudto.m_necessary+i_num }"><br>
		</c:forEach> --%>
		<input type="text" name="m_necessary1" value="${menudto.m_necessary1 }">
		<input type="text" name="m_necessary1_num" value="${menudto.m_necessary1_num }"><br>
		<input type="text" name="m_necessary2" value="${menudto.m_necessary2}">
		<input type="text" name="m_necessary2_num" value="${menudto.m_necessary2_num}"><br>
		<input type="text" name="m_necessary3" value="${menudto.m_necessary3}">
		<input type="text" name="m_necessary3_num" value="${menudto.m_necessary3_num}"><br>
		<input type="text" name="m_necessary4" value="${menudto.m_necessary4 }">
		<input type="text" name="m_necessary4_num" value="${menudto.m_necessary4_num }"><br>
		
		 	
 	<div> 		
		<select name="o_sauce1">
			<option>소스선택</option>
			<c:forEach var="olist" items="${option}" begin="15" end="31">
				<option  value="${ olist.m_code }">${olist.m_name}</option>
			</c:forEach>
		</select>
		<select name="o_sauce2">
			<option>소스선택</option>
			<c:forEach var="olist" items="${option}" begin="15" end="31">
				<option  value="${ olist.m_code }">${olist.m_name}</option>
			</c:forEach>
		</select>		
 	</div>
		
 		<br>옵션 : <br>
		<input type="text" name="o_option1" value="">
		<input type="text" name="o_option2" value="">
		<input type="text" name="o_option3" value="">
		<input type="text" name="o_option1_num" value="0"><br>
		<input type="text" name="o_option2_num" value="0"><br>
		<input type="text" name="o_option3_num" value="0"><br> 
		
		<br>베지 : <br>
		<c:forEach var="olist" items="${option}" begin="0" end="8" varStatus="i">
 			<input type="checkbox" id="o_${olist.m_code}" name="o_vage${i.count}" maxlength="1" value="o" checked="checked"><label for="o_${olist.m_code}">${olist.m_name}</label>&nbsp;
 			<c:if test="${i.count%4 == 0 }"><br></c:if>
 		</c:forEach>
		
		<br>가격 : <br>
		<input hidden="hidden" type="text" name="o_price" value="${ menudto.m_price }"> <label >${ menudto.m_price } 원</label>
		<br>
		<button value="basket" name="command">장바구니</button>
		<button value="payment" name="command">결제</button>
	
	</form>
	
	
	
	
	
</body>
</html>