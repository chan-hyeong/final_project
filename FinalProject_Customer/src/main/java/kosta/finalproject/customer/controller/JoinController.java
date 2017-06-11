package kosta.finalproject.customer.controller;

import java.util.Random;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kosta.finalproject.customer.dao.CustomersDAO;
import kosta.finalproject.customer.dao.MailService;
import kosta.finalproject.customer.dto.CustomersTDTO;

@Controller
public class JoinController {
	@Autowired
	private SqlSession sqlsession;

	@RequestMapping("/joinform.do")
	public String joinform() {

		return "customer/joinform";
	}

	@RequestMapping("/joinpro.do")
	public String joinpro(CustomersTDTO dto) {
		System.out.println("this is joinpro.do ");
		CustomersDAO dao = sqlsession.getMapper(CustomersDAO.class);
		if (dao.insert_into_Customers(dto) > 0)
			System.out.println("join success");
		return "customer/index";
	}

	// 이메일 인증
	@RequestMapping("/email_check.do")
	public String email(HttpSession session, @RequestParam String c_email) {
		sendMailAuth(session, c_email);
		return "customer/email";
	}

	// 이메일 인증
	@RequestMapping(value = "/email.do", produces = "application/json")
	@ResponseBody
	public boolean sendMailAuth(HttpSession session, @RequestParam String c_email) {
		System.out.println("이메일.do");
		int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
		System.out.println(ran);
		String joinCode = String.valueOf(ran);
		System.out.println(joinCode);
		session.setAttribute("joinCode", joinCode);

		String subject = "회원가입 인증 코드 발급 안내 입니다.";
		StringBuilder sb = new StringBuilder();
		sb.append("귀하의 인증 코드는 " + joinCode + " 입니다.");
		return MailService.send(subject, sb.toString(), "wlgp123776@gmail.com", c_email, null);

	}

	// 아이디 중복체크
	@RequestMapping("/id_check.do")
	public String confirmID(CustomersTDTO dto, Model model) {
		CustomersDAO dao = sqlsession.getMapper(CustomersDAO.class);
		int result = dao.check_id_duplication(dto);

		if (result == 0) {
			model.addAttribute("result", 0);// 아이디 없음
			model.addAttribute("id", dto.getC_id());
		} else if (result == 1) {
			model.addAttribute("result", 1);// 아이디 잇음
		}

		return "customer/confirmID";
	}
	

	// 내정보 보기
	@RequestMapping("/modify.do")
	public String modify(Model model, HttpSession session) {
		System.out.println("this is modify.do");
		CustomersDAO dao = sqlsession.getMapper(CustomersDAO.class);
		String id = (String) session.getAttribute("id");
		System.out.println("id : " + id);
		CustomersTDTO dto = null;
		dto = dao.get_customerInfo_by_id(id);
		System.out.println(dto.getC_id());
		model.addAttribute("info", dto);
		
		System.out.println("\n---------------- out modify.do");
		return "customer/modify";
	}

	@RequestMapping("/modify_update.do")
	public String modify_update(CustomersTDTO dto, HttpSession session) {
		System.out.println("모디처음");
		CustomersDAO dao = sqlsession.getMapper(CustomersDAO.class);
		String id = (String) session.getAttribute("id");
		System.out.println("id : " + id);
		dao.update_customerInfo(dto);
		return "customer/main";
	}

	
}//end class