	function check_intervally(){
		console.log("\t in interval fn 변화를 체크할 것이다 ");
		
		$.ajax({
			type : "get",
			url : "checked.do",
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
	
	
	
	
	
	
	// ////////////////////////////
	