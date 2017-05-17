package kosta.finalproject.customer.dao;

import java.util.ArrayList;

import kosta.finalproject.customer.dto.CustomersTDTO;

public interface CustomersDAO {
	public void insert(CustomersTDTO dto);
	public int customers(CustomersTDTO dto);
	public CustomersTDTO getcustomers(String id);
	public void update(CustomersTDTO dto);
}
