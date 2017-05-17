<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>로그인폼</h1>
	<form method="post" action="/customer/loginpro.do">
		ID: <input type="text" name="c_id" /><br> pw: <input
			type="password" name="c_pw" /><br> <input type="submit"
			value="로그인"> <a href="index.do">홈</a><br>
	</form>
</body>
</html>