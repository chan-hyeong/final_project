<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>로그아웃</title>
</head>
<body>
<%
session.invalidate();
System.out.print("로그아웃");
response.sendRedirect("/customer/index.do");
%>
</body>
</html>