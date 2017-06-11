package kosta.finalproject.customer.dao;

import kosta.finalproject.customer.dto.CustomersTDTO;

public interface CustomersDAO {
	/**
	 * joinform에서 사용자가 입력한 c_id의 중복여부를 판단
	 * 
	 * @param customer_dto
	 *            : 에서 c_id 만 사용 <--바꿔야할까?
	 * @return 중복된 id 가 없다면 0, 그외는 중복이다
	 */
	public int check_id_duplication(CustomersTDTO customer_dto);

	/**
	 * joinform 에서 유효성맞게 입력된 정보를 customers 테이블에 추가 == 회원가입
	 * 
	 * @param customer_dto
	 *            : joinform 에 사용자가 입력한 값들
	 * @return return 값이 1이면 가입성공
	 */
	public int insert_into_Customers(CustomersTDTO customer_dto);

	/**
	 * 로그인
	 * 
	 * @param customer_dto
	 *            : loginform 에서 사용자가 입력한 id, pw
	 * @return id, pw가 일치하면 1 을 리턴
	 */
	public int login_id_pw_check(CustomersTDTO customer_dto);

	/**
	 * 회원정보 수정 페이지에서 보여질 회원정보
	 * 
	 * @param c_id
	 *            : 사용자 id
	 * @return : 모든정보 
	 */
	public CustomersTDTO get_customerInfo_by_id(String c_id);

	/**
	 * 회원정보 수정 페이지에서 수정된 정보를 dto타입으로 받아서 update를 수행한다
	 * 
	 * @param customer_dto
	 *            : 변경 or 유지된 모든 정보
	 */
	public int update_customerInfo(CustomersTDTO customer_dto);

	
	
	///여기는 결제하는 dao로 가야할듯?★★★★★★★★★★
	/**
	 * 주문시 결제를 하면 해당금액이 차감됨 coin < o_totalprice 라면 에러가 날것임 예외처리를 여기서 걸어줘야겠다
	 * 
	 * @param c_id
	 *            : 결제하는사람의 id
	 * @param o_totalprice
	 *            : 결제금액 <-- 결제api 에서 리턴한 값
	 * @return update된 행의 수 (1) 를 리턴
	 */
	public int subtract_coin_in_order(String c_id, int o_totalprice);

}// end class