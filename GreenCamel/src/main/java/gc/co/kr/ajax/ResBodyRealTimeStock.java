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


/*

			<div class="box box-one">
		<div class="box-header with-border box-one-header">
		<button  id="modal-one"  type="button" class="waves-effect waves-light btn btn-default mb-5 add-symbol" data-bs-toggle="modal" data-bs-target="#modal-center" onclick="initData('one')"> 
			종목<i class="mdi mdi-plus-box"></i>
		</button>
		<div class="btn-group">
		  <button class="waves-effect waves-light btn btn-default mb-5  dropdown-toggle" type="button" data-bs-toggle="dropdown">그래프 종류</button>
		  <div class="dropdown-menu dropdown-menu-end">
			<a class="dropdown-item line-one" onclick="graphType('one' ,'line')"  href="#">라인</a>
			<a class="dropdown-item candle-one" onclick="graphType('one' ,'candle')"  href="#">양초</a>
		  </div> 										  
		</div>
		<div class="btn-group">
		  <button class="waves-effect waves-light btn btn-default mb-5  dropdown-toggle" type="button" data-bs-toggle="dropdown">틱</button>
		  <div class="dropdown-menu dropdown-menu-end">
			<a class="dropdown-item tic-one" onclick="tic('one' , 10  )" href="#">10초</a>
			<a class="dropdown-item tic-one" onclick="tic('one' , 30  )"  href="#">30초</a>
			<a class="dropdown-item tic-one" onclick="tic('one' , 60  )"  href="#">60초</a>
			<a class="dropdown-item tic-one" onclick="tic('one' , 300  )"  href="#">5분</a>
			<a class="dropdown-item tic-one" onclick="tic('one' , 1800  )"  href="#">30분</a>
			<a class="dropdown-item tic-one" onclick="tic('one' , 3600  )"  href="#">1시간</a>
			<a class="dropdown-item tic-one" onclick="tic('one' , 10800  )"  href="#">3시간</a>
			<a class="dropdown-item tic-one" onclick="tic('one' , 86400  )"  href="#">하루</a>
		  </div> 										  
		</div>																				
		<button type="button" class="waves-effect waves-light btn btn-default mb-5 start-one" onclick="start('one')">
			실시간 출력 <i class="fa fa-play"></i>									
		</button>
		<button type="button" class="waves-effect waves-light btn btn-default mb-5 stop-one" onclick="stop('one')">
			고정 <i class="fa fa-stop"></i>									
		</button>
		</div>
		<h4 class="box-title"></h4>
		<div class="box-body box-one-body">
		<div class="chart">
			<div></div>
		</div>
								</div>
		test = null
		//allSymbols  = ["AAPL" , "HD" ]
		allSymbols  = []
		chartDict = {};
		dataDict = {};
		
		
		clicked_box = "none";
		box_counts = 0;
		
		each_box = {"symbol" : null,
					"type" : "candlestick",
					"tic" : 300,
					"realtime-flag" : false}
		box_info = {"one" : each_box , 
					"two" : each_box,
					"three" : each_box}	

/*
<div class="row">
	<div class="col">
		<div class="box h-500 box-one">
			<div class="box-header with-border box-one-header">
				<button class="init-modal" id="modal-one"  type="button" class="waves-effect waves-light btn btn-default mb-5" data-bs-toggle="modal" data-bs-target="#modal-center">
					종목 추가<i class="mdi mdi-plus-box"></i>
				</button>
			
			</div>
			<h4 class="box-title"></h4>
		</div>
		<div class="box-body box-one-body">
			<div class="chart">
				<div></div>
			</div>
		</div>
	</div>					
</div>*/

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
		int fullTime = Integer.parseInt(request.getParameter("fullTime")); 		
		 
		List<String> symbolList  = Arrays.asList(request.getParameter("symbols").split(","));
		for(String s : symbolList  ) {
			System.out.println("s : "  + s);
		}
		params.put("interval", interval);
		params.put("fullTime" , fullTime);
		params.put("symbolList", symbolList);
		result = service.getInitValues(params);
		for(Map<String,Object> m : result) {
			System.out.println(m.get("grp_id"));
		}
		
		
		return result;		
	}	
}
