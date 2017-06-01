package kosta.finalproject.customer.dao;

import java.util.List;

import kosta.finalproject.customer.dto.Order_DetailTDTO;

public interface Order_DetailDAO {
	//select 
	public List<Order_DetailTDTO> order_detail_list(String c_id);
	public List<Order_DetailTDTO> order_detail_list_for_customer(String c_id);
	//전체 리스트 가져오기 <--히스토리, 히스토리 디테일에서 사용 
	
	public List<Order_DetailTDTO> order_detail_basket(String c_id);
	public List<Order_DetailTDTO> order_detail_basket_for_customer(String c_id);
	//장바구니 리스트 가져오기 <--장바구니 보기, 장바구니 결제에서 사용 
	
	//insert 
	public int insert_order_detail(Order_DetailTDTO dto);
	//주문 상세정보 입력하기 (한 줄씩) <-- 결제완료를 하면 주문한 내역이 order_detail 테이블에 들어감 
	
	//delete 
	public int delete_order_detail(int order_num, int order_detail_num);//param을 뭘 받을까 c_id, order_num 은 필수일텐데, map?? 
	//주문취소(준비완료 상태에서는 불가?) / 장바구니에서 삭제  
	
	//update는 흠..  
	public void update_order_detail(Order_DetailTDTO dto);
	//장바구니 --> 주문완료 상태 , update보단 delete하고 insert 하는게 깔끔하지 않을려나 
	
	public void update_order_details(List<Order_DetailTDTO> dtos);
	//장바구니인 애들이 여러개 있을텐데 파라미터도 여러개 받아야하지않을까 
}
