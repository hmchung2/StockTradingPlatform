<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${ pageContext.request.contextPath }/resources/js/jquery-3.6.0.min.js"></script>

<script>
function selectAll() {
	let tags = document.querySelectorAll(".checkBtn input")
	let length = tags.length
	for (let i = 0; i < length; i++) {
		tags[i].checked = true
	}
}

function unselectAll() {
	let tags = document.querySelectorAll(".checkBtn input")
	let length = tags.length
	for (let i = 0; i < length; i++) {
		tags[i].checked = false
	}
}
function toggle() {
	if ($('.checkAllBtn #chk').is(":checked")) {
		selectAll()
	} else {
		let check = true
		let tags = document.querySelectorAll(".checkBtn input")
		let f = document.querySelectorAll(".checkBtn input")
		let cnt = 0
		for (let i = 0; i < tags.length && tags[i].checked; i++) {
			if (tags[i].checked)
				cnt++
			else
				break
		}
		if (cnt == tags.length) {
			unselectAll()
		}
	}
}

function checkRequired() {
	let requiredTags = document.querySelectorAll(".required input")
	let length = requiredTags.length
	let cnt = 0
	for (let i = 0; i < length; i++) {
		if (requiredTags[i].checked) {
			cnt++
		} else {
			break
		}
	}
	if (cnt == length) {
		location.href="${pageContext.request.contextPath }/account/create"
	} else {
		$(".required input").css("outline", "2px solid #0d6efd")
	}
}

</script>

</head>
<body>
	<h2 style="margin: auto; margin-top: 30px; margin-bottom: 20px;">이용약관</h2>
		<ul class="join_box">
			<li class="checkBox check01">
				<ul class="clearfix">
					<li>이용약관, 개인정보 수집 및 이용, 위치정보 이용약관(선택), 프로모션 안내 메일 수신(선택)에 모두 동의합니다.</li>
					<li class="checkAllBtn"><input type="checkbox" name="chkAll" id="chk" class="chkAll" onclick="toggle()"></li>
				</ul>
			</li>
			<li class="checkBox check02">
				<ul class="clearfix">
					<li>이용약관 동의(필수)</li>
					<li class="checkBtn required"><input type="checkbox" name="chk1"></li>
				</ul> <textarea name="" id="">여러분을 환영합니다.
네이버 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 네이버 서비스의 이용과 관련하여 네이버 서비스를 제공하는 네이버 주식회사(이하 ‘네이버’)와 이를 이용하는 네이버 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 네이버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
       </textarea>
			</li>
			<li class="checkBox check03">
				<ul class="clearfix">
					<li>개인정보 수집 및 이용에 대한 안내(필수)</li>
					<li class="checkBtn required"><input type="checkbox" name="chk2"></li>
				</ul> <textarea name="" id="">여러분을 환영합니다.
네이버 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 네이버 서비스의 이용과 관련하여 네이버 서비스를 제공하는 네이버 주식회사(이하 ‘네이버’)와 이를 이용하는 네이버 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 네이버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
       </textarea>
			</li>
			<li class="checkBox check03">
				<ul class="clearfix">
					<li>위치정보 이용약관 동의(선택)</li>
					<li class="checkBtn"><input type="checkbox" name="chk3"></li>
				</ul> <textarea name="" id="">여러분을 환영합니다.
네이버 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 네이버 서비스의 이용과 관련하여 네이버 서비스를 제공하는 네이버 주식회사(이하 ‘네이버’)와 이를 이용하는 네이버 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 네이버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
       </textarea>
			</li>
			<li class="checkBox check04">
				<ul class="clearfix">
					<li>이벤트 등 프로모션 알림 메일 수신(선택)</li>
					<li class="checkBtn"><input type="checkbox" name="chk4"></li>
				</ul>
			</li>
		</ul>
		<ul class="footBtwrap clearfix">
			<li><button class="fpmgBt1" id="goback" onclick="">취소</button></li>
			<li><button type="submit" class="fpmgBt2" id="confirm-btn" onclick="checkRequired()">확인</button></li>
		</ul>

</body>
</html>