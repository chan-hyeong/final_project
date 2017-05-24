package kosta.finalproject.customer.dao;

import java.util.ArrayList;
import java.util.List;

import kosta.finalproject.customer.dto.Order_DetailTDTO;
import kosta.finalproject.customer.dto.Order_DetailTDTO_basket;
import kosta.finalproject.customer.dto.Order_ListTDTO;


public interface Order_DetailDAO {
	public List<Order_DetailTDTO_basket> order_detail_list(String ID);
	public void order_detail_delete1(int order_num);
	public void order_detail_delete2(int order_detail_num);
	
	public void insert_shoppingbag_detail(Order_DetailTDTO d_dto);
	public void insert_shoppingbag_list(Order_ListTDTO l_dto);
	public int select_onum();
	public int select_onum1(int order_num);
	
	public ArrayList<Integer> select_onum_list(String id);
	public void deleteall_detail(int order_num);
	public void deleteall_list(String id);
}
