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
			total=eval(document.getElementById('totalprice').value);
			total=total+Number(document.getElementsByName('h_price')[params.id-1].value);
			document.getElementById('totalprice').value=total;
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
			total=eval(document.getElementById('totalprice').value);
			total=total-Number(document.getElementsByName('h_price')[params.id-1].value);
			document.getElementById('totalprice').value=total;
		}else{
			return;
		}
	}
	

</script>
<body>	
	<img src="${pageContext.request.contextPath}/img/${menudto.m_code}.png">
	${menudto.m_explain}<br>
	${menudto.m_name}<br>
	<br>
 	<div>
 		<c:forEach var="olist" items="${option}" begin="0" end="8">
 			<input type="checkbox" id="${olist.m_code}" name="${olist.m_code}" value="${olist.m_name}" checked="true"><label for="${olist.m_code}">${olist.m_name}</label>&nbsp;
 		</c:forEach>
 	</div>
 	<br>
 	<div>
		<select>
			<option>빵선택</option>
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
			${olist.m_name} <input name="price" value="0" style="width: 75px; text-align: center;"/>
			<input type="hidden" value="${ olist.m_price }" name="h_price"/>
			<input type="button" value="-" id="${status.count}" onclick="minus(this)"/>
			<input readonly="" value="0" name="quantity" style="width: 25px; text-align: center;">
			<input type="button" value="+" id="${status.count}" onclick="plus(this)"/>
		</div>
		</c:forEach>
 	</div>
 	<div>
 		<input value="${ menudto.m_price }" id="totalprice"/> 		
 	</div>
 	<br>
	<div>
		<a href="history.do">결제</a>&nbsp;
		<a href="menulist.do">취소</a>&nbsp;
		<a href="shoppingbag.do">장바구니담기</a>&nbsp;
	</div>
</body>
</html>