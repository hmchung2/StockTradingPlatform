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

		test = null
		allSymbols  = []
		chartDict = {};
		dataDict = {};
		updateFlag = false;
		
		
		clicked_box = "none";
		box_counts = 0;
		
		each_box = {"symbol" : null,
					"type" : "candlestick",
					"tic" : 1800,
					"realtime-flag" : false}
		box_info = {"one" : each_box , 
					"two" : each_box,
					"three" : each_box}						
				
		if (localStorage.getItem("allSymbols") != null
				&& localStorage.getItem("allSymbols") != "") {
			allSymbols = localStorage.getItem("allSymbols").split(",")
		}			
	
		function getinitdata(symbol , box){
			console.log("symbol : " + symbol)
			console.log("tic : " +   box_info[box]['tic'])
			$.ajax({type : 'get',
	      		url : "${pageContext.request.contextPath }/ajax/getInitStockValues.json",
	      		data : {interval : box_info[box]['tic'],
	      				symbols : symbol,
	      				fullTime : 1630460051
	      		},
	      		contentType : "application/x-www-form-urlencoded;charset=ISO-8859-15",
	      		datatype : 'json',
	      		success : function(data) {	      			
	      			console.log("success")	      			
	      			for(let i in data){
	      				currentData = data[i]	      				
	      				if(dataDict[currentData.symbol] == undefined){
	      					dataDict[currentData.symbol] = [  
	      						{
	      							x : new Date( parseInt(currentData.grp_id) * 1000 ),
	      							y : [currentData.min_created_value,	      								
	      								currentData.max_value,
	      								currentData.min_value,
	      								currentData.max_created_value]	      								
	      						}	      						
	      					]
	      				}else{
	      					dataDict[currentData.symbol].push({
	      						x : new Date(parseInt(currentData.grp_id) * 1000),
      							y : [currentData.min_created_value, 
      								currentData.max_value,
      								currentData.min_value,
      								currentData.max_created_value]	
	      					}) 	      					
	      				}	      				
	      			}
	      		},
	      		error : function() {
	      			console.log("error")
	      			}
	      		})
		}
		
		function startInterval() {
				console.log("starting to update")			
				interval = setInterval(function() {
					let symbolkeys = Object.keys( chartDict)  
					for(let i in  symbolkeys){
						csymbol =  symbolkeys[i]
						let currentChart = chartDict[csymbol]
						let currentData = dataDict[csymbol]
						currentChart.updateSeries([ {
							data : currentData
							} ])
						}														
					}, 3000);								
				}
		
		function initData(box){
			clicked_box = box;
			let chartbox = document.querySelector("#chartbox");				
		}
		
		//
		data = [];
		//
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
							
							getinitdata( newSymbol ,box );	
							
							let chartId = "chart_" +  newSymbol																																			
							let chartDiv = document.createElement("div");									
							chartDiv.id = chartId									
							let chartBody = document.querySelector(".box-" + clicked_box + "-body .chart" )
							chartBody.appendChild(chartDiv);																																		
							allSymbols.push(newSymbol);				
							box_info[clicked_box]['symbol'] =  newSymbol;
							options = {
									chart : {
										height : 350,
										type : box_info[clicked_box]['type'],
									},
									series : [ {
										data : []
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
							chart = new ApexCharts(document.querySelector("#chart_" + newSymbol  ),options);
							chart.render();
							chartDict[newSymbol] =  chart;
							dataDict[newSymbol] = [];																														
							myAlarm("success:종목:"
									+ $("#symbol-code").val()
									+ " 종목 성공");
						} else {
							myAlarm("warning:실패:이미 화면에 존재 합니다.");
						}
						if(updateFlag == false){
							updateFlag = true;
							startInterval();
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
				
				
				
				
				/* ----------------------------------------------------------------------------------- */
				
				
				// Themes begin
				am4core.useTheme(am4themes_kelly);
				// Themes end
				
				var chart = am4core.create("market-btc", am4charts.XYChart);
				chart.padding(0, 15, 0, 15);
				chart.colors.step = 3;
				 			
				
				var price1 = 1000;
				var price2 = 2000;
				var price3 = 3000;
				var quantity = 1000;
				for (var i = 15; i < 3000; i++) {
				  price1 += Math.round((Math.random() < 0.5 ? 1 : -1) * Math.random() * 100);
				  price2 += Math.round((Math.random() < 0.5 ? 1 : -1) * Math.random() * 100);
				  price3 += Math.round((Math.random() < 0.5 ? 1 : -1) * Math.random() * 100);
				
				  if (price1 < 100) {
				    price1 = 100;
				  }
				
				  if (price2 < 100) {
				    price2 = 100;
				  }
				
				  if (price3 < 100) {
				    price3 = 100;
				  }    
				
				  quantity += Math.round((Math.random() < 0.5 ? 1 : -1) * Math.random() * 500);
				
				  if (quantity < 0) {
				    quantity *= -1;
				  }
				  data.push({ date: new Date(2000, 0, i), price1: price1, price2:price2, price3:price3, quantity: quantity } );
				}
				
				
				chart.data = data;
				// the following line makes value axes to be arranged vertically.
				chart.leftAxesContainer.layout = "vertical";
					
				// uncomment this line if you want to change order of axes
				//chart.bottomAxesContainer.reverseOrder = true;
				
				var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
				dateAxis.renderer.grid.template.location = 0;
				dateAxis.renderer.ticks.template.length = 8;
				dateAxis.renderer.ticks.template.strokeOpacity = 0.1;
				dateAxis.renderer.grid.template.disabled = true;
				dateAxis.renderer.ticks.template.disabled = false;
				dateAxis.renderer.ticks.template.strokeOpacity = 0.2;
				dateAxis.renderer.minLabelPosition = 0.01;
				dateAxis.renderer.maxLabelPosition = 0.99;
				dateAxis.keepSelection = true;
				
				dateAxis.groupData = true;
				dateAxis.minZoomCount = 5;
				
				// these two lines makes the axis to be initially zoomed-in
				// dateAxis.start = 0.7;
				// dateAxis.keepSelection = true;
				
				var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
				valueAxis.tooltip.disabled = true;
				valueAxis.zIndex = 1;
				valueAxis.renderer.baseGrid.disabled = true;
				// height of axis
				valueAxis.height = am4core.percent(65);
				
				valueAxis.renderer.gridContainer.background.fill = am4core.color("#000000");
				valueAxis.renderer.gridContainer.background.fillOpacity = 0.05;
				valueAxis.renderer.inside = true;
				valueAxis.renderer.labels.template.verticalCenter = "bottom";
				valueAxis.renderer.labels.template.padding(2, 2, 2, 2);
				
				//valueAxis.renderer.maxLabelPosition = 0.95;
				valueAxis.renderer.fontSize = "0.8em"
				
				var series1 = chart.series.push(new am4charts.LineSeries());
				series1.dataFields.dateX = "date";
				series1.dataFields.valueY = "price1";
				series1.dataFields.valueYShow = "changePercent";
				series1.tooltipText = "{name}: {valueY.changePercent.formatNumber('[#0c0]+#.00|[#c00]#.##|0')}%";
				series1.name = "Stock A";
				series1.tooltip.getFillFromObject = false;
				series1.tooltip.getStrokeFromObject = true;
				series1.tooltip.background.fill = am4core.color("#fff");
				series1.tooltip.background.strokeWidth = 2;
				series1.tooltip.label.fill = series1.stroke;
				
				var series2 = chart.series.push(new am4charts.LineSeries());
				series2.dataFields.dateX = "date";
				series2.dataFields.valueY = "price2";
				series2.dataFields.valueYShow = "changePercent";
				series2.tooltipText = "{name}: {valueY.changePercent.formatNumber('[#0c0]+#.00|[#c00]#.##|0')}%";
				series2.name = "Stock B";
				series2.tooltip.getFillFromObject = false;
				series2.tooltip.getStrokeFromObject = true;
				series2.tooltip.background.fill = am4core.color("#fff");
				series2.tooltip.background.strokeWidth = 2;
				series2.tooltip.label.fill = series2.stroke;
				
				var series3 = chart.series.push(new am4charts.LineSeries());
				series3.dataFields.dateX = "date";
				series3.dataFields.valueY = "price3";
				series3.dataFields.valueYShow = "changePercent";
				series3.tooltipText = "{name}: {valueY.changePercent.formatNumber('[#0c0]+#.00|[#c00]#.##|0')}%";
				series3.name = "Stock C";
				series3.tooltip.getFillFromObject = false;
				series3.tooltip.getStrokeFromObject = true;
				series3.tooltip.background.fill = am4core.color("#fff");
				series3.tooltip.background.strokeWidth = 2;
				series3.tooltip.label.fill = series3.stroke;
				
				var valueAxis2 = chart.yAxes.push(new am4charts.ValueAxis());
				valueAxis2.tooltip.disabled = true;
				// height of axis
				valueAxis2.height = am4core.percent(35);
				valueAxis2.zIndex = 3
				// this makes gap between panels
				valueAxis2.marginTop = 30;
				valueAxis2.renderer.baseGrid.disabled = true;
				valueAxis2.renderer.inside = true;
				valueAxis2.renderer.labels.template.verticalCenter = "bottom";
				valueAxis2.renderer.labels.template.padding(2, 2, 2, 2);
				//valueAxis.renderer.maxLabelPosition = 0.95;
				valueAxis2.renderer.fontSize = "0.8em";
				
				valueAxis2.renderer.gridContainer.background.fill = am4core.color("#000000");
				valueAxis2.renderer.gridContainer.background.fillOpacity = 0.05;
				
				var volumeSeries = chart.series.push(new am4charts.StepLineSeries());
				volumeSeries.fillOpacity = 1;
				volumeSeries.fill = series1.stroke;
				volumeSeries.stroke = series1.stroke;
				volumeSeries.dataFields.dateX = "date";
				volumeSeries.dataFields.valueY = "quantity";
				volumeSeries.yAxis = valueAxis2;
				volumeSeries.tooltipText = "Volume: {valueY.value}";
				volumeSeries.name = "Series 2";
				// volume should be summed
				volumeSeries.groupFields.valueY = "sum";
				volumeSeries.tooltip.label.fill = volumeSeries.stroke;
				chart.cursor = new am4charts.XYCursor();
				
				var scrollbarX = new am4charts.XYChartScrollbar();
				scrollbarX.series.push(series1);
				scrollbarX.marginBottom = 20;
				var sbSeries = scrollbarX.scrollbarChart.series.getIndex(0);
				sbSeries.dataFields.valueYShow = undefined;
				chart.scrollbarX = scrollbarX;
				
				// Add range selector
				/*
				var selector = new am4plugins_rangeSelector.DateAxisRangeSelector();
				
				selector.container = document.getElementById("controls");
				selector.axis = dateAxis;

				 */
				
				

			})
			
			
			/* ----------------------------------------------------------------------------------- */
			//[Dashboard chart Javascript]

//Project:	Crypto Admin - Responsive Admin Template


			
			
			
			
</script>
<!-- Styles -->
<style>
#chartdiv {
  width: 100%;
  height: 500px;
}
</style>

<!-- Resources -->
<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>

<!-- Chart code -->
<script>
am4core.ready(function() {

// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end

var chart = am4core.create("chartdiv", am4charts.XYChart);
chart.hiddenState.properties.opacity = 0;

chart.padding(0, 0, 0, 0);

chart.zoomOutButton.disabled = true;

var data = [];
var visits = 10;
var i = 0;

for (i = 0; i <= 30; i++) {
    visits -= Math.round((Math.random() < 0.5 ? 1 : -1) * Math.random() * 10);
    data.push({ date: new Date().setSeconds(i - 30), value: visits });
}

chart.data = data;

var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.grid.template.location = 0;
dateAxis.renderer.minGridDistance = 30;
dateAxis.dateFormats.setKey("second", "ss");
dateAxis.periodChangeDateFormats.setKey("second", "[bold]h:mm a");
dateAxis.periodChangeDateFormats.setKey("minute", "[bold]h:mm a");
dateAxis.periodChangeDateFormats.setKey("hour", "[bold]h:mm a");
dateAxis.renderer.inside = true;
dateAxis.renderer.axisFills.template.disabled = true;
dateAxis.renderer.ticks.template.disabled = true;

var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
valueAxis.tooltip.disabled = true;
valueAxis.interpolationDuration = 500;
valueAxis.rangeChangeDuration = 500;
valueAxis.renderer.inside = true;
valueAxis.renderer.minLabelPosition = 0.05;
valueAxis.renderer.maxLabelPosition = 0.95;
valueAxis.renderer.axisFills.template.disabled = true;
valueAxis.renderer.ticks.template.disabled = true;

var series = chart.series.push(new am4charts.LineSeries());
series.dataFields.dateX = "date";
series.dataFields.valueY = "value";
series.interpolationDuration = 500;
series.defaultState.transitionDuration = 0;
series.tensionX = 0.8;

chart.events.on("datavalidated", function () {
    dateAxis.zoom({ start: 1 / 15, end: 1.2 }, false, true);
});

dateAxis.interpolationDuration = 500;
dateAxis.rangeChangeDuration = 500;

document.addEventListener("visibilitychange", function() {
    if (document.hidden) {
        if (interval) {
            clearInterval(interval);
        }
    }
    else {
        startInterval();
    }
}, false);

// add data
var interval;
function startInterval() {
    interval = setInterval(function() {
        visits =
            visits + Math.round((Math.random() < 0.5 ? 1 : -1) * Math.random() * 5);
        var lastdataItem = series.dataItems.getIndex(series.dataItems.length - 1);
        chart.addData(
            { date: new Date(lastdataItem.dateX.getTime() + 1000), value: visits },
            1
        );
    }, 1000);
}

startInterval();

// all the below is optional, makes some fancy effects
// gradient fill of the series
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

}); // end am4core.ready()
</script>

<!-- HTML -->
<div id="chartdiv"></div>
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
								<a class="dropdown-item line-one" onclick="graphType('one' ,'line')" href="#">라인</a>
								<a class="dropdown-item candle-one" onclick="graphType('one' ,'candle')" href="#">양초</a>
							</div>
						</div>
						<div class="btn-group">
							<button class="waves-effect waves-light btn btn-light mb-5  dropdown-toggle" type="button" data-bs-toggle="dropdown">틱</button>
							<div class="dropdown-menu dropdown-menu-end">
								<a class="dropdown-item tic-one" onclick="tic('one' , 10  )" href="#">10초</a>
								<a class="dropdown-item tic-one" onclick="tic('one' , 30  )" href="#">30초</a>
								<a class="dropdown-item tic-one" onclick="tic('one' , 60  )" href="#">60초</a>
								<a class="dropdown-item tic-one" onclick="tic('one' , 300  )" href="#">5분</a>
								<a class="dropdown-item tic-one" onclick="tic('one' , 1800  )" href="#">30분</a>
								<a class="dropdown-item tic-one" onclick="tic('one' , 3600  )" href="#">1시간</a>
								<a class="dropdown-item tic-one" onclick="tic('one' , 10800  )" href="#">3시간</a>
								<a class="dropdown-item tic-one" onclick="tic('one' , 86400  )" href="#">하루</a>
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
								<a class="dropdown-item line-two" onclick="graphType('two' ,'line')" href="#">라인</a>
								<a class="dropdown-item candle-two" onclick="graphType('two' ,'candle')" href="#">양초</a>
							</div>
						</div>
						<div class="btn-group">
							<button class="waves-effect waves-light btn btn-light mb-5 dropdown-toggle" type="button" data-bs-toggle="dropdown">틱</button>
							<div class="dropdown-menu dropdown-menu-end">
								<a class="dropdown-item tic-two" onclick="tic('two' , 10  )" href="#">10초</a>
								<a class="dropdown-item tic-two" onclick="tic('two' , 30  )" href="#">30초</a>
								<a class="dropdown-item tic-two" onclick="tic('two' , 60  )" href="#">60초</a>
								<a class="dropdown-item tic-two" onclick="tic('two' , 300  )" href="#">5분</a>
								<a class="dropdown-item tic-two" onclick="tic('two' , 1800  )" href="#">30분</a>
								<a class="dropdown-item tic-two" onclick="tic('two' , 3600  )" href="#">1시간</a>
								<a class="dropdown-item tic-two" onclick="tic('two' , 10800  )" href="#">3시간</a>
								<a class="dropdown-item tic-two" onclick="tic('two' , 86400  )" href="#">하루</a>
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
				<!-- 				</div>
				
		test = null
		allSymbols  = []
		chartDict = {};
		dataDict = {};
		updateFlag = false;	
		clicked_box = "none";
		box_counts = 0;		
		each_box = {"symbol" : null,
					"type" : "candlestick",
					"tic" : 1800,
					"realtime-flag" : false}
		box_info = {"one" : each_box , 
					"two" : each_box,
					"three" : each_box}	 -->

				<div class="box" id="box-three">
					<div class="box-header with-border box-three-header">
						<button id="modal-three" type="button" class="waves-effect waves-light btn btn-light mb-5 add-symbol" data-bs-toggle="modal" data-bs-target="#modal-center" onclick="initData('three')">
							종목<i class="mdi mdi-plus-box"></i>
						</button>
						<div class="btn-group">
							<button class="waves-effect waves-light btn btn-light mb-5 dropdown-toggle" type="button" data-bs-toggle="dropdown">그래프 종류</button>
							<div class="dropdown-menu dropdown-menu-end">
								<a class="dropdown-item line-three" onclick="graphType('three' ,'line')" href="#">라인</a>
								<a class="dropdown-item candle-three" onclick="graphType('three' ,'candle')" href="#">양초</a>
							</div>
						</div>
						<div class="btn-group">
							<button class="waves-effect waves-light btn btn-light mb-5 dropdown-toggle" type="button" data-bs-toggle="dropdown">틱</button>
							<div class="dropdown-menu dropdown-menu-end">
								<a class="dropdown-item tic-three" onclick="tic('three' , 10  )" href="#">10초</a>
								<a class="dropdown-item tic-three" onclick="tic('three' , 30  )" href="#">30초</a>
								<a class="dropdown-item tic-three" onclick="tic('three' , 60  )" href="#">60초</a>
								<a class="dropdown-item tic-three" onclick="tic('three' , 300  )" href="#">5분</a>
								<a class="dropdown-item tic-three" onclick="tic('three' , 1800  )" href="#">30분</a>
								<a class="dropdown-item tic-three" onclick="tic('three' , 3600  )" href="#">1시간</a>
								<a class="dropdown-item tic-three" onclick="tic('three' , 10800  )" href="#">3시간</a>
								<a class="dropdown-item tic-three" onclick="tic('three' , 86400  )" href="#">하루</a>
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



				<div class="box">
						<div class="box-body">
							<div class="chart">
								<div id="market-btc" style="height: 535px;"></div>
							</div>
						</div>
				</div>
				
				
				
				
				
				
					
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
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/dashboard18.js"></script>
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
	<script src="https://cdn.amcharts.com/lib/4/plugins/rangeSelector.js"></script>
	<script src="https://cdn.amcharts.com/lib/4/themes/kelly.js"></script>
	<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/Web-Ticker-master/jquery.webticker.min.js"></script>
	
	
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/dashboard28.js"></script>
<%--  	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/dashboard28-chart.js"></script>

 --%>

</body>
</html>