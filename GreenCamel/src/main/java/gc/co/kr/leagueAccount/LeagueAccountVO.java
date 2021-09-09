package gc.co.kr.leagueAccount;

public class LeagueAccountVO {
	private String id;
	private int balance;
	private String regDate;
	private String tier;
	private int followPrice;		
	public LeagueAccountVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public float getBalance() {
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
	public String getTier() {
		return tier;
	}
	public void setTier(String tier) {
		this.tier = tier;
	}
	public int getFollowPrice() {
		return followPrice;
	}
	public void setFollowPrice(int followPrice) {
		this.followPrice = followPrice;
	}
	
	@Override
	public String toString() {
		return "LeagueAccountVO [id=" + id + ", balance=" + balance + ", regDate=" + regDate + ", tier=" + tier
				+ ", followPrice=" + followPrice + "]";
	}
	
}




