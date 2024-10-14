package egovframework.kss.main.controller;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.kss.main.service.CourseService;
import egovframework.kss.main.vo.CourseVO;

@Controller
public class CourseController {
	private static Logger Logger = LoggerFactory.getLogger(CourseController.class);

	@Resource(name = "CourseService")
	private CourseService courseService;

	@RequestMapping(value = "/mainPage.do")
	public String home(Model model) {

		Logger.debug("CourseList.......");
		List<?> list = courseService.selectCourseList();
		model.addAttribute("list", list);
		model.addAttribute("pageName", "myCourses");

		return "home";
	}

	@RequestMapping(value = "/courseRegister.do")
	public String courseRegister(Model model) {
		model.addAttribute("pageName", "courseRegister");

		return "courseAdd";
	}

	@PostMapping("/courseCreate.do")
	public String courseCreate(@ModelAttribute CourseVO course) {
		course.setInstructor_id(1);

		courseService.registerCourse(course);

		return "redirect:/mainPage.do";
	}

	@RequestMapping("/course.do")
	public String selectCourse(@RequestParam("id") int id, Model model) {
		System.out.println("course id: " + id);

		return "tests";
	}

}
