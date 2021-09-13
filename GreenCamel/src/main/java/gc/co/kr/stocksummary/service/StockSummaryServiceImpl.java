package gc.co.kr.stocksummary.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gc.co.kr.stocksummary.dao.StockSummaryDAO;
import gc.co.kr.stocksummary.vo.StockNameVO;
import gc.co.kr.stocksummary.vo.StockSummaryVO;

@Service
public class StockSummaryServiceImpl implements StockSummaryService{

	@Autowired
	private StockSummaryDAO stockSummaryDAO;
	
	
	@Override
	public List<StockSummaryVO> selectCurrentStockSummary(List<String> symbols) {		
		List<StockSummaryVO> list = stockSummaryDAO.selectCurrentStockSummary(symbols);		
		return list;
		
	}


	@Override
	public List<StockNameVO> selectAllStockNames() {
		// TODO Auto-generated method stub
		List<StockNameVO> list = stockSummaryDAO.selectAllStockNames();
		return list;
	}
}
