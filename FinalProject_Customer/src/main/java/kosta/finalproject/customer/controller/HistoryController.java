package kosta.finalproject.customer.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kosta.finalproject.customer.dao.HistoryDAO;
import kosta.finalproject.customer.dao.Order_ListDAO;
import kosta.finalproject.customer.dto.Order_ListTDTO;

@Controller
public class HistoryController {

	@Autowired
	private SqlSession sqlsession;

	//history detail ajax 처리 method
	@ResponseBody
	@RequestMapping(value="/historydetail.do", method=RequestMethod.GET)
	public List<HashMap<String, String>> history_detail(HttpServletRequest request, HttpSession session,
														@RequestParam("order_num") int order_num) {
		
		HistoryDAO detail_dao = sqlsession.getMapper(HistoryDAO.class);
		List<HashMap<String, String>> list =detail_dao.historydetail(order_num);

		return list;
	}
	
	//히스토리 디테일 : ajax 이용해서 detail 페이지를 작성, 보낸다 
	@RequestMapping(value="/historydetailtest.do", method=RequestMethod.GET)
	public String history_detail_test(HttpServletRequest request, HttpSession session,
			@RequestParam("order_num") int order_num) {
		
		HistoryDAO detail_dao = sqlsession.getMapper(HistoryDAO.class);
		Order_ListDAO order_dao = sqlsession.getMapper(Order_ListDAO.class);
		List<HashMap<String, String>> list =detail_dao.historydetail(order_num);
		
		for( Order_ListTDTO item : order_dao.get_order_list(session.getAttribute("id").toString())){
			if ( item.getOrder_num() == order_num){ 
				request.setAttribute("orderitem", item);
				System.out.println(item.toString());
				break;
			}
		}
		
		request.setAttribute("order_detail_list", list);
		
		return "customer/history_detail_test";
	}
	
	
	
	//히스토리 진입시 
	@RequestMapping("/history.do")
	public String history(HttpServletRequest request, HttpSession session,
			@RequestParam(name="statuscheck", defaultValue="all")String statuscheck, 
			@RequestParam(name="start", defaultValue="sysdate-30")String start, 
			@RequestParam(name="end", defaultValue="sysdate")String end,
			@RequestParam(name="order_num", defaultValue="0")int order_num) {
		
		if ( session.getAttribute("id") == null){
			return "redirect:loginform.do?result=if you have a Id, please login first~";
		}
		String c_id = session.getAttribute("id").toString();
		
		
		//알람트리거
		order_status_check(session);
		
		HistoryDAO list_dao = sqlsession.getMapper(HistoryDAO.class);
		
		
		System.out.println(start + " , " + end);
		request.setAttribute("orderlist", list_dao.history_get_by_date(c_id, start, end, statuscheck));
		
		//기간 정보도 담기 
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
		Date today = new Date();
		Date target = new Date();
		if ( start.equalsIgnoreCase("sysdate-30") ){
			target.setTime( today.getTime() - ((long)1000*60*60*24*30));//30일전 
			start = sdf.format(target);
		}
		if ( end.equalsIgnoreCase("sysdate"))	 
			end = sdf.format(today);
		
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("statuscheck", statuscheck);
		
		request.setAttribute("order_num", order_num);
	
		return "customer/history";
	}//end 


	/**
	 * 
	 * 1. session null 체크 1-1. null 이라면 session에 담기
	 * 
	 * 2. 있다면 사이즈 체크 2-1. 사이즈 비교 : 다른 경우는 order_status 에 변화가 있는거임 아 그런데 하나가 처리되고
	 * 하나가
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value="checked.do")
	public @ResponseBody List<Integer> order_status_check(HttpSession session) {
		System.out.println("\n\norder_status_check 진입 ");
		HistoryDAO dao = sqlsession.getMapper(HistoryDAO.class);
		String c_id = session.getAttribute("id").toString();

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
				System.out.println("\t session에 담음 " + order_nums.toString()+"\n");
			}else{
				session.setAttribute("slist", order_nums);
			}
		} else {
			//아니라면 session 에서 삭제 
			System.out.println("\t session에서 slist 지움\n");
			session.removeAttribute("slist");
		} 

		System.out.println("\t session에 담긴 slist 값 ("+session.getAttribute("slist").toString() + " \n");
		System.out.println("\t return 할 chaged_order_list 값 ("+chaged_order_nums.size()+"): " + chaged_order_nums.toString() + " \n");
		return chaged_order_nums;// 스크립트 펑션에서 받아볼 list
	}
	// 상태를 확인해야할 놈들을 세션에 담고있다가
	// interval 로 그놈들의 상태를 확인하기
	
	
}//end class