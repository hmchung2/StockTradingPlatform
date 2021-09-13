package gc.co.kr.stocksummary.dao;

import java.util.List;

import gc.co.kr.stocksummary.vo.StockNameVO;
import gc.co.kr.stocksummary.vo.StockSummaryVO;

public interface StockSummaryDAO {
	
	List<StockSummaryVO> selectCurrentStockSummary( List<String> symbols  );
	
	List<StockNameVO> selectAllStockNames();
	
}
