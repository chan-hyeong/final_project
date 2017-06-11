package kosta.finalproject.customer.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kosta.finalproject.customer.dao.CustomersDAO;
import kosta.finalproject.customer.dao.HistoryDAO;
import kosta.finalproject.customer.dto.CustomersTDTO;

@Controller
public class LoginController {
	@Autowired
	private SqlSession sqlsession;

	@RequestMapping("/loginform.do")
	public String loginform(@RequestParam(name="result", required=false)String result, Model model) {
		model.addAttribute("result", result);
		return "customer/loginform";
	}

	@RequestMapping("/loginpro.do")
	public String loginpro(CustomersTDTO dto, HttpSession session, Model model) {
		CustomersDAO dao = sqlsession.getMapper(CustomersDAO.class);
		int result = dao.login_id_pw_check(dto);
		
		if (result == 1) {
			System.out.println("result : " + result);
			model.addAttribute("result", 1);
			session.setAttribute("id", dto.getC_id());
			session.setAttribute("c_coin", dao.get_customerInfo_by_id(dto.getC_id()).getC_coin());
			
			order_status_check(session);
			
			return "redirect:main.do";//로그인 성공 
		} else

			// model.addAttribute("result", 0);
			model.addAttribute("result", "아이디와 비밀번호를 확인하세요.");
		
		//알람 트리거 
		
		return "customer/loginform";
	}

	// 로그아웃 수정 - 지혜
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.setAttribute("id", null);
		session.invalidate();
		System.out.println("로그아웃됨");
		return "redirect:main.do";
	}
	
	


	/**
	 * order_status '준비완료'가 아닌(== 주문상태를 체크할 필요가 있는) order_num 리스트를 이용해서
	 * 사용자에게 준비완료됨을 알려줌  
	 * header에 삽입된 ajax가 interval 호출함 
	 * 
	 * @param session
	 * @return : order_status 가 '준비완료' 로 바뀐 order_num 의 리스트 
	 */
	public @ResponseBody List<Integer> order_status_check(HttpSession session) {
System.out.println("\n\norder_status_check 진입 ");
		HistoryDAO dao = sqlsession.getMapper(HistoryDAO.class);
		
		String c_id = (session.getAttribute("id")==null) ?  "" : session.getAttribute("id").toString();

		List<Integer> order_nums = null;
		List<Integer> chaged_order_nums = null;

		if (session.getAttribute("slist") != null)
			order_nums = (List<Integer>) session.getAttribute("slist"); // 세션에 있다면 바로 가져오고 
		else 
			order_nums = dao.get_uncompleted_order_num(c_id);// 없다면 담아야할 놈을 가져온느데 
		
		//가져온놈이 길이 0 이상이면 상태 체크하고 
		if (order_nums.size() > 0) { 
			chaged_order_nums = dao.completed_order_num(c_id, order_nums); //그놈들의 상태를 체크 
			
			//변화된 놈이 있다면 
			if (chaged_order_nums.size() > 0) {
				// order_num이 변화된게 1개 이상있는거임
				session.setAttribute("slist", dao.get_uncompleted_order_num(c_id)); // session 갱신해주고 
				session.setAttribute("changed_order_nums", chaged_order_nums);// 상태바뀐놈들, 리턴을 하고 있으니 굳이 필요하진..
//System.out.println("\t session에 담음 " + order_nums.toString());
			}else{
				session.setAttribute("slist", order_nums);
			}
		} else {
			//아니라면 session 에서 삭제 
			System.out.println("\t session에서 slist 지움\n");
			session.removeAttribute("slist");
		} 

//System.out.println("\t session에 담긴 slist 값 ("+session.getAttribute("slist").toString());
//System.out.println("\t return 할 chaged_order_list 값 ("+chaged_order_nums.size()+"): " + chaged_order_nums.toString());
		return chaged_order_nums;// 스크립트 펑션에서 받아볼 list
	}
	

}// end class
