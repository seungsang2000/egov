package egovframework.kss.main.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.kss.main.dto.ChatDTO;
import egovframework.kss.main.dto.CourseDetailDTO;
import egovframework.kss.main.dto.CourseEnrollListDTO;
import egovframework.kss.main.dto.CourseScoreDTO;
import egovframework.kss.main.dto.CourseUserCountDTO;
import egovframework.kss.main.mapper.CourseMapper;
import egovframework.kss.main.vo.CourseVO;
import egovframework.kss.main.vo.EnrollmentVO;
import egovframework.kss.main.vo.TestVO;
import egovframework.kss.main.vo.UserVO;
import egovframework.kss.main.vo.messageVO;

@Repository("CourseDAO")
public class CourseDAO {

	@Autowired
	SqlSession sqlSession;

	public List<CourseVO> selectCourseList() {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectCourseList();
	}

	public void registerCourse(CourseVO courseVO) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		courseMapper.registerCourse(courseVO);
	}

	public void enrollUserInCourse(EnrollmentVO enrollmentVO) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		courseMapper.enrollUserInCourse(enrollmentVO);

	}

	public List<CourseEnrollListDTO> selectCourseEnrollList(Map<String, Object> params) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectCourseEnrollList(params);
	}

	public List<CourseVO> selectMyCourseList(Integer currentUserId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectMyCourseList(currentUserId);
	}

	public CourseVO selectCourseById(Integer id) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectCourseById(id);
	}

	public CourseDetailDTO selectCourseDetailById(Integer id) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectCourseDetailById(id);
	}

	public void registerTest(TestVO test) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		courseMapper.registerTest(test);

	}

	public List<TestVO> selectTestInCourse(Integer courseId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectTestInCourse(courseId);
	}

	public void deleteTest(int testId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		courseMapper.deleteTest(testId);
	}

	public void updateTestTime(TestVO test) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		courseMapper.updateTestTime(test);
	}

	public void completeTest(int testId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		courseMapper.completeTest(testId);
	}

	public void incompleteTest(int testId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		courseMapper.incompleteTest(testId);

	}

	public TestVO selectTestById(int testId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectTestById(testId);
	}

	public List<TestVO> selectTestInCourseWithUser(Map<String, Object> params) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectTestInCourseWithUser(params);
	}

	public int selectTotalStudentsByCourseId(int courseId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectTotalStudentsByCourseId(courseId);
	}

	public List<CourseScoreDTO> selectCourseScores(int currentUserId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectCourseScores(currentUserId);
	}

	public List<CourseUserCountDTO> selectCourseUserCounts(int currentUserId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectCourseUserCounts(currentUserId);
	}

	public List<CourseVO> selectEditCourseList(Map<String, Object> params) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectEditCourseList(params);
	}

	public void updateCourse(CourseVO courseVO) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		courseMapper.updateCourse(courseVO);
	}

	public List<Integer> getUsersIdByCourseId(int courseId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.getUsersIdByCourseId(courseId);
	}

	public void insertMessage(messageVO messageVO) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		courseMapper.insertMessage(messageVO);

	}

	public List<ChatDTO> selectMessageByCourseIdAndUserId(Map<String, Object> params) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectMessageByCourseIdAndUserId(params);
	}

	public List<UserVO> selectUsersByCourseId(int courseId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectUsersByCourseId(courseId);
	}

	public void deleteCourse(int courseId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		courseMapper.deleteCourse(courseId);

	}

	public int getEnrolledCoursesCountById(int userId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.getEnrolledCoursesCountById(userId);
	}

	public List<CourseVO> selectCourseEnrollEditList(int userId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectCourseEnrollEditList(userId);
	}

	public void CancelEnrollment(Map<String, Object> params) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		courseMapper.CancelEnrollment(params);
	}

	public int enrollmentCountByCourseId(int courseId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.enrollmentCountByCourseId(courseId);
	}

	public boolean isExamRegisteredForCourse(int courseId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.isExamRegisteredForCourse(courseId);
	}

}
