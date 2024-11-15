package egovframework.kss.main.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.kss.main.mapper.NotificationMapper;
import egovframework.kss.main.model.ChatMessage;
import egovframework.kss.main.vo.NotificationVO;

@Repository("NotificationDAO")
public class NotificationDAO {
	@Autowired
	SqlSession sqlSession;

	public void insertNotification(NotificationVO notification) {
		NotificationMapper notificationMapper = sqlSession.getMapper(NotificationMapper.class);
		notificationMapper.insertNotification(notification);

	}

	public void deleteNotification(Map<String, Object> params) {
		NotificationMapper notificationMapper = sqlSession.getMapper(NotificationMapper.class);
		notificationMapper.deleteNotification(params);

	}

	public void deleteDirectMessage(int id) {
		NotificationMapper notificationMapper = sqlSession.getMapper(NotificationMapper.class);
		notificationMapper.deleteDirectMessage(id);

	}

	public List<NotificationVO> selectNotificationByUserId(int id) {
		NotificationMapper notificationMapper = sqlSession.getMapper(NotificationMapper.class);
		return notificationMapper.selectNotificationByUserId(id);
	}

	public List<ChatMessage> selectDirectMessageByUserId(int id) {
		NotificationMapper notificationMapper = sqlSession.getMapper(NotificationMapper.class);
		return notificationMapper.selectDirectMessageByUserId(id);
	}

	public void deleteAllNotifications(int userId) {
		NotificationMapper notificationMapper = sqlSession.getMapper(NotificationMapper.class);
		notificationMapper.deleteAllNotifications(userId);
	}

	public void deleteAllDirectMessage(int userId) {
		NotificationMapper notificationMapper = sqlSession.getMapper(NotificationMapper.class);
		notificationMapper.deleteAllDirectMessage(userId);

	}

	public void insertDirectMessage(ChatMessage chatMessage) {
		NotificationMapper notificationMapper = sqlSession.getMapper(NotificationMapper.class);
		notificationMapper.insertDirectMessage(chatMessage);

	}

}
