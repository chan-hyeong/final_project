package kosta.finalproject.customer.dao;

import java.util.HashMap;
import java.util.List;

public interface Topmenu5DAO {

	/**
	 * 
	 * @return 잘나가는 메뉴 상위 5가지를 뽑아준다
	 */
	public List<HashMap> top5list();

}
