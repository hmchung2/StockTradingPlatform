package gc.co.kr.realtimestock.dao;

import java.util.List;
import java.util.Map;

import gc.co.kr.realtimestock.vo.RealTimeStockVO;

public interface RealTimeStockDAO {
	
	List<RealTimeStockVO> selectStockByTime(Map<String, String> dates);

}
