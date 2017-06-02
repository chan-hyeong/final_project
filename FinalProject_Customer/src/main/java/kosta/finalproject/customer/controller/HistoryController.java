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
import kosta.finalproject.customer.dao.Order_ListDAO;
import kosta.finalproject.customer.dto.HistoryTDTO;
import kosta.finalproject.customer.dto.Order_ListTDTO;

@Controller
public class HistoryController {

	@Autowired
	private SqlSession sqlsession;

	//history detail ajax 처리 method
	@ResponseBody
	@RequestMapping(value="/historydetail.do", method=RequestMethod.GET)
	public List<HashMap<String, String>> history_detail(HttpServletRequest request, HttpSession session,
														@RequestParam("order_num") int order_num) {
		
		HistoryDAO detail_dao = sqlsession.getMapper(HistoryDAO.class);
		List<HashMap<String, String>> list =detail_dao.historydetail(order_num);

		return list;
	}
	
	@RequestMapping(value="/historydetailtest.do", method=RequestMethod.GET)
	public String history_detail_test(HttpServletRequest request, HttpSession session,
			@RequestParam("order_num") int order_num) {
		
		HistoryDAO detail_dao = sqlsession.getMapper(HistoryDAO.class);
		Order_ListDAO order_dao = sqlsession.getMapper(Order_ListDAO.class);
		List<HashMap<String, String>> list =detail_dao.historydetail(order_num);
		
		for( Order_ListTDTO item : order_dao.get_order_list(session.getAttribute("id").toString())){
			if ( item.getOrder_num() == order_num){ 
				request.setAttribute("orderitem", item);
				System.out.println(item.toString());
				break;
			}
		}
		
		request.setAttribute("order_detail_list", list);
		
		return "customer/history_detail_test";
	}
	
	//historylist
	@RequestMapping("/history.do")
	public String history(HttpServletRequest request, HttpSession session) {
		HistoryDAO list_dao = sqlsession.getMapper(HistoryDAO.class);
		
		String c_id = session.getAttribute("id").toString();
		List<HistoryTDTO> orderlist = list_dao.history(c_id);
		
		System.out.println(orderlist.toString());
		
		request.setAttribute("orderlist", orderlist);
	
		return "customer/history";
	}

	
	
	
}
