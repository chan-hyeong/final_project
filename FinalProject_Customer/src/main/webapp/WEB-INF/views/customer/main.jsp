<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>로그인성공후 메인페이지 </h1>
<%
String id = (String)session.getAttribute("id");
%>
<%=id %>님 환영합니다.<br>
<h3>
<a href="menulist.do">주문</a><br>
</h3>
<h3>
<a href="favorite.do">즐겨찾기</a><br>
</h3>
<h3>
<a href="history.do">히스토리</a><br>
</h3>
<h3>
 <a href="modify.do">내정보</a><br>
</h3>
<h3>
 <a href="shoppingbag.do">장바구니</a><br>
</h3>
<h3>
<a href="logout.do">로그아웃</a><br>
</h3>



<%-- form action="modify.do" method="get">
<input type="hidden" name="c_id" value="<%=id %>" >
<input type="submit" value="내정보">
</form> --%>

</body>
</html>