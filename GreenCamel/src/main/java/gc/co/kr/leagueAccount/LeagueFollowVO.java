package gc.co.kr.leagueAccount;

public class LeagueFollowVO {
	private int no;
	private String followerId;
	private String followedId;
	private String followPrice;
	private String followDate;
		
	public LeagueFollowVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getFollowerId() {
		return followerId;
	}
	public void setFollowerId(String followerId) {
		this.followerId = followerId;
	}
	public String getFollowedId() {
		return followedId;
	}
	public void setFollowedId(String followedId) {
		this.followedId = followedId;
	}
	public String getFollowPrice() {
		return followPrice;
	}
	public void setFollowPrice(String followPrice) {
		this.followPrice = followPrice;
	}
	public String getFollowDate() {
		return followDate;
	}
	public void setFollowDate(String followDate) {
		this.followDate = followDate;
	}
	@Override
	public String toString() {
		return "LeagueFollowVO [no=" + no + ", followerId=" + followerId + ", followedId=" + followedId
				+ ", followPrice=" + followPrice + ", followDate=" + followDate + "]";
	}
	
	
}
