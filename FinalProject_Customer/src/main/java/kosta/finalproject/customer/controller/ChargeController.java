package kosta.finalproject.customer.controller;


import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
//
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import kosta.finalproject.customer.dao.ChargeDAO;
import kosta.finalproject.customer.dao.CustomersDAO;
import kosta.finalproject.customer.dto.CustomersTDTO;

@Controller
public class ChargeController {

	Logger logger = Logger.getLogger(ChargeController.class);
	
	@Autowired
	private SqlSession sqlsession;
	
	/**
	 * charge.do 
	 * 
	 * @return charge.jsp
	 */
	@RequestMapping("charge.do")
	public String charge(HttpServletRequest request, HttpSession session){
			
		logger.debug("charge.do test");
		String c_id = session.getAttribute("id").toString();
		CustomersDAO dao = sqlsession.getMapper(CustomersDAO.class);
		CustomersTDTO customer_info = dao.get_customerInfo_by_id(c_id);
		
		request.setAttribute("RequestURI", request.getRequestURI());//포트 이후 경로
		request.setAttribute("RequestURL", request.getRequestURL());//전부 포함 
		
		request.setAttribute("info", customer_info);
		return "customer/charge";
	}
	
	
	/**
	 * payment ajax method
	 * @param request
	 * @return
	 */
 	@ResponseBody
	@RequestMapping(value="/payments.do", method=RequestMethod.GET)
	public HashMap<String, Object> payments(@RequestParam("coin") int c_coin, HttpServletRequest request, HttpSession session, CustomersTDTO dto){
		CustomersDAO customer_dao = sqlsession.getMapper(CustomersDAO.class);

		HashMap<String, Object> chargeRe=new HashMap<String, Object>();
		String c_id = request.getParameter("c_id");
		String uid = request.getParameter("imp_uid");
		//iamport api에서 제공하는 결제 키
		String api_key = "4582535957834535"; //imp42758107
		String api_secret = "rIenjGaLd4ZLrzK2iApJ7Jiz248QfcyHVM4etfZGjZrLycOQNeAUYSu0XCQcPoTKbYZEdZlxYMjxZ8nM";
		
		ChargeDAO charge_dao = sqlsession.getMapper(ChargeDAO.class);
	
		logger.debug(uid);
		logger.debug(c_coin);
		logger.debug(c_id);
		
		int result = charge_dao.coinupdate(c_coin, c_id);
		
		logger.debug(result);
		//해당 결제에 대한 정보들을 불러옴
		IamportClient client = new IamportClient(api_key, api_secret);
		IamportResponse<Payment> payment_response = client.paymentByImpUid(uid);
		
		Payment rsp = payment_response.getResponse();
		
		chargeRe.put("rsp", rsp);
		chargeRe.put("success", true);
		System.out.println("결제성공");
		
		session.setAttribute("c_coin", customer_dao.get_customerInfo_by_id(dto.getC_id()).getC_coin());
		
		return chargeRe;
	}
	
	
}//end class