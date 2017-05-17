<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	function checkIt(){
		var obj =document.myform;
		
		if(obj.c_id.value == ''){
			document.getElementById("id_txt").innerHTML = "<font color = 'red'>아이디는 필수 값입니다.</font>";
			return;
		}else
			document.getElementById("id_txt").innerHTML = "";
		
		if(obj.c_pw.value == ''){
			document.getElementById("pwd_txt").innerHTML = "<font color = 'red'>비밀번호는 필수 값입니다.</font>";
			return;
		}else
			document.getElementById("pwd_txt").innerHTML = "";
}
</script>
<body> 
	<h1>로그인폼</h1>
	<form name="myform" method="post" action="/customer/loginpro.do" onSubmit = "return checkIt()">
		<div>
		ID: <input type="text" name="c_id" id="id" onkeyup="checkIt()" />
			<span id="id_txt"></span>
		</div>
		<div>
		pw: <input type="password" name="c_pw" id="pwd" onkeyup="checkIt()"/>
			<span id="pwd_txt"></span>
		</div>	
		<input type="submit" id="login" value="로그인"> 
		<a href="index.do">홈</a><br>
	</form>
</body>
</html>