package kosta.finalproject.customer.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CustomerController {
	@Autowired
	private SqlSession sqlsession;

	@RequestMapping("/index.do")
	public String index() {
		return "customer/index";
	}
	
	@RequestMapping("/main.do")
	public String main() {
		return "customer/main";
	}

	@RequestMapping("/favorite.do")
	public String favorite(HttpSession session) {
		if ( session.getAttribute("id") == null){
			return "redirect:loginform.do";
		}
		return "customer/favorite";
	}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////// 분리해야함 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
}//end class