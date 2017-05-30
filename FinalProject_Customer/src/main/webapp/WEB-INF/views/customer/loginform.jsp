<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Please Login</title>
<script type="text/javascript">
	function check() {
		var obj = document.myform;
		if (obj.c_id.value.length == '') {
			document.getElementById("id_txt").innerHTML = "<font color = 'red'>아이디는 필수 값입니다.</font>";
			return false;
		} else
			document.getElementById("id_txt").innerHTML = "";
		if (obj.c_pw.value.length == '') {
			document.getElementById("pwd_txt").innerHTML = "<font color = 'red'>비밀번호는 필수 값입니다.</font>";
			return false;
		} else
			document.getElementById("pwd_txt").innerHTML = "";
	}
</script>
</head>
<body>
	<h1>로그인폼</h1>
	<form name="myform" method="post" action="/customer/loginpro.do" onsubmit="return check()">
		<div>
			ID: <input type="text" name="c_id" id="id" >
			<span id="id_txt"></span>
		</div>
		<div>
			pw: <input type="password" name="c_pw" id="pwd">
			<span id="pwd_txt"></span>
		</div>
		<input type="submit" id="login" value="로그인" >
		<input type = "hidden" value="${result }">
		 <a href="index.do">홈</a><br>
		 <span id="login_txt"></span>
		

	</form>
</body>
<script type="text/javascript">
	var msg = "${result}";
	if (typeof msg != "undefined" && msg != null && msg != "") {
		document.getElementById("login_txt").innerHTML = "<font color = 'red'>"+msg+"</font>"
		//alert(msg);
	}
</script>
</html>