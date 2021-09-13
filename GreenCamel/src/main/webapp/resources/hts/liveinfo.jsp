<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="box">
	<div class="box-header with-border">
		<h4 class="box-title">Wallet Balance</h4>
	</div>
	<div class="box-body">
		<div class="d-flex justify-content-between bb-1 pb-5">
			<h5 class="text-fade fullname"></h5>
		</div>
		<div class="d-flex justify-content-between pb-5 pt-10">
			<h6>종목코드</h6>
			<h6 class=".mp-delay attr symbol"></h6>
		</div>
		<div class="d-flex justify-content-between pb-10">
			<h6>실시간 주가</h6>
			<h6>$ <span class="attr marketPrice">0.0</span></h6>
		</div>
		<div class="d-flex justify-content-between pb-10">
			<h6>주가 변동률</h6>
			<h6 class="attr marketChangePercent"></h6>
		</div>
		<div class="d-flex justify-content-between pb-10">
			<h6>거래량</h6>
			<h6 class="attr marketVolume"></h6>
		</div>
		<div class="d-flex justify-content-between pb-10">
			<h6>최대금액(bid) / bid-size</h6>
			<h6 class="attr bid"></h6>
		</div>
		<div class="d-flex justify-content-between pb-10">
			<h6>최소금액(ask) / ask-size</h6>
			<h6 class="attr ask"></h6>
		</div>
		<div class="d-flex justify-content-between pb-10">
			<h6>배당률</h6>
			<h6 class="attr dividendsYield"></h6>
		</div>		
		<div class="d-flex justify-content-between pb-10">
			<h6>유동주식 수</h6>
			<h6 class="attr floatingShares"></h6>
		</div>
		<div class="d-flex justify-content-between pb-10">
			<h6>공매도 주식수</h6>
			<h6 class="attr shortRatio"></h6>
		</div>
		<div class="d-flex justify-content-between pb-10">
			<h6>발행 주식수</h6>
			<h6 class="attr shareOutstanding"></h6>
		</div>
		<div class="d-flex justify-content-between pb-10">
			<h6>주당 순이익 (EPS)</h6>			
			<h6 class="attr epsForward"></h6>
		</div>		
		<div class="d-flex justify-content-between">
			<button type="button" class="btn btn-outline btn-danger">
				<i class="fa fa-arrow-circle-down"></i> 뉴스 조회
			</button>
			<button type="button" class="btn btn-outline btn-success mt-0">
				<i class="fa fa-arrow-circle-up"></i> AI 솔루션
			</button>
		</div>
	</div>
</div>
