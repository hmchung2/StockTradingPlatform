package gc.co.kr.ajax;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import gc.co.kr.stocksummary.service.StockSummaryService;
import gc.co.kr.stocksummary.vo.StockNameVO;
import gc.co.kr.stocksummary.vo.StockSummaryVO;

@Controller
@RequestMapping("/ajax")
public class ResBodySummaryStock {
	
	
	@Autowired
	private StockSummaryService service;
	
	
	
	@RequestMapping("/getAllSummaryData")
	@ResponseBody
	public List<StockSummaryVO> getAllsummaryData(HttpServletRequest request){				
		List<StockSummaryVO> stockSummaryList = null;
		List<StockNameVO> stockNameList =  service.selectAllStockNames();
		List<String>  symbols= new ArrayList<String>();
		if(stockNameList != null && stockNameList.size() > 0) {			
			for(StockNameVO stock : stockNameList) {
				symbols.add(stock.getSymbol());
			}
			
			stockSummaryList = service.selectCurrentStockSummary(symbols);			
		}
		return stockSummaryList ;		
	}
	
	
}
