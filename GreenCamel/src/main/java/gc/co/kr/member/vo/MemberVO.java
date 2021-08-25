package gc.co.kr.member.vo;

public class MemberVO {
	private String id;
	private int userType;
	private String email;
	private String phone;
	private String regDate;
	private String password;
	private String name;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getUserType() {
		return userType;
	}
	public void setUserType(int userType) {
		this.userType = userType;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "MemberVO [id=" + id + ", userType=" + userType + ", email=" + email + ", phone=" + phone + ", regDate="
				+ regDate + ", password=" + password + ", name=" + name + "]";
	}
	public MemberVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	

}
