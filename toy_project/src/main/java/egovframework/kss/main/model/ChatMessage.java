package egovframework.kss.main.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ChatMessage {
	private String sender; // 메시지를 보낸 사용자
	private int sender_id;
	private String sender_image;
	private String content; // 메시지 내용
	private Timestamp created_at; // 메시지 전송 시간
	private Integer course_id;
	private Integer recipient_id;
	private String recipient_name;
	private Integer message_id;
}
