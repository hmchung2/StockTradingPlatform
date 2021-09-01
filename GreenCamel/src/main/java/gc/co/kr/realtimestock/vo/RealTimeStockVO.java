package gc.co.kr.realtimestock.vo;

public class RealTimeStockVO {
	private int inorder;
	private String time;
	private String symbol;
	private float marketPrice;
	private int shareOutstanding;
	private float avgDailyVolume10day;
	private float avgDailyVolume3month;
	private float dividendsPerShare;
	private float bid;
	private float ask;
	private float bidSize;
	private float askSize;
	private int floatingShares;
	private float shortRatio;
	private float epsForward;
	private float bookValue;
	private int sharesShort;
	private float dividendsYield;
	private float marketChange;
	private float marketChangePercent;
	private float marketDayHigh;
	private float marketDayLow;
	private float marketVolume;
		
	@Override
	public String toString() {
		return "RealTimeStockVO [inorder=" + inorder + ", time=" + time + ", symbol=" + symbol + ", marketPrice="
				+ marketPrice + ", shareOutstanding=" + shareOutstanding + ", avgDailyVolume10day="
				+ avgDailyVolume10day + ", avgDailyVolume3month=" + avgDailyVolume3month + ", dividendsPerShare="
				+ dividendsPerShare + ", bid=" + bid + ", ask=" + ask + ", bidSize=" + bidSize + ", askSize=" + askSize
				+ ", floatingShares=" + floatingShares + ", shortRatio=" + shortRatio + ", epsForward=" + epsForward
				+ ", bookValue=" + bookValue + ", sharesShort=" + sharesShort + ", dividendsYield=" + dividendsYield
				+ ", marketChange=" + marketChange + ", marketChangePercent=" + marketChangePercent + ", marketDayHigh="
				+ marketDayHigh + ", marketDayLow=" + marketDayLow + ", marketVolume=" + marketVolume + "]";
	}
	public RealTimeStockVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getInorder() {
		return inorder;
	}
	public void setInorder(int inorder) {
		this.inorder = inorder;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getSymbol() {
		return symbol;
	}
	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}
	public float getMarketPrice() {
		return marketPrice;
	}
	public void setMarketPrice(float marketPrice) {
		this.marketPrice = marketPrice;
	}
	public int getShareOutstanding() {
		return shareOutstanding;
	}
	public void setShareOutstanding(int shareOutstanding) {
		this.shareOutstanding = shareOutstanding;
	}
	public float getAvgDailyVolume10day() {
		return avgDailyVolume10day;
	}
	public void setAvgDailyVolume10day(float avgDailyVolume10day) {
		this.avgDailyVolume10day = avgDailyVolume10day;
	}
	public float getAvgDailyVolume3month() {
		return avgDailyVolume3month;
	}
	public void setAvgDailyVolume3month(float avgDailyVolume3month) {
		this.avgDailyVolume3month = avgDailyVolume3month;
	}
	public float getDividendsPerShare() {
		return dividendsPerShare;
	}
	public void setDividendsPerShare(float dividendsPerShare) {
		this.dividendsPerShare = dividendsPerShare;
	}
	public float getBid() {
		return bid;
	}
	public void setBid(float bid) {
		this.bid = bid;
	}
	public float getAsk() {
		return ask;
	}
	public void setAsk(float ask) {
		this.ask = ask;
	}
	public float getBidSize() {
		return bidSize;
	}
	public void setBidSize(float bidSize) {
		this.bidSize = bidSize;
	}
	public float getAskSize() {
		return askSize;
	}
	public void setAskSize(float askSize) {
		this.askSize = askSize;
	}
	public int getFloatingShares() {
		return floatingShares;
	}
	public void setFloatingShares(int floatingShares) {
		this.floatingShares = floatingShares;
	}
	public float getShortRatio() {
		return shortRatio;
	}
	public void setShortRatio(float shortRatio) {
		this.shortRatio = shortRatio;
	}
	public float getEpsForward() {
		return epsForward;
	}
	public void setEpsForward(float epsForward) {
		this.epsForward = epsForward;
	}
	public float getBookValue() {
		return bookValue;
	}
	public void setBookValue(float bookValue) {
		this.bookValue = bookValue;
	}
	public int getSharesShort() {
		return sharesShort;
	}
	public void setSharesShort(int sharesShort) {
		this.sharesShort = sharesShort;
	}
	public float getDividendsYield() {
		return dividendsYield;
	}
	public void setDividendsYield(float dividendsYield) {
		this.dividendsYield = dividendsYield;
	}
	public float getMarketChange() {
		return marketChange;
	}
	public void setMarketChange(float marketChange) {
		this.marketChange = marketChange;
	}
	public float getMarketChangePercent() {
		return marketChangePercent;
	}
	public void setMarketChangePercent(float marketChangePercent) {
		this.marketChangePercent = marketChangePercent;
	}
	public float getMarketDayHigh() {
		return marketDayHigh;
	}
	public void setMarketDayHigh(float marketDayHigh) {
		this.marketDayHigh = marketDayHigh;
	}
	public float getMarketDayLow() {
		return marketDayLow;
	}
	public void setMarketDayLow(float marketDayLow) {
		this.marketDayLow = marketDayLow;
	}
	public float getMarketVolume() {
		return marketVolume;
	}
	public void setMarketVolume(float marketVolume) {
		this.marketVolume = marketVolume;
	} 
	
	
	
}

//"regularMarketPrice" : "MARKET_PRICE",
//"sharesOutstanding" : "SHARE_OUTSTANDING",
//"averageDailyVolume10Day" : "AVG_DAILY_VOLUME10DAY",
//"averageDailyVolume3Month" : "AVG_DAILY_VOLUME3MONTH",
//"dividendsPerShare" : "DIVIDENDS_PER_SHARE",
//"bid" : "BID",
//"ask" : "ASK",
//"bidSize" : "BID_SIZE",
//"askSize" : "ASK_SIZE",
//"floatShares" : "FLOATING_SHARES",
//"shortRatio" : "SHORT_RATIO",
//"epsForward" : "EPS_FORWARD",
//"bookValue" : "BOOK_VALUE",
//"sharesShort" : "SHARES_SHORT",
//"dividendYield" : "DIVIDENDS_YIELD",
//"regularMarketChange" : "MARKET_CHANGE",
//"regularMarketChangePercent" : "MARKET_CHANGE_PERCENT",
//"regularMarketDayHigh" : "MARKET_DAY_HIGH",
//"regularMarketDayLow" : "MARKET_DAT_LOW",
//"regularMarketVolume" : "MARKET_VOLUME"