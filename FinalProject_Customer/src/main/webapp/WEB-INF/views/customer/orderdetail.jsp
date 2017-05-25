<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
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
		var name="o_option"+(params.id)+"_num";
		var quantity=document.getElementsByName(name);
		var change=Number(quantity[0].value);		
		if(change<6){
			var total=0;
			for(var i=0; i<5;i++) {
				var t_name="o_option"+(i+1)+"_num"
				var temp=eval(document.getElementsByName(t_name)[0].value);
			    total=total+temp;
			    if(total>=5) {
			    	alert("option이 너무 많습니다");
			    	return ;
			    }
			}
			quantity[0].value=change+1;
			document.getElementsByName('price')[params.id-1].value=quantity[0].value*document.getElementsByName('h_price')[params.id-1].value;
			total=p_price()+eval(document.getElementById('o_price_r').value);
			document.getElementById('o_price').value=total;
			document.getElementById('totalprice').value=total*eval(document.getElementById('m_quantity').value);			
		}else{
			return;
		}
	}
	function minus(params){
		var name="o_option"+(params.id)+"_num";
		var quantity=document.getElementsByName(name);	
		var change=Number(quantity[0].value);			
		if(change>0){
			quantity[0].value=change-1;
			document.getElementsByName('price')[params.id-1].value=quantity[0].value*document.getElementsByName('h_price')[params.id-1].value;			
			total=p_price()+eval(document.getElementById('o_price_r').value);
			document.getElementById('o_price').value=total;
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
			total=(p_total+Number(document.getElementById('o_price_r').value))*quantity.value;
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
		total=(p_total+Number(document.getElementById('o_price_r').value))*quantity.value;
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
	<div>
		<input type="${menudto.m_necessary1_num >0? 'text':'hidden'} " value="${menudto.m_necessary1_name}">
		<input type="hidden" value="${menudto.m_necessary1}" name="m_necessary1">
		<input type="${menudto.m_necessary1_num >0? 'text':'hidden'}" value="${menudto.m_necessary1_num}" name="m_necessary1_num">
		<c:if test="${menudto.m_necessary1_num >0}"><br></c:if>
		<input type="${menudto.m_necessary2_num >0? 'text':'hidden'}" value="${menudto.m_necessary2_name}">
		<input type="hidden" value="${menudto.m_necessary2}" name="m_necessary2">
		<input type="${menudto.m_necessary2_num >0? 'text':'hidden'}" value="${menudto.m_necessary2_num}" name="m_necessary2_num">
		<c:if test="${menudto.m_necessary2_num >0}"><br></c:if>
		<input type="${menudto.m_necessary3_num >0? 'text':'hidden'}" value="${menudto.m_necessary3_name}">
		<input type="hidden" value="${menudto.m_necessary3}" name="m_necessary3">
		<input type="${menudto.m_necessary3_num >0? 'text':'hidden'}" value="${menudto.m_necessary3_num}" name="m_necessary3_num">
		<c:if test="${menudto.m_necessary3_num >0}"><br></c:if>
		<input type="${menudto.m_necessary4_num >0? 'text':'hidden'}" value="${menudto.m_necessary4_name}">
		<input type="hidden" value="${menudto.m_necessary4}" name="m_necessary4">
		<input type="${menudto.m_necessary4_num >0? 'text':'hidden'}" value="${menudto.m_necessary4_num}" name="m_necessary4_num">
		<c:if test="${menudto.m_necessary4_num >0}"><br></c:if>		
	</div>
	<input type="text" value="1" id="h_m_quantity" name="h_m_quantity">
	<input type="hidden" value="${menudto.m_code}" name="m_code">
	<br>	
 	<div>
 		<c:forEach var="olist" items="${option}" begin="0" end="8" varStatus="status">
 			<input type="checkbox" id="${olist.m_code}" name="o_vege${status.count}" value="${olist.m_code}" checked="true"><label for="${olist.m_code}">${olist.m_name}</label>&nbsp;
 		</c:forEach>
 	</div>
 	<br>
 	<div>
		<select name="o_pan">
			<option>빵선택</option>
			<c:forEach var="olist" items="${option}" begin="9" end="14">
				<option  value="${ olist.m_code }" name="o_pan">${olist.m_name}</option>
			</c:forEach>
		</select> 		
 	</div>
 	<br>
 	<div> 		
		<select name="o_sauce1">
			<option>소스선택</option>
			<c:forEach var="olist" items="${option}" begin="15" end="31">
				<option  value="${ olist.m_code }" name="o_sauce1">${olist.m_name}</option>
			</c:forEach>
		</select>
		<select name="o_sauce2">
			<option>소스선택</option>
			<c:forEach var="olist" items="${option}" begin="15" end="31">
				<option  value="${ olist.m_code }" name="o_sauce2">${olist.m_name}</option>
			</c:forEach>
		</select>		
 	</div>
 	<br>
 	<div>		 	
		<c:forEach var="olist" items="${option}" begin="32" end="36" varStatus="status">
		<div>
			<input type="hidden" value="${olist.m_code}" name="o_option${status.count}"/>
			${olist.m_name} <input name="price" value="0" style="width: 75px; text-align: center;"/>
			<input type="hidden" value="${ olist.m_price }" name="h_price"/>
			<input type="button" value="-" id="${status.count}" onclick="minus(this)" />
			<input readonly="" value="0" name="o_option${status.count}_num" style="width: 25px; text-align: center;">
			<input type="button" value="+" id="${status.count}" onclick="plus(this)"/>
		</div>
		</c:forEach>
 	</div>
 	<div>
 		<input type="hidden" value="${ menudto.m_price }" id="o_price_r" name="o_price_r"/>
 		<input type="hidden" value="${ menudto.m_price }" id="o_price" name="o_price"/>
 		<input value="${ menudto.m_price }" id="totalprice" name="o_totalprice"/>
 		
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