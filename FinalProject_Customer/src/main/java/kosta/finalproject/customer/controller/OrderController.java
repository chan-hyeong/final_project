package kosta.finalproject.customer.controller;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kosta.finalproject.customer.dao.InventoryDAO;
import kosta.finalproject.customer.dao.MenuDAO;
import kosta.finalproject.customer.dao.Order_DetailDAO;
import kosta.finalproject.customer.dao.Order_ListDAO;
import kosta.finalproject.customer.dto.MenuTDTO;
import kosta.finalproject.customer.dto.Order_DetailTDTO;
import kosta.finalproject.customer.dto.Order_ListTDTO;

@Controller
public class OrderController {

	@Autowired
	private SqlSession sqlsession;
	
	@RequestMapping("/payment.do")//결제 완료 버튼을 눌렀을때 
	public String paymentpro(HttpServletRequest request, @RequestParam("paymentMethod") String paymentMethod) {
		System.out.println("\n---------------------------payment.do 진입");
		//결제창에서 결제수단 선택 후 결제완료를 누르면 --> [1]주문추가, [2]재고 조정, [3]history 페이지로 이동  
		Order_ListDAO list_dao = sqlsession.getMapper(Order_ListDAO.class);
		Order_DetailDAO detail_dao = sqlsession.getMapper(Order_DetailDAO.class);
		
	 	Order_ListTDTO list_dto = (Order_ListTDTO) request.getSession().getAttribute("list_dto");
		Order_DetailTDTO detail_dto = (Order_DetailTDTO) request.getSession().getAttribute("detail_dto");
		List<Order_DetailTDTO> detail_dto_basket = (List<Order_DetailTDTO>) request.getSession().getAttribute("detail_dto_basket");
		
		list_dto.setOrder_status("결제완료");
		list_dto.setOrder_payment(paymentMethod);	//결제 수단 반영 
		
		System.out.println("\n\t-------------------------------------------------------------------");
		System.out.println("\t"+list_dto.toString());
		if ( detail_dto !=null) System.out.println("\t"+detail_dto.toString());
		if ( detail_dto_basket !=null) System.out.println("\t"+detail_dto_basket.size() +" : " + detail_dto_basket.toString());
		System.out.println("\t"+"-------------------------------------------------------------------\n\n");		
//		
		//[1] 주문 추가  
		if (  request.getParameter("command")!=null && request.getParameter("command").equalsIgnoreCase("basketpayment")){  //장바구니에서 넘어온 경우 
			list_dao.update_order_list_basket(list_dto); //장바구니로 들어가있던 데이터를 주문상태로 변경 
			
//			for (Order_DetailTDTO item : detail_dto_basket){
//				System.out.println("\t 장바구니 결제 진입 order_detail update !!!!");
//				detail_dao.update_order_detail(item);
//			}
			//업데이트를 해버리면 테이블이 나눠져있어서 힘듬 
			//없애고 다시 넣는게 나을듯 
			//★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
			
			//1) delete from order_list , delete from order_detail
			//2) insert into order_list , insert from order_detail
			
			
			
		}else {//일반 주문 (단품) 
			list_dao.insert_order_list(list_dto);
			detail_dao.insert_order_detail(detail_dto);
			System.out.println("\t인서트 완료 : ");

		}
		
		//[2]재고 조정
		//★★★★★★★★★★
		///////////////////////////////////// inventory 변경 test 중 ★★★★★★★★★
		InventoryDAO inven_dao = sqlsession.getMapper(InventoryDAO.class);
		
		System.out.println("\t 업데이트할 order_list : " + list_dto.getOrder_num() + " / " + list_dto.getS_code()  + " / " + list_dto.getOrder_date() );
//		System.out.println(" 재고 수정 결과는1 ? : " + inven_dao.wow_update_inventory_by_order(list_dto));
//		System.out.println(" 재고 수정 결과는1 ? : " + inven_dao.wow_update_inventory_by_order(list_dto.getOrder_num(), list_dto.getS_code()));
//		System.out.println(" 재고 수정 결과는1 ? : " + inven_dao.test1(list_dto.getOrder_num(), list_dto.getS_code()));
		System.out.println(" 재고 수정 결과는2 ? : " + inven_dao.update_inventory_by_order(list_dto.getOrder_num(), list_dto.getS_code()));
		
		///////////////////////////////////// inventory 변경 test 중 ★★★★★★★★★
		//
		
		System.out.println("\n-----return redirect:history.do");
		System.out.println("---------------------------payment.do 아웃");
		//[3] history.do 로 이동 : 주문내역 보여주기 (이 경우에는 주문내역 상세페이지)
		return "redirect:history.do";
	}
	
	//0517 17:11 찬형 //menu에서 detail option을 선택하고 결제 창으로 보냄 
	@RequestMapping("/paymentform.do")
	public String paymentform(Order_ListTDTO list_dto, Order_DetailTDTO detail_dto , HttpServletRequest request, HttpSession session, @RequestParam("command")String command) {
		String view = "customer/paymentform";
		Order_ListDAO list_dao = sqlsession.getMapper(Order_ListDAO.class);
		Order_DetailDAO detail_dao = sqlsession.getMapper(Order_DetailDAO.class);
		
		String c_id = session.getAttribute("id").toString();
		
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
		
		if( command.equalsIgnoreCase("basketpayment")){
			//[3] 장바구니에서 결제를 누른 경우 
			//update order_list 
			//set status = "주문완료", order_num = "order_num" 구해서, order_date = sysdate 
			//where status = "장바구니"
			
			//update order_detail
			//set order_num = "order_num" 구해서 
			//where order_num = 0
			
			list_dto = list_dao.order_list_basket(c_id);
			List<Order_DetailTDTO> detail_dto_basket = detail_dao.order_detail_basket(c_id);
			
			session.setAttribute("list_dto", list_dto);
			session.setAttribute("detail_dto_basket", detail_dto_basket);
			
			System.out.println("\n\t\n-------------------------------------------------------");
			System.out.println("\t"+list_dto.toString());
			System.out.println("\t"+detail_dto_basket.toString());
			System.out.println("\t"+"-------------------------------------------------------\n\n");
			
			request.setAttribute("command", "basketpayment");
		}else {
			String s_code = request.getParameter("s_code");
			int o_totalprice = new Integer(request.getParameter("o_price"));
			list_dto.setO_totalprice(o_totalprice);//장바구니라면 이거 바꿔줘야하는데 

			int order_num = 0;
			if(list_dao.get_order_num()!=null)
				order_num = list_dao.get_order_num(); 
			order_num++;
			
			list_dto.setOrder_num(order_num);
			detail_dto.setOrder_num(order_num);
			
			if (command.equalsIgnoreCase("basket")) {// [1] 장바구니에 넣기
				
				list_dto.setOrder_status("장바구니");
				list_dto.setOrder_payment("basket");
//				
//				System.out.println("----------------------------------------------");
//				System.out.println( list_dao.order_list_basket(c_id)); 
//				System.out.println( detail_dto.toString()); 
//				System.out.println("----------------------------------------------");
//				
				Order_ListTDTO order_list_basket = list_dao.order_list_basket(c_id); 
				if ( order_list_basket == null ) { //order_list가 없으면 (처음 들어가는 장바구니)
					list_dao.insert_order_list(list_dto);
				}else{//order_list에 이미 들어가있으면
					list_dao.update_order_list(list_dto);//토탈 가격이랑 order_date 바꿔주고 
					
					order_num = order_list_basket.getOrder_num();
					detail_dto.setOrder_num(order_num);	//장바구니에 추가될 dto에 order_num 일치시켜준다음
				}
				detail_dao.insert_order_detail(detail_dto);//삽입
				
				view = "redirect:menulist.do";
			} else if (command.equalsIgnoreCase("payment")) {// [2] 바로 결제 페이지로 가기 (단일 메뉴 주문)
				list_dto.setOrder_status("주문완료");
				
				session.setAttribute("list_dto", list_dto);
				session.setAttribute("detail_dto", detail_dto);
				
				request.setAttribute("command", "payment");
			}
		}//장바구니 or 결제 인 경우
		return view;
	}

	@RequestMapping("/orderdetail.do")
	public String orderdetail(HttpServletRequest request,@RequestParam("m_code") String m_code) {
		MenuDAO dao=sqlsession.getMapper(MenuDAO.class);
		request.setAttribute("menudto", dao.menudetail(m_code));
		List<MenuTDTO> option_bread = new ArrayList<MenuTDTO>(), option_sauces = new ArrayList<MenuTDTO>(), option_extra = new ArrayList<MenuTDTO>(), option_vege = new ArrayList<MenuTDTO>();
		for(MenuTDTO item : dao.menuoption()){
			if ( item.getM_group().equalsIgnoreCase("bread") )
				option_bread.add(item);
			else if( item.getM_group().equalsIgnoreCase("sauces") )
				option_sauces.add(item);
			else if( item.getM_group().equalsIgnoreCase("add_option") )
				option_extra.add(item);
			else if( item.getM_group().equalsIgnoreCase("vegetable") )
				option_vege.add(item);
		}
		
		System.out.println("\t"+option_bread.toString());
		System.out.println("\t"+option_extra.toString());
		System.out.println("\t"+option_sauces.toString());
		System.out.println("\t"+option_vege.toString());
		
//		request.setAttribute("option",dao.menuoption());
		request.setAttribute("option_bread",option_bread);
		request.setAttribute("option_sauces",option_sauces);
		request.setAttribute("option_extra",option_extra);
		request.setAttribute("option_vege",option_vege);
		
//		System.out.println(dao.menuoption().toString());
		
		return "customer/orderdetail";
	}
	
	@RequestMapping("/menulist.do")
	public String menulist(HttpServletRequest request) {
		MenuDAO dao=sqlsession.getMapper(MenuDAO.class);
		request.setAttribute("menulist", dao.menulist());
		request.setAttribute("url", getClass().getResource("/img"));
		return "customer/menulist";
	}

	
	
	
}//end class