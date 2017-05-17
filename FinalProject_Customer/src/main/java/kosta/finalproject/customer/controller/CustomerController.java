package kosta.finalproject.customer.controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String menulist() {

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
	public String cash() {

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
