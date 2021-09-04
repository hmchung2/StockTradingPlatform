package gc.co.kr.ajax;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import gc.co.kr.realtimestock.service.RealTimeStockService;
import gc.co.kr.realtimestock.vo.RealTimeStockVO;

@Controller
@RequestMapping("/ajax")
public class ResBodyRealTimeStock {

	@Autowired
	private RealTimeStockService service;
	
	
	@RequestMapping("/realTimeStock.json")
	@ResponseBody
	public RealTimeStockVO getRealTimeStock(@RequestParam("start") String start , @RequestParam("end") String end  ){
		//yyyy-MM-DD-HH24:MI:SS
		Map<String, String> dates = new HashMap<String , String>();
		dates.put("start", start);
		dates.put("end", end);
		List<RealTimeStockVO> list= service.selectStockByTime(dates);
		RealTimeStockVO result = null;
		if(list != null && list.size() > 0) {
			result = list.get(list.size() - 1);			
		}
		return result;
	}
}
