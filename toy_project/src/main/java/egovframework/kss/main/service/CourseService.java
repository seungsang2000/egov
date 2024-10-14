package egovframework.kss.main.service;

import java.util.List;

import egovframework.kss.main.vo.CourseVO;

public interface CourseService {

	public List<CourseVO> selectCourseList();

	public void registerCourse(CourseVO courseVO);

}
