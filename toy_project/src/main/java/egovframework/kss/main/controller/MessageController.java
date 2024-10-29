package egovframework.kss.main.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class MessageController {

	@MessageMapping("/sendMessage") // 클라이언트가 /app/sendMessage로 메시지를 보낼 때
	@SendTo("/topic/messages") // /topic/messages로 메시지를 브로드캐스트
	public String sendMessage(String message) {
		System.out.println(message);
		return message;  // 받은 메시지를 그대로 반환
	}
}
