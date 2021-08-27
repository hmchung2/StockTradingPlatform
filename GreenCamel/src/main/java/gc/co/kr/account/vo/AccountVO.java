package gc.co.kr.account.vo;

public class AccountVO {
	private String gcaNumber;
	private String id;
	private String gcaPassword;
	private int balance;
	private String regDate;
	private String nick;
	
	public AccountVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getGcaNumber() {
		return gcaNumber;
	}
	
	public void setGcaNumber(String gcaNumber) {
		this.gcaNumber = gcaNumber;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getGcaPassword() {
		return gcaPassword;
	}
	
	public void setGcaPassword(String gcaPassword) {
		this.gcaPassword = gcaPassword;
	}
	
	public int getBalance() {
		return balance;
	}
	
	public void setBalance(int balance) {
		this.balance = balance;
	}

	public String getRegDate() {
		return regDate;
	}
	
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "AccountVO [gcaNumber=" + gcaNumber + ", id=" + id + ", gcaPassword=" + gcaPassword + ", balance="
				+ balance + ", regDate=" + regDate + ", nick=" + nick + "]";
	}


}
