<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <title>${id } 님 주문을 진행합니다</title>
<style type="text/css">
table {
	border-collapse: collapse;
	border: none;
	margin-right: 10%;
	float: right;
	border-top-style: solid;
}

td {
	padding: 10px;
}

img {
	margin-left: 10%;
	float: left;
}

table th {
	padding: 2%;
	text-align: center;
}

div.tit01 {
	font: bold 24px/30px "malgun gothic", "Dotum", " Gulim", "Arial",
		"verdana", "Helvetica", sans-serif;
	color: #111;
	text-align: center;
}

#opt {
	font-stretch: normal;
}
</style>
</head>
<body>   
<jsp:include page="header.jsp"></jsp:include>


<div style="margin-top: 10%;">
   <div class="tit01">${id } 회원님의 주문현황</div>
   <br>
   <br>
	<img src="${pageContext.request.contextPath}/img/${menudto.m_code}.png?ver=6" >
     ${menudto.m_explain}
     
     <!-- 사용자가 선택한 조합 == 결제페이지로 넘길 정보 -->
    <form name="orderfrm" action="paymentform.do" method="post" onsubmit="return check();">
         <table>
			 <input type="hidden" name="c_id" value="${id}">
			 <input type="hidden" name="s_code" value="${selected_store.s_code}">
		     <input type="hidden" name="m_code" value="${menudto.m_code }">
            <colgroup><col width="30%"><col width=""></colgroup>

            <tr>
               <th>기본 가격</th>
               <td><input type="hidden" id="default_price" value="${ menudto.m_price }"><fmt:formatNumber>${ menudto.m_price }</fmt:formatNumber>  원</td>
            </tr>
            <tr>
               <th>빵 선택</th>
               <td>
               <!-- 빵을 선택, 6개중에 , radio 버튼에 디자인 입혀서 동그란 토글 버튼으로 하고싶다  -->
                  <select name="o_pan" required="required" title="빵은 필수 선택사항입니다.">
                   <option value="none">빵선택</option>
                   <c:forEach var="olist" items="${option_bread}">
                     <option  value="${ olist.m_code }" title="menu테이블에 explain을 추가한다면 title에 넣으면 되겠다." >${olist.m_name}</option>
                   </c:forEach>
                  </select>  
                </td>
            </tr>

            <tr>
               <th>필수</th>
               <td>
                  <p>
                  <!-- 기본으로 들어가는 재료 출력 -->
                     <input type="hidden" name="m_necessary1" value="${menudto.m_necessary1 }">
                     <input type="hidden" name="m_necessary1_num" value="${menudto.m_necessary1_num }">
                     <input type="hidden" name="m_necessary2" value="${menudto.m_necessary2}">
                     <input type="hidden" name="m_necessary2_num" value="${menudto.m_necessary2_num}">
                     <input type="hidden" name="m_necessary3" value="${menudto.m_necessary3}">
                     <input type="hidden" name="m_necessary3_num" value="${menudto.m_necessary3_num}">
                     <input type="hidden" name="m_necessary4" value="${menudto.m_necessary4 }">
                     <input type="hidden" name="m_necessary4_num" value="${menudto.m_necessary4_num }">
                     
                     <label>${menudto.m_necessary1_name } &nbsp;&nbsp; ${menudto.m_necessary1_num}개</label><br><c:if test="${menudto.m_necessary2_num > 0 }">
                     <label>${menudto.m_necessary2_name } &nbsp;&nbsp; ${menudto.m_necessary2_num}개</label><br></c:if><c:if test="${menudto.m_necessary3_num > 0 }">
                     
                     <label>${menudto.m_necessary3_name } &nbsp;&nbsp; ${menudto.m_necessary3_num}개</label><br></c:if><c:if test="${menudto.m_necessary4_num > 0 }">
                     <label>${menudto.m_necessary4_name } &nbsp;&nbsp; ${menudto.m_necessary4_num}개</label></c:if>
                  </p>

                  <p>
                  <!-- 소스선택 , radio 버튼에 디자인 입혀서 동그란 토글 버튼으로 하고싶다  -->
                     <select name="o_sauce1" onchange="sauce_select(o_sauce1)" required="required" title="기본적으로 소스는 하나이상 선택, 아 소스없이 먹는사람도 있겠는데, 걍 묻기만 할까">
                        <option value="none">소스선택</option>
                        <c:forEach var="olist" items="${option_sauces}">
                           <option value="${ olist.m_code }">${olist.m_name}</option>
                        </c:forEach>
                     </select>
                     <select name="o_sauce2" onchange="sauce_select(o_sauce2)">
                        <option value="none">추가 소스선택</option>
                        <c:forEach var="olist" items="${option_sauces}">
                           <option value="${ olist.m_code }">${olist.m_name}</option>
                        </c:forEach>
                     </select>  
                  </p>
               </td>
            </tr>

            <tr>
               <th>옵션</th>
               <td>
               <!-- 옵션을 반복문으로 출력  -->
                  <c:forEach var="olist" items="${option_extra}" varStatus="i">
                     	<div>
                        <!-- 옵션 m_code , 필요없을듯?-->
                        <input type="hidden" value="${ olist.m_code}" name="o_option${i.count }"/> 
                        
                        <!-- 옵션 이름 -->
                        <label style="display: inline-block; width: 60px; white-space: nowrap; letter-spacing: 2px;" title="옵션의 이름">${olist.m_name}</label>
                        
                        <!-- 개당 옵션 가격 정보는 숨겨둔다  -->
                        <input type="hidden" value="${ olist.m_price }" id="h_price${i.count }" readonly="readonly"/>&nbsp;
                        
                        <input type="button" class="btn btn-primary btn-xs" value="▼" id="${i.count}" onclick="extra_sub(o_option${i.count }_num, price${i.count }, h_price${i.count })"/>
                        
                        <!-- 선택된 옵션의 수량 표시 -->
                        <font id="o_option${i.count }_num" style="margin:0px 10px 0px 10px;" size="3" title="선택된 옵션의 수량">0</font>
                        <input type="hidden" readonly="readonly" value="0" name="o_option${i.count }_num"> 
                        
                        <input type="button" class="btn btn-primary btn-xs" value="▲" id="${i.count }" onclick="extra_add(o_option${i.count }_num, price${i.count }, h_price${i.count })"/>
                        
                        <!-- 추가된 가격 표시 -->
                        &nbsp;(+&nbsp;￦ <font id="price${i.count }"> 0 </font>)
                   		</div>
                   </c:forEach>
               <!-- 옵션을 반복문으로 출력  -->
               </td>
            </tr>

            <tr>
               <th>채소</th>
               <td>
               	<div style="display:-webkit-box; max-width: 45%; ">
                  <!-- 채소 정보만 넘겨주는 option  -->
                  <c:forEach var="olist" items="${option_vege}" varStatus="i"> 
                  <div style="width: 90%; white-space: nowrap; ">
                    <input type="checkbox" id="${olist.m_code}" name="o_vege${i.count}" value="${olist.m_code}" checked="checked" >
                    	<label style="letter-spacing: 2px; margin-right: 10px; /* display: inline-block; width: 30px; white-space: nowrap; letter-spacing: 2px; padding-right :5px; */" 
                    		for="${olist.m_code}">${olist.m_name}</label>
                  </div>
                    <c:if test="${i.count%3 == 0 }"></div><div style="display:-webkit-box; max-width: 45%;"></c:if>
                  </c:forEach>
               	</div>
               </td>
            </tr>

            <tr>
               <th>옵션 적용가</th>
               <td>
                  <input hidden="hidden" type="text" name="o_price" value="${ menudto.m_price }"> 
                  <label id="o_price"><fmt:formatNumber>${ menudto.m_price}</fmt:formatNumber> 원</label>
					</td>
            </tr>
            <tr>
               <th><label for="amount">수 량</label></th>
               <td>
						<select name="amount" id="amount" title="같은 조합의 메뉴를 한번에 여러개 주문할 수 있습니다." onchange="update_totalprice(this.value)">
							<option value="1" selected="selected">1개</option>
							<option value="2">2개</option>
							<option value="3">3개</option>
							<option value="4">4개</option>
					</select> &nbsp;
				</td>
            </tr>
            <tr>
            	<td colspan="2"><hr></td>
            </tr>
            <tr>
               <th><font size="4" color="green">총 합계</font></th>
               <td>
               		<!-- 수량까지 적용한 최종가격 o_totalprice -->
                  	<input hidden="hidden" type="text" name="o_totalprice" value="${ menudto.m_price }"> 
                  	<font id="o_totalprice" size="4"><fmt:formatNumber>${ menudto.m_price }</fmt:formatNumber> 원</font> 
				</td>
            </tr>
			<tr>
				<td colspan="2" style="text-align: center; border-top-style: solid;">
				<br>
				<br>
					<button value="basket" name="command" class="btn btn-default" title="현재 조합을 장바구니에 추가합니다.">장바구니</button>
					<button value="payment" name="command" class="btn btn-default" title="현재 조합으로 주문을 진행합니다.">결제</button><br><br>
				</td>
			</tr>
         </table>
      </form>

</div>
<br>
<br>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
<script type="text/javascript">
	//선택된 옵션의 개수를 전역에 저장하면서 체크
   var total_extra = 0;
   
	
	function update_totalprice(amount){
		var o_price = eval(document.getElementsByName('o_price')[0].value * amount);
		document.getElementsByName('o_totalprice')[0].value = o_price;
		document.getElementById('o_totalprice').innerHTML = comma(o_price) + " 원";
	}
	
   /* 옵션 감소 ▲ 버튼  
   	parmas : 수량을 담는 element, 가격을 담는 element, 옵션가가 반영된 총가격을 담는 element
   */
   function extra_add(e_amount_to_update, e_price_to_update, o_price){
      if(total_extra >= 5){ 
         alert("extra는 5개 이상 못해요");   
         return false;
      }
      e_amount_to_update.value++; //개수 증가 
      
      document.getElementById(e_amount_to_update.name).innerHTML = e_amount_to_update.value; //레이블 
      
      e_price_to_update.innerHTML = comma(eval(uncomma(e_price_to_update.innerHTML)) + eval(o_price.value)); //가격 갱신
      
       document.getElementsByName('o_price')[0].value = eval(document.getElementsByName('o_price')[0].value) + eval(o_price.value); 
 
      document.getElementById('o_price').innerHTML = comma(document.getElementsByName('o_price')[0].value)+" 원";  //화면에 보여지는 값 
      update_totalprice(document.getElementsByName('amount')[0].value);
      total_extra ++;
   }
   
   /* 옵션 감소 ▼ 버튼  
   	parmas : 수량을 담는 element, 가격을 담는 element, 옵션가가 반영된 총가격을 담는 element
   */
   function extra_sub(e_amount_to_update, e_price_to_update, o_price){
      if(total_extra <= 0 || e_amount_to_update.value <= 0){ 
         return false;
      }
      e_amount_to_update.value--;//옵션 선택개수 감소 
      document.getElementById(e_amount_to_update.name).innerHTML = e_amount_to_update.value; //사용자가 보게될 선택개수도 업데이트
      
      e_price_to_update.innerHTML = comma(eval(uncomma(e_price_to_update.innerHTML)) - eval(o_price.value)); //선택된 옵션 가격 갱신
      
      document.getElementsByName('o_price')[0].value = eval(document.getElementsByName('o_price')[0].value) - eval(o_price.value );//다음페이지로 넘길값
      
      document.getElementById('o_price').innerHTML = comma(document.getElementsByName('o_price')[0].value)+" 원";  //화면에 보여지는 값 
      update_totalprice(document.getElementsByName('amount')[0].value);
      
      total_extra --;
   }//end function 
   
   
   	function comma(str) {
   	    str = String(str);
   	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
   	}
   	//콤마풀기
   	function uncomma(str) {
   	    str = String(str);
   	    return str.replace(/[^\d]+/g, '');
   	}

   	
   	//옵션추가를 동적으로 셀렉을 쓰려면 전역으로 배열을 선언해놓고 옵션을 담으면 될듯 , 추가될때마다 빼주기 
    var option_num = 0;
   function test(params){
       if ( option_num >= 3) return false;
       alert(document.getElementById('option').innerHTML);
       option_num++;
       var d = "div_" + option_num;
      var code1 = "<select>";
          code1 += "<option value=\"dc\">더블치즈</option>";   
          code1 += "<option value=\"ac\">아보카도</option>";   
          code1 += "<option value=\"dm\">더블미트</option>";
          code1 += "<option value=\"em\">에그마요</option>";
          code1 += "<option value=\"bk\">베이컨</option>";
          code1 += "</select>";
      var code2 = "<select><option value=1>1</option><option value=2>2</option><option value=3>3</option></select>";
      var code = code1+code2+"<button value=1 onclick=\"delete_div(div_"+option_num+")\">X</button>";
      document.getElementById(d).innerHTML += code;
      return;
   }
   
   function delete_div(params){
      var name = params;
      alert("눌린버튼 : " + name);
      name.innerHTML = "";
      option_num --;
   }
   	//옵션추가를 동적으로 셀렉을 쓰려면 전역으로 배열을 선언해놓고 옵션을 담으면 될듯 , 추가될때마다 빼주기 
   
   function sauce_select(params){
      var o_sauce1 = document.getElementsByName('o_sauce1')[0].value; //선택된 소스1
      var o_sauce2 = document.getElementsByName('o_sauce2')[0].value; //선택된 소스2
      
      if(o_sauce1=='none'){ 
         alert("첫번째 소스를 선택해주세요");
         return false;
      }
      if(o_sauce1==o_sauce2) {
         alert("서로 다른 소스를 선택해주세요");
         params.value='none';
         params.focus();
         return false;
      }
      return true;
   }//end 소스선택확인 function

   	//form 을 서브밋하기전에 선택
   	<!--
   function check(){
	   var e_pan = document.getElementsByName('o_pan')[0];
      if( e_pan.value == 'none' ) {
         e_pan.focus();
         alert("빵을 선택해주세요");
         return false;
      }
      return sauce_select(document.orderfrm.o_sauce2);
      //return true;
   }//end function
   //-->
</script>