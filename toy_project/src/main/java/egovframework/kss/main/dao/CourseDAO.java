package egovframework.kss.main.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.kss.main.mapper.CourseMapper;
import egovframework.kss.main.vo.CourseVO;

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

}
