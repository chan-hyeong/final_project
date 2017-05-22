package kosta.finalproject.customer.controller;

import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kosta.finalproject.customer.dao.CustomersDAO;
import kosta.finalproject.customer.dao.MenuDAO;
import kosta.finalproject.customer.dao.Order_DetailDAO;
import kosta.finalproject.customer.dao.Order_ListDAO;
import kosta.finalproject.customer.dto.CustomersTDTO;
import kosta.finalproject.customer.dto.Order_DetailTDTO;
import kosta.finalproject.customer.dto.Order_ListTDTO;

@Controller
public class CustomerController {

	@Autowired
	private SqlSession sqlsession;

	@RequestMapping("/index.do")
	public String index() {

		return "customer/index";
	}

	@RequestMapping("/loginform.do")
	public String loginform() {
		return "customer/loginform";
	}

	@RequestMapping("/loginpro.do")
	public String loginpro(CustomersTDTO dto, HttpSession session) {
		CustomersDAO dao = sqlsession.getMapper(CustomersDAO.class);
		int result = dao.customers(dto);
		if (result == 1) {
			System.out.println(result);
			session.setAttribute("id", dto.getC_id());
			return "customer/main";
		} else
			System.out.println(result);
		return "customer/loginform";
	}

	@RequestMapping("/joinform.do")
	public String joinform() {

		return "customer/joinform";
	}

	@RequestMapping("/joinpro.do")
	public String joinpro(CustomersTDTO dto) {
		CustomersDAO dao = sqlsession.getMapper(CustomersDAO.class);
		System.out.println("tetetstst");
		dao.insert(dto);
		System.out.println("sucea");
		return "customer/index";
	}

	// 내정보 보기
	@RequestMapping("/modify.do")
	public String modify(Model model, HttpSession session) {
		CustomersDAO dao = sqlsession.getMapper(CustomersDAO.class);
		System.out.println("모디처음");
		String id = (String) session.getAttribute("id");
		System.out.println("id : " + id);
		CustomersTDTO dto = null;
		dto = dao.getcustomers(id);
		System.out.println(dto.getC_id());
		model.addAttribute("info", dto);
		System.out.println("모디파이");
		return "customer/modify";
	}

	@RequestMapping("/modify_update.do")
	public String modify_update(CustomersTDTO dto, HttpSession session) {
		CustomersDAO dao = sqlsession.getMapper(CustomersDAO.class);
		System.out.println("모디처음");
		String id = (String) session.getAttribute("id");
		System.out.println("id : " + id);
		dao.update(dto);
		return "customer/main";
	}
	//로그아웃 수정 - 지혜
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.setAttribute("id", null);
		session.invalidate();
		System.out.println("로그아웃됨");
		return "customer/index";
	}

	@RequestMapping("/main.do")
	public String main() {

		return "customer/main";
	}

	@RequestMapping("/menulist.do")
	public String menulist(HttpServletRequest request) {
		MenuDAO dao=sqlsession.getMapper(MenuDAO.class);
		request.setAttribute("menulist", dao.menulist());
		request.setAttribute("url", getClass().getResource("/img"));
		return "customer/menulist";
	}

	@RequestMapping("/favorite.do")
	public String favorite() {

		return "customer/favorite";
	}

	@RequestMapping("/history.do")
	public String history() {

		return "customer/history";
	}

	@RequestMapping("/cash.do")
	public String cash() {

		return "customer/cashform";
	}
		
	@RequestMapping("/payment.do")
	public String paymentpro(HttpServletRequest request,@RequestParam("paymentMethod") String paymentMethod) {
		
		return "customer/history";
	}
	
	//0517 17:11 찬형 
	@RequestMapping("/paymentform.do")
	public String paymentform(Order_ListTDTO list_dto, Order_DetailTDTO detail_dto , HttpServletRequest request, HttpSession session) {
		Order_ListDAO list_dao = sqlsession.getMapper(Order_ListDAO.class);
		Order_DetailDAO detail_dao = sqlsession.getMapper(Order_DetailDAO.class);
		
		Enumeration<String> e=  request.getParameterNames();
		while(e.hasMoreElements()){
			String name = e.nextElement();
			String value = request.getParameter(name);
			System.out.println("\t" + name + " : " + value);
		}
		
		//command 로 분기 한다 
		//1. 장바구니에 담는 경우 
			//status = '장바구니', order~테이블에 row넣기, menulist 페이지로
		//2. 결제한 경우 
			//status = '주문완료', order~테이블에 row넣기,paymentform 페이지로 
		
		String c_id = session.getAttribute("id").toString();
		String s_code = request.getParameter("s_code");
		String order_status = "";// = request.getParameter("order_status");
		String command = request.getParameter("command");
		int o_totalprice = new Integer(request.getParameter("o_totalprice"));
		
		List<Order_ListTDTO> order_list = list_dao.order_list_list(c_id); //order_num만 구해오면 되니까 메서드 하나 만들자 
		
		int order_num = 0;
		if (command.equalsIgnoreCase("basket")){//장바구니에 넣기  
			order_status = "장바구니";
			order_num = 0;
		}else if(command.equalsIgnoreCase("payment")){//결제 페이지로 가기  
			order_status = "주문완료";
			if ( order_list.size() > 0 ) 
				order_num = order_list.get(0).getOrder_num();
			order_num ++;
		}else if(command.equalsIgnoreCase("basketpayment")) {//장바구니에서 결제 
			//update order_list 
			//set status = "주문완료", order_num = "order_num" 구해서, order_date = sysdate 
			//where status = "장바구니"
			
			//update order_detail
			//set order_num = "order_num" 구해서 
			//where order_num = 0
		}else{
			//command 가 잘못넘어온다면?
		}
		
		list_dto.setOrder_status(order_status);
		list_dto.setOrder_num(order_num);
		
		detail_dto.setOrder_num(order_num);
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println(list_dto.toString());
		System.out.println(detail_dto.toString());
		System.out.println("-------------------------------------------------------------------\n\n");
		
		list_dao.insert_order_list(list_dto);
		detail_dao.insert_order_detail(detail_dto);
		
		return "customer/paymentform";
	}

	@RequestMapping("/orderdetail.do")
	public String orderdetail(HttpServletRequest request,@RequestParam("m_code") String m_code) {
		MenuDAO dao=sqlsession.getMapper(MenuDAO.class);
		request.setAttribute("menudto", dao.menudetail(m_code));
		request.setAttribute("option",dao.menuoption());

		return "customer/orderdetail";
	}

	@RequestMapping("/shoppingbag.do")
	public String shoppingbag(HttpServletRequest request) {
		String c_id = request.getSession().getAttribute("id").toString();
		
		Order_DetailDAO detail_dao = sqlsession.getMapper(Order_DetailDAO.class);
		request.setAttribute("detail_list", detail_dao.order_detail_list(c_id));

		return "customer/shoppingbag";//장바구니 페이지 보여주기 vs 메뉴 리스트로 다시 돌아가기
	}
}
