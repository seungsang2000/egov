package egovframework.kss.main.service;

import java.util.List;
import java.util.Map;

import egovframework.kss.main.vo.NotificationVO;

public interface NotificationService {
	void insertNotification(NotificationVO notification);

	void deleteNotification(Map<String, Object> params);

	List<NotificationVO> selectNotificationByUserId(int id);
}
