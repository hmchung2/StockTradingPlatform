package gc.co.kr.realtimestock.service;

import java.util.List;
import java.util.Map;

import gc.co.kr.realtimestock.vo.RealTimeStockVO;

public interface RealTimeStockService {
	
	List<RealTimeStockVO> selectStockByTime(Map<String, String> dates);
	
	List<RealTimeStockVO> selectStockByTimeSymbols(Map<String,Object> params );

	List<Map<String,Object>> getInitValues(Map<String,Object> params);
	
	List<Map<String,Object>> getInitValuesLines(Map<String,Object> params);
	
	List<RealTimeStockVO> getRealTimeStockData(Map<String,Object> params);
}
