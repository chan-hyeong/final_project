package kosta.finalproject.customer.dao;

import java.util.List;

import kosta.finalproject.customer.dto.MenuTDTO;

public interface MenuDAO {
	public List<MenuTDTO> menulist();
	public MenuTDTO menudetail(String m_code);
	public List<MenuTDTO> menuoption();
}
