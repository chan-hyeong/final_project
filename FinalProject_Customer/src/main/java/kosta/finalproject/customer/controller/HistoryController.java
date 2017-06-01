package kosta.finalproject.customer.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kosta.finalproject.customer.dao.Order_DetailDAO;
import kosta.finalproject.customer.dao.Order_ListDAO;
import kosta.finalproject.customer.dto.Order_DetailTDTO;
import kosta.finalproject.customer.dto.Order_ListTDTO;

@Controller
public class HistoryController {

	@Autowired
	private SqlSession sqlsession;

	
	
	@RequestMapping("/history_detail.do")
	public String history_detail(HttpServletRequest request, HttpSession session, @RequestParam("order_num") String order_num) {
		System.out.println("\n----------------history detail.do 진입 ");
		Order_DetailDAO detail_dao = sqlsession.getMapper(Order_DetailDAO.class);
		Order_ListDAO list_dao = sqlsession.getMapper(Order_ListDAO.class);
		
		String c_id = session.getAttribute("id").toString();
		List<Order_DetailTDTO> orderdetail_all = detail_dao.order_detail_list_for_customer(c_id);
		List<Order_DetailTDTO> orderdetail = new ArrayList<Order_DetailTDTO>();
		
		//////★★★★★★★ for 문 없애고 매서드하나 더 만드는게 나을듯? 오버라이딩하거나
		
		
		System.out.println("\n\t 세션에서 넘겨받은 아이디 : " + c_id + " : ");
		for( Order_DetailTDTO item : orderdetail_all){
			System.out.println(item.toString());
			if ( item.getOrder_num() == Integer.parseInt(order_num)){
				orderdetail.add(item);
				System.out.println("\t히스토리 디테일 아이템 : " + item);
				continue;
			}
		}
		for( Order_ListTDTO item : list_dao.get_order_list_for_customer(c_id)){
			if ( item.getOrder_num() == Integer.parseInt(order_num)){
				System.out.println("\t히스토리 list아이템 : " + item);
				request.setAttribute("orderitem", item);
				//★★이러느니 order_num이랑 c_id 로 단일 행 select 하는 기능을 매퍼에 추가하는게 나을 듯 
				break;
			}
		}
		
		request.setAttribute("orderdetail", orderdetail);
//		request.setAttribute("orderdetail", orderdetail_all);
		
		System.out.println("\t retunr 값 : customer/history_detail ");
		System.out.println("----------------history detail.do 아웃 \n");
		return "customer/history_detail";
	}
	
	
	@RequestMapping("/history.do")
	public String history(HttpServletRequest request, HttpSession session) {
		Order_ListDAO list_dao = sqlsession.getMapper(Order_ListDAO.class);
		
		String c_id = session.getAttribute("id").toString();
		List<Order_ListTDTO> orderlist = list_dao.get_order_list_for_customer(c_id);
		
		System.out.println("\n\t 세션에서 넘겨받은 아이디 : " + c_id + " : ");
		for( Order_ListTDTO item : orderlist){
			System.out.println(item.toString());
		}
		
		request.setAttribute("orderlist", orderlist);
		
	
		return "customer/history";
	}

	
	
	
}
