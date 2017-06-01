<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
div#menulist {
	border: 1px black solid;
	padding : 5px;
	width: 70%;
}
button{
	width:120px;
	margin: 2px;
	padding: 2px;
}
</style>
</head>
<body>
	<a href="shoppingbag.do"><h3>장바구니로 가기</h3></a>
	<a href="main.do"><h3>메인으로 가기</h3></a>
	
	<fieldset>
		<legend>
		<h2>테스트 공간 </h2>
		</legend>
			리스트 타입으로 넘어오면 index로 접근 가능하다 
			<hr>
			${menulist[0]}
			<br>
			<br>
			${menulist[1].m_name}
			<br>
	</fieldset>
	<hr>
	
	<fieldset>
		<legend>		<h2>아이디어 </h2>		</legend>
		
		아 메뉴리스트를 div 안에 사진이랑 정보만 보여주고 버튼을 안만듦
		div 영역을 클릭하면 화면 상or하단에 버튼이 float로 나타나는 거임 --> 선택된 메뉴 이름나오고 버튼들 짠! 누르면 다음페이지로 넘어가는 
		
	</fieldset>
	<hr>
	

	<h1>메뉴리스트</h1>
	<c:forEach var="list" items="${menulist}">
			<div id="menulist" style="display: inline-table;">
		<a href="orderdetail.do?m_code=${ list.m_code }">
			<img src="${pageContext.request.contextPath}/img/${ list.m_code }.png" 
				style="width: 65%;" title="${list.m_explain}">
		</a>
			<div>
				<h2>${list.m_name} <fmt:formatNumber currencySymbol="￦">${list.m_price }</fmt:formatNumber> 원</h2>
				<i>${list.m_necessary1 } ${list.m_necessary2 } ${list.m_necessary3 } ${list.m_necessary4 }</i>
			</div>
			<div>
				<button>15cm</button></input> | <button>30cm</button><br><!-- 버튼이지만 라디오 버튼같은 용도로 사용해야함  , 누르면 토글되고 금액바뀌고 컨트롤러로 값 넘기고 -->
				<button disabled="disabled">★바로담기</button> | <button disabled="disabled">★바로주문</button><br> <!-- El 문으로 해당 메뉴코드로 즐겨찾기 없을시 비활성화? or 아에 안보여주기 --> 
				<button>추천 담기</button> | <button>추천 주문</button><br> <!-- 추천 기능 들어가면 추천 메뉴로 주문 가능  -->
				<button>퍼스널 옵션 ▶</button><br>
				
			</div>
			</div>
		
		<br><br>
	</c:forEach>
</body>
</html>
	<!-- <a href="payment.do">클릭하면 해당상품 결제</a> -->