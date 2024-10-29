package egovframework.kss.main.service;

import java.util.List;
import java.util.Map;

import egovframework.kss.main.dto.CourseEnrollListDTO;
import egovframework.kss.main.dto.CourseScoreDTO;
import egovframework.kss.main.dto.CourseUserCountDTO;
import egovframework.kss.main.vo.CourseVO;
import egovframework.kss.main.vo.TestVO;
import egovframework.kss.main.vo.UserVO;

public interface CourseService {

	public List<CourseVO> selectCourseList();

	public List<CourseVO> selectEditCourseList(Integer currentUserId);

	public void registerCourse(CourseVO courseVO);

	public void enrollUserInCourse(int courseId, UserVO user);

	List<CourseEnrollListDTO> selectCourseEnrollList(Integer currentUserId);

	List<CourseVO> selectMyCourseList(Integer currentUserId);

	CourseVO selectCourseById(Integer id);

	void registerTest(TestVO test);

	List<TestVO> selectTestInCourse(Integer courseId);

	List<TestVO> selectTestInCourseWithUser(Map<String, Object> params);

	public void deleteTest(int testId);

	void completeTest(int testId);

	public TestVO selectTestById(int testId);

	int selectTotalStudentsByCourseId(int courseId);

	List<CourseScoreDTO> selectCourseScores(int currentUserId);

	List<CourseUserCountDTO> selectCourseUserCounts(int currentUserId);

	void updateCourse(CourseVO courseVO);

}
