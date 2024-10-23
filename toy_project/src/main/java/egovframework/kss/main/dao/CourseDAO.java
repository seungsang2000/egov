package egovframework.kss.main.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.kss.main.dto.CourseEnrollListDTO;
import egovframework.kss.main.mapper.CourseMapper;
import egovframework.kss.main.vo.CourseVO;
import egovframework.kss.main.vo.EnrollmentVO;
import egovframework.kss.main.vo.TestVO;

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

	public List<CourseEnrollListDTO> selectCourseEnrollList(Integer currentUserId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectCourseEnrollList(currentUserId);
	}

	public List<CourseVO> selectMyCourseList(Integer currentUserId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectMyCourseList(currentUserId);
	}

	public CourseVO selectCourseById(Integer id) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectCourseById(id);
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

	public void completeTest(int testId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		courseMapper.completeTest(testId);
	}

	public TestVO selectTestById(int testId) {
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		return courseMapper.selectTestById(testId);
	}

}
