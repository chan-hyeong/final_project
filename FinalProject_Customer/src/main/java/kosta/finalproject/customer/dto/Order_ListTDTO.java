package kosta.finalproject.customer.dto;

import java.util.Date;

public class Order_ListTDTO {
	private int order_num;
	private String c_id;
	private String s_code;
	private String order_status;
	private Date order_date;
	private int o_totalprice;
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
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public int getO_totalprice() {
		return o_totalprice;
	}
	public void setO_totalprice(int o_totalprice) {
		this.o_totalprice = o_totalprice;
	}
	
}
