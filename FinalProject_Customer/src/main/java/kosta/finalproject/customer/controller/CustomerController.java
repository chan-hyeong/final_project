package kosta.finalproject.customer.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kosta.finalproject.customer.dao.MenuDAO;
import kosta.finalproject.customer.dto.MenuTDTO;

@Controller
public class CustomerController {

	@Autowired
	private SqlSession sqlsessoin;

	@RequestMapping("/index.do")
	public String index() {

		return "customer/index";
	}

	@RequestMapping("/loginform.do")
	public String loginform() {

		return "customer/loginform";
	}

	@RequestMapping("/joinform.do")
	public String joinform() {

		return "customer/joinform";
	}

	@RequestMapping("/main.do")
	public String main() {

		return "customer/main";
	}

	@RequestMapping("/menulist.do")
	public String menulist(HttpServletRequest request) {
		MenuDAO dao=sqlsessoin.getMapper(MenuDAO.class);
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

	@RequestMapping("/payment.do")
	public String menudetail(HttpServletRequest request,@RequestParam("m_code") String m_code) {
		MenuDAO dao=sqlsessoin.getMapper(MenuDAO.class);
		request.setAttribute("menudto", dao.menudetail(m_code));
		request.setAttribute("option",dao.menuoption());
		return "customer/paymentform";
	}

	@RequestMapping("/orderdetail.do")
	public String orderdetail() {

		return "customer/orderdetail";
	}

	@RequestMapping("/shoppingbag.do")
	public String shoppingbag() {

		return "customer/shoppingbag";
	}
}
