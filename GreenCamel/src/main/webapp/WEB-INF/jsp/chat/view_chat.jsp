<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>웹소켓 채팅</title>
	<script src="${ pageContext.request.contextPath }/resources/js/jquery-3.6.0.min.js"></script>	
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<script>
	
	var sock = new SockJS('${ pageContext.request.contextPath }/chatting');
	console.log(sock)
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	sock.onopen = onOpen;
	
	$(document).ready(function() {					
		$('#button-send').on("click" , function(){
			console.log("ok")
			sendMessage();
			console.log("ok2")
			$('#msg').val('')
		})	
	})
	
	
	

	
	function sendMessage(){
		console.log("msg : " + $('#msg').val())
		sock.send($('#msg').val());
	}
	
	
	function onMessage(msg){
		var data = msg.data;
		console.log("data : " + data)
		var sessionId = null;
		var message = null;
		
		var arr = data.split(":");
		
		for(var i = 0; i < arr.length ; i ++){
			console.log('arr[' + i + '] : ' + arr[i] );
		}
		
		var cur_session = '${userid}';
		console.log("cur_session : " + cur_session);
		sessionId = arr[0];
		message = arr[1];
		console.log("sessionId : " + sessionId)
		console.log("message : " + message)
		
		if(sessionId == cur_session){
			var str = "div class='col-6'>"
			str += "<div class='alert alert-secondary'>";
			str += "<b>" + sessionId + " : " + message + "</b>";
			str += "</div></div>"
			$("#msgArea").append(str)
		}else{
			var str = "<div class='col-6'>";
			str += "<div class='alert alert-warning'>";
			str += "<b>" + sessionId + " : " + message + "</b>";
			str += "</div></div>";
			$("#msgArea").append(str)
			
			
		}
		
		
		
	}
	
	
	function onClose(evt){
		var user = '${pr.username}';
		var str = user + " 님이 퇴장하셨습니다."
		$('#msgArea').append(str);
	}
	
	function onOpen(evt){
		var user = "${pr.username}";
		var str = user + "님이 입장하셨습니다.."
		$('#msgArea').append(str)
	}
	
	</script>
	
</head>
<body>
	<div class="container">
		<div class="col-6">
			<label>채팅방</label>
		</div>
		
		<div>
			<div id="msgArea" class="col">			
			</div>
			
			<div class="col-6">
				<div class="nput-group mb-3">
					<input type="text" id="msg" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2">
					<div class="input-group-append">
						<button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
					</div>
				</div>			
			
			</div>
			
		</div>
		<div class="col-6">
		</div>
		
	</div>
</body>
</html>