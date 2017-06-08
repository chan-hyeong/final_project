package kosta.finalproject.customer.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kosta.finalproject.customer.dao.StoreDAO;
import kosta.finalproject.customer.dto.StoreTDTO;

/////////////////////////매장 선택관련 컨트롤러 - 지헤/////////////////////////
@Controller
public class StoreController {

	@Autowired
	private SqlSession sqlsession;
	
	 
	@RequestMapping("/store2.do")
	public String store2(HttpServletRequest request) {
		StoreDAO dao=sqlsession.getMapper(StoreDAO.class);
		
		request.setAttribute("storelist", dao.storelist());
		
		///////////////////////////test
		
		System.out.println("\n--------------------------------------------------------------------------------");
		for ( StoreTDTO item : dao.storelist()){
			System.out.println(item);
		}
		System.out.println("--------------------------------------------------------------------------------\n");
		
		
		
		
		///////////////////////////test
		
		
		//여기서 현재위치 기반 가까운 매장 리스트 정렬해야함 
		
		
		
		return "customer/store2";
	}//end
	
	@RequestMapping("/store_selec.do")
	public String store_select(HttpSession session, @RequestParam(name="s_code")String s_code) {
		session.setAttribute("s_code", s_code);
		//다음페이지까지만 유효하게 해야될텐데 
		
		return "redirect:menulist.do";
	}//end
	
}//end class
