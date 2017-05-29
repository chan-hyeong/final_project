package kosta.finalproject.customer.dao;

import java.util.List;
import java.util.Map;

import kosta.finalproject.customer.dto.HistoryDetailTDTO;
import kosta.finalproject.customer.dto.HistoryTDTO;

public interface HistoryDAO {
	public List<HistoryTDTO> historylist(String c_id);
	public List<HistoryDetailTDTO> historydetaillist(int order_num);
}
