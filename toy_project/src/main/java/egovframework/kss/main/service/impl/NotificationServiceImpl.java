package egovframework.kss.main.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.kss.main.dao.NotificationDAO;
import egovframework.kss.main.service.NotificationService;
import egovframework.kss.main.vo.NotificationVO;

@Service("NotificationService")
public class NotificationServiceImpl implements NotificationService {

	@Resource(name = "NotificationDAO")
	private NotificationDAO notificationDAO;

	@Override
	public void insertNotification(NotificationVO notification) {
		notificationDAO.insertNotification(notification);
	}

	@Override
	public void deleteNotification(Map<String, Object> params) {
		notificationDAO.deleteNotification(params);

	}

	@Override
	public List<NotificationVO> selectNotificationByUserId(int id) {
		return notificationDAO.selectNotificationByUserId(id);
	}

	@Override
	public void deleteAllNotifications(int userId) {
		notificationDAO.deleteAllNotifications(userId);

	}

}
