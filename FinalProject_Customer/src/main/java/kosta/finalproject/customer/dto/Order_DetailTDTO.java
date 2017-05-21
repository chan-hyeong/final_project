package kosta.finalproject.customer.dto;

public class Order_DetailTDTO {
	private int order_num;

	private int m_code;

	private String o_pan;

	private String m_necessary1;
	private int m_necessary1_num;

	private String m_necessary2;
	private int m_necessary2_num;

	private String m_necessary3;
	private int m_necessary3_num;

	private String m_necessary4;
	private int m_necessary4_num;

	@Override
	public String toString() {
		return "Order_DetailTDTO [order_num=" + order_num + ", m_code=" + m_code + ", o_pan=" + o_pan
				+ ", m_necessary1=" + m_necessary1 + ", m_necessary1_num=" + m_necessary1_num + ", m_necessary2="
				+ m_necessary2 + ", m_necessary2_num=" + m_necessary2_num + ", m_necessary3=" + m_necessary3
				+ ", m_necessary3_num=" + m_necessary3_num + ", m_necessary4=" + m_necessary4 + ", m_necessary4_num="
				+ m_necessary4_num + "]";
	}

}
