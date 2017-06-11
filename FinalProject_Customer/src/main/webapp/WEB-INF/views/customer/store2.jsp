<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>



<title>${id}님주문하시려면 매장을 선택하세요</title>
<style>
#map {
	height: 300px;
	width: 100%;
}
</style>
<script>
	//컴마씨우기
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	//콤마풀기
	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	}
</script>
<script type="text/javascript">
var lat;
var lon;

	if ("geolocation" in navigator) {
		alert(" 지오로케이션 사용 가능 */");
		navigator.geolocation.getCurrentPosition(function(position) {
			 alert("("+position.coords.latitude+", "+ position.coords.longitude+")");
			 lat=eval(position.coords.latitude);
			 lon=eval(position.coords.longitude);
			});
	} else {
	  /* 지오로케이션 사용 불가능 */
	  alert(" 지오로케이션 사용 불가능 *");
	}
</script>

<script type="text/javascript">
	function gmap_getdistance(lat1, lon1, lat2, lon2){
		// from http://www.movable-type.co.uk/scripts/latlong.html
		var radfactorval = 0.017453293;
	   /* var lat1 = document.getElementById("latval").value;
	   var lat2 = document.getElementById("latval2").value;
	   var lon1 = document.getElementById("longval").value;
	   var lon2 = document.getElementById("longval2").value; */
	   var R = 6371; // km
	   var dLat = (lat2-lat1) * radfactorval;
	   var dLon = (lon2-lon1) * radfactorval;
	   var a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(lat1*radfactorval) * Math.cos(lat2*radfactorval) * Math.sin(dLon/2) * Math.sin(dLon/2); 
	   var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
	   var d = R * c * 1000;//m 니까 1000
	   return parseInt(d);
	   //document.getElementById("distresult").innerHTML = formatnumber(d,2);
	}
</script>

<script>

var latarr = new Array(<c:forEach items="${storelist}" var="item" varStatus="i"> '${item.s_latitude eq null? 0 : item.s_latitude }' <c:if test="${!i.last}">, </c:if></c:forEach> );
var lonarr = new Array(<c:forEach items="${storelist}" var="item" varStatus="i"> '${item.s_longitude eq null? 0 : item.s_longitude }' <c:if test="${!i.last}">, </c:if></c:forEach> );
var addrarr = new Array(<c:forEach items="${storelist}" var="item" varStatus="i"> '${item.s_address eq null? 0 : item.s_address }' <c:if test="${!i.last}">, </c:if></c:forEach> );
var s_codearr = new Array(<c:forEach items="${storelist}" var="item" varStatus="i"> '${item.s_code eq null? 0 : item.s_code }' <c:if test="${!i.last}">, </c:if></c:forEach> );
var s_namearr = new Array(<c:forEach items="${storelist}" var="item" varStatus="i"> '${item.s_name eq null? 0 : item.s_name}' <c:if test="${!i.last}">, </c:if></c:forEach> );

var distancearr = new Array();	
var stores = new Array();
</script>

<script>
<!--
	$(document).ready(function() {
		$('a[data-toggle="tab"]').on('hidden.bs.tab', function(e) {
			alert("이벤트 실행됨");
		});

		getLocation();
	});

	var map;
	var infowindow;
	var x = document.getElementById("map");

	function getLocation() {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(initMap);
		} else {
			x.innerHTML = "Geolocation is not supported by this browser.";
		}
	}

	// 맵 초기화 
	function initMap(position) {
		//[1] 현재위치가져오기 
		//lat = position.coords.latitude;
		//lon = position.coords.longitude;
			 alert(lat);
			 alert(lon);

		//오리역 
		lat = 37.339875;
		lon = 127.108942;

		//지도의 center점을 설정하기 위한 객체?
		var pyrmont = {
			lat : lat,
			lng : lon
		};

		//[2] 지도설정 : 내위치를 center 
		map = new google.maps.Map(document.getElementById('map'), {
			center : pyrmont,
			zoom : 15
		});

		//[3] 지도상의 내 위치를 마커로 표시해줌 
		latlon = new google.maps.LatLng(lat, lon)
		var mymarker = new google.maps.Marker({
			position : latlon,
			map : map,
			title : "당신위치입니다."
		});

		
		for ( var i =0; i<${fn:length(storelist)}; i++){
			//console.log("( " + lat  + ", " + lon + " ) ~ ( " +  latarr[i] + ", " + lonarr[i]+" )\n");
			distancearr[i] = gmap_getdistance(lat,lon, latarr[i], lonarr[i]);
			//console.log(i+" " + addrarr[i] + " 거리는 : " + distancearr[i] + "m\n\n");
		    
			stores[i] = { s_code : s_codearr[i], s_name : s_namearr[i], s_address : addrarr[i], distance : distancearr[i], s_latitude : latarr[i], s_longitude : lonarr[i]};
		}
		/* var str = "";
		for ( var i =0; i<${fn:length(storelist)}; i++){
			str += i + " : " + stores[i].s_address + " , " + stores[i].distance + "\n";
		}
		alert(str); */
		
		///===================================================================

		//alert(stores[0].s_code + " : " + stores[0].s_address);
		/* 이름순으로 정렬 
		stores.sort(function(a, b) { // 유니코드 오름차순
		    return a.s_address < b.s_address ? -1 : a.s_address > b.s_address ? 1 : 0;

		});

		stores.sort(function(a, b) { // 유니코드 내림차순
		    return a.s_address > b.s_address ? -1 : a.s_address < b.s_address ? 1 : 0;
		});
		*/
		
		/* ★★★★★★★★★★ 거리순으로 정렬 <--- 우리가 사용할 방법 */
		var sortingField = "distance";

		stores.sort(function(a, b) { // 오름차순
		    return a[sortingField] - b[sortingField];
		});// 13
		//alert(stores[0].s_code + " : " + stores[0].s_address);
		///===================================================================
		
		var str = "\n";
		for ( var i =0; i<${fn:length(storelist)}; i++){
			str += i + " : " + stores[i].s_address + " , " + stores[i].distance + "\n";//정렬된 값 확인하기 위해 출력 
			var tmplb = document.getElementById('dist'+i);//거리 반영
			var dist = stores[i].distance 
			if (dist < 1000)
				tmplb.innerHTML = comma(stores[i].distance) + " m" ;
			else 
				tmplb.innerHTML = comma( (parseInt( eval(stores[i].distance)/1000 )) ) + " km" ;
			
			
			tmplb = document.getElementById('adrs'+i);//정렬된 주소 표시
			tmplb.innerHTML = stores[i].s_address;
			
			tmplb = document.getElementById('s_code'+i);//정렬된 s_code 표시
			tmplb.value = stores[i].s_code;
			
			tmplb = document.getElementById('name'+i);//주소 매장명 반영
			tmplb.innerHTML = stores[i].s_name + " 점";
			
			tmplb = document.getElementById('distresult');//s_code이름 등등 반영
			tmplb.innerHTML += '<li>'+stores[i].s_code + '|' + stores[i].s_name + '|' + stores[i].s_address + '|' + stores[i].distance + '|</li>';
		}
		//console.log("정렬된 stores 배열 : " + str);
		for (var i = 0 ; i < ${fn:length(storelist)}; i++){
			//console.log(i+"\t"+latarr[i] + " " + lonarr[i] + " "+ addrarr[i]);
			latlon = new google.maps.LatLng(stores[i].s_latitude, stores[i].s_longitude);
			
			var tmarker= new google.maps.Marker({
				position : latlon,
				map : map,
				title : stores[i].s_name,
				address : stores[i].s_address,
				s_code : stores[i].s_code,
				index : i
			});
			google.maps.event.addListener(tmarker, 'click', function() {
				var ctt= "";
				ctt += this.title + "<br>";
				ctt += this.address + "<br>";
				infowindow.setContent(ctt);
				infowindow.open(map, this);
				
				//마커를 눌렀을경우
				if ( ${id ne null} ){
					//선택된 매장 정보를 받아와서 
					if ( confirm(this.title + " 점을 선택하시겠습니까?\n" + "(주소 : " + this.address + ")" ))
						window.location.href="store_selec.do?s_code="+this.s_code+"";
					}
			});
		}
		
		infowindow = new google.maps.InfoWindow();
		var service = new google.maps.places.PlacesService(map);
		service.nearbySearch({
			location : pyrmont,
			radius : 12000,
			keyword : "써브웨이", 
			type : [ 'bakery', 'cafe', 'store']
		}, callback);
	}//end init
	

	function callback(results, status) {
		if (status === google.maps.places.PlacesServiceStatus.OK) {
			for (var i = 0; i < results.length; i++) {
				createMarker(results[i]);
				$("#distresult").append(
						"<li> 매장명 : " + results[i].name + ", 매장평점 : "
								+ results[i].rating + "</li>");
				/* console.log(results[i].rating); */
			}
		}
	}

	function createMarker(place) {
		var placeLoc = place.geometry.location;
		var marker = new google.maps.Marker({
			map : map,
			 "geometry" : {
		            "location" : {
		               "lat" : -33.870943,
		               "lng" : 151.190311
		            }
		         },
			"icon" : "http://maps.gstatic.com/mapfiles/place_api/icons/travel_agent-71.png",
	         "id" : "45a27fd8d56c56dc62afc9b49e1d850440d5c403",
	         "name" : place.name,
	         "photos" : [
	             {
	                "height" : 426,
	                "html_attributions" : [],
	                "photo_reference" : "CnRnAAAAL3n0Zu3U6fseyPl8URGKD49aGB2Wka7CKDZfamoGX2ZTLMBYgTUshjr-MXc0_O2BbvlUAZWtQTBHUVZ-5Sxb1-P-VX2Fx0sZF87q-9vUt19VDwQQmAX_mjQe7UWmU5lJGCOXSgxp2fu1b5VR_PF31RIQTKZLfqm8TA1eynnN4M1XShoU8adzJCcOWK0er14h8SqOIDZctvU",
	                "width" : 640
	             }
	          ],
	         
			position : place.geometry.location
		});

		google.maps.event.addListener(marker, 'click', function() {
			infowindow.setContent(place.name);
			infowindow.open(map, this);
			//alert(place.name + "\n" );
		});
	}
//-->
</script>

</head>
<body>
	<jsp:include page="header.jsp" />
	<br>
	<br>
	<br>
	<br>

	<div style="margin-top: 10%;">

		<div class="container">
			<ul id="myTab" class="nav nav-tabs" role="tablist">
				<li role="presentation" class="">
					<a data-target="#freq" role="tab" id="freq-tab" data-toggle="tab" aria-controls="freq" aria-expanded="false" >자주가는 매장</a>
				</li>
				<li role="presentation" class="active">
					<a data-target="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">지도에서 찾기</a>
				</li>
				<li role="presentation" class="">
					<a data-target="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile" aria-expanded="false" >가까운매장</a>
				</li>
			</ul>
			
			<div id="myTabContent" class="tab-content">
				<!-- 자주가는 매장 탭  -->
				<%-- <div role="tabpane1" class="tab-pane fade" id="freq" aria-labelledby="freq-tab">
						자주가는 매장은 어케 표시할까나...
						select  s_code, count(*)
						from order_list
						where c_id = #{c_id}
						group by s_code 
						order by count(*)
						뭐 이런거면 될려나 
						
				</div>
					 --%>
				<!-- 지도에서 찾기 탭  -->
				<div role="tabpane2" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
					<div id="map" style="width: 70%; height: 60%; margin: 10px;"></div>
					
					<ul id="distresult" style="display: none;">
					</ul>
					
					<script	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAx-OV3qCLjcCKIFWMgSRHOa2uPRR7RRB4&libraries=places&callback=initMap"	async defer></script>
					
					 <!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVtMhIFUiHQM5qnLz_hb1PImhAsbPWP0w&libraries=places&callback=initMap"	async defer></script>
 -->
					<!-- 
						매장리스트 출력  , 자주가는 매장?, 가까운 매장 현재위치에서 2km이내 매장에만 주문을 전송할수 있어요 
					-->
					<br>
					<c:forEach var="list" items="${storelist}" varStatus="i">
						<form action="store_selec.do" method="post" style="display: ${id eq null ? 'none' : 'inline'};">
							<label id="name${i.index}" style="width:20%;">${list.s_name}</label>
							<label id="adrs${i.index}" style="width:45%; ">${list.s_address}</label>
							<input type="hidden" name="s_code" id="s_code${i.index}" value="${list.s_code}">
							<label id="dist${i.index}" style="width:6%;">0</label>	
							<input type="submit" value="선택">
						</form><br><br>
					</c:forEach>
				</div>

				<!-- 가까운 매장 탭  -->
				<!-- <div role="tabpane3" class="tab-pane fade" id="profile" aria-labelledby="profile-tab">
					가까운 매장 탭 	
				</div> -->
			</div><!-- /myTabContent  -->
		</div>
</body>
</html>
