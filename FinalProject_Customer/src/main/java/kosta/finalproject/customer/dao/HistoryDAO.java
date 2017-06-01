package kosta.finalproject.customer.dao;

import java.util.HashMap;
import java.util.List;

import kosta.finalproject.customer.dto.HistoryTDTO;


public interface HistoryDAO {
	public List<HistoryTDTO> history(String c_id);
	public List<HashMap<String, String>> historydetail(int order_num);
}
