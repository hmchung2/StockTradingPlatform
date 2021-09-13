package gc.co.kr.stocksummary.vo;

public class StockNameVO {
	

	private String symbol;
	private String longName;
	private String path;
	private String sector;
	private String phone;
	private String website;
	
	
	public StockNameVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public String getSymbol() {
		return symbol;
	}
	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}
	public String getLongName() {
		return longName;
	}
	public void setLongName(String longName) {
		this.longName = longName;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}

	public String getSector() {
		return sector;
	}
	public void setSector(String sector) {
		this.sector = sector;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}


	@Override
	public String toString() {
		return "StockNameVO [symbol=" + symbol + ", longName=" + longName + ", path=" + path + ", sector=" + sector
				+ ", phone=" + phone + ", website=" + website + "]";
	}

	
	
}
