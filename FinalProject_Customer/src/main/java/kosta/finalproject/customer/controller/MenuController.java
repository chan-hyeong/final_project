package kosta.finalproject.customer.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kosta.finalproject.customer.dao.MenuDAO;
import kosta.finalproject.customer.dto.MenuTDTO;

@Controller
public class MenuController {

	@Autowired
	private SqlSession sqlsession;

	@RequestMapping("/orderdetail.do")
	public String orderdetail(HttpServletRequest request, @RequestParam("m_code") String m_code) {
		MenuDAO dao = sqlsession.getMapper(MenuDAO.class);
		request.setAttribute("menudto", dao.menudetail(m_code));
		List<MenuTDTO> option_bread = new ArrayList<MenuTDTO>(), option_sauces = new ArrayList<MenuTDTO>(),
				option_extra = new ArrayList<MenuTDTO>(), option_vege = new ArrayList<MenuTDTO>();
		for (MenuTDTO item : dao.menuoption()) {
			if (item.getM_group().equalsIgnoreCase("bread"))
				option_bread.add(item);
			else if (item.getM_group().equalsIgnoreCase("sauces"))
				option_sauces.add(item);
			else if (item.getM_group().equalsIgnoreCase("add_option"))
				option_extra.add(item);
			else if (item.getM_group().equalsIgnoreCase("vegetable"))
				option_vege.add(item);
		}

		System.out.println("\t" + option_bread.toString());
		System.out.println("\t" + option_extra.toString());
		System.out.println("\t" + option_sauces.toString());
		System.out.println("\t" + option_vege.toString());

		// request.setAttribute("option",dao.menuoption());
		request.setAttribute("option_bread", option_bread);
		request.setAttribute("option_sauces", option_sauces);
		request.setAttribute("option_extra", option_extra);
		request.setAttribute("option_vege", option_vege);

		// System.out.println(dao.menuoption().toString());

		return "customer/orderdetail";
	}

	@RequestMapping("/menulist.do")
	public String menulist(HttpServletRequest request) {
		MenuDAO dao = sqlsession.getMapper(MenuDAO.class);
		request.setAttribute("menulist", dao.menulist());
		request.setAttribute("url", getClass().getResource("/img"));
		return "customer/menulist";
	}

}
