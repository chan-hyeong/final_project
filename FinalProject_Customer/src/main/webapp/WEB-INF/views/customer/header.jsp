<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jstl/fmt_rt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">	

<!-- start 알람체크하는 기능 -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="<c:url value="js/alarm.js"/>">
</script>
<script>
	  //페이지 진입시 
		$(document).ready(function(){
			var title = document.getElementsByTagName("title")[0].innerHTML;
			title ='<%=request.getRequestURI()%>';
			title = title.split('/')[5].split('.jsp')[0];
			console.log(title + " page 입니다");
			
			console.log(title + " page 입니다");
			
			var tmp = ${slist eq null? 0 : slist};
			var slist = new Array();
			for ( var i=0; i<tmp.length; i++){
				slist[i] = tmp[i];
			}
			console.log("주문상태를 체크해야할 order (" + slist.length + " 개): <" + slist + ">");
			console.log(slist[1]);
			
			//console.log("header page 입니다");
			console.log(${slist eq null ? false : true} + " ← 이 정보로 트리거 호출할거임");
			trigerfn(${slist eq null ? false : true});			
		});
</script>
<!-- end 알람체크하는 기능 -->


<title>Insert title here</title>
<style type="text/css">
#loginid {
	color: #ffffff;
	    margin-top: 5%;
}
</style>

</head>
<body>

<div class="header">
<div class="navbar navbar-inverse navbar-fixed-top" style="background-color: #015643; border-color: #015643;">
      <div class="container">
        <div class="navbar-header">
          <!-- 브라우저가 좁아졋을때 나오는 버튼(클릭시 메뉴출력) -->
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="main.do"><img alt="Brand" src="${pageContext.request.contextPath}/css/sub_로고.png"></a>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="main.do">Home</a></li>
				<li><a href="menulist.do">주문</a></li>
				<li><a href="favorite.do">즐겨찾기</a></li>
				<li><a href="history.do">히스토리</a></li>
				<li><a href="shoppingbag.do">장바구니</a></li>
          </ul>
          <div class="nav navbar-nav navbar-right" id="loginmenu" >
			<c:set var="id" value="${id}"></c:set>
			<c:choose>
				<c:when test="${ id eq null }">
					<li><a href="loginform.do"> <span class="glyphiconglyphicon-user"> </span>로그인
					</a></li>
					<li><a href="joinform.do"> <span class="glyphiconglyphicon-user"> </span>회원가입
					</a></li>
				</c:when>
				<c:when test="${id ne null }">
					<li id="loginid"><span class="glyphicon glyphicon-user"></span>
						${id} 님 환영합니다.<%--  카드 잔액은 <fmt:formatNumber>${c_coin eq null ? 0 : c_coin}</fmt:formatNumber> 원 입니다 , 아 줄이깨지네--%>
						</li>
					<li><a href="modify.do"><span
							class="glyphicon glyphicon-user"></span>내정보 </a></li>
					<li><a href="logout.do"><span
							class="glyphicons glyphicons-log-out"></span>로그아웃</a></li>
				</c:when>
			</c:choose>
		</div>
        </div>
      </div>
</div>


</div>	
</body>
</html>

