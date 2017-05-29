package kosta.finalproject.customer.dto;

public class TestDTO {

	private String i_code;
	private int i_amount;
	private int changed_i_amount;
	@Override
	public String toString() {
		return "TestDTO [" + i_code + ", " + i_amount + ", " + changed_i_amount + "]\n";
	}
	public String getI_code() {
		return i_code;
	}
	public void setI_code(String i_code) {
		this.i_code = i_code;
	}
	public int getI_amount() {
		return i_amount;
	}
	public void setI_amount(int i_amount) {
		this.i_amount = i_amount;
	}
	public int getChanged_i_amount() {
		return changed_i_amount;
	}
	public void setChanged_i_amount(int changed_i_amount) {
		this.changed_i_amount = changed_i_amount;
	}
	public TestDTO(String i_code, int i_amount, int changed_i_amount) {
		super();
		this.i_code = i_code;
		this.i_amount = i_amount;
		this.changed_i_amount = changed_i_amount;
	}
	public TestDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	
}
