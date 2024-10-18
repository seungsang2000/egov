package egovframework.kss.main.mapper;

import java.util.List;

import egovframework.kss.main.dto.CourseEnrollListDTO;
import egovframework.kss.main.vo.CourseVO;
import egovframework.kss.main.vo.EnrollmentVO;
import egovframework.kss.main.vo.TestVO;

public interface CourseMapper {
	List<CourseVO> selectCourseList();

	List<CourseVO> selectMyCourseList(Integer currentUserId);

	void registerCourse(CourseVO courseVO);

	void enrollUserInCourse(EnrollmentVO enrollmentVO);

	List<CourseEnrollListDTO> selectCourseEnrollList(Integer currentUserId);

	CourseVO selectCourseById(Integer id);

	void registerTest(TestVO test);

	List<TestVO> selectTestInCourse(Integer courseId);

	void deleteTest(Integer testId);

}
