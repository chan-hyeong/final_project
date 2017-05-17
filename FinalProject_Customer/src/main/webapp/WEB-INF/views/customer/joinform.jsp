<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>조인폼</h1>
	<form method="post" action="/customer/joinpro.do">
		ID: <input type="text" name="c_id" /><br> 
		pw: <input type="password" name="c_pw" /><br> 
		이름: <input type="text" name="c_name" /><br> 
		이메일: <input type="text" name="c_email" /><br>
		성별 : <input type="radio" name="c_gender" value="M" />M
			 <input type="radio" name="c_gender" value="F" />F<br>
		생년월일: <input type="text" name="c_birth" /><br> 
		<input type="submit" value="등록"> <a href="index.do">홈</a>
	</form>

</body>
</html>