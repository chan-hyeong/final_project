<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css?ver=1">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/form-elements.css?ver=1">

<title>${id} 님의 정보입니다. </title>
</head>
<body>
	<form method="post" action="/customer/modify_update.do">
		<div class="col-sm-6 col-sm-offset-3 form-box">
			<div class="form-top">
					<div class="form-top-left">
						<h3>Kosta Subway My Info</h3>
						<p></p>
					</div>
					<div class="form-top-right">
						<i class="fa fa-lock"></i>
					</div>
				</div>
			<div class="form-bottom">
				<label class="sr-only" for="form-username"></label>
					ID: <input type="text" name="c_id" class="form-username form-control" value="${info.c_id }" readonly><br>
				<label class="sr-only" for="form-password"></label>
					pw: <input type="password" name="c_pw" class="form-password form-control" value="${info.c_pw  }"><br>
				<label class="sr-only" for="form-username"></label>
					이름: <input type="text" name="c_name" class="form-username form-control" value="${info.c_name  }"><br>
				<label class="sr-only" for="form-username"></label>
					이메일: <input type="text" name="c_email" class="form-username form-control" value="${info.c_email  }"><br>
				<label class="sr-only" for="form-username"></label>
					적립금: <input type="text" name="c_coin"  class="form-username form-control" value="${info.c_coin  }" readonly><br>
				<label class="sr-only" for="form-username"></label>
					생년월일: <input type="text" name="c_birth" class="form-username form-control" value="${info.c_birth  }"readonly><br>
					<input type="submit" class="btn" value="수정 완료">
					<a href="main.do" class="btn">main</a>
			</div>
			</div>
	</form>

</form>
</body>
</html>