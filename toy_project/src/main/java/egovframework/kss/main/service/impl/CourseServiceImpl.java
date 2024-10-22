package egovframework.kss.main.service.impl;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.kss.main.dao.CourseDAO;
import egovframework.kss.main.dto.CourseEnrollListDTO;
import egovframework.kss.main.service.CourseService;
import egovframework.kss.main.vo.CourseVO;
import egovframework.kss.main.vo.EnrollmentVO;
import egovframework.kss.main.vo.TestVO;
import egovframework.kss.main.vo.UserVO;

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

		EnrollmentVO enrollmentVO = new EnrollmentVO(); //강좌 생성시 강좌 제작자 등록 작업 
		enrollmentVO.setCourse_id(courseVO.getId());
		enrollmentVO.setUser_id(courseVO.getInstructor_id());
		enrollmentVO.setEnrolled_at(Timestamp.from(Instant.now()));
		enrollmentVO.setStatus("admin");

		courseDAO.enrollUserInCourse(enrollmentVO);

	}

	@Override
	public void enrollUserInCourse(int courseId, UserVO user) {
		EnrollmentVO enrollmentVO = new EnrollmentVO();
		enrollmentVO.setCourse_id(courseId);
		enrollmentVO.setEnrolled_at(Timestamp.from(Instant.now()));
		enrollmentVO.setStatus("user");
		enrollmentVO.setUser_id(user.getId());

		courseDAO.enrollUserInCourse(enrollmentVO);

	}

	@Override
	public List<CourseEnrollListDTO> selectCourseEnrollList(Integer currentUserId) {
		return courseDAO.selectCourseEnrollList(currentUserId);
	}

	@Override
	public List<CourseVO> selectMyCourseList(Integer currentUserId) {
		return courseDAO.selectMyCourseList(currentUserId);
	}

	@Override
	public CourseVO selectCourseById(Integer id) {
		return courseDAO.selectCourseById(id);
	}

	@Override
	public void registerTest(TestVO test) {
		test.setStatus("작성중");
		courseDAO.registerTest(test);
	}

	@Override
	public List<TestVO> selectTestInCourse(Integer courseId) {
		return courseDAO.selectTestInCourse(courseId);
	}

	@Override
	public void deleteTest(int testId) {
		courseDAO.deleteTest(testId);
	}

	@Override
	public void completeTest(int testId) {
		courseDAO.completeTest(testId);

	}

}
