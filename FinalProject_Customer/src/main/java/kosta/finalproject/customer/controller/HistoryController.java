package kosta.finalproject.customer.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kosta.finalproject.customer.dao.HistoryDAO;
import kosta.finalproject.customer.dto.HistoryTDTO;

@Controller
public class HistoryController {

	@Autowired
	private SqlSession sqlsession;

	//history detail ajax 처리 method
	@ResponseBody
	@RequestMapping(value="/historydetail.do", method=RequestMethod.GET)
	public List<HashMap<String, String>> history_detail(HttpServletRequest request, HttpSession session,
														@RequestParam("ordernum") int order_num) {
		
		System.out.println(2);
		HistoryDAO detail_dao = sqlsession.getMapper(HistoryDAO.class);
		System.out.println(3);
		List<HashMap<String, String>> list =detail_dao.historydetail(order_num);
		System.out.println(4);
		/*for (int i = 0; i<list.size(); i++){
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("order_no","orderno_value");
		}*/
		System.out.println(list.get(0));
		System.out.println(list.get(1));

		
		System.out.println(7);
		
		
		

		
		return list;
	}
	
	//historylist
	@RequestMapping("/history.do")
	public String history(HttpServletRequest request, HttpSession session) {
		HistoryDAO list_dao = sqlsession.getMapper(HistoryDAO.class);
		
		String c_id = session.getAttribute("id").toString();
		List<HistoryTDTO> orderlist = list_dao.history(c_id);
		
		for( HistoryTDTO item : orderlist){
			System.out.println(item.toString());
		}
		
		request.setAttribute("orderlist", orderlist);
		
	
		return "customer/history";
	}

	
	
	
}
