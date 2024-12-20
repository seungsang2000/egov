package egovframework.kss.main.service.impl;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.kss.main.dao.CourseDAO;
import egovframework.kss.main.dto.ChatDTO;
import egovframework.kss.main.dto.CourseDetailDTO;
import egovframework.kss.main.dto.CourseEnrollListDTO;
import egovframework.kss.main.dto.CourseScoreDTO;
import egovframework.kss.main.dto.CourseUserCountDTO;
import egovframework.kss.main.service.CourseService;
import egovframework.kss.main.vo.CourseVO;
import egovframework.kss.main.vo.EnrollmentVO;
import egovframework.kss.main.vo.TestVO;
import egovframework.kss.main.vo.UserVO;
import egovframework.kss.main.vo.messageVO;

@Service("CourseService")
public class CourseServiceImpl implements CourseService {

	@Resource(name = "CourseDAO")
	private CourseDAO courseDAO;

	@Override
	public List<CourseVO> selectCourseList() {
		return courseDAO.selectCourseList();
	}

	@Override
	public void registerCourse(CourseVO courseVO) {
		courseDAO.registerCourse(courseVO);

		EnrollmentVO enrollmentVO = new EnrollmentVO(); //강좌 생성시 강좌 제작자 등록 작업 
		enrollmentVO.setCourse_id(courseVO.getId());
		enrollmentVO.setUser_id(courseVO.getInstructor_id());
		enrollmentVO.setEnrolled_at(Timestamp.from(Instant.now()));
		enrollmentVO.setStatus("admin");

		courseDAO.enrollUserInCourse(enrollmentVO);

	}

	@Override
	public void enrollUserInCourse(int courseId, UserVO user) {
		EnrollmentVO enrollmentVO = new EnrollmentVO();
		enrollmentVO.setCourse_id(courseId);
		enrollmentVO.setEnrolled_at(Timestamp.from(Instant.now()));
		enrollmentVO.setStatus("user");
		enrollmentVO.setUser_id(user.getId());

		courseDAO.enrollUserInCourse(enrollmentVO);

	}

	@Override
	public List<CourseEnrollListDTO> selectCourseEnrollList(Map<String, Object> params) {
		return courseDAO.selectCourseEnrollList(params);
	}

	@Override
	public List<CourseVO> selectMyCourseList(Integer currentUserId) {
		return courseDAO.selectMyCourseList(currentUserId);
	}

	@Override
	public CourseVO selectCourseById(Integer id) {
		return courseDAO.selectCourseById(id);
	}

	@Override
	public CourseDetailDTO selectCourseDetailById(Integer id) {
		return courseDAO.selectCourseDetailById(id);
	}

	@Override
	public void registerTest(TestVO test) {
		test.setStatus("작성중");
		courseDAO.registerTest(test);
	}

	@Override
	public List<TestVO> selectTestInCourse(Integer courseId) {
		return courseDAO.selectTestInCourse(courseId);
	}

	@Override
	public void deleteTest(int testId) {
		courseDAO.deleteTest(testId);
	}

	@Override
	public void updateTestTime(TestVO test) {
		courseDAO.updateTestTime(test);
	}

	@Override
	public void completeTest(int testId) {
		courseDAO.completeTest(testId);

	}

	@Override
	public void incompleteTest(int testId) {
		courseDAO.incompleteTest(testId);
	}

	@Override
	public TestVO selectTestById(int testId) {

		return courseDAO.selectTestById(testId);
	}

	@Override
	public List<TestVO> selectTestInCourseWithUser(Map<String, Object> params) {
		return courseDAO.selectTestInCourseWithUser(params);
	}

	@Override
	public int selectTotalStudentsByCourseId(int courseId) {
		return courseDAO.selectTotalStudentsByCourseId(courseId);
	}

	@Override
	public List<CourseScoreDTO> selectCourseScores(int currentUserId) {
		return courseDAO.selectCourseScores(currentUserId);
	}

	@Override
	public List<CourseUserCountDTO> selectCourseUserCounts(int currentUserId) {
		return courseDAO.selectCourseUserCounts(currentUserId);
	}

	@Override
	public List<CourseVO> selectEditCourseList(Map<String, Object> params) {
		return courseDAO.selectEditCourseList(params);
	}

	@Override
	public void updateCourse(CourseVO courseVO) {
		courseDAO.updateCourse(courseVO);

	}

	@Override
	public List<Integer> getUsersIdByCourseId(int courseId) {
		return courseDAO.getUsersIdByCourseId(courseId);
	}

	@Override
	public void insertMessage(messageVO messageVO) {
		courseDAO.insertMessage(messageVO);

	}

	@Override
	public List<ChatDTO> selectMessageByCourseIdAndUserId(Map<String, Object> params) {
		return courseDAO.selectMessageByCourseIdAndUserId(params);
	}

	@Override
	public List<UserVO> selectUsersByCourseId(int courseId) {
		return courseDAO.selectUsersByCourseId(courseId);
	}

	@Override
	public void deleteCourse(int courseId) {
		courseDAO.deleteCourse(courseId);

	}

	@Override
	public int getEnrolledCoursesCountById(int userId) {
		return courseDAO.getEnrolledCoursesCountById(userId);
	}

	@Override
	public List<CourseVO> selectCourseEnrollEditList(int userId) {
		return courseDAO.selectCourseEnrollEditList(userId);

	}

	@Override
	public void CancelEnrollment(Map<String, Object> params) {
		courseDAO.CancelEnrollment(params);

	}

	@Override
	public int enrollmentCountByCourseId(int courseId) {
		return courseDAO.enrollmentCountByCourseId(courseId);
	}

	@Override
	public boolean isExamRegisteredForCourse(int courseId) {

		return courseDAO.isExamRegisteredForCourse(courseId);
	}

}
