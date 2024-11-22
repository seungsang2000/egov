package egovframework.kss.main.dto;

import java.util.List;

import egovframework.kss.main.vo.CourseVO;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class TestReviewDTO {
	private int testId;
	private List<QuestionListDTO> questions;
	private QuestionDetailWithUserAnswerDTO currentQuestion;
	private int selectedQuestionId;
	private QuestionDetailDTO questionDetail;
	private String correctAnswer;
	private CourseVO course;
	private boolean editable;
}
