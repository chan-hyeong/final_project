package kosta.finalproject.customer.dao;

import java.util.List;

import kosta.finalproject.customer.dto.Order_ListTDTO;

public interface Order_ListDAO {
	//select 
	public List<Order_ListTDTO> order_list_list(String c_id);
	//전체 리스트 가져오기 <--히스토리, 히스토리 디테일에서 사용 
	
	public Order_ListTDTO order_list_basket(String c_id);
	//basket 가져오기  
	
	public Integer get_order_num();
	//basket 가져오기  
	
	//insert 
	public void insert_order_list(Order_ListTDTO dto);
	//결제완료를 하면 주문한 내역이 order_list 테이블에 한줄 들어감 
	
	//delete 
	public void delete_order_list(Order_ListTDTO dto);//param을 뭘 받을까 c_id, order_num 은 필수일텐데 
	//주문취소(준비완료 상태에서는 불가?) / 장바구니에서 삭제  
	
	//update는 흠..  
	public void update_order_list(Order_ListTDTO dto);
	//장바구니 --> 주문완료 상태 , update보단 delete하고 insert 하는게 깔끔하지 않을려나 
}
