package egovframework.kss.main.mapper;

import java.util.List;
import java.util.Map;

import egovframework.kss.main.dto.ChatDTO;
import egovframework.kss.main.dto.CourseDetailDTO;
import egovframework.kss.main.dto.CourseEnrollListDTO;
import egovframework.kss.main.dto.CourseScoreDTO;
import egovframework.kss.main.dto.CourseUserCountDTO;
import egovframework.kss.main.vo.CourseVO;
import egovframework.kss.main.vo.EnrollmentVO;
import egovframework.kss.main.vo.TestVO;
import egovframework.kss.main.vo.UserVO;
import egovframework.kss.main.vo.messageVO;

public interface CourseMapper {
	List<CourseVO> selectCourseList();

	List<CourseVO> selectEditCourseList(Map<String, Object> params);

	List<CourseVO> selectMyCourseList(Integer currentUserId);

	void registerCourse(CourseVO courseVO);

	void enrollUserInCourse(EnrollmentVO enrollmentVO);

	List<CourseEnrollListDTO> selectCourseEnrollList(Map<String, Object> params);

	CourseVO selectCourseById(Integer id);

	CourseDetailDTO selectCourseDetailById(Integer id);

	void registerTest(TestVO test);

	List<TestVO> selectTestInCourse(Integer courseId);

	List<TestVO> selectTestInCourseWithUser(Map<String, Object> params);

	void deleteTest(Integer testId);

	void deleteCourse(Integer courseId);

	void updateTestTime(TestVO test);

	void completeTest(int testId);

	void incompleteTest(int testId);

	TestVO selectTestById(int testId);

	int selectTotalStudentsByCourseId(int courseId);

	List<CourseScoreDTO> selectCourseScores(int currentUserId);

	List<CourseUserCountDTO> selectCourseUserCounts(int currentUserId);

	void updateCourse(CourseVO courseVO);

	List<Integer> getUsersIdByCourseId(int courseId);

	void insertMessage(messageVO messageVO);

	List<ChatDTO> selectMessageByCourseIdAndUserId(Map<String, Object> params);

	List<UserVO> selectUsersByCourseId(int courseId);

	int getEnrolledCoursesCountById(int userId);

	List<CourseVO> selectCourseEnrollEditList(int userId);

	void CancelEnrollment(Map<String, Object> params);

	int enrollmentCountByCourseId(int courseId);

	boolean isExamRegisteredForCourse(int courseId);

}
