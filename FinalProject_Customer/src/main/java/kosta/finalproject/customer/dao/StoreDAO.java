package kosta.finalproject.customer.dao;

import java.util.List;

import kosta.finalproject.customer.dto.StoreTDTO;

public interface StoreDAO {
	
	/**
	 * 모든 store 정보를 List타입으로 리턴한한다 
	 * @return
	 */
	public List<StoreTDTO> storelist();
	
	/**
	 * s_code를 파라미터로 넘기면 
	 * 해당 store 정보를 리턴한다  
	 * @return
	 */
	public StoreTDTO get_store_info(String s_code);
}
