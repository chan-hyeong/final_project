package kosta.finalproject.customer.controller;

import javax.mail.Session;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.Date;
import java.util.Random;
import java.util.StringTokenizer;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kosta.finalproject.customer.dao.CustomersDAO;
import kosta.finalproject.customer.dao.MailService;
import kosta.finalproject.customer.dao.MenuDAO;
import kosta.finalproject.customer.dao.Order_DetailDAO;
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
	public String loginpro(CustomersTDTO dto, HttpSession session, Model model) {
		CustomersDAO dao = sqlsession.getMapper(CustomersDAO.class);
		int result = dao.customers(dto);
		if (result == 1) {
			System.out.println("result : "+result);
			model.addAttribute("result", 1);
			session.setAttribute("id", dto.getC_id());
			return "customer/main";
		} else
			
			
//			model.addAttribute("result", 0);
		model.addAttribute("result", "아이디와 비밀번호를 확인하세요.");
		
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

	// �궡�젙蹂� 蹂닿린
	@RequestMapping("/modify.do")
	public String modify(Model model, HttpSession session) {
		CustomersDAO dao = sqlsession.getMapper(CustomersDAO.class);
		String id = (String) session.getAttribute("id");
		System.out.println("id : " + id);
		CustomersTDTO dto = null;
		dto = dao.getcustomers(id);
		System.out.println(dto.getC_id());
		model.addAttribute("info", dto);
		return "customer/modify";
	}

	@RequestMapping("/modify_update.do")
	public String modify_update(CustomersTDTO dto, HttpSession session) {
		CustomersDAO dao = sqlsession.getMapper(CustomersDAO.class);
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
	
	//이메일 인증 
	@RequestMapping("/email_check.do")
	public String email(HttpSession session, @RequestParam String c_email) {
		sendMailAuth(session, c_email);
		return "customer/email";
	}
	
	//이메일 인증
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
	
	//아이디 중복체크
	@RequestMapping("/id_check.do")
	public String confirmID(CustomersTDTO dto, Model model) {
		CustomersDAO dao = sqlsession.getMapper(CustomersDAO.class);
		int result = dao.getid(dto);
		
		if(result == 0){
			model.addAttribute("result", 0);//아이디 없음
			model.addAttribute("id", dto.getC_id());
		}else if(result == 1){
			model.addAttribute("result", 1);//아이디 잇음
		}
		
		return "customer/confirmID";
	}
	
	@RequestMapping("/main.do")
	public String main() {

		return "customer/main";
	}

	@RequestMapping("/menulist.do")
	public String menulist(HttpServletRequest request) {
		MenuDAO dao=sqlsession.getMapper(MenuDAO.class);
		request.setAttribute("menulist", dao.menulist());
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
	public String menudetail(HttpServletRequest request,Order_DetailTDTO d_dto,Order_ListTDTO l_dto,@RequestParam("h_m_quantity") int quantity) {
	
		String command = request.getParameter("command");
		HttpSession session = request.getSession();
		l_dto.setC_id((String)session.getAttribute("id"));
		if(command!=null&&command.equals("basket")){
			Date today = new Date();
			l_dto.setOrder_date(today);
			Order_DetailDAO dao=sqlsession.getMapper(Order_DetailDAO.class);
			
			//vegetable null값 넘어오면 오류 나는 부분 임시 해결
			if(d_dto.getO_vege1()== null) d_dto.setO_vege1("temp");
			if(d_dto.getO_vege2()== null) d_dto.setO_vege2("temp");
			if(d_dto.getO_vege3()== null) d_dto.setO_vege3("temp");
			if(d_dto.getO_vege4()== null) d_dto.setO_vege4("temp");
			if(d_dto.getO_vege5()== null) d_dto.setO_vege5("temp");
			if(d_dto.getO_vege6()== null) d_dto.setO_vege6("temp");
			if(d_dto.getO_vege7()== null) d_dto.setO_vege7("temp");
			if(d_dto.getO_vege8()== null) d_dto.setO_vege8("temp");
			//vegetable null값 넘어오면 오류 나는 부분 임시 해결
			
			//
			//
			
			//동시 주문시 order_num 통일시키기 위해
			int order_num=dao.select_onum();
			d_dto.setOrder_num(order_num);
			l_dto.setOrder_num(order_num);
			//동시 주문시 order_num 통일시키기 위해
			
			for(int i=0;i<quantity;i++)	dao.insert_shoppingbag_detail(d_dto);
			dao.insert_shoppingbag_list(l_dto);
			/*System.out.println("=========================================================");			
			System.out.println(d_dto.toString());			
			System.out.println("=========================================================");
			System.out.println(l_dto.toString());			
			System.out.println("=========================================================");*/
			return "redirect:shoppingbag.do";
		}
		return "customer/paymentform";
	}
	
/*	//0517 17:11 찬형 
	@RequestMapping("/payment.do")
	public String paymentform(HttpServletRequest request,@RequestParam("m_code") String m_code) {
		
		return "customer/paymentform";
	}*/

	@RequestMapping("/orderdetail.do")
	public String orderdetail(HttpServletRequest request,@RequestParam("m_code") String m_code) {
		MenuDAO dao=sqlsession.getMapper(MenuDAO.class);
		request.setAttribute("menudto", dao.menudetail(m_code));
		request.setAttribute("option",dao.menuoption());
		return "customer/orderdetail";
	}

	@RequestMapping("/shoppingbag.do")
	public String shoppingbag(HttpServletRequest request) {	
		//////////////미로그인시 로그인창으로 돌리기////////////////////
		HttpSession session = request.getSession();
		String ID = (String) session.getAttribute("id");
		if(ID==null) return "customer/loginform";	
		/////////////////////////////////////////////////////
		
		Order_DetailDAO dao=sqlsession.getMapper(Order_DetailDAO.class);
		
		/////////////////////////장바구니 delete작업////////////////////////////////////////
		String command = request.getParameter("command");
		System.out.println("command : "+command);
		if(command!=null&&command.equals("deleteall")){
			ArrayList<Integer> list=dao.select_onum_list(ID);
			dao.deleteall_list(ID);
			for(int i=0;i<list.size();i++){
				dao.deleteall_detail(list.get(i));
			}
			return "redirect:shoppingbag.do";
		}
		int index=0;
		String order_num[]=null;
		String order_detail_num[]=null;
		if(command!=null){
			StringTokenizer st = new StringTokenizer( command, "/" );
			command=st.nextToken();
			index=Integer.parseInt(st.nextToken());
			order_num=(String[])(request.getParameterValues("order_num"));
			order_detail_num=(String[])(request.getParameterValues("order_detail_num"));
		}
		
		if(command!=null&&command.equals("delete")){
			
			if(dao.select_onum1(Integer.parseInt(order_num[index]))==1){
				dao.order_detail_delete1(Integer.parseInt(order_num[index]));
			}
			dao.order_detail_delete2(Integer.parseInt(order_detail_num[index]));
			return "redirect:shoppingbag.do";
		}		
		request.setAttribute("order_detail", dao.order_detail_list(ID));
		//////////////////////////////장바구니 delete작업/////////////////////////////////
		return "customer/shoppingbag";
	}
}
