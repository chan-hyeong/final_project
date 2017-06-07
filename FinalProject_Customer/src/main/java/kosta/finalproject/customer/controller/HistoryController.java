package kosta.finalproject.customer.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

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
	
	//히스토리 디테일 : ajax 이용해서 detail 페이지를 작성, 보낸다 
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
	
	
	
	//히스토리 진입시 
	@RequestMapping("/history.do")
	public String history(HttpServletRequest request, HttpSession session,
			@RequestParam(name="statuscheck", defaultValue="all")String statuscheck, 
			@RequestParam(name="start", defaultValue="sysdate-30")String start, 
			@RequestParam(name="end", defaultValue="sysdate")String end ) {
		HistoryDAO list_dao = sqlsession.getMapper(HistoryDAO.class);
		
		String c_id = session.getAttribute("id").toString();
		
		System.out.println(start + " , " + end);
		request.setAttribute("orderlist", list_dao.history_get_by_date(c_id, start, end, statuscheck));
		
		//기간 정보도 담기 
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
		Date today = new Date();
		Date target = new Date();
		if ( start.equalsIgnoreCase("sysdate-30") ){
			target.setTime( today.getTime() - ((long)1000*60*60*24*30));//30일전 
			start = sdf.format(target);
		}
		if ( end.equalsIgnoreCase("sysdate"))	 
			end = sdf.format(today);
		
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("statuscheck", statuscheck);
	
		return "customer/history";
	}//end 

	
}//end class
