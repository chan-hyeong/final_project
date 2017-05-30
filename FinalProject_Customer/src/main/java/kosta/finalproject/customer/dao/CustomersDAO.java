package kosta.finalproject.customer.dao;

import kosta.finalproject.customer.dto.CustomersTDTO;

public interface CustomersDAO {
	public int insert(CustomersTDTO dto);
	public int customers(CustomersTDTO dto);
	public CustomersTDTO getcustomers(String id);
	public void update(CustomersTDTO dto);
	public int getid(CustomersTDTO dto);
}
