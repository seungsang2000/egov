package egovframework.kss.main.mapper;

import java.util.List;

import egovframework.kss.main.vo.CourseVO;

public interface CourseMapper {
	List<CourseVO> selectCourseList();

	void registerCourse(CourseVO courseVO);

}
