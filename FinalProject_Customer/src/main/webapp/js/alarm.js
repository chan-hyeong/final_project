//AJAX 를 이용해서 주문상태를 체크, 알람을 띄워준다 

/**
 * 
 * @param isNotNullSlist : 세션에 order_status를 체크해야할 order_nume들의 list가 있냐 없냐 , 있으면 길이가 0 이상이냐
 * @returns : list가 존재하며 길이가 0이상이라면 interval 수행할것이다 / 아니라면 할필요없다 
 */
function trigerfn(isNotNullSlist){//slist 가 null 이거나 길이가 0 이면 true 를 리턴할거임 
	console.log("넘어온 파라메타 (T/F): " + isNotNullSlist );
	if ( isNotNullSlist ){
		var interval = 6000;//ms
		console.log("※※※※ 주문 상태변화 체크가 필요합니다. " + parseInt(interval/1000) + " 초 마다 체크를 수행합니다.\n")
		//check_status_change(flag);
		window.setInterval("check_intervally()", interval);
	}else{
		console.log("주문 상태변화 체크가 필요없는 상태입니다 (새로운 주문이 없습니다).\n")
	}
}//end function


/**
 * ajax를 이용해서 주문상태 변경을 체크 
 * 이걸 웹소켓방식으로 변경해야하나 ?
 * @returns : '준비완료' 된 order_num 의 list가 넘어오며 'history.do'로 이동 및 해당 주문상세정보 보여주기
 */
function check_intervally(){
	console.log("\t in interval fn 변화를 체크할 것이다 ");
	
	//dependecy에 json 관련 추가했으므로 parse가 필요없음
	$.ajax({
		type : "get",
		url : "orders_status_check.do",
		success : function(list) {
			console.log("\t in success , list.size=" + list.length + "" );
			if(list !=null && list.length > 0){
				console.log("\t true");
				var str = "( " + list.length + "개 : ";
				for (var i= 0 ; i < list.length ; i++) str += list[i] + " ";
				str += " )"
					if ( confirm("메뉴가 모두 준비되었습니다. " + str + "\n 히스토리 페이지로 이동하시겠습니까?") )
						window.location.href="history.do?order_num="+list[0]+"";
			}else{
				//리스트 사이즈가 작으면 수행할거없지   
				console.log("\t false");
			} 
			console.log("\t out success ")
		},// end sucess
		error : function(){
			console.log("\t in ajax 에러 ");
		}
	});// end ajax
	console.log("\t out interval fn//");
}//end function 