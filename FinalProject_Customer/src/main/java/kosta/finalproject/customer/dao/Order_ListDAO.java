package kosta.finalproject.customer.dao;

import java.util.List;

import kosta.finalproject.customer.dto.Order_ListTDTO;

public interface Order_ListDAO {
	/////////////////////////// select///////////////////////// 
	public List<Order_ListTDTO> get_order_list(String c_id);
	//전체 리스트 가져오기 <--코드로 가져오기 
	
	public List<Order_ListTDTO> get_order_list_for_customer(String c_id);
	//전체 리스트 가져오기 <--히스토리, 히스토리 디테일에서 사용 
	
	public Order_ListTDTO get_basket(String c_id);
	//basket 가져오기  
	
	//새로들어갈 주문, 장바구니 등의 order_num을 구하기 위한
	public int get_order_num();
	
	
	//insert 
	public void insert_order(Order_ListTDTO list_dto);
	//결제완료를 하면 주문한 내역이 order_list 테이블에 한줄 들어감 
	
	
	
	////////// 장바구니 //////////////////////// 
	public int delete_from_order_list(String c_id, int order_num);//param을 뭘 받을까 c_id, order_num 은 필수일텐데 
	//주문취소(준비완료 상태에서는 불가?) / 장바구니에서 삭제  
	
	
	//장바구니에서 주문이 들어온 경우 update order_date, order_status, order_payment
	public int order_by_basket(Order_ListTDTO list_dto);
	//장바구니에 추가, 내려놓은 경우 업데이트 update order_date, o_totalprice
	public int update_basket(String c_id);
}
