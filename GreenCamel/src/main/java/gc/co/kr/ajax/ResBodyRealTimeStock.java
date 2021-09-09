package gc.co.kr.ajax;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
	public List<RealTimeStockVO> getRealTimeStock(HttpServletRequest request ){		
		//yyyy-MM-DD-HH24:MI:SS
		Map<String, Object> params = new HashMap<String , Object>();
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		List<String> symbolList = Arrays.asList( request.getParameter("symbols").split(","));		
		System.out.println(symbolList);
		System.out.println(symbolList);		
		System.out.println(start + " : "  + end);
		params.put("start", start);
		params.put("end", end);
		params.put("symbolList", symbolList);
		List<RealTimeStockVO> list= service.selectStockByTimeSymbols(params);
		for(RealTimeStockVO l : list) {
			System.out.println(l);
		}
		
		List<RealTimeStockVO> result = null;
		if(list != null && list.size() > 0) {
			result = list;			
		}
		return result;
	}
	
	@RequestMapping("/getInitStockValues.json")
	@ResponseBody
	public List<Map<String,Object>> getInitValues(HttpServletRequest request){		
		List<Map<String,Object>> result = null;		
		Map<String,Object> params = new HashMap<String  , Object>();
		int interval =  Integer.parseInt(request.getParameter("interval"));		
		//int fullTime = 10 * interval;
		int fullTime  = 1630460051;
		
		List<String> symbolList  = Arrays.asList(request.getParameter("symbols").split(","));		
		params.put("interval", interval);
		params.put("fullTime" , fullTime);
		params.put("symbolList", symbolList);
		result = service.getInitValues(params);					
		return result;		
	}	
}
