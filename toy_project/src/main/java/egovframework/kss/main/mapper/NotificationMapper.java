package egovframework.kss.main.mapper;

import java.util.List;
import java.util.Map;

import egovframework.kss.main.vo.NotificationVO;

public interface NotificationMapper {
	void insertNotification(NotificationVO notification);

	void deleteNotification(Map<String, Object> params);

	List<NotificationVO> selectNotificationByUserId(int userId);
}
