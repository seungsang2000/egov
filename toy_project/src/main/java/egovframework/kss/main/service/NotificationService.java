package egovframework.kss.main.service;

import java.util.List;
import java.util.Map;

import egovframework.kss.main.model.ChatMessage;
import egovframework.kss.main.vo.NotificationVO;

public interface NotificationService {
	void insertNotification(NotificationVO notification);

	void deleteNotification(Map<String, Object> params);

	void deleteDirectMessage(int id);

	List<NotificationVO> selectNotificationByUserId(int id);

	List<ChatMessage> selectDirectMessageByUserId(int id);

	void deleteAllNotifications(int userId);

	void deleteAllDirectMessage(int userId);

	void sendNotificationByTestId(int testId, String messageText);

	void sendChatting(int courseId, ChatMessage chatMessage);

	void insertDirectMessage(ChatMessage chatMessage);

	void sendDirectMessage(ChatMessage chatMessage);
}
