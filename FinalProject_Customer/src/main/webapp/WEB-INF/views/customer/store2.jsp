<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>${id} 님 매장을 선택해주세요</title>
 <style>
     #map {
      height: 300px;
      width: 100%;
     }
  </style>
 <script>
        $(document).ready(function() {
            $('a[data-toggle="tab"]').on('hidden.bs.tab', function(e){
                alert("이벤트 실행됨");
            });
            
            getLocation();
        });

      var map;
      var infowindow;
      var x = document.getElementById("demo");
     
      function getLocation() {
          if (navigator.geolocation) {
              navigator.geolocation.getCurrentPosition(initMap);
          } else { 
              x.innerHTML = "Geolocation is not supported by this browser.";
          }
      }

      function initMap(position) {
         
       //lat = position.coords.latitude;
        //lon = position.coords.longitude;
        
        lat = 37.339875;
        lon = 127.108942;
        
        var pyrmont = {lat: lat, lng: lon};

        map = new google.maps.Map(document.getElementById('map'), {
          center: pyrmont,
          zoom: 15
        });
        
        latlon = new google.maps.LatLng(lat, lon)
        var mymarker = new google.maps.Marker({position:latlon,map:map,title:"You are here!"});

        infowindow = new google.maps.InfoWindow();
        var service = new google.maps.places.PlacesService(map);
        service.nearbySearch({
          location: pyrmont,
          radius: 500,
          keyword: "서브웨이",
          type: ['*   ']
        }, callback);
      }

      function callback(results, status) {
        if (status === google.maps.places.PlacesServiceStatus.OK) {
          for (var i = 0; i < results.length; i++) {
            createMarker(results[i]);
            $("#distresult").append("<li> 매장명 : "+results[i].name+", 매장거리 : "+results[i].rating+"</li>");
            console.log(results[i].rating);
          }
        }
      }

      function createMarker(place) {
        var placeLoc = place.geometry.location;
        var marker = new google.maps.Marker({
          map: map,
          position: place.geometry.location
        });

        google.maps.event.addListener(marker, 'click', function() {
          infowindow.setContent(place.name);
          infowindow.open(map, this);
        });
      }
    </script>

</head>
<body>
<jsp:include page="header.jsp"/>

<div style="margin-top: 15%;">

<div class="container">
   <ul id="myTab" class="nav nav-tabs" role="tablist">
     <li role="presentation" class="active"><a data-target="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">지도</a></li>
     <li role="presentation" class=""><a data-target="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile" aria-expanded="false" onclick = "test();">가까운매장</a></li>
   </ul>
   <div id="myTabContent" class="tab-content">
     <div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
    
    
    <div id="map" style="width:300px; height:300px;"></div>
    <ul id="distresult"> </ul>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAx-OV3qCLjcCKIFWMgSRHOa2uPRR7RRB4&libraries=places&callback=initMap" async defer></script>    
    
       <c:forEach var="list" items="${storelist }">
          <form action="store_selec.do" method="post">
             ${list.s_name} - ${list.s_address }
               <%-- <input type="hidden" name="s_address" value="${list.s_address }"> --%>
               <input type="hidden" name="s_code" value="${list.s_code}">
               <input type="submit" value="선택">
           </form>
       </c:forEach>
  </body>
</html>