package kosta.finalproject.customer.dao;

import java.util.HashMap;
import java.util.List;

public interface InventoryDAO {

	// <!-- 주문이 들어온 경우 (결제가 완료된 경우) or 주문이 취소된 경우 (결제 취소) 재고를 수정해야함 -->
//	public void update_inventory_by_order();
//	public int update_inventory_by_order(int val, String i_code);
	//파라미터로 뭘 넘겨줘야할까.. 맵 ? 리스트? order_detail dto? 일단은 order_detail_dto 로 해보자  
	public int test_update_inventory_by_order(HashMap param);
	
	//이렇게하면 order_num 과 s_code 만 가지고 update 가능
//	public int wow_update_inventory_by_order(Order_ListTDTO list_dto);
	public int update_inventory_by_order(int order_num, String s_code);
	
	/*public List test1(int order_num, String s_code);*/
	
	

	// <!-- 소비자가 메뉴 선택시 재료의 재고가 없는 메뉴는 선택불가하게, 또는 결제불가하게 만들어야함 체크 인벤토리 -->
	public List<String> select_invetory_check_for_customer();
	//어떤 타입으로 만들어야할까, 파라미터로 뭘 넘겨야할까 

}
