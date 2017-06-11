<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/footer.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>메인</title>
<style type="text/css">
.go {
	height: 100px;
	width: 300px;
	background-color: rgba(0, 0, 0, .075);
	box-shadow: 2px 2px 3px rgba(69, 52, 27, 0.56);
	border-color: #555;
	display: table-cell;
	vertical-align: middle;
	font-size: 17px;
	font-weight: 900;
	color: rgb(80, 80, 80);
	line-height: 24px;
	margin-left: 10px;
	padding: 1%;
}

.go2 {
	/* display: inline-block; */
	padding: 0 10px;
	border: 2px solid #0078ae;
	font-size: 16px;
	font-weight: 500;
	color: #0078ae;
	line-height: 40px;
	/* vertical-align: middle; */
	float: right;
}

.go2 a {
	color: #807d7d;
	font-weight: bold;
}

.go3 {
	padding: 0 10px;
	border: 2px solid #ffffff;
	font-size: 16px;
	font-weight: 500;
	color: #ffffff;
	line-height: 40px;
	/* vertical-align: middle; */
	float: right;
}

.order {
	background: rgb(38, 97, 156);
	/* display: table-cell; */
	/* vertical-align: middle; */
	font-size: 17px;
	font-weight: 500;
	color: #4a3a3a;
	height: 80px;
	width: 300px;
	text-align: center;
	/* margin-left: 50%; */
	padding: 25px;
	box-shadow: 2px 2px 3px rgba(69, 52, 27, 0.56);
	font-weight: bold;
	color: white;
}

.row {
	margin-right: -15px;
	margin-left: -15px;
	margin-top: 5%;
}
</style>

</head>

<body>
	<div class="wrapper">
		<!-- header -->
		<div class="header">
			<jsp:include page="header.jsp" />
		</div>

		<!-- content -->
		<div class="content" style="margin-top: 85px;-webkit-margin-before: 12em;">
			<div id="myCarousel" class="carousel slide" data-ride="carousel">
				<!-- Indicators -->
				<ol class="carousel-indicators">
					<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					<li data-target="#myCarousel" data-slide-to="1"></li>
					<li data-target="#myCarousel" data-slide-to="2"></li>
				</ol>

				<!-- Wrapper for slides -->
				<div class="carousel-inner">
					<div class="item active">
						<img src="${pageContext.request.contextPath}/css/main1.png"
							style="width: 100%;">
					</div>

					<div class="item">
						<img src="${pageContext.request.contextPath}/css/main2.png"
							style="width: 100%;">
					</div>

					<div class="item">
						<img src="${pageContext.request.contextPath}/css/main3.png"
							style="width: 100%;">
					</div>
				</div>

				<!-- Left and right controls -->
				<a class="left carousel-control" href="#myCarousel"
					data-slide="prev"
					style="background-image: linear-gradient(to right, rgba(0, 0, 0, 0) 0, rgba(0, 0, 0, 0) 100%);">
					<span class="glyphicon glyphicon-chevron-left"></span> <span
					class="sr-only">Previous</span>
				</a> <a class="right carousel-control" href="#myCarousel"
					data-slide="next"
					style="background-image: linear-gradient(to left, rgba(0, 0, 0, 0) 0, rgba(0, 0, 0, 0) 100%);">
					<span class="glyphicon glyphicon-chevron-right"></span> <span
					class="sr-only">Next</span>
				</a>
			</div>
		</div>
		<div>
			<br>

			<div
				style="display: -webkit-box; display: -moz-box; display: -ms-flexbox; display: -webkit-flex; display: flex; align-items: center; justify-content: center; -webkit-align-items: center; -webkit-justify-content: center; -webkit-box-pack: center; -webkit-box-align: center; -moz-box-pack: center; -moz-box-align: center; -ms-box-pack: center; -ms-box-align: center;">
				<div class="order">
					SubWay 주문방법 →
					<div class="go3" data-toggle="modal" data-target="#myModal">
						클릭</div>
				</div>
				<!-- Modal -->
				<div class="modal fade" id="myModal" role="dialog">
					<div class="modal-dialog">

						<!-- Modal content-->
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title" id="m_name"></h4>
							</div>
							<div class="modal-body" id="m_necessary">
								<div class="w3-content" style="max-width: 800px">
									<img class="mySlides"
										src="${pageContext.request.contextPath}/css/o1.jpg"
										style="width: 100%"> <img class="mySlides"
										src="${pageContext.request.contextPath}/css/o2.jpg"
										style="width: 100%"> <img class="mySlides"
										src="${pageContext.request.contextPath}/css/o3.jpg"
										style="width: 100%"> <img class="mySlides"
										src="${pageContext.request.contextPath}/css/o4.jpg"
										style="width: 100%"> <img class="mySlides"
										src="${pageContext.request.contextPath}/css/o5.jpg"
										style="width: 100%"> <img class="mySlides"
										src="${pageContext.request.contextPath}/css/o6.jpg"
										style="width: 100%"> <img class="mySlides"
										src="${pageContext.request.contextPath}/css/o7.jpg"
										style="width: 100%">
								</div>

								<div class="w3-center">
									<div class="w3-section">
										<input type="button" class="w3-button w3-light-grey"
											onclick="plusDivs(-1)" value="Prev" /> <input type="button"
											class="w3-button w3-light-grey" onclick="plusDivs(1)"
											value="Next" />
									</div>
									<input type="button" class="w3-button demo"
										onclick="currentDiv(1)" value="1"> <input
										type="button" class="w3-button demo" onclick="currentDiv(2)"
										value="2"> <input type="button" class="w3-button demo"
										onclick="currentDiv(3)" value="3"> <input
										type="button" class="w3-button demo" onclick="currentDiv(4)"
										value="4"> <input type="button" class="w3-button demo"
										onclick="currentDiv(5)" value="5"> <input
										type="button" class="w3-button demo" onclick="currentDiv(6)"
										value="6"> <input type="button" class="w3-button demo"
										onclick="currentDiv(7)" value="7">
								</div>

							</div>

						</div>

					</div>
				</div>

			</div>
			<div class="form-group row"
				style="display: -webkit-box; display: -moz-box; display: -ms-flexbox; display: -webkit-flex; display: flex; align-items: center; justify-content: center; -webkit-align-items: center; -webkit-justify-content: center; -webkit-box-pack: center; -webkit-box-align: center; -moz-box-pack: center; -moz-box-align: center; -ms-box-pack: center; -ms-box-align: center;">
				<div class="go">
					<c:if test="${id eq null}">
				로그인 하시면 <br>
				편리하게 주문가능!
				</c:if>
					<c:if test="${id ne null}">
					${id }님 환영합니다.
				</c:if>
					<c:if test="${id eq null}">
						<div class="go2">
							<a href="loginform.do">로그인</a>
						</div>
					</c:if>
				</div>
				&nbsp;&nbsp;&nbsp;
				<div class="go">
					복잡한 주문을 <br> 간단하게!
					<div class="go2">
						<a href="menulist.do">주문</a>
					</div>
				</div>
				&nbsp;&nbsp;&nbsp;
				<div class="go">
					내 주변 매장 찾기<br>
					<div class="go2">
						<a href="store2.do">매장</a>
					</div>
				</div>
				&nbsp;&nbsp;&nbsp;
			</div>
			<!-- 	<div class="go">
		주문 할려면 로그인 gogo
		로그인
	</div> -->
			<br>
			<br>
			 <h1 style="margin-left: 9%;">베스트 Top 5</h1>
      <div>
      <div class="top" style="text-align: center;">
               <c:forEach items="${top5 }" var="top" >
                 <div class="col-sm-4" style="font-weight: bold;" >
                 ${top.rank }위
                  <img title="${top.menu_name }" src=<c:url value="img/${top.menu_code}.png"/> style="box-shadow: 2px 2px 3px rgba(69,52,27,0.56); margin-top: 15px; text-align: center;">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 </div>
                  
               </c:forEach>
          
        </div>
        
     </div>
			<br> <br> <br>
		</div>







		<!-- footer -->
		<jsp:include page="footer.jsp" />
	</div>



	<%-- <p>
추천 : order_Detail , order_list 를 이용해서 인기 메뉴 rank 매김 , 연령? 지역? 시간? 성별?로 그룹 
또는 본인이 자주 시켰던 메뉴의 인기 조합 
별점 시스템? 자기만 평을 매기는거지 평은 order_detail에 comment정도로 저장하면 될듯?
동메뉴 주문횟수 * 별점  뭐 이런식으로 가중치 적용 

미리충전된 마일리지? 포인트? 로 주문 결제하는 시스템, 주문을 빠르게 할 수 있음
실제 충전되는 기능을 삽입해야 할듯 ?


매장선택가능케! 
지도 api 이용해서 현재 위치기반 가까운 매장 좌라락 보여주고 선택가능케, 
매장선택하면 s_code 로 inventory 조회해서 주문불가한 메뉴 파악가능 --> 주문버튼 비활성화?
매장에 주문이 너무 몰리게되면 대기시간이 길어질거임 
샌드위치 하나 제조에 대략 4분 ?정도 걸린다고 가정하고 대기시간을 알려주는거임, 실시간으로 변하면 더 좋고 
pool 처럼 일정량을 초과해서 주문이 들어올경우 경고? 같은거 띄워주면서 대기가 길어짐을 강조? 아니면 주문을 못하게? "해당매장은 주문 과부화상탬돠"

for(menuDTO item : selected menu_list){
	메뉴리스트 { 
		메뉴사진 썸넬, 
			이름, 가격, 필수 재료 목록, 
		버튼 : 0) 15cm / 30cm 선택버튼 (라디오 토글 키 같은 느낌으로 )
			 1) 미리 설정된 옵션으로 주문하기 (즐겨찾기?에 미리 등록해놨을 시에만 활성화 )
			 2) 디폴트(추천 조합) 담기 / 주문 <-- confirm 에서 어떤 조합인지 알려주고 경고하듯 alert 띄우기? 
			 3) 퍼스널 옵션으로 가기 --> 거기서 담기 / 주문
	}
}

컨트롤러에서 shoppingbag 분화해도 될듯 
이름 통일해야할듯 
cart? shoppingbag? basket? 


즐겨찾기 기능 추가되면 favorite controller도 생길듯? 
즐겨찾는 조합을 정해서 저장할 수 있음 order_detail에 고대로 들어가고 order_list.order_status='즐겨찾기'로 들어가면 될듯 ?

장바구니 2개월후에 삭제되는거는 
delete from order_detail 
where order_num = (select order_num 
					from order_list 
					where --c_id = #{c_id } and 
						order_status = '장바구니 ' 
						and order_date < sysdate-60 --오늘로 부터 60일 전 , 보다 더 전에 등록된 장바구니들 지워라 
					);
					


매장에서는 메뉴, 재료, 시간대별 매출 비교 가능케  


재료들끼리 궁합잘맞는것도 쿼리로 찾아낼수 잇을듯? --> 신메뉴 또는 개선메뉴 출시에 좋은 자료가 될듯 
예를 들어 미트볼이랑 에그마요 조합이 좋으면 미트에그볼 샌드위치를 출시해서 좀더 저렴한 가격에 재공한다거나 뭐 그런 


본사에서는 특별히 지점별 매출 비교 가능케? 
--> 단순매출총액 
	, 시간대별 매출  : 오전-오후 (매장별 장사 잘되는 시간을 상이하다면 재고 배송 스케줄 우선순위 고려해야할듯)
	, 전년(월 주 일)대비 매출이 증가한 매장 파악도 가능할듯?
	
				

이제 슬슬 샌드위치 말고 다른 메뉴도 추가해야할듯? 
너무 샌드위치 한정으로 바뀌고 있음 
샌드위치가 아닌 메뉴는 퍼스널옵션없이 바로 담기 또는 주문 가능케 ? 
최대한 일반화를 시켜야함 


목요일정도에 지혜가 부트스트랩 사용법 파악하고 조원들한테 전파해주면 
jsp 페이지 싹다 갈아엎고 
controller 와 그 안에있는 매서드도 다 분화, 
주석 달면서 read me? 같은 역할하는 문서도 만드는게 좋을 듯 

ppt로 다이어그램? 도 만들면서 해야할듯 


ppt { 
	1. 주제선정 배경 
		- 웹툰? 처럼 서브웨이 주문상황 묘사 
			1) 처음 와본 사람, 뭘 선택해야 할지 몰라서 벙쪄있음, 장사잘되는 시간이라 뒤에는 손님들 줄서잇음 ( 손님들 중엔 메뉴와 조합을 이미 결정해서 바로 주문만 때리면 도니느 사람이 있다는걸 보여줌 )
			2) 겨우 결정해서 주문했건만 재고를 살피던 알바 -> 떨어져서 다른걸 고르라 함 , 뒤에 손님들 속터짐 
			--> 이게 현상황 
		- 스타벅스의 사이렌 오더 사용을 묘사 
			1) 08:55 분, 출근 5분전, 스벅 매장은 한산한데 음료가 계속 나오고 있음 
			2) 바쁘게 들어온 사람들은 음료를 바로 들고 나감, 결제도 없음 
			3) 5분전, 매장으로부터 2km 떨어진 거리의 버스안에서 siren order로 주문하고 결제까지 끝내는 직장인 
		--> 고객 : 원하는 메뉴를 미리 주문, 픽업 / 점주 : 단위시간에 더 많은 매출을 올릴 수 있음, 웨이팅을 보고 이탈하는 손님까지 영업가능 
	
		- 내가 주문해서 먹었던 메뉴와 조합이 기억이 안남, 이 조합이 맛있었는지 맛없었는지 기억이 안남 
			, 남들이 추천해주는 조합을 블로그나 페북에서만 보니 신빙성없는 정보도 넘쳐남 또는 내입맛에 안맞음 <-- 데이터와 통계를 통해 추천메뉴가 제공된다면? 나랑 비슷한 패턴을 가진 고객들이 자주 먹는 메뉴라면?
			, 또는 나랑 입맛이 비슷한 친구(팔로우 기능?)가 추천하는 또는 별점을 높게 준 메뉴라면 믿고 먹어볼만함 --> 재구매 의사 업업 
		
		- 단체 주문을 할때, 시간절약을 위해 메뉴를 통일? 왜? 장바구니에 등록하는것도 꽤 걸리겠네 그럼 어케? 
			, 쪽지 보내듯 내가 선택한 조합을 다른사람에게 보낼 수 있다면? 
			, 예를 들어 30명이 메뉴를 준비하는데 subway 앱 또는 웹을 사용하는 사람이 4~5명만 되도 금방 퍼스널 옵션 가능 
			, 아 같은 조합으로 여러개를 주문/담기 할 수 있게 해야겠다 <-- 준혁이꺼에서 가져오면 될듯 
			
	2. 벤치마킹 
		- 스타벅스 : 동일한 기능 선두 주자 
		
		
	3. 특장점 
		- 차트 , 그래프 , 표 등으로 데이터를 시각화 
		- 단순히 저장된 데이터 ~~> 의미있는 값으로 조합 ~~> 사용자 구매, 사업자의 재고 수주 등과 같은 의사 결정을 빠르고 효율적으로 가능케, 만족도가 높게, 기대와 결과가 정비례하게끔 
		- 메뉴선정, 옵션 결정도 시각정인 정보를 중점적으로 하는게 좋을듯 
			이름만 보고 빵을 결정하는게 아니고 빵 사진(단면, 대략의 설명)을 보고 결정할 수 있게끔 
					소스도  서브웨이처럼 매운맛/단맛 뭐 이런식으로 분류 나눠놓은 다음 대략적인 설명도?! 선택한 메뉴와 잘어울리는(실제 데이터상 인기있는? 아니면 개발자가 정한?) 소스는 하이라이터를 준다거나 (★을 표시한다거나)
					엑스트라 컨디먼트도 사진, 가격, 몇개 들어가는지 세세하게 볼수있게 (접어놓을수도있게!)
					야채도 클릭하면 사진 볼 수있게? 
					진짜 싫어하는 야채를 미리 등록해놓으면 그 야채는 선택안됨이 디폴드가 되게끔 ?? 
					
			조합을 선택하고 결제페이지로 넘어가면 "이 메뉴를 102명이 주문했고, 80명이 맛있다고 평가(재구매가 이뤄진 정보에 가중치를 둬서)했어요!" 뭐 이런식의 메시지가 출력되도 좋을듯? 
			
		- 재조담당직원이 주문을 보고 빠르게 재조할 수 있는 ui를 만들어야함 
			빵이 젤 앞에 나오고 ? 밑에까는 재료들이 나오고  마지막에 소스 , 아 15cm 30cm 도 있구나 커팅여부도 잇고 
		
		- 앱/웹 사용을 유도하려면 보상이 좀 있어야할듯, 편하다는것만으론 보수적인 사람 유입하기가 힘듦 
			온라인에서만 사용가능한 제품교환 스탬프를 찍어준다거나, 마일리지를 추가 적립해준다거나, 옵션가격을 할인해준다거나, 음료나 쿠키를 절반가격에 판매한다거나, 
			
				

}
	




</p>
 --%>


</body>
</html>
<script type="text/javascript">
	var slideIndex = 1;
	showDivs(slideIndex);

	function plusDivs(n) {
		showDivs(slideIndex += n);
	}

	function currentDiv(n) {
		showDivs(slideIndex = n);
	}

	function showDivs(n) {
		var i;
		var x = document.getElementsByClassName("mySlides");
		var dots = document.getElementsByClassName("demo");
		if (n > x.length) {
			slideIndex = 1
		}
		if (n < 1) {
			slideIndex = x.length
		}
		for (i = 0; i < x.length; i++) {
			x[i].style.display = "none";
		}
		for (i = 0; i < dots.length; i++) {
			dots[i].className = dots[i].className.replace(" w3-red", "");
		}
		x[slideIndex - 1].style.display = "block";
		dots[slideIndex - 1].className += " w3-red";
	}
</script>