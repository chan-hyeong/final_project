package kosta.finalproject.customer.dao;

import java.util.HashMap;
import java.util.List;

import kosta.finalproject.customer.dto.HistoryTDTO;


public interface HistoryDAO {
	////////// 애네들은 여기있으면 안될거같다 
	/**
	 * 
	 * session에 담긴 order_status 변화를 체크해야할 order_num 리스트를 넘겨주면 
	 * 변화된 놈을 찾아서 리턴 
	 * 
	 * @param c_id : session에 담겼을 사용자 id
	 * @param order_nums : order_status 변화를 체크해야할 order_num 목록 
	 * @return order_status = '준비완료' 인 주문의 order_num 리스트를 리턴한다 
	 */
	public List<Integer> completed_order_num(String c_id, List<Integer> order_nums);
	
	
	/**
	 * 주문을 하면 준비가 완료됐을때 알람이 뜨는 기능 : 
	 * session에 
	 * " order_status 가 '준비완료' 나 '결제취소' 가 아닌 (== '결제완료') 
	 * order_num 리스트" 를 담아 뒀다가 
	 * completed_order_num 메서드에 파라메터로 전달하면 
	 * 알람 기능 가능 
	 * 
	 * @param c_id : session에 담겼을 사용자 id
	 * @return order_status not in ('준비완료', '결제취소') 인 order_num 리스트 
	 */
	public List<Integer> get_uncompleted_order_num(String c_id);
	
	////////// 애네들은 여기있으면 안될거같다 
	
	
	
	public List<HistoryTDTO> history(String c_id);
	public List<HistoryTDTO> history_get_by_date(String c_id, String start, String end, String statuscheck);
	public List<HashMap<String, String>> historydetail(int order_num);
}
