package gc.co.kr.stocksummary.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import gc.co.kr.stocksummary.vo.StockNameVO;
import gc.co.kr.stocksummary.vo.StockSummaryVO;

@Repository
public class StockSummaryDAOImpl implements StockSummaryDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Autowired
	private SqlSession session;

	@Override
	public List<StockSummaryVO> selectCurrentStockSummary(List<String> symbols) {
		// TODO Auto-generated method stub
		List<StockSummaryVO> summaryList =  sqlSessionTemplate.selectList("summarystock.SummaryStockDAO.selectCurrentStockSummary" ,symbols);
		return summaryList;
		
		
	}

	@Override
	public List<StockNameVO> selectAllStockNames() {
		List<StockNameVO> stockNamesVO = sqlSessionTemplate.selectList("summarystock.SummaryStockDAO.selectAllStockNames");
		return stockNamesVO;
	}
}
