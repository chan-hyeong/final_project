<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css?ver=1">	
<style type="text/css">


.container-fluid {
	margin-top: 90px;
	float: right;
}
.carousel-control.left{
background-image: linear-gradient(to right,rgba(0,0,0,0) 0,rgba(0,0,0,0) 100%);
}
.carousel-control.right{
background-image: linear-gradient(to right,rgba(0,0,0,0) 0,rgba(0,0,0,0) 100%);
}
#bottom{
	margin-left: 30%;
}
</style>



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
<script type="text/javascript">

$(function(){
    $("#popbutton").click(function(){
        $('div.modal').modal({
                      remote : 'joinform.do'
                });
    })
})
</script>



<title>Please Login</title>
</head>
<body>
<!-- header -->
<jsp:include page="header.jsp"/>
	<br>
	<br>
	<br>
	<br>
</div>
	<div class="login" style="margin-top: 10%;">
	<div class="login-triangle"></div>
	  <h2 class="login-header">Log in</h2>
		<form class="login-container" name="myform" method="post" action="loginpro.do" onsubmit="return check()">

		<p><input type="text" name="c_id" id="id" placeholder="ID" ></p>
				<span id="id_txt"></span>

		<p><input type="password" name="c_pw" id="pwd" placeholder="Password"></p>
			<span id="pwd_txt"></span>

		<p><input type="submit" id="login" value="로그인" ></p>
		<div id="bottom">
		<a href="joinform.do">회원가입</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="main.do" >메인으로</a>
		</div>
			<input type = "hidden" value="${result }">
			 <span id="login_txt"></span>
	</form>
	</div>
	<br>
	<br>
	<br>
	<br>
	<!-- footer -->
	<jsp:include page="footer.jsp"/>
</body>
<script type="text/javascript">
	var msg = "${result}";
	if (typeof msg != "undefined" && msg != null && msg != "") {

		document.getElementById("login_txt").innerHTML = "<font color = 'red'>"+msg+"</font>"
		//alert(msg);
	}
</script>

</html>