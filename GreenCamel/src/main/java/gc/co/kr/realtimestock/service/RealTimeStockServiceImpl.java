package gc.co.kr.realtimestock.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gc.co.kr.realtimestock.dao.RealTimeStockDAO;
import gc.co.kr.realtimestock.vo.RealTimeStockVO;

@Service
public class RealTimeStockServiceImpl implements RealTimeStockService{

	@Autowired
	private RealTimeStockDAO realTimeStockDAO;
	
	@Override
	public List<RealTimeStockVO> selectStockByTime(Map<String, String> dates) {
		// TODO Auto-generated method stub		
		List<RealTimeStockVO> list = realTimeStockDAO.selectStockByTime(dates);
		return list;
	}

	@Override
	public List<RealTimeStockVO> selectStockByTimeSymbols(Map<String, Object> params) {		
		List<RealTimeStockVO> list = realTimeStockDAO.selectStockByTimeSymbols(params);
		return list;
	}

	@Override
	public List<Map<String, Object>> getInitValues(Map<String, Object> params) {		
		List<Map<String,Object>> candleList = realTimeStockDAO.getInitValues(params);		
		return candleList ;
	}

	@Override
	public List<Map<String, Object>> getInitValuesLines(Map<String, Object> params) {
		// TODO Auto-generated method stub
		List<Map<String,Object>> lineList = realTimeStockDAO.getInitValuesLines(params);		
		return lineList ;
	}

	@Override
	public List<RealTimeStockVO> getRealTimeStockData(Map<String, Object> params) {
		// TODO Auto-generated method stub
		List<RealTimeStockVO> result = realTimeStockDAO.getRealTimeStockData(params);		
		return result;
	}

	@Override
	public RealTimeStockVO getRealTimeStockDataLine(Map<String, Object> params) {
		// TODO Auto-generated method stub
		RealTimeStockVO result = realTimeStockDAO.getRealTimeStockDataLine(params);
		return result;
	}	
}
