package egovframework.kss.main.mapper;

import java.util.List;
import java.util.Map;

import egovframework.kss.main.dto.CourseEnrollListDTO;
import egovframework.kss.main.dto.CourseScoreDTO;
import egovframework.kss.main.dto.CourseUserCountDTO;
import egovframework.kss.main.vo.CourseVO;
import egovframework.kss.main.vo.EnrollmentVO;
import egovframework.kss.main.vo.TestVO;

public interface CourseMapper {
	List<CourseVO> selectCourseList();

	List<CourseVO> selectEditCourseList(Integer currentUserId);

	List<CourseVO> selectMyCourseList(Integer currentUserId);

	void registerCourse(CourseVO courseVO);

	void enrollUserInCourse(EnrollmentVO enrollmentVO);

	List<CourseEnrollListDTO> selectCourseEnrollList(Integer currentUserId);

	CourseVO selectCourseById(Integer id);

	void registerTest(TestVO test);

	List<TestVO> selectTestInCourse(Integer courseId);

	List<TestVO> selectTestInCourseWithUser(Map<String, Object> params);

	void deleteTest(Integer testId);

	void completeTest(int testId);

	TestVO selectTestById(int testId);

	int selectTotalStudentsByCourseId(int courseId);

	List<CourseScoreDTO> selectCourseScores(int currentUserId);

	List<CourseUserCountDTO> selectCourseUserCounts(int currentUserId);

	void updateCourse(CourseVO courseVO);

	List<Integer> getUsersByCourseId(int courseId);

}
