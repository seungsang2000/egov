package egovframework.kss.main.service;

import java.util.List;
import java.util.Map;

import egovframework.kss.main.dto.ChatDTO;
import egovframework.kss.main.dto.CourseDetailDTO;
import egovframework.kss.main.dto.CourseEnrollListDTO;
import egovframework.kss.main.dto.CourseScoreDTO;
import egovframework.kss.main.dto.CourseUserCountDTO;
import egovframework.kss.main.vo.CourseVO;
import egovframework.kss.main.vo.TestVO;
import egovframework.kss.main.vo.UserVO;
import egovframework.kss.main.vo.messageVO;

public interface CourseService {

	public List<CourseVO> selectCourseList();

	public List<CourseVO> selectEditCourseList(Map<String, Object> params);

	public void registerCourse(CourseVO courseVO);

	public void enrollUserInCourse(int courseId, UserVO user);

	List<CourseEnrollListDTO> selectCourseEnrollList(Map<String, Object> params);

	List<CourseVO> selectMyCourseList(Integer currentUserId);

	CourseVO selectCourseById(Integer id);

	CourseDetailDTO selectCourseDetailById(Integer id);

	void registerTest(TestVO test);

	List<TestVO> selectTestInCourse(Integer courseId);

	List<TestVO> selectTestInCourseWithUser(Map<String, Object> params);

	public void deleteTest(int testId);

	void updateTestTime(TestVO test);

	void completeTest(int testId);

	void incompleteTest(int testId);

	public TestVO selectTestById(int testId);

	int selectTotalStudentsByCourseId(int courseId);

	List<CourseScoreDTO> selectCourseScores(int currentUserId);

	List<CourseUserCountDTO> selectCourseUserCounts(int currentUserId);

	void updateCourse(CourseVO courseVO);

	List<Integer> getUsersIdByCourseId(int courseId);

	void insertMessage(messageVO messageVO);

	List<ChatDTO> selectMessageByCourseIdAndUserId(Map<String, Object> params);

	List<UserVO> selectUsersByCourseId(int courseId);

	public void deleteCourse(int courseId);

	int getEnrolledCoursesCountById(int userId);

	List<CourseVO> selectCourseEnrollEditList(int userId);

	public void CancelEnrollment(Map<String, Object> params);

	public int enrollmentCountByCourseId(int courseId);

	public boolean isExamRegisteredForCourse(int courseId);

}
