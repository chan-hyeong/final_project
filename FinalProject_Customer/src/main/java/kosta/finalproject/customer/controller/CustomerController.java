package kosta.finalproject.customer.controller;

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
import kosta.finalproject.customer.dto.CustomersTDTO;

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

	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.setAttribute("id", null);
		return "customer/logout";
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
	public String menudetail(/*HttpServletRequest request,@RequestParam("m_code") String m_code*/) {
		/*MenuDAO dao=sqlsession.getMapper(MenuDAO.class);
		request.setAttribute("menudto", dao.menudetail(m_code));
		request.setAttribute("option",dao.menuoption());*/
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
	public String shoppingbag() {

		return "customer/shoppingbag";
	}
}
