<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
<title>내정보</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="login" style="margin-top: 10%;">
<div class="login-triangle"></div>
 <h2 class="login-header">내정보</h2>
   <form class="login-container" method="post" action="/customer/modify_update.do">         
      <p>ID: <input type="text" name="c_id" class="form-username form-control" value="${info.c_id }" readonly></p>
      <p>pw: <input type="password" name="c_pw" class="form-password form-control" value="${info.c_pw  }"></p>
      <p>이름: <input type="text" name="c_name" class="form-username form-control" value="${info.c_name  }"></p>
      <p>이메일: <input type="text" name="c_email" class="form-username form-control" value="${info.c_email  }"></p>
      <p>적립금: <input type="text" name="c_coin"  class="form-username form-control" value="${info.c_coin  }" readonly></p>
      <p>생년월일: <input type="text" name="c_birth" class="form-username form-control" value="${info.c_birth  }"readonly></p>
      <input type="submit" class="btn" value="수정 완료">
      <a href="main.do" class="btn" style="text-align: center">메인으로</a>
   </form>
   </div>
   

<jsp:include page="footer.jsp"/>
</body>
</html>