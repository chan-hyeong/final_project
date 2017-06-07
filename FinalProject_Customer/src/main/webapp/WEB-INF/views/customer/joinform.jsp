<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css?ver=1">	

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style type="text/css">
.login input[type="button"]{
  padding: 0px;
  width: 150px;
  height: 40px;
  float: right;
  margin-bottom: 10px;
  margin-right: 14px;
}
</style>

<title>subway는 회원 가입을 페이지 입니다.</title>

</head>

<script type="text/javascript">
	function checkIt(){
		var myform = eval("document.myform");
        var regType = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		
		//이름 유효성
		if(myform.c_name.value == ''){
			alert('이름을 입력하세요');
			return false;
		}
		//이메일 유효성
		if(myform.c_email.value == ''){
			alert('이메일을 입력하세요');
			return false;
		}
		//성별 유효성
		if(myform.c_gender.value == ''){
			alert('성별을 체크하세요');
			return false;
		}
		//생일 유효성
		if(myform.c_birth.value == ''){
			alert('생일을 입력하세요');
			return false;
		}
		if(myform.idDuplication.value != "idCheck"){
			alert('아이디 중복체크는 필수입니다');
			return false;
		}
		
		if(myform.email_Check.value != "check"){
			alert('이메일 인증은 필수입니다');
			return false;
		}
	}
	
	function check_id(){
		var obj =document.myform;
        var regType = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
       
		//id 유효성
		if(obj.c_id.value == ''){
			alert('id를 입력하세요');
			document.getElementsByName("confirm_id")[0].disabled = true;
			return false;
		}else if(obj.c_id.value.length < 4 || obj.c_id.value.length > 10){
			document.getElementById("id_txt").innerHTML = "<font color = 'red'>아이디는 4~10자 사이로 입력하세요.</font>";
			document.getElementsByName("confirm_id")[0].disabled = true;
			return false;
		}else if(regType.test(obj.c_id.value)){
			document.getElementById("id_txt").innerHTML = "<font color = 'red'>아이디가 조건에 맞지 않습니다.</font>";
			document.getElementsByName("confirm_id")[0].disabled = true;
			return;
		}else
			document.getElementById("id_txt").innerHTML = "";
		
		document.getElementsByName("confirm_id")[0].disabled = false;
	}
	
	function check_pw(){
		var obj =document.myform;
		//비밀번호 유효성
		if(obj.c_pw.value == ''){
			document.getElementById("pw_txt").innerHTML = "<font color = 'red'>비밀번호를 입력하세요.</font>";
			return false;
		}else if(obj.c_pw.value.length < 4 || obj.c_pw.value.length >8){
			document.getElementById("pw_txt").innerHTML = "<font color = 'red'>비밀번호는 4~8자 사이로 입력하세요.</font>";
			return false;
		}else
			document.getElementById("pw_txt").innerHTML = "";
	}
	
	function check_birth(){
		var obj =document.myform;
		if(obj.c_birth.value.length > 6 ){
			document.getElementById("c_birth").innerHTML = "<font color = 'red'>생일을 정확히 입력해주세요.</font>";
			return false;
		}else
			document.getElementById("c_birth").innerHTML = "";
	}
	function email_check(myform){
		if(myform.c_email.value == ''){
			alert('이메일을 입력해주세요');
			return false;
		}
		
		 url = "email_check.do?c_email=" + myform.c_email.value;
		 
	    open(url, "eamil_check", 
	    "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=450, height=150");
		
	}
	
	function id_check(myform){
		if(myform.c_id.value == ''){
			alert('id를 입력해주세요');
			return false;
		}
		
		 url = "id_check.do?c_id=" + myform.c_id.value;
		 
	    open(url, "id_check", 
	    "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=450, height=150");
		
	}
</script>
<body>
	<!-- header -->
	<jsp:include page="header.jsp"/>
	<br>
	<br>
	<br>
	<br>
	<div class="login">
		<div class="login-triangle"></div>
	  	<h2 class="login-header">Join</h2>
	  	
		<form class="login-container" name="myform" method="post" action="/customer/joinpro.do" onSubmit="return checkIt()">
			<p><input type="text" name="c_id" placeholder="ID (영문대, 소문자와 숫자만 사용해주세요)" onkeyup="check_id()"></p>
				<input type="button" class="button" name="confirm_id" value="ID중복체크" onclick = "id_check(this.form);">
				<input type="hidden" name = "idDuplication" value="idUncheck">
				<span id="id_txt"></span>
			
			
			<p> <input type="password" name="c_pw" placeholder="Password" onkeyup="check_pw()"></p>
				<span id="pw_txt"></span>
				
			<p><input type="text" name="c_name" placeholder="이름" ></p>
			
			<p> <input type="text" name="c_email" placeholder="이메일 (예 : example@gmail.com)" ></p>
		  	<input type="button" class="button" id="e_btn" value = "이메일 인증" onclick = "email_check(this.form);"><br>
			<input type="hidden" name = "email_Check" value="Uncheck"><br>
			
			성별  
			<input type="radio" name="c_gender" value="M" style="vertical-align: 3px">M 
			<input type="radio" name="c_gender" value="F" style="vertical-align: 0px">F
			
			<p><input type="text" name="c_birth" placeholder="생년월일 (예 : 19920219)" onkeyup="check_birth()"></p>
			<span id="c_birth"></span>
			
			<p><input type="submit" value="등록"></p>	
		</form>
	</div>
	<br>
	<br>
	<br>
	<br>
	
	<!-- footer -->
	<jsp:include page="footer.jsp"/>
	
	<!-- 
	 <a href="index.do">홈</a> -->

</body>
</html>