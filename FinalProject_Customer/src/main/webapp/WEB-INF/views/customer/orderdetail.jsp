<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
</head>
<script type="text/javascript">
	function p_price(){
		var price=document.getElementsByName('price');
		var p_total=0;
		for(var i=0; i<price.length; i++) {
		    p_total=p_total+Number(price[i].value);		    
		}
		return p_total;
	}
	function plus(params){		
		var quantity=document.getElementsByName('quantity');
		var change=Number(quantity[params.id-1].value);
		if(change<5){			
			var total=0;
			for(var i=0; i<quantity.length; i++) {
			    total=total+Number(quantity[i].value);
			    if(total>=5) {
			    	alert("option이 너무 많습니다");
			    	return ;
			    }
			}
			quantity[params.id-1].value=change+1;
			document.getElementsByName('price')[params.id-1].value=quantity[params.id-1].value*document.getElementsByName('h_price')[params.id-1].value;
			total=p_price()+eval(document.getElementById('o_price').value);
			document.getElementById('totalprice').value=total*eval(document.getElementById('m_quantity').value);
		}else{
			return;
		}
	}
	function minus(params){
		var quantity=document.getElementsByName('quantity');
		var change=Number(quantity[params.id-1].value);			
		if(change>0){			
			quantity[params.id-1].value=change-1;
			document.getElementsByName('price')[params.id-1].value=quantity[params.id-1].value*document.getElementsByName('h_price')[params.id-1].value
			total=p_price()+eval(document.getElementById('o_price').value);
			document.getElementById('totalprice').value=total*eval(document.getElementById('m_quantity').value);
		}else{
			return;
		}
	}
	function m_minus(){
		var quantity=document.getElementById('m_quantity');
		var p_total=p_price();
		var change=Number(quantity.value);
		if(change>1){
			var total=0;
			quantity.value=change-1;
			total=(p_total+Number(document.getElementById('o_price').value))*quantity.value;
			document.getElementById('totalprice').value=total;
			document.getElementById('h_m_quantity').value=change-1;
		}else{
			return;
		}
	}
	function m_plus(){
		var quantity=document.getElementById('m_quantity');
		var p_total=p_price();
		var change=Number(quantity.value);		
		var total=0;
		quantity.value=change+1;
		total=(p_total+Number(document.getElementById('o_price').value))*quantity.value;
		document.getElementById('totalprice').value=total;
		document.getElementById('h_m_quantity').value=change+1;
	}
</script>
<body>

	<img src="${pageContext.request.contextPath}/img/${menudto.m_code}.png"/>
	${menudto.m_explain}<br>	
	<div>
		${menudto.m_name}
		<input type="button" value="-" id="m_minus" onclick="m_minus()"/>
		<input readonly="" value="1" id="m_quantity" style="width: 25px; text-align: center;"/>
		<input type="button" value="+" id="m_plus" onclick="m_plus()"/>
	</div>
	<form action="payment.do">
	<input type="hidden" value="1" id="h_m_quantity">
	<%-- <input type="hidden" value="${menudto.m_code}" name="m_code"> --%>
	<br>	
 	<div>
 		<c:forEach var="olist" items="${option}" begin="0" end="8" varStatus="status">
 			<input type="checkbox" id="${olist.m_code}" name="o_vege${status.count}" value="o" checked="true"><label for="${olist.m_code}">${olist.m_name}</label>&nbsp;
 		</c:forEach>
 	</div>
 	<br>
 	<div>
		<select>
			<option>빵선택</option>
			<c:forEach var="olist" items="${option}" begin="9" end="14">
				<option  value="${ olist.m_code }" name="o_pan">${olist.m_name}</option>
			</c:forEach>
		</select> 		
 	</div>
 	<br>
 	<div> 		
		<select>
			<option>소스선택</option>
			<c:forEach var="olist" items="${option}" begin="15" end="31">
				<option  value="${ olist.m_code }" name="o_sauce1">${olist.m_name}</option>
			</c:forEach>
		</select>
		<select>
			<option>소스선택</option>
			<c:forEach var="olist" items="${option}" begin="15" end="31">
				<option  value="${ olist.m_code }" name="o_sauce2">${olist.m_name}</option>
			</c:forEach>
		</select>		
 	</div>
 	<br>
 	<div>
 		<%-- <select>
			<option>option선택</option>
			<c:forEach var="olist" items="${option}" begin="32" end="36" varStatus="status">
				<option  value="${ olist.m_code }" name="o_option${status.count }">${olist.m_name}</option>
			</c:forEach>
			<input type="button" value="-" id="${status.count}" onclick="minus(this)"/>
			<input readonly="" value="0" name="quantity" style="width: 25px; text-align: center;">
			<input type="button" value="+" id="${status.count}" onclick="plus(this)"/>
			<input name="price" value="0" style="width: 75px; text-align: center;"/>
		</select> --%>
		<c:forEach var="olist" items="${option}" begin="32" end="36" varStatus="status">
		<div>
			<input type="hidden" value="${olist.m_code}" name="o_option${status.count}"/>
			${olist.m_name} <input name="price" value="0" style="width: 75px; text-align: center;"/>
			<input type="hidden" value="${ olist.m_price }" name="h_price"/>
			<input type="button" value="-" id="${status.count}" onclick="minus(this)"/>
			<input readonly="" value="0" name="quantity" style="width: 25px; text-align: center;">
			<input type="button" value="+" id="${status.count}" onclick="plus(this)"/>
		</div>
		</c:forEach>
 	</div>
 	<div>
 		<input type="hidden" value="${ menudto.m_price }" id="o_price" name="o_price"/>
 		<input value="${ menudto.m_price }" id="totalprice"/> 		
 	</div>
 	<br>
	<div>
		<button value="payment" name="command">결제</button>&nbsp;
		<button value="cancle" name="command">취소</button>&nbsp;
		<button value="basket" name="command">장바구니</button>&nbsp;	
	</div>
</form>
</body>
</html>