<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="${ pageContext.request.contextPath }/resources/images/favicon.ico">
<title>GreenCamel</title>
<!-- Vendors Style-->
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/dash/css/vendors_css.css">

<link href="https://www.amcharts.com/lib/3/plugins/export/export.css" rel="stylesheet" type="text/css" />

<!-- Style-->
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/dash/css/style.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/dash/css/skin_color.css">
<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/jquery-3.6.0.min.js"></script>
<script>
/* 	
	function getRealTimeData() {
		$.ajax({type : 'get',
		url : "${pageContext.request.contextPath }/ajax/realTimeStock.json",
		data : {start : "2021-08-31-17:37:20",
				end : "2021-08-31-17:40:50",
				symbols : allSymbols.join(",")
		},
		contentType : "application/x-www-form-urlencoded;charset=ISO-8859-15",
		datatype : 'json',
		success : function(data) {
			console.log(data)
			console.log("success")
			test = data
			for(let i in data){
				allSymbolInfo[ data[i].symbol ] = data[i]
			}
		},
		error : function() {
			console.log("error")
			}
		})
	}
 */

		
		allSymbols  = []
		chartDict = {};
 		dataDict = {}
						
		clicked_box = "none";
		box_counts = 0;		
		realdata = {}
		
		
		
		box_info = {}
		box_info["one"] =  {"symbol" : null,
				"type" : "candlestick",
				"tic" : 1800,
				"realtime-flag" : false,
				"start_date": null,
				"end_date" : null}
		box_info["two"] =  {"symbol" : null,
				"type" : "candlestick",
				"tic" : 1800,
				"realtime-flag" : false,
				"start_date": null,
				"end_date" : null}
		box_info["three"] =  {"symbol" : null,
				"type" : "candlestick",
				"tic" : 1800,
				"realtime-flag" : false,
				"start_date": null,
				"end_date" : null}		
		
		if (localStorage.getItem("allSymbols") != null
				&& localStorage.getItem("allSymbols") != "") {
			allSymbols = localStorage.getItem("allSymbols").split(",")
		}			
	
		var oneInterval;
		oneIntervalFlag = false
		var twoInterval;
		twoIntervalFlag = false;
		var threeInterval;
		threeInterval = false;
		
		function startIntervalOne(  symbol , tic , type  ){	
			if(oneIntervalFlag){
				clearInterval(oneInterval)
			}
			if( type == "candlestick"){
				console.log("candle real time data started")
				oneInterval = setInterval(function(){
					$.ajax({type : 'get',
			      		url : "${pageContext.request.contextPath }/ajax/getRealTimeStock.json",
			      		data : {interval : tic,
			      				symbol : symbol,
			      				startTime : 1631200787,  // ~~(Date. now() / 1000) - tic,
			      				endTime :   1631300887  // ~~(Date. now() / 1000) 
			      		},
			      		contentType : "application/x-www-form-urlencoded;charset=ISO-8859-15",
			      		datatype : 'json',
			      		success : function(result) {	      			
			      			console.log("one real time success")
			      			
			      			
			      			dataDict[box_info["one"]["symbol"]].push(
			      					{
			      						x : new Date(parseInt(result.unixTime) * 1000),  
			   							y : [result.firstPrice, 
			   								result.maxPrice,
			   								result.minPrice,
			   								result.lastPrice]	
			      						}					      			
			      			)
			      			if(dataDict[box_info["one"]["symbol"]].length > 500){
			      				console.log("over 500 data deleting")
			      				for (var i = dataDict[box_info["one"]["symbol"]].length  - 1; i >= 0; i--) {
									  // remove element if index is odd
								  if (i % 2 == 1)
									  dataDict[box_info["one"]["symbol"]].splice(i, 1);
								}	
			      			}
			      			chartDict[box_info["one"]["symbol"]].updateSeries([{
			      				data: dataDict[box_info["one"]["symbol"]]
					       	}]) 						       
			      		},
			      		error : function() {
			      			console.log("error")
			      		}
			      	})					
				}, 10 * 1000 ) //tic * 1000				
			}else if( type == "line"){
				oneInterval = setInterval(function(){
					console.log("line graph real time starting")										
					chartDict[box_info["one"]["symbol"]].addData(
							{ date: new Date(1631300887    * 1000 ), 
  				 				price: 150,  
  				 				quantity: 300 },
					         1);					
				}, 3000)								
			}				
		}
		
			
			
		
		function getinitdata( box , symbol ){
			
			box_info[box]['type'] = "candlestick"
			delete chartDict[symbol];
			delete dataDict[symbol];
		
			console.log("symbol : " + symbol)
			console.log("box : " + box)
			console.log("tic : " +   box_info[box]['tic'])
			$.ajax({type : 'get',
	      		url : "${pageContext.request.contextPath }/ajax/getInitStockValues.json",
	      		data : {interval : box_info[box]['tic'],
	      				symbols : symbol,
	      				startTime : 1631200787,
	      				endTime :   1631220787
	      		},
	      		contentType : "application/x-www-form-urlencoded;charset=ISO-8859-15",
	      		datatype : 'json',
	      		success : function(result) {	      			
	      			console.log("success")
	      			let data = [];
	      			for(let i in result){
	      				currentData = result[i]	      					      				
      					data.push({
      						x : new Date(parseInt(currentData.grp_id) * 1000),
   							y : [currentData.min_created_value, 
   								currentData.max_value,
   								currentData.min_value,
   								currentData.max_created_value]	
      						}) 	      					
     					}	      				
	      			
	      			dataDict[symbol] = data
	      																		
					console.log( "newSymbol : " +   symbol)					
					let chartId = "chart_" +  symbol																																			
					let chartDiv = document.createElement("div");									
					chartDiv.id = chartId									
					let chartBody = document.querySelector(".box-" + box + "-body .chart" )
					chartBody.appendChild(chartDiv);																																		
									
					box_info[box]['symbol'] =  symbol;
					options = {
							chart : {
								height : 350,
								type : 'candlestick',
							},
							series : [ {
								data : data
							} ],
							title : {
								text : 'CandleStick Chart',
								align : 'left'
							},
							xaxis : {
								type : 'datetime'
							},
							yaxis : {
								tooltip : {
									enabled : true
								}
							}
						}
					chart = new ApexCharts(document.querySelector("#chart_" + symbol  ),options);
					chart.render();
					chartDict[symbol] =  chart;
					/* chart.updateSeries([ {
						data : data
					}]) */
					
				startIntervalOne(symbol , box_info[box]['tic'] ,  "candlestick"); 
				oneIntervalFlag = true;
					
										      			
	      		},
	      		error : function() {
	      			console.log("error")
	      			}
	      		})
			}
		
		
			function initData(box){
				clicked_box = box;
				let chartbox = document.querySelector("#chartbox");				
			}
		
		
			function getinitdataLine(box, symbol){
					let data = [];
					delete chartDict[symbol];
					delete dataDict[symbol];					
					box_info[box]['type'] = "line"
					let chartId = "linechart_" +  symbol
					let chartDiv = document.createElement("div");									
					chartDiv.id = chartId
					chartDiv.classList.add("h-550");
					let chartBody = document.querySelector(".box-" + box + "-body .chart" )
					chartBody.appendChild(chartDiv);	
					am4core.useTheme(am4themes_animated);					
					var chart = am4core.create("linechart_" +  symbol, am4charts.XYChart);
					
					
					chart.padding(0, 15, 0, 15);
					chart.colors.step = 3;
					$.ajax({type : 'get',
			      		url : "${pageContext.request.contextPath }/ajax/getInitStockValuesLines.json",
			      		data : {interval : box_info[box]['tic'],
			      				symbols : symbol,
			      				startTime : 1631200787,
			      				endTime :   1631220787
			      		},
			      		contentType : "application/x-www-form-urlencoded;charset=ISO-8859-15",
			      		datatype : 'json',
			      		success : function(result){	      			
			      			console.log("success")	      			
			      			for(let i in result){
			      				currentData = result[i]	    
			  				 	data.push({ date: new Date( parseInt(currentData.grp_id) * 1000 ), 
			  				 				price: currentData.avg_price,  
			  				 				quantity: currentData.max_vol } );			      				
			      				}
			      			var interfaceColors = new am4core.InterfaceColorSet();
			      			chart.data = data;
			      			chart.leftAxesContainer.layout = "vertical";
							
							// uncomment this line if you want to change order of axes
							//chart.bottomAxesContainer.reverseOrder = true;
							
							var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
							
							dateAxis.renderer.grid.template.location = 0;
							dateAxis.renderer.ticks.template.length = 8;
							dateAxis.renderer.ticks.template.strokeOpacity = 0.1;
							dateAxis.renderer.grid.template.disabled = true;
							dateAxis.renderer.inside = true;
							dateAxis.renderer.axisFills.template.disabled = true;
							dateAxis.renderer.ticks.template.disabled = true;
							
							dateAxis.renderer.ticks.template.strokeOpacity = 0.2;

							// these two lines makes the axis to be initially zoomed-in
							//dateAxis.start = 0.7;
							//dateAxis.keepSelection = true;

							var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
							valueAxis.tooltip.disabled = true;
							valueAxis.zIndex = 1;
							valueAxis.renderer.baseGrid.disabled = true;
							valueAxis.renderer.minLabelPosition = 0.05;
							valueAxis.renderer.maxLabelPosition = 0.95;

							// Set up axis
							valueAxis.renderer.inside = true;
							valueAxis.height = am4core.percent(60);
							valueAxis.renderer.labels.template.verticalCenter = "bottom";
							valueAxis.renderer.labels.template.padding(2,2,2,2);
							//valueAxis.renderer.maxLabelPosition = 0.95;
							valueAxis.renderer.fontSize = "0.8em"

							// uncomment these lines to fill plot area of this axis with some color
							valueAxis.renderer.gridContainer.background.fill = interfaceColors.getFor("alternativeBackground");
							valueAxis.renderer.gridContainer.background.fillOpacity = 0.05;


							var series = chart.series.push(new am4charts.LineSeries());
							series.dataFields.dateX = "date";
							series.dataFields.valueY = "price";
							series.tooltipText = "{valueY.value}";
							series.name = "Series 1";
							

							var valueAxis2 = chart.yAxes.push(new am4charts.ValueAxis());
							valueAxis2.tooltip.disabled = true;

							// this makes gap between panels
							valueAxis2.marginTop = 30;
							valueAxis2.renderer.baseGrid.disabled = true;
							valueAxis2.renderer.inside = true;
							valueAxis2.height = am4core.percent(40);
							valueAxis2.zIndex = 3
							valueAxis2.renderer.labels.template.verticalCenter = "bottom";
							valueAxis2.renderer.labels.template.padding(2,2,2,2);
							//valueAxis2.renderer.maxLabelPosition = 0.95;
							valueAxis2.renderer.fontSize = "0.8em"

							// uncomment these lines to fill plot area of this axis with some color
							valueAxis2.renderer.gridContainer.background.fill = interfaceColors.getFor("alternativeBackground");
							valueAxis2.renderer.gridContainer.background.fillOpacity = 0.05;

							var series2 = chart.series.push(new am4charts.ColumnSeries());
							series2.columns.template.width = am4core.percent(50);
							series2.dataFields.dateX = "date";
							series2.dataFields.valueY = "quantity";
							series2.yAxis = valueAxis2;
							series2.tooltipText = "{valueY.value}";
							series2.name = "Series 2";

							chart.cursor = new am4charts.XYCursor();
							chart.cursor.xAxis = dateAxis;

							var scrollbarX = new am4charts.XYChartScrollbar();
							scrollbarX.series.push(series);
							scrollbarX.marginBottom = 20;
							chart.scrollbarX = scrollbarX;
							chartDict[symbol] = chart
							
							
							
							
							chart.events.on("datavalidated", function () {
							    dateAxis.zoom({ start: 1 / 15, end: 1.2 }, false, true);
							});
							
							dateAxis.interpolationDuration = 500;
							dateAxis.rangeChangeDuration = 500;
							series.interpolationDuration = 500;
							series.defaultState.transitionDuration = 0;
							series.tensionX = 0.8;
							chart.events.on("datavalidated", function () {
							    dateAxis.zoom({ start: 1 / 15, end: 1.2 }, false, true);
							});
							
							
							
							
							startIntervalOne(symbol , box_info[box]['tic'] ,  "line") 
							oneIntervalFlag = true;
							
							series.fillOpacity = 1;
							var gradient = new am4core.LinearGradient();
							gradient.addColor(chart.colors.getIndex(0), 0.2);
							gradient.addColor(chart.colors.getIndex(0), 0);
							series.fill = gradient;

							// this makes date axis labels to fade out
							dateAxis.renderer.labels.template.adapter.add("fillOpacity", function (fillOpacity, target) {
							    var dataItem = target.dataItem;
							    return dataItem.position;
							})

							// need to set this, otherwise fillOpacity is not changed and not set
							dateAxis.events.on("validated", function () {
							    am4core.iter.each(dateAxis.renderer.labels.iterator(), function (label) {
							        label.fillOpacity = label.fillOpacity;
							    })
							})

							// this makes date axis labels which are at equal minutes to be rotated
							dateAxis.renderer.labels.template.adapter.add("rotation", function (rotation, target) {
							    var dataItem = target.dataItem;
							    if (dataItem.date && dataItem.date.getTime() == am4core.time.round(new Date(dataItem.date.getTime()), "minute").getTime()) {
							        target.verticalCenter = "middle";
							        target.horizontalCenter = "left";
							        return -90;
							    }
							    else {
							        target.verticalCenter = "bottom";
							        target.horizontalCenter = "middle";
							        return 0;
							    }
							})

							// bullet at the front of the line
							var bullet = series.createChild(am4charts.CircleBullet);
							bullet.circle.radius = 5;
							bullet.fillOpacity = 1;
							bullet.fill = chart.colors.getIndex(0);
							bullet.isMeasured = false;

							series.events.on("validated", function() {
							    bullet.moveTo(series.dataItems.last.point);
							    bullet.validatePosition();
							});
							
			      			},
			      		error : function() {
			      			console.log("error")
			      			}
			      		})
				}
				
			function graphType(box , type){
				console.log("graphType : " + box + " : " + type)
				if(type == box_info[box]["type"]  ){
					console.log("already the same type")
				}else{
					current_symbol = box_info[box]["symbol"]
					if(type == "line"){						
						$("#chart-" + box).remove("#chart_" +  current_symbol  );
						var previousChart = document.getElementById("chart_" +  current_symbol);
						var parentDiv = previousChart.parentNode;
						parentDiv.removeChild(previousChart);						
						box_info[box]['type'] = "line"
						getinitdataLine( box , current_symbol )
						
					}else if(type == "candlestick"){
						$("#chart-" + box).remove("#chart_" +  current_symbol);
						var previousChart = document.getElementById("linechart_" +  current_symbol);
						var parentDiv = previousChart.parentNode;
						parentDiv.removeChild(previousChart);
						box_info[box]['type'] = "candle"
						getinitdata( box , current_symbol  )
					}
				}	
			}
			

			
		
		$(document).ready(function() {
					$("#box-one").hide()
					$("#box-two").hide()
					$("#box-three").hide()
			
					let fullMsg = '${msg}'
					if (fullMsg != null && fullMsg != "") {
						myAlarm(fullMsg)
					}									
					let chartbox = document.querySelector("#chartbox")
					$('#add-symbol').click(function(){
						if (!allSymbols.includes($("#symbol-code").val() )) {							
							var newSymbol = $("#symbol-code").val()																	
							console.log( "newSymbol : " +   newSymbol)							
							getinitdata(  clicked_box , newSymbol  );																							
						} else {
							myAlarm("warning:실패:이미 화면에 존재 합니다.");
						}												
					})
				
					
					
				$("#two-horizontal").click(function(){
					box_counts  = 2;				
					$('#box-one').appendTo("#row-one-col");
					$('#box-one').show()
					
					$('#box-two').appendTo('#row-two-col');
					$('#box-two').show()
					
					$('#box-three').hide()					
				})
				
				$("#three-horizontal").click(function(){
					box_counts  = 3;
					$('#box-one').appendTo('#row-one-col');
					$('#box-one').show();
					
					$('#box-two').appendTo('#row-two-col');
					$('#box-two').show();
					
					$('#box-three').appendTo('#row-three-col');
					$('#box-three').show()
					
				})
				
				
				
				
							
		      	$("#one").click(function(){
		      		box_counts  = 1;
					$('#box-one').appendTo("#row-one-col");		      	
					$('#box-one').show()
					
					$('#box-two').hide()
					$('#box-three').hide()
					
				})
				
				$("#two-vertical").click(function(){
					box_counts  = 2;
					$('#box-one').appendTo('#lc-one');
					$('#box-one').show()
					
					$('#box-two').appendTo('#lc-two');
					$('#box-two').show()
					
					$('#box-three').hide()						
				})
				
				$("#three-vertical").click(function(){
					box_counts  = 3;
					$('#box-one').appendTo('#sc-one');
					$('#box-one').show()
					
					$('#box-two').appendTo('#sc-two');
					$('#box-two').show()
					
					$('#box-three').appendTo("#sc-three");
					$('#box-three').show()
				})

				
				
				$("#three-cross").click(function(){
					box_counts  = 3;
					$('#box-one').appendTo('#sc-one');
					$('#box-one').show()
					
					$('#box-two').appendTo('#sc-two');
					$('#box-two').show()
					
					$('#box-three').appendTo("#sc-three");
					$('#box-three').show()

				})
			})
			
			
			
			
</script>

</head>
<body class="hold-transition light-skin sidebar-mini theme-warning fixed">
	<div class="wrapper">
		<div id="loader"></div>
		<header class="main-header">
			<jsp:include page="/resources/dash/include/header.jsp" />
		</header>
	</div>
	<aside class="main-sidebar">
		<jsp:include page="/resources/dash/include/sidebar.jsp" />
	</aside>
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<div class="container-full">
			<!-- Main content -->
			<section class="content">
				<div class="row">

					<div class="col-12">
						<div class="box">
							<div class="box-body">
								<ul id="webticker-1" class="text-center">
									<li class="py-5"><i class="cc BTC d-block mx-auto mb-10"></i>
										<p class="mb-0">BTC</p> <span class="d-block text-danger"> -0.784 <i class="fa fa-arrow-down"></i>
									</span></li>
									<li class="py-5"><i class="cc ETH d-block mx-auto mb-10"></i>
										<p class="mb-0">ETH</p> <span class="d-block text-danger"> -0.714 <i class="fa fa-arrow-down"></i>
									</span></li>
									<li class="py-5"><i class="cc GAME d-block mx-auto mb-10"></i>
										<p class="mb-0">GAME</p> <span class="d-block text-success"> +1.985 <i class="fa fa-arrow-up"></i>
									</span></li>
									<li class="py-5"><i class="cc LBC d-block mx-auto mb-10"></i>
										<p class="mb-0">LBC</p> <span class="d-block text-success"> +0.965 <i class="fa fa-arrow-up"></i>
									</span></li>
									<li class="py-5"><i class="cc NEO d-block mx-auto mb-10"></i>
										<p class="mb-0">NEO</p> <span class="d-block text-danger"> -0.985 <i class="fa fa-arrow-down"></i>
									</span></li>
									<li class="py-5"><i class="cc STEEM d-block mx-auto mb-10"></i>
										<p class="mb-0">STE</p> <span class="d-block text-success"> +1.784 <i class="fa fa-arrow-up"></i>
									</span></li>
									<li class="py-5"><i class="cc LTC d-block mx-auto mb-10"></i>
										<p class="mb-0">LIT</p> <span class="d-block text-danger"> -1.002 <i class="fa fa-arrow-down"></i>
									</span></li>
									<li class="py-5"><i class="cc NOTE d-block mx-auto mb-10"></i>
										<p class="mb-0">NOTE</p> <span class="d-block text-success"> +0.958 <i class="fa fa-arrow-up"></i>
									</span></li>
									<li class="py-5"><i class="cc MINT d-block mx-auto mb-10"></i>
										<p class="mb-0">MINT</p> <span class="d-block text-success"> +9.845 <i class="fa fa-arrow-up"></i>
									</span></li>
									<li class="py-5"><i class="cc IOTA d-block mx-auto mb-10"></i>
										<p class="mb-0">IOT</p> <span class="d-block text-danger"> -0.824 <i class="fa fa-arrow-down"></i>
									</span></li>
									<li class="py-5"><i class="cc DASH d-block mx-auto mb-10"></i>
										<p class="mb-0">DAS</p> <span class="d-block text-success"> +0.632 <i class="fa fa-arrow-up"></i>
									</span></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="row mb-10 p-10">
					<div class="col-md-1">
						<div class="dropdown">
							<button class="waves-effect waves-light btn btn-light mb-5 dropdown-toggle" type="button" data-bs-toggle="dropdown">레이아웃</button>
							<div class="dropdown-menu dropdown-grid">
								<a id="one" class="dropdown-item" href="#"> <span class="icon ti-layout-width-full"></span> <span class="title"></span></a> <a id="two-vertical" class="dropdown-item" href="#"> <span class="icon ti-layout-column2-alt"></span> <span class="title"></span></a> <a id="three-vertical" class="dropdown-item" href="#"> <span class="icon ti-layout-column3-alt"></span> <span class="title"></span></a> <a id="two-horizontal" class="dropdown-item" href="#"> <span class="icon ti-layout-column2-alt fa-rotate-90"></span> <span class="title"></span></a> <a id="three-horizontal" class="dropdown-item" href="#"> <span class="icon ti-layout-column3-alt fa-rotate-90"></span> <span class="title"></span></a>
							</div>
						</div>
					</div>
				</div>
				<div id="chart-area">
					<div class="row" id="row-one">
						<div class="col" id="row-one-col"></div>
					</div>
					<div class="row" id="row-two">
						<div class="col" id="row-two-col"></div>
					</div>
					<div class="row" id="row-three">
						<div class="col" id="row-three-col"></div>
					</div>
					<div class="row" id="row-final">
						<div class="col-md-4" id="sc-one"></div>
						<div class="col-md-4" id="sc-two"></div>
						<div class="col-md-4" id="sc-three"></div>
						<div class="col-md-6" id="lc-one"></div>
						<div class="col-md-6" id="lc-two"></div>
					</div>				
				</div>
				<div hidden="true" id="e_chart_2" class="" style="height: 285px;"></div>
				<div class="box" id="box-one">
					<div class="box-header with-border box-one-header">
						<button id="modal-one" type="button" class="waves-effect waves-light btn btn-light mb-5 add-symbol" data-bs-toggle="modal" data-bs-target="#modal-center" onclick="initData('one')">
							종목<i class="mdi mdi-plus-box"></i>
						</button>
						<div class="btn-group">
							<button class="waves-effect waves-light btn btn-light mb-5 dropdown-toggle" type="button" data-bs-toggle="dropdown">그래프 종류</button>
							<div class="dropdown-menu dropdown-menu-end">
								<a class="dropdown-item line-one" onclick="graphType('one' ,'line')" href="#">라인</a> <a class="dropdown-item candle-one" onclick="graphType('one' ,'candlestick')" href="#">양초</a>
							</div>
						</div>
						<div class="btn-group">
							<button class="waves-effect waves-light btn btn-light mb-5  dropdown-toggle" type="button" data-bs-toggle="dropdown">틱</button>
							<div class="dropdown-menu dropdown-menu-end">
								<a class="dropdown-item tic-one" onclick="tic('one' , 10  )" href="#">10초</a> <a class="dropdown-item tic-one" onclick="tic('one' , 30  )" href="#">30초</a> <a class="dropdown-item tic-one" onclick="tic('one' , 60  )" href="#">60초</a> <a class="dropdown-item tic-one" onclick="tic('one' , 300  )" href="#">5분</a> <a class="dropdown-item tic-one" onclick="tic('one' , 1800  )" href="#">30분</a> <a class="dropdown-item tic-one" onclick="tic('one' , 3600  )" href="#">1시간</a> <a class="dropdown-item tic-one" onclick="tic('one' , 10800  )" href="#">3시간</a> <a class="dropdown-item tic-one" onclick="tic('one' , 86400  )" href="#">하루</a>
							</div>
						</div>
						<button type="button" class="waves-effect waves-light btn btn-light mb-5 start-one" onclick="start('one')">
							실시간 출력 <i class="fa fa-play"></i>
						</button>
						<button type="button" class="waves-effect waves-light btn btn-light mb-5 stop-one" onclick="stop('one')">
							고정 <i class="fa fa-stop"></i>
						</button>
					</div>
					<h4 class="box-title"></h4>
					<div class="box-body box-one-body">
						<div class="chart" id="chart-one">
							<div></div>
						</div>
					</div>
				</div>
				<div class="box" id="box-two">
					<div class="box-header with-border box-two-header">
						<button id="modal-two" type="button" class="waves-effect waves-light btn btn-light mb-5 add-symbol" data-bs-toggle="modal" data-bs-target="#modal-center" onclick="initData('two')">
							종목<i class="mdi mdi-plus-box"></i>
						</button>
						<div class="btn-group">
							<button class="waves-effect waves-light btn btn-light mb-5 dropdown-toggle" type="button" data-bs-toggle="dropdown">그래프 종류</button>
							<div class="dropdown-menu dropdown-menu-end">
								<a class="dropdown-item line-two" onclick="graphType('two' ,'line')" href="#">라인</a> <a class="dropdown-item candle-two" onclick="graphType('two' ,'candlestick')" href="#">양초</a>
							</div>
						</div>
						<div class="btn-group">
							<button class="waves-effect waves-light btn btn-light mb-5 dropdown-toggle" type="button" data-bs-toggle="dropdown">틱</button>
							<div class="dropdown-menu dropdown-menu-end">
								<a class="dropdown-item tic-two" onclick="tic('two' , 10  )" href="#">10초</a> <a class="dropdown-item tic-two" onclick="tic('two' , 30  )" href="#">30초</a> <a class="dropdown-item tic-two" onclick="tic('two' , 60  )" href="#">60초</a> <a class="dropdown-item tic-two" onclick="tic('two' , 300  )" href="#">5분</a> <a class="dropdown-item tic-two" onclick="tic('two' , 1800  )" href="#">30분</a> <a class="dropdown-item tic-two" onclick="tic('two' , 3600  )" href="#">1시간</a> <a class="dropdown-item tic-two" onclick="tic('two' , 10800  )" href="#">3시간</a> <a class="dropdown-item tic-two" onclick="tic('two' , 86400  )" href="#">하루</a>
							</div>
						</div>
						<button type="button" class="waves-effect waves-light btn btn-light mb-5 start-two" onclick="start('two')">
							실시간 출력 <i class="fa fa-play"></i>
						</button>
						<button type="button" class="waves-effect waves-light btn btn-light mb-5 stop-two" onclick="stop('two')">
							고정 <i class="fa fa-stop"></i>
						</button>

					</div>
					<h4 class="box-title"></h4>
					<div class="box-body box-two-body">
						<div class="chart" id="chart-two">
							<div></div>
						</div>
					</div>
				</div>
				<div class="box" id="box-three">
					<div class="box-header with-border box-three-header">
						<button id="modal-three" type="button" class="waves-effect waves-light btn btn-light mb-5 add-symbol" data-bs-toggle="modal" data-bs-target="#modal-center" onclick="initData('three')">
							종목<i class="mdi mdi-plus-box"></i>
						</button>
						<div class="btn-group">
							<button class="waves-effect waves-light btn btn-light mb-5 dropdown-toggle" type="button" data-bs-toggle="dropdown">그래프 종류</button>
							<div class="dropdown-menu dropdown-menu-end">
								<a class="dropdown-item line-three" onclick="graphType('three' ,'line')" href="#">라인</a> <a class="dropdown-item candle-three" onclick="graphType('three' ,'candlestick')" href="#">양초</a>
							</div>
						</div>
						<div class="btn-group">
							<button class="waves-effect waves-light btn btn-light mb-5 dropdown-toggle" type="button" data-bs-toggle="dropdown">틱</button>
							<div class="dropdown-menu dropdown-menu-end">
								<a class="dropdown-item tic-three" onclick="tic('three' , 10  )" href="#">10초</a> <a class="dropdown-item tic-three" onclick="tic('three' , 30  )" href="#">30초</a> <a class="dropdown-item tic-three" onclick="tic('three' , 60  )" href="#">60초</a> <a class="dropdown-item tic-three" onclick="tic('three' , 300  )" href="#">5분</a> <a class="dropdown-item tic-three" onclick="tic('three' , 1800  )" href="#">30분</a> <a class="dropdown-item tic-three" onclick="tic('three' , 3600  )" href="#">1시간</a> <a class="dropdown-item tic-three" onclick="tic('three' , 10800  )" href="#">3시간</a> <a class="dropdown-item tic-three" onclick="tic('three' , 86400  )" href="#">하루</a>
							</div>
						</div>
						<button type="button" class="waves-effect waves-light btn btn-light mb-5 start-three" onclick="start('three')">
							실시간 출력 <i class="fa fa-play"></i>
						</button>
						<button type="button" class="waves-effect waves-light btn btn-light mb-5 stop-three" onclick="stop('three')">
							고정 <i class="fa fa-stop"></i>
						</button>

					</div>
					<h4 class="box-title"></h4>
					<div class="box-body box-three-body">
						<div class="chart" id="chart-three">
							<div></div>
						</div>
					</div>
				</div>
				
				
				
<!-- 					<div class="box">
						<div class="box-body">
							<div class="chart">
								<div id="market-btc" style="height: 535px;"></div>
							</div>
						</div>
					</div> -->
				
				
					
			</section>

		</div>

	</div>
	
	<footer class="main-footer">
		<jsp:include page="/resources/dash/include/footer.jsp" />
		&copy; 2021 <a href="https://www.multipurposethemes.com/">Multipurpose Themes</a>. All Rights Reserved.
	</footer>
	
	<aside class="control-sidebar">
		<jsp:include page="/resources/dash/include/control-sidebar.jsp" />
	</aside>
	<div class="control-sidebar-bg"></div>


	<!-- modal -->
	<div class="modal center-modal fade" id="modal-center" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">종목 코드 입력</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>종목 코드 입력</p>
					<input class="mt-5" type="text" id="symbol-code">
				</div>
				<div class="modal-footer modal-footer-uniform">
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
					<button type="button" id="add-symbol" data-bs-dismiss="modal" class="btn btn-primary float-end">확인</button>
				</div>
			</div>
		</div>
	</div>




	<!-- Vendor JS -->
	<script src="${ pageContext.request.contextPath }/resources/dash/js/vendors.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/chat-popup.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/icons/feather-icons/feather.min.js"></script>



	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/apexcharts-bundle/irregular-data-series.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/apexcharts-bundle/dist/apexcharts.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/ohlc.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/Web-Ticker-master/jquery.webticker.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/echarts-master/dist/echarts-en.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/echarts-liquidfill-master/dist/echarts-liquidfill.min.js"></script>



	<!-- Crypto Admin App -->
	<!-- check number of dashboart -->
	<script src="${ pageContext.request.contextPath }/resources/dash/js/template.js"></script>
	<%-- 	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/dashboard.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/dashboard-chart.js"></script> --%>

	<%-- 	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/dashboard8.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/dashboard8-chart.js"></script> --%>
	
	<%-- <script src="${ pageContext.request.contextPath }/resources/dash/js/pages/dashboard18.js"></script> --%>
	<%-- 	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/dashboard18-chart.js"></script> --%>




	<!-- alert and notification -->
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/chat-popup.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/icons/feather-icons/feather.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/sweetalert/sweetalert.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/js/sweet-alert.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/notification.js"></script>






	<!-- line chart -->

	<script src="https://www.amcharts.com/lib/4/core.js"></script>
	<script src="https://www.amcharts.com/lib/4/charts.js"></script>
	<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/Web-Ticker-master/jquery.webticker.min.js"></script>
	
	
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/dashboard26.js"></script>
<%--  	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/dashboard28-chart.js"></script>

 --%>

</body>
</html>