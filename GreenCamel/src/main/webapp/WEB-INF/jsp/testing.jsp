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
		test = null
		//allSymbols  = ["AAPL" , "HD" ]
		allSymbols  = []
		chartDict = {};
		dataDict = {};
		
		allSymbolInfo = {};
		
		if (localStorage.getItem("allSymbols") != null
				&& localStorage.getItem("allSymbols") != "") {
			allSymbols = localStorage.getItem("allSymbols").split(",")
		}

		
		function getinitdata(symbolList){
			
			$.ajax({type : 'get',
	      		url : "${pageContext.request.contextPath }/ajax/getInitStockValues.json",
	      		data : {interval : 30,
	      				symbols : "HD"
	      		},
	      		contentType : "application/x-www-form-urlencoded;charset=ISO-8859-15",
	      		datatype : 'json',
	      		success : function(data) {	      			
	      			console.log("success")
	      			
	      			for(let i in data){
	      				currentData = data[i]
	      				console.log(currentData.grp_id * 1000)
	      				console.log({
      						x : new Date(parseInt(currentData.grp_id) * 1000 ),
  							y : [currentData.min_created_value, 
  								currentData.max_value,
  								currentData.min_value,
  								currentData.max_created_value]	
      					})
	      		
	      			
	      				
	      				if(dataDict[currentData.symbol] == undefined){
	      					dataDict[currentData.symbol] = [  
	      						{
	      							x : new Date(parseInt(currentData.grp_id) * 1000 ),
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
			
			
			/* let data =  [ {
				x : new Date(1538881200000),
				y : [ 6603.5, 6603.99, 6597.5, 6602.86 ]
			}, {
				x : new Date(1538883000000),
				y : [ 6603.85, 6605, 6600, 6604.07 ]
			}, {
				x : new Date(1538884800000),
				y : [ 6604.98, 6606, 6604.07, 6606 ]
			} ]
			return data; */
		}
		
		function startInterval() {
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
				}, 1000);
			}
		
		
		
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
		
		
		console.log(allSymbols);
		
		
		
		$(document).ready(function() {
					let fullMsg = '${msg}'
					if (fullMsg != null && fullMsg != "") {
						myAlarm(fullMsg)
					}					

					
					
					let chartbox = document.querySelector("#chartbox")					
					
					$("#add-symbol").click(
							function() {
								if (!allSymbols.includes($("#symbol-code").val() )) {
									var newSymbol = $("#symbol-code").val()																	
									console.log( "newSymbol : " +   newSymbol)
									
									getinitdata( [newSymbol] );	
									
									let chartId = "chart_" +  newSymbol																		
									let chartDiv = document.createElement("div");									
									chartDiv.className = "chart"									
									let chartChild = document.createElement("div");									
									chartChild.id = chartId									
									chartDiv.appendChild(chartChild)
									chartbox.appendChild(chartDiv)																		
									allSymbols.push(newSymbol);
									data = getinitdata();
									options = {
											chart : {
												height : 510,
												type : 'candlestick',
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
											
																											
									myAlarm("success:종목 추가:"
											+ $("#symbol-code").val()
											+ " 종목 추가 성공");
								} else {
									myAlarm("warning:실패:이미 화면에 존재 합니다.");
								}
							})			
					


					
					
				startInterval()
					
					
		})														
	</script>	
	
</head>
<body class="hold-transition dark-skin sidebar-mini theme-warning fixed">
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
					<div class="col-12">
						<div id="chartbox" class="box-body">
						
							<button type="button" class="waves-effect waves-light btn btn-default mb-5" data-bs-toggle="modal" data-bs-target="#modal-center">
									종목 추가<i class="mdi mdi-plus-box"></i>
							</button>
						
						
							<div class="chart">
								<div id="bcn-btc"></div>
							</div>
														
							
						</div>
					</div>					
					<div hidden="true" id="e_chart_2" class="" style="height:285px;"></div>				
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
					<input type="text" id="symbol-code">
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
	
	
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/Web-Ticker-master/jquery.webticker.min.js"></script>
	
	<!-- alert and notification -->
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/chat-popup.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/icons/feather-icons/feather.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/sweetalert/sweetalert.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/js/sweet-alert.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/notification.js"></script>
	
</body>          
</html>