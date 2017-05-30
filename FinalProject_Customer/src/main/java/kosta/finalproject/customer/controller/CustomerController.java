package kosta.finalproject.customer.controller;

import static org.hamcrest.CoreMatchers.instanceOf;


import javax.mail.Session;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
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
import kosta.finalproject.customer.dao.InventoryDAO;
import kosta.finalproject.customer.dao.MenuDAO;
import kosta.finalproject.customer.dao.Order_DetailDAO;
import kosta.finalproject.customer.dao.Order_ListDAO;
import kosta.finalproject.customer.dto.CustomersTDTO;
import kosta.finalproject.customer.dto.MenuTDTO;
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
	
	@RequestMapping("/main.do")
	public String main() {
		return "customer/main";
	}

	@RequestMapping("/favorite.do")
	public String favorite() {
		return "customer/favorite";
	}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping("/shoppingbag.do")
	public String shoppingbag(HttpServletRequest request) {
		String c_id = request.getSession().getAttribute("id").toString();
		
		Order_DetailDAO detail_dao = sqlsession.getMapper(Order_DetailDAO.class);
		request.setAttribute("detail_list", detail_dao.order_detail_basket(c_id));

		return "customer/shoppingbag";//장바구니 페이지 보여주기 vs 메뉴 리스트로 다시 돌아가기
	}
}
