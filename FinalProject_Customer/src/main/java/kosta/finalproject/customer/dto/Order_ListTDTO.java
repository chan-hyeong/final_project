package kosta.finalproject.customer.dto;

import java.sql.Timestamp;


public class Order_ListTDTO {
	private int order_num; // NUMBER
	private String c_id; // VARCHAR2(14)
	private String s_code; // VARCHAR2(14)
	private String order_status; // VARCHAR2(12)
	private Timestamp order_date; // DATE
	private int o_totalprice; // NUMBER

	public int getOrder_num() {
		return order_num;
	}

	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}

	public String getC_id() {
		return c_id;
	}

	public void setC_id(String c_id) {
		this.c_id = c_id;
	}

	public String getS_code() {
		return s_code;
	}

	public void setS_code(String s_code) {
		this.s_code = s_code;
	}

	public String getOrder_status() {
		return order_status;
	}

	public void setOrder_status(String order_status) {
		this.order_status = order_status;
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

	@Override
	public String toString() {
		return "Order_ListTDTO [order_num=" + order_num + ", c_id=" + c_id + ", s_code=" + s_code + ", order_status="
				+ order_status + ", order_date=" + order_date + ", o_totalprice=" + o_totalprice + "]";
	}
	
	

	
	
}
