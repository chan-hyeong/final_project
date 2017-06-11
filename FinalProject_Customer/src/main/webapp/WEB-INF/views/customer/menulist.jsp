<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">	
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">	
<title>Insert title here</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script> 

</script>
<script type="text/javascript">
function session(m_code){
	var id = "${id}"
	var store = "${selected_store.s_code}"
	
	if(id == ""){
		if ( confirm('로그인 먼저 해주세요') ) window.location.href="loginform.do";
		return false;
	}		
	if(store == ""){
		if ( confirm('매장을 먼저 선택해주세요') ) window.location.href="store2.do";
		return false; 
	}
	window.location.href="orderdetail.do?m_code=" + m_code + "";
}

function store(){
	var id = "${id}"
	if(id == ""){
		if ( confirm('로그인 먼저 해주세요') ) window.location.href="loginform.do";
		return false;
	}
	
}
</script>

<style type="text/css">

	#flip{
		cursor:pointer;
	}
	.grid{
		margin-left: 8%;
		    margin-top: 5%;
	}
	#m_name{
	 font-size: xx-large;
    	color: #3c763d;
	}
	#m_necessary{
		color: orange;
		font-size: large;
	}

.sample_image  img {
    -webkit-transform:scale(1);
    -moz-transform:scale(1);
    -ms-transform:scale(1); 
    -o-transform:scale(1);  
    transform:scale(1);
    -webkit-transition:.3s;
    -moz-transition:.3s;
    -ms-transition:.3s;
    -o-transition:.3s;
    transition:.3s;
}
.sample_image:hover img {
    -webkit-transform:scale(1.2);
    -moz-transform:scale(1.2);
    -ms-transform:scale(1.2);   
    -o-transform:scale(1.2);
    transform:scale(1.2);
}
.sample_image{
	overflow: hidden;
}
#store{
	width: 100%;
	position: fixed;
	
}
.btn{
	    width: 100%;
    position: fixed;
    bottom: 0;
}
</style>
</head>

<body>

<jsp:include page="header.jsp"/>

<div style="margin-top: 12%;">
	<div class="button-group filters-button-group">
	  <button class="button is-checked default" data-filter="*">모든메뉴</button>
	  <button class="button default" data-filter=".m004,.m005, .m006, .m001, .m002">한정메뉴</button>
	  <button class="button default" data-filter=".m007, .m008, .m010, .m017, .m018, .m019">클래식메뉴</button>
	  <button class="button default" data-filter=".m011, .m012, .m013, .m014, .m015, .m016">프리미엄메뉴</button>
	
	</div>
	
	<div class="grid">
		<c:forEach  varStatus="i" begin="0" end="18">
			<div class="element-item  ${menulist[i.index].m_code } ">
					<p class="symbol" style="text-align: center;" >
				<div class="flip col-sm-11 sample_image" id="flip" data-toggle="modal" data-target="#myModal${i.index}" >	
							<img src="${pageContext.request.contextPath}/img/${menulist[i.index].m_code }.png?ver=6" style=" box-shadow: 1px 1px 4px rgba(0,0,0,0.34);"></a></p>
				</div>
				  <!-- Modal -->
				  <div class="modal fade" id="myModal${i.index}" role="dialog" style="top: 20%;height: 100%;">
				    <div class="modal-dialog" style="height: 60%;">
				    
					<!-- Modal content-->
				      <div class="modal-content" style="height: 100%;" >
				        <div class="modal-header">
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				          <h4 class="modal-title" id="m_name">
				          	${menulist[i.index].m_name }
				          </h4>
				        </div>
				        <div class="modal-body" id="m_necessary">
				          ${menulist[i.index].m_necessary1 }
				          ${menulist[i.index].m_necessary2 }
				          ${menulist[i.index].m_necessary3 }
				          ${menulist[i.index].m_necessary4 }
				          
				          	여기에 메뉴 설명
				        </div>
				        <div class="modal-footer" >
				        <!-- 버튼에 스타일 입히기  ★★★★★★★★-->
				          <button onclick="return session('${menulist[i.index].m_code}');">디폴트 담기</button>
				          <button onclick="return session('${menulist[i.index].m_code}');">즐겨찾기 담기</button>
				          <button onclick="return session('${menulist[i.index].m_code}');">주문하기</button>
				        </div>
				      </div>
				    </div>
				  </div>
			</div>
		</c:forEach>
	</div>
	
		<!--------------매장 선택 정보--------------------------------------- -->
		<a href="store2.do" onclick="return store();">
			<button class="btn btn-warning" style="height: 8%;">
					<font color="white">
					<c:choose>
						<c:when test="${selected_store eq null}">
							주문하실 매장을 먼저 선택해주세요
						</c:when>
						<c:otherwise>
							현재 선택된 매장은 <font size="5">${selected_store.s_name}</font><%-- (${selected_store.s_address})--%> 점 입니다
						</c:otherwise>
					</c:choose>
					</font>
			</button>
		</a>		
		<!---------------------------------------------------------------- -->
</div>

<jsp:include page="footer.jsp"></jsp:include>
	<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.2/jquery.min.js'></script>
	<script src='http://npmcdn.com/isotope-layout@3/dist/isotope.pkgd.js'></script>
    <script src="${pageContext.request.contextPath}/js/index.js"></script>
    <script src="${pageContext.request.contextPath}/js/side.js"></script>
</body>
</html>