package egovframework.kss.main.service.impl;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.stereotype.Service;

import egovframework.kss.main.service.ErrorService;

@Service("ErrorService")
public class ErrorServiceImpl implements ErrorService {

	@Override
	public String redirectErrorPage(String message) {
		try {
			message = URLEncoder.encode(message, "UTF-8");
			return "redirect:/errorPage.do?error=" + message; // 에러 페이지로 리디렉션
		} catch (UnsupportedEncodingException e) {
			// 인코딩 문제 발생 시 기본 메시지로 리디렉션
			return "redirect:/errorPage.do?error=알 수 없는 오류가 발생했습니다.";
		}
	}

}
