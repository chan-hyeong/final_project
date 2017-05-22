<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>중복확인</title>
</head>
<body>

<c:set var="msg" value="${result }"></c:set>
<c:if test="${msg!=null }">
<c:choose>
	<c:when test="${msg=='1' }">
		<script type="text/javascript">
		alert("사용중인 아이디입니다.");
		history.go(-1);
		</script>
		<form action="/customer/id_check.do">
			<input type = "text" name ="c_id" />
			<input type = "submit" value = "ID중복확인"/>
		</form>
	</c:when>
	<c:when test="${msg=='0' }">
		<script type="text/javascript">
		alert("사용가능");
		opener.document.myform.idDuplication.value="idCheck";
		opener.document.myform.c_id.value="${id}";
		self.close();
		</script>
	</c:when>
</c:choose>
</c:if>
</body>
</html>