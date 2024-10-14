package egovframework.kss.main.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.kss.main.dao.CourseDAO;
import egovframework.kss.main.service.CourseService;
import egovframework.kss.main.vo.CourseVO;

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

	}

}
