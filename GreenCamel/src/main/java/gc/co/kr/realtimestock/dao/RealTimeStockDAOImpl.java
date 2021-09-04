package gc.co.kr.realtimestock.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import gc.co.kr.realtimestock.vo.RealTimeStockVO;

@Repository
public class RealTimeStockDAOImpl implements RealTimeStockDAO{

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<RealTimeStockVO> selectStockByTime(Map<String,String> dates ) {
		List<RealTimeStockVO> stockList = sqlSessionTemplate.selectList("realtimestock.RealTimeStockDAO.selectByTimeRange" ,dates);
		return stockList;
	}
	
	@Override
	public List<RealTimeStockVO> selectStockByTimeSymbols(Map<String , String> dates , List<String> symbols){
		String symbolStr = String.join(",", symbols);
		System.out.println(symbolStr);
		dates.put("symbols", symbolStr);		
		List<RealTimeStockVO> stockList = sqlSessionTemplate.selectList("realtimestock.RealTimeStockDAO.selectByTimeRangeSymbols" , dates );		
		return stockList;
	}

}
