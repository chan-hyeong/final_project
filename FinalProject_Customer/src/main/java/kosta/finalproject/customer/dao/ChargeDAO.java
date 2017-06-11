package kosta.finalproject.customer.dao;

public interface ChargeDAO {
	/**
	 * 
	 * 회원의 코인 업데이트 
	 * 
	 * @param c_coin
	 * @param c_id
	 * @return
	 */
	public int coinupdate(int c_coin, String c_id);

}
