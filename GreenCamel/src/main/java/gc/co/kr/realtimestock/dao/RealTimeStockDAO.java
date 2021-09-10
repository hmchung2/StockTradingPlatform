package gc.co.kr.realtimestock.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import gc.co.kr.realtimestock.vo.RealTimeStockVO;

public interface RealTimeStockDAO {
	
	List<RealTimeStockVO> selectStockByTime(Map<String, String> dates);
	
	List<RealTimeStockVO> selectStockByTimeSymbols(Map<String,Object> params ) ;
	
	List<Map<String,Object>> getInitValues(Map<String,Object> params);
	
	List<Map<String,Object>> getInitValuesLines(Map<String,Object> params);
	
	List<RealTimeStockVO> getRealTimeStockData(Map<String,Object> params);
}
