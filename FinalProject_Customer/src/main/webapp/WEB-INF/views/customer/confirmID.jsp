<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>중복확인</title>
<script type="text/javascript">
	var result = "${result}";
	if(result == "1"){
		alert("사용중인 아이디입니다.");
	}else if(result == "0"){
		alert("사용가능");
		opener.document.myform.idDuplication.value="idCheck";
		opener.document.myform.c_id.value="${id}";
		self.close();
	}
</script>
</head>

<body>
		<form action="/customer/id_check.do">
			<input type = "text" name ="c_id" />
			<input type = "submit" value = "ID중복확인"/>
			<input type = "hidden" value = "${result }">
		</form>
</body>
</html>