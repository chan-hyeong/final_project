package kosta.finalproject.customer.dao;

import java.util.HashMap;
import java.util.List;

import kosta.finalproject.customer.dto.HistoryTDTO;


public interface HistoryDAO {
	public List<HistoryTDTO> history(String c_id);
	public List<HistoryTDTO> history_get_by_date(String c_id, String start, String end, String statuscheck);
	public List<HashMap<String, String>> historydetail(int order_num);
}
