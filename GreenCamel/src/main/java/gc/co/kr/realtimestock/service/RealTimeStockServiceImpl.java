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
}
