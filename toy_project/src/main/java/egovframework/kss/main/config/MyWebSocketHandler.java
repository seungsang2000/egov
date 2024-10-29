package egovframework.kss.main.config;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class MyWebSocketHandler extends TextWebSocketHandler {

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 연결이 성립된 후 처리
		System.out.println("Connected: " + session.getId());
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 클라이언트로부터 메시지를 수신했을 때 처리
		System.out.println("Received: " + message.getPayload());
		session.sendMessage(new TextMessage("Echo: " + message.getPayload())); // 메시지 에코
	}
}
