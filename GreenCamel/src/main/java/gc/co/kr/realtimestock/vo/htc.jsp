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
	<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>
	<script>
/* 	$(document).ready(function() {	

		// 자바스크립트 여기
	
	})
	 */
		/* let availableStocks = null;
		$.ajax({
			type : "GET",
			url : "http://192.168.125.186:8000/getSymbols",
			crossDomain : true,
			success : function(result) {
				console.log("Result:");
				availableStocks = result["symbols"]
				console.log(result);
			},
			fail : function() {
				console.log("fail")
			}
		}); */

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
 /*        visits =
            visits + Math.round((Math.random() < 0.5 ? 1 : -1) * Math.random() * 5); */
        visits = 25;
							
            				
        
            
        console.log("s5")
																								        
        																												
																																																									
																													
        console.log(visits)
        //getRealTimeData("test")
        var lastdataItem = series.dataItems.getIndex(series.dataItems.length - 1);
        chart.addData(
            { date: new Date(lastdataItem.dateX.getTime() + 5000), value: visits },
            1
        );
    }, 5000);
}

function getRealTimeData(symbol){
	$.ajax({
		type: 'get',
		url: "${pageContext.request.contextPath }/ajax/realTimeStock.json",
		data : {
				start : "2021-08-31-17:37:20",
				end : "2021-08-31-17:40:50"
		},
		contentType: "application/x-www-form-urlencoded;charset=ISO-8859-15",
		datatype: 'json',
		success: function(data){
			console.log(data)
			console.log("success")
			console.log(data.marketPrice)
		},
		error: function(){
			console.log("error")
		}		
	})
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

	
	
	
</head>
<body class="hold-transition dark-skin sidebar-mini theme-warning fixed">
	
<div class="wrapper">
	<div id="loader"></div>
	
  <header class="main-header">
	<div class="d-flex align-items-center logo-box justify-content-start">	
		<!-- Logo -->
		<a href="index.html" class="logo">
		  <!-- logo-->
		  <div class="logo-mini w-30">
			  <span class="light-logo"><img src="${ pageContext.request.contextPath }/resources/images/logo-letter.png" alt="logo"></span>
			  <span class="dark-logo"><img src="${ pageContext.request.contextPath }/resources/images/logo-letter.png" alt="logo"></span>
		  </div>
		  <div class="logo-lg">
			  <span class="light-logo"><img src="${ pageContext.request.contextPath }/resources/images/logo-dark-text.png" alt="logo"></span>
			  <span class="dark-logo"><img src="${ pageContext.request.contextPath }/resources/images/logo-light-text.png" alt="logo"></span>
		  </div>
		</a>	
	</div>  
    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
	  <div class="app-menu">
		<ul class="header-megamenu nav">
			<li class="btn-group nav-item">
				<a href="#" class="waves-effect waves-light nav-link push-btn btn-primary-light" data-toggle="push-menu" role="button">
					<i data-feather="align-left"></i>
			    </a>
			</li>
			<li class="btn-group nav-item d-none d-xl-inline-block">
				<a href="contact_app_chat.html" class="waves-effect waves-light nav-link svg-bt-icon btn-primary-light" title="Chat">
					<i data-feather="message-circle"></i>
			    </a>
			</li>
			<li class="btn-group nav-item d-none d-xl-inline-block">
				<a href="mailbox.html" class="waves-effect waves-light nav-link svg-bt-icon btn-primary-light" title="Mailbox">
					<i data-feather="at-sign"></i>
			    </a>
			</li>
			<li class="btn-group nav-item d-none d-xl-inline-block">
				<a href="extra_taskboard.html" class="waves-effect waves-light nav-link svg-bt-icon btn-primary-light" title="Taskboard">
					<i data-feather="clipboard"></i>
			    </a>
			</li>
		</ul> 
	  </div>
		
      <div class="navbar-custom-menu r-side">
        <ul class="nav navbar-nav">		  
			<li class="btn-group d-lg-inline-flex d-none">
				<div class="app-menu">
					<div class="search-bx mx-5">
						<form>
							<div class="input-group">
							  <input type="search" class="form-control" placeholder="Search" aria-label="Search" aria-describedby="button-addon2">
							  <div class="input-group-append">
								<button class="btn" type="submit" id="button-addon3"><i data-feather="search"></i></button>
							  </div>
							</div>
						</form>
					</div>
				</div>
			</li>
			<li class="btn-group nav-item d-lg-inline-flex d-none">
				<a href="#" data-provide="fullscreen" class="waves-effect waves-light nav-link full-screen btn-primary-light" title="Full Screen">
					<i data-feather="maximize"></i>
			    </a>
			</li>
		  <!-- Notifications -->
		  <li class="dropdown notifications-menu">
			<a href="#" class="waves-effect waves-light dropdown-toggle btn-primary-light" data-bs-toggle="dropdown" title="Notifications">
			  <i data-feather="bell"></i>
			</a>
			<ul class="dropdown-menu animated bounceIn">

			  <li class="header">
				<div class="p-20">
					<div class="flexbox">
						<div>
							<h4 class="mb-0 mt-0">Notifications</h4>
						</div>
						<div>
							<a href="#" class="text-danger">Clear All</a>
						</div>
					</div>
				</div>
			  </li>

			  <li>
				<!-- inner menu: contains the actual data -->
				<ul class="menu sm-scrol">
				  <li>
					<a href="#">
					  <i class="fa fa-users text-info"></i> Curabitur id eros quis nunc suscipit blandit.
					</a>
				  </li>
				  <li>
					<a href="#">
					  <i class="fa fa-warning text-warning"></i> Duis malesuada justo eu sapien elementum, in semper diam posuere.
					</a>
				  </li>
				  <li>
					<a href="#">
					  <i class="fa fa-users text-danger"></i> Donec at nisi sit amet tortor commodo porttitor pretium a erat.
					</a>
				  </li>
				  <li>
					<a href="#">
					  <i class="fa fa-shopping-cart text-success"></i> In gravida mauris et nisi
					</a>
				  </li>
				  <li>
					<a href="#">
					  <i class="fa fa-user text-danger"></i> Praesent eu lacus in libero dictum fermentum.
					</a>
				  </li>
				  <li>
					<a href="#">
					  <i class="fa fa-user text-primary"></i> Nunc fringilla lorem 
					</a>
				  </li>
				  <li>
					<a href="#">
					  <i class="fa fa-user text-success"></i> Nullam euismod dolor ut quam interdum, at scelerisque ipsum imperdiet.
					</a>
				  </li>
				</ul>
			  </li>
			  <li class="footer">
				  <a href="#">View all</a>
			  </li>
			</ul>
		  </li>	
		  
	      <!-- User Account-->
          <li class="dropdown user user-menu">
            <a href="#" class="waves-effect waves-light dropdown-toggle btn-primary-light" data-bs-toggle="dropdown" title="User">
				<i data-feather="user"></i>
            </a>
            <ul class="dropdown-menu animated flipInX">
              <li class="user-body">
				 <a class="dropdown-item" href="#"><i class="ti-user text-muted me-2"></i> Profile</a>
				 <a class="dropdown-item" href="#"><i class="ti-wallet text-muted me-2"></i> My Wallet</a>
				 <a class="dropdown-item" href="#"><i class="ti-settings text-muted me-2"></i> Settings</a>
				 <div class="dropdown-divider"></div>
				 <a class="dropdown-item" href="#"><i class="ti-lock text-muted me-2"></i> Logout</a>
              </li>
            </ul>
          </li>	
		  
          <!-- Control Sidebar Toggle Button -->
          <li>
              <a href="#" data-toggle="control-sidebar" title="Setting" class="waves-effect waves-light btn-primary-light">
			  	<i data-feather="settings"></i>
			  </a>
          </li>
			
        </ul>
      </div>
    </nav>
  </header>
  
  <aside class="main-sidebar">
    <!-- sidebar-->
    <section class="sidebar position-relative">	
	  	<div class="multinav">
		  <div class="multinav-scroll" style="height: 100%;">	
			  <!-- sidebar menu-->
			  <ul class="sidebar-menu" data-widget="tree">
				<li class="treeview">
				  <a href="#">
					<i data-feather="monitor"></i>
					<span>Dashboard</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Options 1 to 5
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="index.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 1</a></li>
							<li><a href="index2.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 2</a></li>
							<li><a href="index3.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 3</a></li>
							<li><a href="index4.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 4</a></li>
							<li><a href="index5.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 5</a></li>							
						</ul>
					</li>
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Options 6 to 10
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="index6.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 6</a></li>
							<li><a href="index7.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 7</a></li>
							<li><a href="index8.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 8</a></li>
							<li><a href="index9.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 9</a></li>
							<li><a href="index10.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 10</a></li>							
						</ul>
					</li>
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Options 11 to 15
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="index11.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 11</a></li>
							<li><a href="index12.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 12</a></li>
							<li><a href="index13.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 13</a></li>
							<li><a href="index14.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 14</a></li>
							<li><a href="index15.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 15</a></li>							
						</ul>
					</li>
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Options 16 to 20
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="index16.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 16</a></li>
							<li><a href="index17.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 17</a></li>
							<li><a href="index18.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 18</a></li>
							<li><a href="index19.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 19</a></li>
							<li><a href="index20.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 20</a></li>							
						</ul>
					</li>
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Options 21 to 25
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="index21.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 21</a></li>
							<li><a href="index22.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 22</a></li>
							<li><a href="index23.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 23</a></li>
							<li><a href="index24.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 24</a></li>
							<li><a href="index25.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 25</a></li>							
						</ul>
					</li>
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Options 26 to 30
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="index26.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 26</a></li>
							<li><a href="index27.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 27</a></li>
							<li><a href="index28.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 28</a></li>
							<li><a href="index29.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 29</a></li>
							<li><a href="index30.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dash 30</a></li>							
						</ul>
					</li>								
				  </ul>
				</li>
				<li class="treeview">
				  <a href="#">
					<i data-feather="bar-chart-2"></i>
					<span>Reports</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="reports_transactions.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Transactions</a></li>
					<li><a href="reports_top_gainers_losers.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Top Gainers/Losers</a></li>
					<li><a href="reports_market_capitalizations.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Market Capitalizations</a></li>
					<li><a href="reports_crypto_stats.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Crypto Stats</a></li>
				  </ul>
				</li> 
				<li class="treeview">
				  <a href="#">
					<i data-feather="pie-chart"></i>
					<span>Initial Coin Offering</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="ico_distribution_countdown.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Countdown</a></li>
					<li><a href="ico_roadmap_timeline.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Roadmap/Timeline</a></li>
					<li><a href="ico_progress.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Progress Bar</a></li>
					<li><a href="ico_details.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Details</a></li>
					<li><a href="ico_listing.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>ICO Listing</a></li>
					<li><a href="ico_filter.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>ICO Listing - Filters</a></li>	
				  </ul>
				</li> 
				<li>
				  <a href="currency_exchange.html">
					<i data-feather="refresh-ccw"></i>
					<span>Currency Exchange</span>
				  </a>
				</li> 
				<li class="treeview">
				  <a href="#">
					<i data-feather="users"></i>
					<span>Members</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="members.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Members Grid</a></li>
					<li><a href="members_list.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Members List</a></li>
					<li><a href="member_profile.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Member Profile</a></li>	
				  </ul>
				</li>
				<li class="treeview">
				  <a href="#">
					<i data-feather="sliders"></i>
					<span>Tickers</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="tickers.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Ticker</a></li>
					<li><a href="tickers_live_pricing.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Live Crypto Prices</a></li>	
				  </ul>
				</li>
				<li class="treeview">
				  <a href="#">
					<i data-feather="dollar-sign"></i>
					<span>Transactions</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="transactions_tables.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Transactions Tables</a></li>
					<li><a href="transaction_search.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Transactions Search</a></li>	
					<li><a href="transaction_details.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Single Transaction</a></li>
					<li><a href="transactions_counter.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Transactions Counter</a></li>
				  </ul>
				</li>				
				<li class="treeview">
				  <a href="#">
					<i data-feather="pie-chart"></i>
					<span>Charts</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="charts_chartjs.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>ChartJS</a></li>
					<li><a href="charts_flot.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Flot</a></li>
					<li><a href="charts_inline.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Inline charts</a></li>
					<li><a href="charts_morris.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Morris</a></li>
					<li><a href="charts_peity.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Peity</a></li>
					<li><a href="charts_chartist.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Chartist</a></li>
					  
					<li><a href="charts_rickshaw.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Rickshaw Charts</a></li>
					<li><a href="charts_nvd3.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>NVD3 Charts</a></li>
					<li><a href="charts_echart.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>eChart</a></li>

					<li><a href="charts_amcharts.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>amCharts Charts</a></li>
					<li><a href="charts_amstock_charts.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>amCharts Stock Charts</a></li>
					<li><a href="charts_ammaps.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>amCharts Maps</a></li>
				  </ul>
				</li> 
				<li class="treeview">
				  <a href="#">
					<i data-feather="grid"></i>
					<span>Apps</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="extra_calendar.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Calendar</a></li>
					<li><a href="contact_app.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Contact List</a></li>
					<li><a href="contact_app_chat.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Chat</a></li>
					<li><a href="extra_taskboard.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Todo</a></li>
					<li><a href="mailbox.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Mailbox</a></li>
					<li><a href="app_project_table.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Project</a></li>
				  </ul>
				</li>  
				  				  
				<li class="treeview">
				  <a href="#">
					<i data-feather="package"></i>
					<span>Features</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Components
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="component_bootstrap_switch.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Bootstrap Switch</a></li>
							<li><a href="component_date_paginator.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Date Paginator</a></li>
							<li><a href="component_media_advanced.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Advanced Medias</a></li>
							<li><a href="component_rangeslider.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Range Slider</a></li>
							<li><a href="component_rating.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Ratings</a></li>
							<li><a href="component_animations.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Animations</a></li>
							<li><a href="extension_fullscreen.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Fullscreen</a></li>
							<li><a href="extension_pace.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Pace</a></li>
							<li><a href="component_nestable.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Nestable</a></li>
							<li><a href="component_portlet_draggable.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Draggable Portlets</a></li>	
						</ul>
					</li>								
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Card
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="box_cards.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>User Card</a></li>
							<li><a href="box_advanced.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Advanced Card</a></li>
							<li><a href="box_basic.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Basic Card</a></li>
							<li><a href="box_color.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Card Color</a></li>
							<li><a href="box_group.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Card Group</a></li>
						</ul>
					</li>
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Utility Elements
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="ui_badges.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Badges</a></li>
							<li><a href="ui_border_utilities.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Border</a></li>
							<li><a href="ui_buttons.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Buttons</a></li>	
							<li><a href="ui_color_utilities.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Color</a></li>
							<li><a href="ui_dropdown.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dropdown</a></li>
							<li><a href="ui_dropdown_grid.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dropdown Grid</a></li>
							<li><a href="ui_progress_bars.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Progress Bars</a></li>	
						</ul>
					</li>				
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Icons
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="icons_fontawesome.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Font Awesome</a></li>
							<li><a href="icons_glyphicons.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Glyphicons</a></li>
							<li><a href="icons_material.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Material Icons</a></li>	
							<li><a href="icons_themify.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Themify Icons</a></li>
							<li><a href="icons_simpleline.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Simple Line Icons</a></li>
							<li><a href="icons_cryptocoins.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Cryptocoins Icons</a></li>
							<li><a href="icons_flag.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Flag Icons</a></li>
							<li><a href="icons_weather.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Weather Icons</a></li>
						</ul>
					</li>
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Extra Elements
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="ui_ribbons.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Ribbons</a></li>
							<li><a href="ui_sliders.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Sliders</a></li>
							<li><a href="ui_typography.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Typography</a></li>
							<li><a href="ui_tab.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Tabs</a></li>
							<li><a href="ui_timeline.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Timeline</a></li>
							<li><a href="ui_timeline_horizontal.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Horizontal Timeline</a></li>
						</ul>
					</li>
					<li><a href="ui_grid.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Grid System</a></li>  
				  </ul>
				</li>			
				<li class="treeview">
				  <a href="#">
					<i data-feather="inbox"></i>
					<span>Forms & Tables</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>					
				  <ul class="treeview-menu">					
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Forms
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="forms_advanced.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Form Elements</a></li>
							<li><a href="forms_general.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Form Layout</a></li>
							<li><a href="forms_wizard.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Form Wizard</a></li>	
							<li><a href="forms_validation.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Form Validation</a></li>
							<li><a href="forms_mask.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Formatter</a></li>
							<li><a href="forms_xeditable.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Xeditable Editor</a></li>
							<li><a href="forms_dropzone.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Dropzone</a></li>
							<li><a href="forms_code_editor.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Code Editor</a></li>
							<li><a href="forms_editors.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Editor</a></li>
							<li><a href="forms_editor_markdown.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Markdown</a></li>
						</ul>
					</li> 		
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Tables
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="tables_simple.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Simple tables</a></li>
							<li><a href="tables_data.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Data tables</a></li>
							<li><a href="tables_editable.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Editable Tables</a></li>
							<li><a href="tables_color.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Table Color</a></li>
						</ul>
					</li> 					
				  </ul>
				</li>
				<li class="treeview">
				  <a href="#">
					<i data-feather="edit"></i>
					<span>Widgets</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Core Widgets
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="widgets_blog.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Blog</a></li>
							<li><a href="widgets_chart.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Chart</a></li>
							<li><a href="widgets_list.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>List</a></li>
							<li><a href="widgets_social.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Social</a></li>
							<li><a href="widgets_statistic.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Statistic</a></li>
							<li><a href="widgets_weather.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Weather</a></li>
							<li><a href="widgets.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Widgets</a></li>
							<li><a href="email_index.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Emails</a></li>
						</ul>
					</li>										  	
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Maps
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="map_google.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Google Map</a></li>
							<li><a href="map_vector.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Vector Map</a></li>
						</ul>
					</li>					  	
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Modals
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="component_modals.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Modals</a></li>
							<li><a href="component_sweatalert.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Sweet Alert</a></li>
							<li><a href="component_notification.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Toastr</a></li>
						</ul>
					</li>
				  </ul>
				</li> 	 		
				<li class="treeview">
				  <a href="#">
					<i data-feather="cast"></i>
					<span>Pages</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">					
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Elements Pages
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="sample_faq.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>FAQs</a></li>
							<li><a href="sample_blank.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Blank</a></li>
							<li><a href="sample_coming_soon.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Coming Soon</a></li>
							<li><a href="sample_custom_scroll.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Custom Scrolls</a></li>
							<li><a href="sample_gallery.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Gallery</a></li>
							<li><a href="sample_lightbox.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Lightbox Popup</a></li>
							<li><a href="sample_pricing.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Pricing</a></li>	
						</ul>
					</li>
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Invoice
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="invoice.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Invoice</a></li>
							<li><a href="invoicelist.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Invoice List</a></li>	
						</ul>
					</li>	
					<li><a href="extra_app_ticket.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Support Ticket</a></li>
					<li class="treeview">
						<a href="#">
							<i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>User Pages
							<span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="extra_profile.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>User Profile</a></li>
							<li><a href="contact_userlist_grid.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Userlist Grid</a></li>
							<li><a href="contact_userlist.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Userlist</a></li>		
						</ul>
					</li>					
				  </ul>
				</li>
				<li class="treeview">
				  <a href="#">
					<i data-feather="lock"></i>
					<span>Authentication</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="auth_login.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Login</a></li>
					<li><a href="auth_register.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Register</a></li>
					<li><a href="auth_lockscreen.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Lockscreen</a></li>
					<li><a href="auth_user_pass.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Recover password</a></li>	
				  </ul>
				</li>
				<li class="treeview">
				  <a href="#">
					<i data-feather="alert-triangle"></i>
					<span>Miscellaneous</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="error_404.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Error 404</a></li>
					<li><a href="error_500.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Error 500</a></li>
					<li><a href="error_maintenance.html"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>Maintenance</a></li>	
				  </ul>
				</li>	 	     
			  </ul>
			  
			  <div class="sidebar-widgets">
				<div class="mx-25 mb-30 p-30 text-center bg-primary-light rounded5">
					<img src="${ pageContext.request.contextPath }/resources/images/trophy.png" alt="">
					<h4 class="my-3 fw-500 text-uppercase text-primary">Start Trading</h4>
					<span class="fs-12 d-block mb-3 text-black-50">Offering discounts for better online a store can loyalty weapon into driving</span>
					<button type="button" class="waves-effect waves-light btn btn-sm btn-primary mb-5">Invest Now</button>
				</div>
				<div class="copyright text-center m-25">
					<p><strong class="d-block">Crypto Admin Dashboard</strong> © 2021 All Rights Reserved</p>
				</div>
			  </div>
		  </div>
		</div>
    </section>
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
	  <div class="container-full">
		<!-- Main content -->
		<section class="content">			
			<div class="row">			
				<div class="col-12">
					<div class="box">
					  <div class="box-body tickers-block">
						  <ul id="webticker-1">
							<li><i class="cc BTC"></i> BTC <span class="text-primary"> $11.039232</span></li> 
							<li><i class="cc ETH"></i> ETH <span class="text-primary"> $1.2792</span></li> 
							<li><i class="cc GAME"></i> GAME <span class="text-primary"> $11.039232</span></li> 
							<li><i class="cc LBC"></i> LBC <span class="text-primary"> $0.588418</span></li> 
							<li><i class="cc NEO"></i> NEO <span class="text-primary"> $161.511</span></li> 
							<li><i class="cc STEEM"></i> STE <span class="text-primary"> $0.551955</span></li> 
							<li><i class="cc LTC"></i> LIT <span class="text-primary"> $177.80</span></li> 
							<li><i class="cc NOTE"></i> NOTE <span class="text-primary"> $13.399</span></li>
							<li><i class="cc MINT"></i> MINT <span class="text-primary"> $0.880694</span></li> 
							<li><i class="cc IOTA"></i> IOT <span class="text-primary"> $2.555</span></li> 
							<li><i class="cc DASH"></i> DAS <span class="text-primary"> $769.22</span></li>   
						  </ul>
					  </div>
				  </div>
				</div>

				<div class="col-12">
					<div class="box">
						<div class="box-header with-border">
						  <h4 class="box-title">Intra-day Data</h4>

						  <ul class="box-controls pull-right">
							  <li><a class="box-btn-close" href="#"></a></li>
							  <li><a class="box-btn-slide"  href="#"></a></li>	
							  <li><a class="box-btn-fullscreen" href="#"></a></li>
						  </ul>
						</div>
						<div class="box-body">
							<div class="chart">
								<div id="chartdiv" class="h-500">
									

								
								</div>
							</div>
						</div>
						<!-- /.box-body -->
					  </div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="box pull-up">
					  <div class="box-body">
						  <div class="media align-items-center p-0">
							<div class="text-center">
							  <a href="#"><i class="cc BTC me-5" title="BTC"></i></a>
							</div>
							<div>
							  <h3 class="no-margin">Bitcoin BTC</h3>
							</div>
						  </div>
						  <div class="flexbox align-items-center mt-5">
							<div>
							  <p class="no-margin fw-600"><span class="text-primary">0.00000434 </span>BTC<span class="text-info">$0.04</span></p>
							</div>
							<div class="text-end">
							  <p class="no-margin fw-600"><span class="text-success">+1.35%</span></p>
							</div>
						  </div>
					</div>
					<div class="box-footer p-0 no-border">
						<div class="chart"><canvas id="chartjs1" class="h-80"></canvas></div>
					</div>
				 </div>
			  </div>
				<div class="col-lg-3 col-md-6">
					<div class="box pull-up">
					  <div class="box-body">
						  <div class="media align-items-center p-0">
							<div class="text-center">
							  <a href="#"><i class="cc LTC me-5" title="LTC"></i></a>
							</div>
							<div>
							  <h3 class="no-margin">Litecoin LTC</h3>
							</div>
						  </div>
						  <div class="flexbox align-items-center mt-5">
							<div>
							  <p class="no-margin fw-600"><span class="text-primary">0.00000434 </span>LTC<span class="text-info">$0.04</span></p>
							</div>
							<div class="text-end">
							  <p class="no-margin fw-600"><span class="text-danger">-1.35%</span></p>
							</div>
						  </div>
					</div>
					<div class="box-footer p-0 no-border">
						<div class="chart"><canvas id="chartjs2" class="h-80"></canvas></div>
					</div>
				 </div>
			  </div>
				<div class="col-lg-3 col-md-6">
					<div class="box pull-up">
					  <div class="box-body">
						  <div class="media align-items-center p-0">
							<div class="text-center">
							  <a href="#"><i class="cc NEO me-5" title="NEO"></i></a>
							</div>
							<div>
							  <h3 class="no-margin">Neo NEO</h3>
							</div>
						  </div>
						  <div class="flexbox align-items-center mt-5">
							<div>
							  <p class="no-margin fw-600"><span class="text-primary">0.00000434 </span>NEO<span class="text-info">$0.04</span></p>
							</div>
							<div class="text-end">
							  <p class="no-margin fw-600"><span class="text-danger">-1.35%</span></p>
							</div>
						  </div>
					</div>
					<div class="box-footer p-0 no-border">
						<div class="chart"><canvas id="chartjs3" class="h-80"></canvas></div>
					</div>
				 </div>
			  </div>
				<div class="col-lg-3 col-md-6">
					<div class="box pull-up">
					  <div class="box-body">
						  <div class="media align-items-center p-0">
							<div class="text-center">
							  <a href="#"><i class="cc DASH me-5" title="DASH"></i></a>
							</div>
							<div>
							  <h3 class="no-margin">Dash DASH</h3>
							</div>
						  </div>
						  <div class="flexbox align-items-center mt-5">
							<div>
							  <p class="no-margin fw-600"><span class="text-primary">0.00000434 </span>DASH<span class="text-info">$0.04</span></p>
							</div>
							<div class="text-end">
							  <p class="no-margin fw-600"><span class="text-success">+1.35%</span></p>
							</div>
						  </div>
					</div>
					<div class="box-footer p-0 no-border">
						<div class="chart"><canvas id="chartjs4" class="h-80"></canvas></div>
					</div>
				 </div>
			  </div>

				<div class="col-lg-7 col-12">
					<div class="box">
						<div class="box-header with-border">
						  <h4 class="box-title">Recent Trading Activities</h4>
							<ul class="box-controls pull-right">
							  <li><a class="box-btn-close" href="#"></a></li>
							  <li><a class="box-btn-slide" href="#"></a></li>	
							  <li><a class="box-btn-fullscreen" href="#"></a></li>
							</ul>
						</div>
						<div class="box-body no-padding">
							<div class="table-responsive">
								<table class="table no-bordered no-margin table-striped">
									<thead>
										<tr>
											<th>ID</th>
											<th>Trade Time</th>
											<th>Status</th>
											<th>Last Trade</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th>#12457</th>
											<td>11.00AM</td>
											<td><span class="label label-success">Complete</span></td>
											<td><i class="fa fa-arrow-down text-danger"></i> 0.124587 BTC</td>
										</tr>
										<tr>
											<th>#12586</th>
											<td>10.11AM</td>
											<td><span class="label label-danger">Pending</span></td>
											<td><i class="fa fa-arrow-down text-danger"></i> 3.84572 LTC</td>
										</tr>
										<tr>
											<th>#13258</th>
											<td>09.12AM</td>
											<td><span class="label label-danger">Pending</span></td>
											<td><i class="fa fa-arrow-up text-success"></i> 0.215485 LTC</td>
										</tr>
										<tr>
											<th>#13586</th>
											<td>08.22AM</td>
											<td><span class="label label-warning">Cancelled</span></td>
											<td><i class="fa fa-arrow-down text-danger"></i> 0.8457952 BTC</td>
										</tr>
										<tr>
											<th>#14578</th>
											<td>07.48AM</td>
											<td><span class="label label-success">Complete</span></td>
											<td><i class="fa fa-arrow-up text-success"></i> 0.954278 DASH</td>
										</tr>
										<tr>
											<th>#15623</th>
											<td>06.45AM</td>
											<td><span class="label label-success">Complete</span></td>
											<td><i class="fa fa-arrow-up text-success"></i> 0.9654582 BTC</td>
										</tr>
										<tr>
											<th>#15685</th>
											<td>05.11PM</td>
											<td><span class="label label-warning">Cancelled</span></td>
											<td><i class="fa fa-arrow-down text-danger"></i> 9.8545269 LTC</td>
										</tr>
										<!-- Repeat -->
										<tr>
											<th>#16585</th>
											<td>23.18PM</td>
											<td><span class="label label-danger">Pending</span></td>
											<td><i class="fa fa-arrow-up text-success"></i> 1.9564258 DASH</td>
											</tr>
										<tr>
											<th>#16785</th>
											<td>19.27PM</td>
											<td><span class="label label-success">Complete</span></td>
											<td><i class="fa fa-arrow-down text-danger"></i> 12.845725 LTC</td>
										</tr>
									</tbody>
								</table>
							</div>						
						</div>
						<!-- /.box-body -->
					  </div>
					  <!-- /.box -->

				  </div>

				<div class="col-lg-5 col-12">
					<div class="box">
						<div class="box-header with-border">
						  <h4 class="box-title">Markets</h4>
						</div>
						<div class="box-body no-padding">
							<!-- Tab panes -->
							<div class="tab-content">
								<div id="navpills-1" class="tab-pane active">
									<div class="table-responsive">
									  <table class="table table-hover no-margin text-center">
										  <thead>
											<tr>
											  <th scope="col">Market</th>
											  <th scope="col">Price</th>
											  <th scope="col">Change</th>
											</tr>
										  </thead>
										  <tbody>
											<tr>
											  <td>BTC - 12458</td>
											  <td>0.002548548</td>
											  <td>+12.85% <i class="fa fa-arrow-up text-success"></i></td>
											</tr>
											<tr>
											  <td>BTC - 02157</td>
											  <td>0.025486854</td>
											  <td>+05.15% <i class="fa fa-arrow-up text-success"></i></td>
											</tr>
											<tr>
											  <td>BTC - 12457</td>
											  <td>0.025845218</td>
											  <td>-02.01% <i class="fa fa-arrow-down text-danger"></i></td>
											</tr>
											<tr>
											  <td>BTC - 35487</td>
											  <td>0.021548754</td>
											  <td>+06.15% <i class="fa fa-arrow-up text-success"></i></td>
											</tr>
											<tr>
											  <td>BTC - 03254</td>
											  <td>0.025845845</td>
											  <td>-07.09% <i class="fa fa-arrow-down text-danger"></i></td>
											</tr>
											<tr>
											  <td>BTC - 12458</td>
											  <td>0.002548548</td>
											  <td>+12.85% <i class="fa fa-arrow-up text-success"></i></td>
											</tr>
											<tr>
											  <td>BTC - 15875</td>
											  <td>0.2485975</td>
											  <td>-08.15% <i class="fa fa-arrow-up text-danger"></i></td>
											</tr>
											<tr>
											  <td>BTC - 12457</td>
											  <td>0.025845218</td>
											  <td>-02.01% <i class="fa fa-arrow-down text-danger"></i></td>
											</tr>
										  </tbody>
										</table>
									</div>
								</div>
								<div id="navpills-2" class="tab-pane">
									<div class="table-responsive">
									  <table class="table table-hover text-center">
										  <thead>
											<tr>
											  <th scope="col">Market</th>
											  <th scope="col">Price</th>
											  <th scope="col">Change</th>
											</tr>
										  </thead>
										  <tbody>
											<tr>
											  <td>ETH - 12458</td>
											  <td>0.002548548</td>
											  <td>+12.85% <i class="fa fa-arrow-up text-success"></i></td>
											</tr>
											<tr>
											  <td>ETH - 02157</td>
											  <td>0.025486854</td>
											  <td>+05.15% <i class="fa fa-arrow-up text-success"></i></td>
											</tr>
											<tr>
											  <td>ETH - 12457</td>
											  <td>0.025845218</td>
											  <td>-02.01% <i class="fa fa-arrow-down text-danger"></i></td>
											</tr>
											<tr>
											  <td>ETH - 35487</td>
											  <td>0.021548754</td>
											  <td>+06.15% <i class="fa fa-arrow-up text-success"></i></td>
											</tr>
											<tr>
											  <td>ETH - 03254</td>
											  <td>0.025845845</td>
											  <td>-07.09% <i class="fa fa-arrow-down text-danger"></i></td>
											</tr>
										  </tbody>
										</table>
									</div>
								</div>
								<div id="navpills-3" class="tab-pane">
									<div class="table-responsive">
									  <table class="table table-hover text-center">
										  <thead>
											<tr>

											  <th scope="col">Market</th>
											  <th scope="col">Price</th>
											  <th scope="col">Change</th>
											</tr>
										  </thead>
										  <tbody>
											<tr>
											  <td>DASH - 12458</td>
											  <td>0.002548548</td>
											  <td>+12.85% <i class="fa fa-arrow-up text-success"></i></td>
											</tr>
											<tr>
											  <td>DASH - 02157</td>
											  <td>0.025486854</td>
											  <td>+05.15% <i class="fa fa-arrow-up text-success"></i></td>
											</tr>
											<tr>
											  <td>DASH - 12457</td>
											  <td>0.025845218</td>
											  <td>-02.01% <i class="fa fa-arrow-down text-danger"></i></td>
											</tr>
											<tr>
											  <td>DASH - 35487</td>
											  <td>0.021548754</td>
											  <td>+06.15% <i class="fa fa-arrow-up text-success"></i></td>
											</tr>
											<tr>
											  <td>DASH - 03254</td>
											  <td>0.025845845</td>
											  <td>-07.09% <i class="fa fa-arrow-down text-danger"></i></td>
											</tr>
										  </tbody>
										</table>
									</div>
								</div>
								<div id="navpills-4" class="tab-pane">
									<div class="table-responsive">
									  <table class="table table-hover text-center">
										  <thead>
											<tr>
											  <th scope="col">Market</th>
											  <th scope="col">Price</th>
											  <th scope="col">Change</th>
											</tr>
										  </thead>
										  <tbody>
											<tr>
											  <td>LTC - 12458</td>
											  <td>0.002548548</td>
											  <td>+12.85% <i class="fa fa-arrow-up text-success"></i></td>
											</tr>
											<tr>
											  <td>LTC - 02157</td>
											  <td>0.025486854</td>
											  <td>+05.15% <i class="fa fa-arrow-up text-success"></i></td>
											</tr>
											<tr>
											  <td>LTC - 12457</td>
											  <td>0.025845218</td>
											  <td>-02.01% <i class="fa fa-arrow-down text-danger"></i></td>
											</tr>
											<tr>
											  <td>LTC - 35487</td>
											  <td>0.021548754</td>
											  <td>+06.15% <i class="fa fa-arrow-up text-success"></i></td>
											</tr>
											<tr>
											  <td>LTC - 03254</td>
											  <td>0.025845845</td>
											  <td>-07.09% <i class="fa fa-arrow-down text-danger"></i></td>
											</tr>
										  </tbody>
										</table>
									</div>
								</div>
							</div>						
							<!-- Nav tabs -->
							<ul class="nav nav-fill nav-pills margin-bottom margin-top-10">
								<li class="nav-item bt-2 border-warning"> <a href="#navpills-1" class="nav-link active no-radius" data-bs-toggle="tab" aria-expanded="false">BTC</a> </li>
								<li class="nav-item bt-2 border-primary"> <a href="#navpills-2" class="nav-link no-radius" data-bs-toggle="tab" aria-expanded="false">ETH</a> </li>
								<li class="nav-item bt-2 border-success"> <a href="#navpills-3" class="nav-link no-radius" data-bs-toggle="tab" aria-expanded="true">DASH</a> </li>
								<li class="nav-item bt-2 border-danger"> <a href="#navpills-4" class="nav-link no-radius" data-bs-toggle="tab" aria-expanded="true">LTC</a> </li>
							</ul>												
						</div>
						<!-- /.box-body -->
					  </div>
				</div>			
			</div>
		</section>
		<!-- /.content -->
	  </div>
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right d-none d-sm-inline-block">
        <ul class="nav nav-primary nav-dotted nav-dot-separated justify-content-center justify-content-md-end">
		  <li class="nav-item">
			<a class="nav-link" href="javascript:void(0)">FAQ</a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link" href="#">Purchase Now</a>
		  </li>
		</ul>
    </div>
	  &copy; 2021 <a href="https://www.multipurposethemes.com/">Multipurpose Themes</a>. All Rights Reserved.
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar">
	  
	<div class="rpanel-title"><span class="pull-right btn btn-circle btn-danger"><i class="ion ion-close text-white" data-toggle="control-sidebar"></i></span> </div>  <!-- Create the tabs -->
    <ul class="nav nav-tabs control-sidebar-tabs">
      <li class="nav-item"><a href="#control-sidebar-home-tab" data-bs-toggle="tab" class="active"><i class="mdi mdi-message-text"></i></a></li>
      <li class="nav-item"><a href="#control-sidebar-settings-tab" data-bs-toggle="tab"><i class="mdi mdi-playlist-check"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane active" id="control-sidebar-home-tab">
          <div class="flexbox">
			<a href="javascript:void(0)" class="text-grey">
				<i class="ti-more"></i>
			</a>	
			<p>Users</p>
			<a href="javascript:void(0)" class="text-end text-grey"><i class="ti-plus"></i></a>
		  </div>
		  <div class="lookup lookup-sm lookup-right d-none d-lg-block">
			<input type="text" name="s" placeholder="Search" class="w-p100">
		  </div>
          <div class="media-list media-list-hover mt-20">
			<div class="media py-10 px-0">
			  <a class="avatar avatar-lg status-success" href="#">
				<img src="${ pageContext.request.contextPath }/resources/images/avatar/1.jpg" alt="...">
			  </a>
			  <div class="media-body">
				<p class="fs-16">
				  <a class="hover-primary" href="#"><strong>Tyler</strong></a>
				</p>
				<p>Praesent tristique diam...</p>
				  <span>Just now</span>
			  </div>
			</div>

			<div class="media py-10 px-0">
			  <a class="avatar avatar-lg status-danger" href="#">
				<img src="${ pageContext.request.contextPath }/resources/images/avatar/2.jpg" alt="...">
			  </a>
			  <div class="media-body">
				<p class="fs-16">
				  <a class="hover-primary" href="#"><strong>Luke</strong></a>
				</p>
				<p>Cras tempor diam ...</p>
				  <span>33 min ago</span>
			  </div>
			</div>

			<div class="media py-10 px-0">
			  <a class="avatar avatar-lg status-warning" href="#">
				<img src="${ pageContext.request.contextPath }/resources/images/avatar/3.jpg" alt="...">
			  </a>
			  <div class="media-body">
				<p class="fs-16">
				  <a class="hover-primary" href="#"><strong>Evan</strong></a>
				</p>
				<p>In posuere tortor vel...</p>
				  <span>42 min ago</span>
			  </div>
			</div>

			<div class="media py-10 px-0">
			  <a class="avatar avatar-lg status-primary" href="#">
				<img src="${ pageContext.request.contextPath }/resources/images/avatar/4.jpg" alt="...">
			  </a>
			  <div class="media-body">
				<p class="fs-16">
				  <a class="hover-primary" href="#"><strong>Evan</strong></a>
				</p>
				<p>In posuere tortor vel...</p>
				  <span>42 min ago</span>
			  </div>
			</div>			
			
			<div class="media py-10 px-0">
			  <a class="avatar avatar-lg status-success" href="#">
				<img src="${ pageContext.request.contextPath }/resources/images/avatar/1.jpg" alt="...">
			  </a>
			  <div class="media-body">
				<p class="fs-16">
				  <a class="hover-primary" href="#"><strong>Tyler</strong></a>
				</p>
				<p>Praesent tristique diam...</p>
				  <span>Just now</span>
			  </div>
			</div>

			<div class="media py-10 px-0">
			  <a class="avatar avatar-lg status-danger" href="#">
				<img src="${ pageContext.request.contextPath }/resources/images/avatar/2.jpg" alt="...">
			  </a>
			  <div class="media-body">
				<p class="fs-16">
				  <a class="hover-primary" href="#"><strong>Luke</strong></a>
				</p>
				<p>Cras tempor diam ...</p>
				  <span>33 min ago</span>
			  </div>
			</div>

			<div class="media py-10 px-0">
			  <a class="avatar avatar-lg status-warning" href="#">
				<img src="${ pageContext.request.contextPath }/resources/images/avatar/3.jpg" alt="...">
			  </a>
			  <div class="media-body">
				<p class="fs-16">
				  <a class="hover-primary" href="#"><strong>Evan</strong></a>
				</p>
				<p>In posuere tortor vel...</p>
				  <span>42 min ago</span>
			  </div>
			</div>

			<div class="media py-10 px-0">
			  <a class="avatar avatar-lg status-primary" href="#">
				<img src="${ pageContext.request.contextPath }/resources/images/avatar/4.jpg" alt="...">
			  </a>
			  <div class="media-body">
				<p class="fs-16">
				  <a class="hover-primary" href="#"><strong>Evan</strong></a>
				</p>
				<p>In posuere tortor vel...</p>
				  <span>42 min ago</span>
			  </div>
			</div>
			  
		  </div>

      </div>
      <!-- /.tab-pane -->
      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
          <div class="flexbox">
			<a href="javascript:void(0)" class="text-grey">
				<i class="ti-more"></i>
			</a>	
			<p>Todo List</p>
			<a href="javascript:void(0)" class="text-end text-grey"><i class="ti-plus"></i></a>
		  </div>
        <ul class="todo-list mt-20">
			<li class="py-15 px-5 by-1">
			  <!-- checkbox -->
			  <input type="checkbox" id="basic_checkbox_1" class="filled-in">
			  <label for="basic_checkbox_1" class="mb-0 h-15"></label>
			  <!-- todo text -->
			  <span class="text-line">Nulla vitae purus</span>
			  <!-- Emphasis label -->
			  <small class="badge bg-danger"><i class="fa fa-clock-o"></i> 2 mins</small>
			  <!-- General tools such as edit or delete-->
			  <div class="tools">
				<i class="fa fa-edit"></i>
				<i class="fa fa-trash-o"></i>
			  </div>
			</li>
			<li class="py-15 px-5">
			  <!-- checkbox -->
			  <input type="checkbox" id="basic_checkbox_2" class="filled-in">
			  <label for="basic_checkbox_2" class="mb-0 h-15"></label>
			  <span class="text-line">Phasellus interdum</span>
			  <small class="badge bg-info"><i class="fa fa-clock-o"></i> 4 hours</small>
			  <div class="tools">
				<i class="fa fa-edit"></i>
				<i class="fa fa-trash-o"></i>
			  </div>
			</li>
			<li class="py-15 px-5 by-1">
			  <!-- checkbox -->
			  <input type="checkbox" id="basic_checkbox_3" class="filled-in">
			  <label for="basic_checkbox_3" class="mb-0 h-15"></label>
			  <span class="text-line">Quisque sodales</span>
			  <small class="badge bg-warning"><i class="fa fa-clock-o"></i> 1 day</small>
			  <div class="tools">
				<i class="fa fa-edit"></i>
				<i class="fa fa-trash-o"></i>
			  </div>
			</li>
			<li class="py-15 px-5">
			  <!-- checkbox -->
			  <input type="checkbox" id="basic_checkbox_4" class="filled-in">
			  <label for="basic_checkbox_4" class="mb-0 h-15"></label>
			  <span class="text-line">Proin nec mi porta</span>
			  <small class="badge bg-success"><i class="fa fa-clock-o"></i> 3 days</small>
			  <div class="tools">
				<i class="fa fa-edit"></i>
				<i class="fa fa-trash-o"></i>
			  </div>
			</li>
			<li class="py-15 px-5 by-1">
			  <!-- checkbox -->
			  <input type="checkbox" id="basic_checkbox_5" class="filled-in">
			  <label for="basic_checkbox_5" class="mb-0 h-15"></label>
			  <span class="text-line">Maecenas scelerisque</span>
			  <small class="badge bg-primary"><i class="fa fa-clock-o"></i> 1 week</small>
			  <div class="tools">
				<i class="fa fa-edit"></i>
				<i class="fa fa-trash-o"></i>
			  </div>
			</li>
			<li class="py-15 px-5">
			  <!-- checkbox -->
			  <input type="checkbox" id="basic_checkbox_6" class="filled-in">
			  <label for="basic_checkbox_6" class="mb-0 h-15"></label>
			  <span class="text-line">Vivamus nec orci</span>
			  <small class="badge bg-info"><i class="fa fa-clock-o"></i> 1 month</small>
			  <div class="tools">
				<i class="fa fa-edit"></i>
				<i class="fa fa-trash-o"></i>
			  </div>
			</li>
			<li class="py-15 px-5 by-1">
			  <!-- checkbox -->
			  <input type="checkbox" id="basic_checkbox_7" class="filled-in">
			  <label for="basic_checkbox_7" class="mb-0 h-15"></label>
			  <!-- todo text -->
			  <span class="text-line">Nulla vitae purus</span>
			  <!-- Emphasis label -->
			  <small class="badge bg-danger"><i class="fa fa-clock-o"></i> 2 mins</small>
			  <!-- General tools such as edit or delete-->
			  <div class="tools">
				<i class="fa fa-edit"></i>
				<i class="fa fa-trash-o"></i>
			  </div>
			</li>
			<li class="py-15 px-5">
			  <!-- checkbox -->
			  <input type="checkbox" id="basic_checkbox_8" class="filled-in">
			  <label for="basic_checkbox_8" class="mb-0 h-15"></label>
			  <span class="text-line">Phasellus interdum</span>
			  <small class="badge bg-info"><i class="fa fa-clock-o"></i> 4 hours</small>
			  <div class="tools">
				<i class="fa fa-edit"></i>
				<i class="fa fa-trash-o"></i>
			  </div>
			</li>
			<li class="py-15 px-5 by-1">
			  <!-- checkbox -->
			  <input type="checkbox" id="basic_checkbox_9" class="filled-in">
			  <label for="basic_checkbox_9" class="mb-0 h-15"></label>
			  <span class="text-line">Quisque sodales</span>
			  <small class="badge bg-warning"><i class="fa fa-clock-o"></i> 1 day</small>
			  <div class="tools">
				<i class="fa fa-edit"></i>
				<i class="fa fa-trash-o"></i>
			  </div>
			</li>
			<li class="py-15 px-5">
			  <!-- checkbox -->
			  <input type="checkbox" id="basic_checkbox_10" class="filled-in">
			  <label for="basic_checkbox_10" class="mb-0 h-15"></label>
			  <span class="text-line">Proin nec mi porta</span>
			  <small class="badge bg-success"><i class="fa fa-clock-o"></i> 3 days</small>
			  <div class="tools">
				<i class="fa fa-edit"></i>
				<i class="fa fa-trash-o"></i>
			  </div>
			</li>
		  </ul>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  
  <!-- Add the sidebar's background. This div must be placed immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
  
</div>
<!-- ./wrapper -->
	
	<!-- ./side demo panel -->
	<div class="sticky-toolbar">	    
	    <a href="https://themeforest.net/item/crypto-admin-responsive-bootstrap-4-admin-html-templates/21604673" data-bs-toggle="tooltip" data-bs-placement="left" title="Buy Now" class="waves-effect waves-light btn btn-primary-light btn-flat mb-5 btn-sm" target="_blank">
			<span class="icon-Money"><span class="path1"></span><span class="path2"></span></span>
		</a>
	    <a href="https://themeforest.net/user/multipurposethemes/portfolio" data-bs-toggle="tooltip" data-bs-placement="left" title="Portfolio" class="waves-effect waves-light btn btn-primary-light btn-flat mb-5 btn-sm" target="_blank">
			<span class="icon-Image"></span>
		</a>
	    <a id="chat-popup" href="#" data-bs-toggle="tooltip" data-bs-placement="left" title="Live Chat" class="waves-effect waves-light btn btn-primary-light btn-flat btn-sm">
			<span class="icon-Group-chat"><span class="path1"></span><span class="path2"></span></span>
		</a>
	</div>
	<!-- Sidebar -->
		
	<div id="chat-box-body">
		<div id="chat-circle" class="waves-effect waves-circle btn btn-circle btn-lg btn-primary l-h-70">
            <div id="chat-overlay"></div>
            <span class="icon-Group-chat fs-30"><span class="path1"></span><span class="path2"></span></span>
		</div>

		<div class="chat-box">
            <div class="chat-box-header p-15 d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button class="waves-effect waves-circle btn btn-circle btn-primary-light h-40 w-40 rounded-circle l-h-45" type="button" data-bs-toggle="dropdown">
                      <span class="icon-Add-user fs-22"><span class="path1"></span><span class="path2"></span></span>
                  </button>
                  <div class="dropdown-menu min-w-200">
                    <a class="dropdown-item fs-16" href="#">
                        <span class="icon-Color me-15"></span>
                        New Group</a>
                    <a class="dropdown-item fs-16" href="#">
                        <span class="icon-Clipboard me-15"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></span>
                        Contacts</a>
                    <a class="dropdown-item fs-16" href="#">
                        <span class="icon-Group me-15"><span class="path1"></span><span class="path2"></span></span>
                        Groups</a>
                    <a class="dropdown-item fs-16" href="#">
                        <span class="icon-Active-call me-15"><span class="path1"></span><span class="path2"></span></span>
                        Calls</a>
                    <a class="dropdown-item fs-16" href="#">
                        <span class="icon-Settings1 me-15"><span class="path1"></span><span class="path2"></span></span>
                        Settings</a>
                    <div class="dropdown-divider"></div>
					<a class="dropdown-item fs-16" href="#">
                        <span class="icon-Question-circle me-15"><span class="path1"></span><span class="path2"></span></span>
                        Help</a>
					<a class="dropdown-item fs-16" href="#">
                        <span class="icon-Notifications me-15"><span class="path1"></span><span class="path2"></span></span> 
                        Privacy</a>
                  </div>
                </div>
                <div class="text-center flex-grow-1">
                    <div class="text-dark fs-18">Mayra Sibley</div>
                    <div>
                        <span class="badge badge-sm badge-dot badge-primary"></span>
                        <span class="text-muted fs-12">Active</span>
                    </div>
                </div>
                <div class="chat-box-toggle">
                    <button id="chat-box-toggle" class="waves-effect waves-circle btn btn-circle btn-danger-light h-40 w-40 rounded-circle l-h-45" type="button">
                      <span class="icon-Close fs-22"><span class="path1"></span><span class="path2"></span></span>
                    </button>                    
                </div>
            </div>
            <div class="chat-box-body">
                <div class="chat-box-overlay">   
                </div>
                <div class="chat-logs">
                    <div class="chat-msg user">
                        <div class="d-flex align-items-center">
                            <span class="msg-avatar">
                                <img src="${ pageContext.request.contextPath }/resources/images/avatar/2.jpg" class="avatar avatar-lg">
                            </span>
                            <div class="mx-10">
                                <a href="#" class="text-dark hover-primary fw-bold">Mayra Sibley</a>
                                <p class="text-muted fs-12 mb-0">2 Hours</p>
                            </div>
                        </div>
                        <div class="cm-msg-text">
                            Hi there, I'm Jesse and you?
                        </div>
                    </div>
                    <div class="chat-msg self">
                        <div class="d-flex align-items-center justify-content-end">
                            <div class="mx-10">
                                <a href="#" class="text-dark hover-primary fw-bold">You</a>
                                <p class="text-muted fs-12 mb-0">3 minutes</p>
                            </div>
                            <span class="msg-avatar">
                                <img src="${ pageContext.request.contextPath }/resources/images/avatar/3.jpg" class="avatar avatar-lg">
                            </span>
                        </div>
                        <div class="cm-msg-text">
                           My name is Anne Clarc.         
                        </div>        
                    </div>
                    <div class="chat-msg user">
                        <div class="d-flex align-items-center">
                            <span class="msg-avatar">
                                <img src="${ pageContext.request.contextPath }/resources/images/avatar/2.jpg" class="avatar avatar-lg">
                            </span>
                            <div class="mx-10">
                                <a href="#" class="text-dark hover-primary fw-bold">Mayra Sibley</a>
                                <p class="text-muted fs-12 mb-0">40 seconds</p>
                            </div>
                        </div>
                        <div class="cm-msg-text">
                            Nice to meet you Anne.<br>How can i help you?
                        </div>
                    </div>
                </div><!--chat-log -->
            </div>
            <div class="chat-input">      
                <form>
                    <input type="text" id="chat-input" placeholder="Send a message..."/>
                    <button type="submit" class="chat-submit" id="chat-submit">
                        <span class="icon-Send fs-22"></span>
                    </button>
                </form>      
            </div>
		</div>
	</div>
									<div id="chartdiv21" hidden="true" class="h-500"></div>
	
	<!-- Page Content overlay -->
	<!-- Vendor JS -->
	<script src="${ pageContext.request.contextPath }/resources/dash/js/vendors.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/chat-popup.js"></script>
    <script src="${ pageContext.request.contextPath }/resources/assets/icons/feather-icons/feather.min.js"></script>
	
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/Flot/jquery.flot.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/Flot/jquery.flot.resize.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/Flot/jquery.flot.pie.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/Flot/jquery.flot.categories.js"></script>
	<script src="http://www.amcharts.com/lib/3/amcharts.js" type="text/javascript"></script>
	<script src="http://www.amcharts.com/lib/3/gauge.js" type="text/javascript"></script>
	<script src="http://www.amcharts.com/lib/3/serial.js" type="text/javascript"></script>
	<script src="http://www.amcharts.com/lib/3/amstock.js" type="text/javascript"></script>
	<script src="http://www.amcharts.com/lib/3/pie.js" type="text/javascript"></script>
	<script src="https://www.amcharts.com/lib/3/plugins/dataloader/dataloader.min.js"></script>
	<script src="http://www.amcharts.com/lib/3/plugins/animate/animate.min.js" type="text/javascript"></script>
	<script src="http://www.amcharts.com/lib/3/plugins/export/export.min.js" type="text/javascript"></script>
	<script src="http://www.amcharts.com/lib/3/themes/patterns.js" type="text/javascript"></script>
	<script src="http://www.amcharts.com/lib/3/themes/light.js" type="text/javascript"></script>	
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/Web-Ticker-master/jquery.webticker.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/echarts-master/dist/echarts-en.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/echarts-liquidfill-master/dist/echarts-liquidfill.min.js"></script>
    <script src="${ pageContext.request.contextPath }/resources/assets/vendor_components/datatable/datatables.min.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/vendor_plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.js"></script>
	
	<!-- Crypto Admin App -->
	<script src="${ pageContext.request.contextPath }/resources/dash/js/template.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/dashboard7.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/dash/js/pages/dashboard7-chart.js"></script> 	
	
</body>          
</html>