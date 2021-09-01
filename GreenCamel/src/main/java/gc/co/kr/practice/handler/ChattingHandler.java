package gc.co.kr.practice.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


public class ChattingHandler extends TextWebSocketHandler{
	
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("#ChattingHandler, afterConnectionEstablished");
		sessionList.add(session);
		System.out.println(session.getPrincipal() + "님이 입장하셨습니다.");
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session , TextMessage message) throws Exception{
		System.out.println("#ChattingHandler, handleMessaage");
		System.out.println("ws session : " +  session);
		System.out.println("text msg : " + message);
		for(WebSocketSession s : sessionList) {
			System.out.println(s);
			s.sendMessage(new TextMessage("testing" + ":" + message.getPayload()  ));
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session , CloseStatus status) throws Exception{
		System.out.println("#ChattingHandler , afterConnectionClosed");
		sessionList.remove(session);
		System.out.println(session.getPrincipal().getName() + "님이 퇴장하셧습니다.");
	}
	
}
