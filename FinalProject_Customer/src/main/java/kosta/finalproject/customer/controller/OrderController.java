package kosta.finalproject.customer.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kosta.finalproject.customer.dao.CustomersDAO;
import kosta.finalproject.customer.dao.InventoryDAO;
import kosta.finalproject.customer.dao.Order_DetailDAO;
import kosta.finalproject.customer.dao.Order_ListDAO;
import kosta.finalproject.customer.dto.Order_DetailTDTO;
import kosta.finalproject.customer.dto.Order_ListTDTO;

@Controller
public class OrderController {

	@Autowired
	private SqlSession sqlsession;
	//0517 17:11 찬형 //menu에서 detail option을 선택하고 결제 창으로 보냄 
	
	
	
	@RequestMapping("/paymentform.do")
	public String paymentform(
			Order_ListTDTO list_dto
			,Order_DetailTDTO detail_dto  
			,HttpServletRequest request, HttpSession session 
			,@RequestParam("command")String command
			,@RequestParam(name="amount", defaultValue="1")int amount
			) {
		
System.out.println("\n\n\n==============================================================================");
System.out.println("\t"+list_dto.toString());
System.out.println("\t"+detail_dto.toString());
System.out.println("\t"+amount);
System.out.println("==============================================================================\n\n\n");
		
		Order_ListDAO list_dao = sqlsession.getMapper(Order_ListDAO.class);
		Order_DetailDAO detail_dao = sqlsession.getMapper(Order_DetailDAO.class);
		
		String c_id = session.getAttribute("id").toString();
		
		
		//매장정보 
		String s_code = request.getParameter("s_code");
		
		

		int order_num = list_dao.get_order_num()+1; 
		list_dto.setOrder_num(order_num);
		detail_dto.setOrder_num(order_num);
		
		//command 로 분기 한다 
		//1. 장바구니에 담는 경우 
		//status = '장바구니', order~테이블에 row넣기, menulist 페이지로
		//2. 결제한 경우 
		//status = '주문완료', order~테이블에 row넣기,paymentform 페이지로 
		
		if (command.equalsIgnoreCase("basket")) {// [1] 장바구니에 넣기
			list_dto.setOrder_status("장바구니");
			list_dto.setOrder_payment("basket");
			
			Order_ListTDTO order_list_basket = list_dao.get_basket(c_id); 
			if ( order_list_basket == null ) { //order_list가 없으면 (처음 들어가는 장바구니)
				list_dao.insert_order(list_dto);
			}else{//order_list에 이미 들어가있으면
				detail_dto.setOrder_num(order_list_basket.getOrder_num());
			}
			for (int i=0; i<amount; i++)
				detail_dao.insert_order_detail(detail_dto);//개수에 맞게 삽입
			
			list_dao.update_basket(c_id);//토탈 가격이랑 order_date 바꿔주고 
			
			return "redirect:menulist.do";
			
		} else if (command.equalsIgnoreCase("payment")) {// [2] 바로 결제 페이지로 <-- 단일 메뉴 주문
			session.setAttribute("list_dto", list_dto);
			
			List<Order_DetailTDTO> detail_dto_list = new ArrayList<Order_DetailTDTO>(); 
			for (int i=0; i<amount; i++)
				detail_dto_list.add( detail_dto );
			session.setAttribute("detail_dto_list", detail_dto_list);
			
//			System.out.println(" \n\t 테 스 트 : " + ((Order_DetailTDTO[] )session.getAttribute("detail_dto_list"))[0].toString() + "\n\n");
			
			request.setAttribute("command", "payment");
		}
		
		return "customer/paymentform";
	}

	
	
	//트랜잭션이 필요함 //[1]주문추가 [2]재고수정 [3]코인결제, 셋 중 하나라도 실패하면 rollback해야함 
	@RequestMapping("/payment.do")//결제 완료 버튼을 눌렀을때 
	public String paymentpro(HttpServletRequest request, HttpSession session, 
			@RequestParam(value="command", defaultValue="null") String command,
			@RequestParam("paymentMethod") String paymentMethod) {
		//결제창에서 결제수단 선택 후 결제완료를 누르면 --> [1]주문추가, [2]재고 조정, [3]history 페이지로 이동  
		Order_ListDAO list_dao = sqlsession.getMapper(Order_ListDAO.class);
		Order_DetailDAO detail_dao = sqlsession.getMapper(Order_DetailDAO.class);
		InventoryDAO inven_dao = sqlsession.getMapper(InventoryDAO.class);
		CustomersDAO cus_dao = sqlsession.getMapper(CustomersDAO.class);
		
		Order_ListTDTO list_dto = (Order_ListTDTO) session.getAttribute("list_dto");
		List<Order_DetailTDTO> detail_dto_list = (List<Order_DetailTDTO>) session.getAttribute("detail_dto_list");
		
		list_dto.setOrder_status("결제완료");
		list_dto.setOrder_payment(paymentMethod);	//결제 수단 반영 
		
//		System.out.println("\n\t-------------------------------------------------------------------");
//		System.out.println("\t"+list_dto.toString());
//		if ( detail_dto_list !=null) System.out.println("\t"+detail_dto_list.size() +" : " + detail_dto_list.toString());
//		System.out.println("\t"+"-------------------------------------------------------------------\n\n");		
		
		//★★★★★★★★★★여기서 부터 트랜잭션 필요 
		
		//[1] 주문 추가  
		if (  command.equalsIgnoreCase("basketpayment")){  //장바구니에서 넘어온 경우 
			list_dao.order_by_basket(list_dto); //주문상태를 결제완료로 변경  
			//★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
			
			
			//[1-1] 장바구니에서 결제를 누른 경우 
			//1) delete from order_list , delete from order_detail
			//update order_list 
			//set status = "주문완료", order_num = "order_num" 구해서, order_date = sysdate 
			//where status = "장바구니"
			
			//2) insert into order_list , insert from order_detail
			//update order_detail
			//set order_num = "order_num" 구해서 
			//where order_num = 0
		}else if (command.equalsIgnoreCase("payment")) {//일반 주문 (단품) 
			list_dao.insert_order(list_dto);
			for (int i = 0 ; i< detail_dto_list.size(); i++){
				System.out.println("\t" + i + "행 인서트 완료 : " + detail_dao.insert_order_detail(detail_dto_list.get(i)));
			}
		}
		
		//[2]재고 조정
		//★★★★★★★★★★
		///////////////////////////////////// inventory 변경 test 중 ★★★★★★★★★
		
System.out.println("\t 업데이트할 order_list : " + list_dto.getOrder_num() + " / " + list_dto.getS_code()  + " / " + list_dto.getOrder_date() );
System.out.println(" 재고 수정 결과는2 ? : " + inven_dao.update_inventory_by_order(list_dto.getOrder_num(), list_dto.getS_code()));
		
		///////////////////////////////////// inventory 변경 test 중 ★★★★★★★★★
		
		//[3] 결제된 금액만큼 customers.c_coin 을 업데이트하기 ? 

System.out.println(" order_list dto : " + list_dto.toString());
System.out.println(" 결제전 coin : " + cus_dao.get_customerInfo_by_id(list_dto.getC_id()).getC_coin());
System.out.println(list_dto.getO_totalprice() + " : total 가격!!!!!!!!!! ");
		cus_dao.subtract_coin_in_order(list_dto.getC_id(), list_dto.getO_totalprice());
System.out.println(" 결제후 coin : " + cus_dao.get_customerInfo_by_id(list_dto.getC_id()).getC_coin());
		
		
		//★★★★★★★★★★여기까지 트랜잭션 필요, 예외발생시 돌아갈곳도  
		
		//[4] history.do 로 이동 : 주문내역 보여주기 (이 경우에는 주문내역 상세페이지)
//		alarm_need_check(session, 0);//알람필요?
		return "redirect:history.do?order_num="+list_dto.getOrder_num();
	}
	
	
}//end class