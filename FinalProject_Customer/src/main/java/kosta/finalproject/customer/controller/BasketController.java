package kosta.finalproject.customer.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kosta.finalproject.customer.dao.Order_DetailDAO;
import kosta.finalproject.customer.dao.Order_ListDAO;
import kosta.finalproject.customer.dto.Order_ListTDTO;

@Controller
public class BasketController {
	
	@Autowired
	private SqlSession sqlsession;

	//파라미터 없이 진입시 장바구니 띄워주기  
	@RequestMapping(value="/shoppingbag.do",  method=RequestMethod.GET)
	public String shoppingbag(HttpServletRequest request) {
		String c_id = request.getSession().getAttribute("id").toString();
		
		Order_DetailDAO detail_dao = sqlsession.getMapper(Order_DetailDAO.class);
		Order_ListDAO list_dao = sqlsession.getMapper(Order_ListDAO.class);
		
		System.out.println("\n--------------------------------------------------------");
		System.out.println("\t"+detail_dao.order_detail_basket_for_customer(c_id));
		System.out.println("\t"+list_dao.get_basket(c_id));
		System.out.println("--------------------------------------------------------\n");
		
		
		request.setAttribute("detail_list", detail_dao.order_detail_basket_for_customer(c_id));
		request.setAttribute("list_dto", list_dao.get_basket(c_id));
		

		return "customer/shoppingbag";//장바구니 페이지 보여주기 vs 메뉴 리스트로 다시 돌아가기
	}
	
	//장바구니내에서 단일품목 삭제 or 장바구니 전체 비우기 기능 
	@RequestMapping(value="/shoppingbag.do", method=RequestMethod.POST)
	public String shoppingbag_delete(HttpServletRequest request, 
			@RequestParam(name="command", required=false, defaultValue="null")String command,
			@RequestParam(name="delete_order_detail_num", required=false, defaultValue="0")int delete_order_detail_num
			) {
		String c_id = request.getSession().getAttribute("id").toString();
		
		Order_DetailDAO detail_dao = sqlsession.getMapper(Order_DetailDAO.class);
		Order_ListDAO list_dao = sqlsession.getMapper(Order_ListDAO.class);
		
//		System.out.println("\n테스트---------------------------------------");
//		System.out.println(delete_order_detail_num + "를 지우고 order_list의 total_price를 조정할겁니다");
//		System.out.println("------------------------------------테스트 입니다\n");
		
		Order_ListTDTO basket_dto = list_dao.get_basket(c_id);
		int order_num  = basket_dto!=null? basket_dto.getOrder_num() : 0;
		
		if ( command.equals("deleteAll") && order_num > 0){//모두 지우는 경우 
			System.out.println("\t 장바구니를 비웁니다 : " + detail_dao.delete_order_detail(order_num, 0));
			list_dao.delete_from_order_list(c_id, order_num);
			
		}else if(delete_order_detail_num > 0){//숫자가 넘어왔다면 
			System.out.println("\t 장바구니에서 " + delete_order_detail_num + "만 지웁니다");
			detail_dao.delete_order_detail(order_num, delete_order_detail_num);
			list_dao.update_basket(c_id);
			//사실 if문도 필요없음 한줄로 가능 
		}		
		
		return "redirect:shoppingbag.do";//장바구니 페이지 보여주기 vs 메뉴 리스트로 다시 돌아가기
	}
	
	//장바구니에 담긴 아이템들을 한번에 결제할때 
	@RequestMapping(value="/shoppingbag.do", params="command=basketpayment")
	public String shoppingbag_payment(HttpServletRequest request, HttpSession session) {
		System.out.println("장바구니를 결제합니다");
		String c_id = session.getAttribute("id").toString();
		
		Order_DetailDAO detail_dao = sqlsession.getMapper(Order_DetailDAO.class);
		Order_ListDAO list_dao = sqlsession.getMapper(Order_ListDAO.class);

		session.setAttribute("list_dto", list_dao.get_basket(c_id));
		session.setAttribute("detail_dto_list", detail_dao.order_detail_basket_for_customer(c_id));
		session.setAttribute("command", "basketpayment");
		
		return "customer/paymentform";//장바구니 페이지 보여주기 vs 메뉴 리스트로 다시 돌아가기
	}

}//class