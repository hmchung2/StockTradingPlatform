package gc.co.kr.realtimestock.service;

import java.util.List;
import java.util.Map;

import gc.co.kr.realtimestock.vo.RealTimeStockVO;

public interface RealTimeStockService {
	
	List<RealTimeStockVO> selectStockByTime(Map<String, String> dates);

}
