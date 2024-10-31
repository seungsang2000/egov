package egovframework.kss.main.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.MessagingException;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.kss.main.dao.NotificationDAO;
import egovframework.kss.main.service.CourseService;
import egovframework.kss.main.service.NotificationService;
import egovframework.kss.main.vo.CourseVO;
import egovframework.kss.main.vo.NotificationVO;
import egovframework.kss.main.vo.TestVO;

@Service("NotificationService")
public class NotificationServiceImpl implements NotificationService {

	@Resource(name = "NotificationDAO")
	private NotificationDAO notificationDAO;

	@Resource(name = "CourseService")
	private CourseService courseService;

	@Autowired
	private SimpMessagingTemplate messagingTemplate;

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

	@Override
	public void sendMessageByTestId(int testId, String messageText) {
		TestVO test = courseService.selectTestById(testId);
		CourseVO course = courseService.selectCourseById(test.getCourse_id());

		List<Integer> receiverIds = courseService.getUsersByCourseId(test.getCourse_id());

		//db에 메세지 저장
		for (int receiverId : receiverIds) {
			NotificationVO notification = new NotificationVO();
			notification.setCourse_id(test.getCourse_id());
			notification.setMessage(messageText);
			notification.setUser_id(receiverId); // 수신자 ID 설정
			insertNotification(notification);
		}

		// STOMP를 통해 해당 강좌에 구독 중인 사용자에게 메시지 전송
		Map<String, Object> message = new HashMap<>();
		message.put("message", messageText);
		message.put("course_id", test.getCourse_id());
		try {
			messagingTemplate.convertAndSend("/topic/course/" + test.getCourse_id() + "/notifications", new ObjectMapper().writeValueAsString(message));
		} catch (MessagingException | JsonProcessingException e) {

		}

	}

}
