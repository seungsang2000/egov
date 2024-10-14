package egovframework.kss.main.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ThumbController {
	private static Logger Logger = LoggerFactory.getLogger(QnAController.class);

	@RequestMapping(value = "thumbList.do")
	public String ThumbList() {
		System.out.println("-------thumbList.do");

		return "bbs/thumbList";
	}

}
