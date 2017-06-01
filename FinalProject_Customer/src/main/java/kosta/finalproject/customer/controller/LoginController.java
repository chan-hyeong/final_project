package kosta.finalproject.customer.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kosta.finalproject.customer.dao.CustomersDAO;
import kosta.finalproject.customer.dto.CustomersTDTO;

@Controller
public class LoginController {
	@Autowired
	private SqlSession sqlsession;

	@RequestMapping("/loginform.do")
	public String loginform() {
		return "customer/loginform";
	}

	@RequestMapping("/loginpro.do")
	public String loginpro(CustomersTDTO dto, HttpSession session, Model model) {
		CustomersDAO dao = sqlsession.getMapper(CustomersDAO.class);
		int result = dao.customers(dto);
		if (result == 1) {
			System.out.println("result : " + result);
			model.addAttribute("result", 1);
			session.setAttribute("id", dto.getC_id());
			return "redirect:main.do";//로그인 성공 
		} else

			// model.addAttribute("result", 0);
			model.addAttribute("result", "아이디와 비밀번호를 확인하세요.");

		return "customer/loginform";
	}

	// 로그아웃 수정 - 지혜
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.setAttribute("id", null);
		session.invalidate();
		System.out.println("로그아웃됨");
		return "customer/index";
	}
	

}// end class
