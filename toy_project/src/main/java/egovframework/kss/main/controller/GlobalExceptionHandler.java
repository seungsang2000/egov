package egovframework.kss.main.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import egovframework.kss.main.exception.CustomException;

@ControllerAdvice
@EnableWebMvc
public class GlobalExceptionHandler {

	@ExceptionHandler(CustomException.class)
	public ModelAndView handleCustomException(CustomException e) throws UnsupportedEncodingException {
		String message;
		try {
			message = URLEncoder.encode(e.getMessage(), "UTF-8");
		} catch (UnsupportedEncodingException ex) {
			message = URLEncoder.encode("알 수 없는 오류가 발생했습니다.", "UTF-8");
		}
		return new ModelAndView("redirect:/errorPage.do?error=" + message);
	}
}
