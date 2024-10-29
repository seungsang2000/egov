package egovframework.kss.main.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class NotificationController {

	@MessageMapping("/sendNotification") // 클라이언트가 이 경로로 메시지를 보낼 때 호출됨
	@SendTo("/topic/notifications") // 이 경로를 구독하는 클라이언트에게 메시지를 보냄
	public String sendNotification(String message) {
		// 메시지를 처리하고 클라이언트로 보냄
		return message; // 클라이언트에게 보낼 메시지
	}
}
