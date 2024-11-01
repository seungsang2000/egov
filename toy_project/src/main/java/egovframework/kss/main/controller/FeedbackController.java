package egovframework.kss.main.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import egovframework.kss.main.dto.QuestionDetailDTO;
import egovframework.kss.main.model.Option;
import egovframework.kss.main.service.CourseService;
import egovframework.kss.main.service.OpenAIService;
import egovframework.kss.main.service.QuestionService;
import egovframework.kss.main.service.UserService;
import egovframework.kss.main.vo.UserVO;

@RestController
public class FeedbackController {

	@Resource(name = "UserService")
	private UserService userService;

	@Resource(name = "CourseService")
	private CourseService courseService;

	@Resource(name = "OpenAIService")
	private OpenAIService openAIService;

	@Resource(name = "QuestionService")
	private QuestionService questionService;

	@GetMapping("/getFeedback.do")
	public String getFeedback(@RequestParam int questionId) {
		UserVO user = userService.getCurrentUser();
		int userId = user.getId();
		QuestionDetailDTO questionDetail = questionService.selectQuestionById(questionId);

		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("questionId", questionId);
		params.put("testId", questionDetail.getTest_id());

		String userAnswer = questionService.selectUserAnswer(params);

		String question = "";
		if (questionDetail.getQuestion_type().equals("객관식")) {
			question = "문제 : " + questionDetail.getQuestion_text() + "\n보기:\n";

			// 옵션 추가
			for (Option option : questionDetail.getOptions()) {
				question += option.getOption_number() + ". " + option.getOption_text() + "\n";
			}

			// 정답 및 유저의 답변 추가
			question += "정답 : " + questionDetail.getCorrect_answer() + "\n";
			question += "유저의 답변 : " + userAnswer + "\n";
		} else if (questionDetail.getQuestion_type().equals("주관식")) {
			question = "문제 : " + questionDetail.getQuestion_text() + "\n";

			// 정답 및 유저의 답변 추가
			question += "정답 : " + questionDetail.getCorrect_answer() + "\n";
			question += "유저의 답변 : " + userAnswer + "\n";
		}

		question += "문제와 정답, 유저의 답변을 분석하고, 올바른 정답과 유저의 답변을 비교한 후, 유저가 더 나은 선택을 할 수 있도록 자세한 설명과 해설을 제공해 주세요. 유저 답변이 빈 경우, 답변을 작성하지 않은거야. 단막이나 줄바꿈 같은거 잘 해주고.";

		System.out.println(question);
		return openAIService.getFeedback(question);
	}
}
