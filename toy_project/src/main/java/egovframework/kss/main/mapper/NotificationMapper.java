package egovframework.kss.main.mapper;

import java.util.List;
import java.util.Map;

import egovframework.kss.main.model.ChatMessage;
import egovframework.kss.main.vo.NotificationVO;

public interface NotificationMapper {
	void insertNotification(NotificationVO notification);

	void deleteNotification(Map<String, Object> params);

	void deleteDirectMessage(int id);

	List<NotificationVO> selectNotificationByUserId(int userId);

	List<ChatMessage> selectDirectMessageByUserId(int id);

	void deleteAllNotifications(int userId);

	void deleteAllDirectMessage(int userId);

	void insertDirectMessage(ChatMessage chatMessage);
}
