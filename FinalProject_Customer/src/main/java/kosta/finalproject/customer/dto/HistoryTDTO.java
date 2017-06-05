package kosta.finalproject.customer.dto;

import java.sql.Timestamp;

public class HistoryTDTO {
	private int order_num;
	private int num_of_item;
	private String m_code;
	private String s_code;
	private Timestamp order_date;
	private String order_status;
	private int o_totalprice;
	
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	public String getM_code() {
		return m_code;
	}
	public void setM_code(String m_code) {
		this.m_code = m_code;
	}
	public String getS_code() {
		return s_code;
	}
	public void setS_code(String s_code) {
		this.s_code = s_code;
	}
	public Timestamp getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Timestamp order_date) {
		this.order_date = order_date;
	}
	public int getO_totalprice() {
		return o_totalprice;
	}
	public void setO_totalprice(int o_totalprice) {
		this.o_totalprice = o_totalprice;
	}


	public int getNum_of_item() {
		return num_of_item;
	}


	public void setNum_of_item(int num_of_item) {
		this.num_of_item = num_of_item;
	}



	public String getOrder_status() {
		return order_status;
	}



	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}
	@Override
	public String toString() {
		return "HistoryTDTO [order_num=" + order_num + ", num_of_item=" + num_of_item + ", m_code=" + m_code
				+ ", s_code=" + s_code + ", order_date=" + order_date + ", order_status=" + order_status
				+ ", o_totalprice=" + o_totalprice + "]<br>\n";
	}
	
	
	
}
