<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>내정보</title>
</head>
<body>
<form method="post" action="/customer/modify_update.do">
ID: <input type="text" name="c_id" value="${info.c_id }" readonly/><br>
pw: <input type="password" name="c_pw" value="${info.c_pw  }"/><br>
이름: <input type="text" name="c_name" value="${info.c_name  }"/><br>
이메일: <input type="text" name="c_email" value="${info.c_email  }"/><br>
적립금: <input type="text" name="c_coin" value="${info.c_coin  }" readonly/><br>
생년월일: <input type="text" name="c_birth" value="${info.c_birth  }"readonly/><br>
<input type="submit" value="수정 완료"/>
<a href="main.do">main</a>

</form>
</body>
</html>