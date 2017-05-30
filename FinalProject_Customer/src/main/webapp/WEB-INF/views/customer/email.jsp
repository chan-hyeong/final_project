<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>email authorize</title>
<script type="text/javascript">
	function check(){
		var obj = document.myform;
		var joincode = ${joinCode };
		
		if(obj.num.value != joincode){
			alert('틀린인증번호 입니다. 다시확인해주세요');
			return false;
		}
		if(obj.num.value == joincode){
			alert('인증완료');
			opener.document.myform.email_Check.value="check";
			window.close();
			
		}
	}
</script>
</head>
<body>
<form name = "myform" method="post">
		번호: <input type="text" name="num" required />
			<input type = "button" value="인증하기" onclick = "check();"/>
			<!-- <input type = "button" value = "닫기" onclick = "close();"/> -->
</form>
</body>
</html>