package kosta.finalproject.customer.dao;

import java.util.List;

import kosta.finalproject.customer.dto.Order_DetailTDTO_basket;


public interface Order_DetailDAO {
	public List<Order_DetailTDTO_basket> order_detail_list(String ID);
	public void order_detail_delete1(int order_num);
	public void order_detail_delete2(int order_num);
}
