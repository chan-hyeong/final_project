package kosta.finalproject.customer.dto;

public class StoreTDTO {
	private String s_code;
	private String s_name;
	private String s_address;
	private String s_phone;
	private String s_manager;
	private String s_latitude;
	private String s_longitude;
	
	
	
	public String getS_code() {
		return s_code;
	}
	public void setS_code(String s_code) {
		this.s_code = s_code;
	}
	public String getS_address() {
		return s_address;
	}
	public void setS_address(String s_address) {
		this.s_address = s_address;
	}
	public String getS_phone() {
		return s_phone;
	}
	public void setS_phone(String s_phone) {
		this.s_phone = s_phone;
	}
	public String getS_manager() {
		return s_manager;
	}
	public void setS_manager(String s_manager) {
		this.s_manager = s_manager;
	}
	public String getS_latitude() {
		return s_latitude;
	}
	public void setS_latitude(String s_latitude) {
		this.s_latitude = s_latitude;
	}
	public String getS_longitude() {
		return s_longitude;
	}
	public void setS_longitude(String s_longitude) {
		this.s_longitude = s_longitude;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	
	
	@Override
	public String toString() {
		return "StoreTDTO [s_code=" + s_code + ", s_name=" + s_name + ", s_address=" + s_address + ", s_phone="
				+ s_phone + ", s_manager=" + s_manager + ", s_latitude=" + s_latitude + ", s_longitude=" + s_longitude
				+ "]<br>\n";
	}
	
	
	

}
