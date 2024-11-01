package egovframework.kss.main.service.impl;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.kss.main.service.OpenAIService;
import egovframework.rte.fdl.property.EgovPropertyService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@Service("OpenAIService")
public class OpenAIServiceImpl implements OpenAIService {

	private final String apiKey;

	@Autowired
	public OpenAIServiceImpl(EgovPropertyService propertiesService) {
		this.apiKey = propertiesService.getString("openai.api.key");
	}

	private final OkHttpClient client = new OkHttpClient.Builder().connectTimeout(30, TimeUnit.SECONDS) // 연결 타임아웃
			.readTimeout(30, TimeUnit.SECONDS) // 읽기 타임아웃
			.writeTimeout(30, TimeUnit.SECONDS) // 쓰기 타임아웃
			.build();

	@Override
	public String getFeedback(String question) {
		JSONObject json = new JSONObject();
		json.put("model", "gpt-4");

		JSONArray messages = new JSONArray();
		JSONObject message = new JSONObject();
		message.put("role", "user");
		message.put("content", question);
		messages.add(message);

		json.put("messages", messages);
		json.put("temperature", 0.7);

		RequestBody body = RequestBody.create(json.toString(), MediaType.get("application/json; charset=utf-8"));

		Request request = new Request.Builder().url("https://api.openai.com/v1/chat/completions").header("Authorization", "Bearer " + apiKey).post(body).build();

		try (Response response = client.newCall(request).execute()) {
			if (response.isSuccessful()) {
				// JSON 응답 파싱
				String responseBody = response.body().string();
				JSONObject responseJson = JSONObject.fromObject(responseBody);

				// content 추출
				String content = responseJson.getJSONArray("choices").getJSONObject(0).getJSONObject("message").getString("content");

				System.out.println(content);
				return content; // content 반환
			} else {
				return "OpenAI API 요청 실패: " + response.code() + " " + response.message();
			}
		} catch (IOException e) {
			e.printStackTrace();
			return "OpenAI API 호출 중 오류 발생: " + e.getMessage();
		}
	}
}
