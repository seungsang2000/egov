package egovframework.kss.main.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.kss.main.dto.CourseScoreDTO;
import egovframework.kss.main.dto.CourseUserCountDTO;
import egovframework.kss.main.service.CourseService;
import egovframework.kss.main.service.QuestionService;
import egovframework.kss.main.service.UserService;
import egovframework.kss.main.vo.UserVO;
import net.bramp.ffmpeg.FFprobe;
import net.bramp.ffmpeg.probe.FFmpegFormat;
import net.bramp.ffmpeg.probe.FFmpegProbeResult;

@Controller
public class MainController {

	private static Logger Logger = LoggerFactory.getLogger(UserController.class);

	@Resource(name = "QuestionService")
	private QuestionService questionService;

	@Resource(name = "UserService")
	private UserService userService;

	@Resource(name = "CourseService")
	private CourseService courseService;

	@RequestMapping(value = "/main.do")
	public String loginPage() {
		return "login";
	}

	@RequestMapping(value = "/list.do")
	public String listPage() {
		return "list";
	}

	@RequestMapping(value = "/chkusr.do")
	public String checkUser() {
		return "chkusr";
	}

	@RequestMapping(value = "/egovSampleList.do")
	public String egovSampleList() {
		return "home";
	}

	@RequestMapping(value = "/errorPage.do")
	public String errorPage(@RequestParam(required = false) String error, Model model) {
		model.addAttribute("error", error);
		return "error";
	}

	@RequestMapping(value = "/chart.do")
	public String userChart(Model model) {
		UserVO user = userService.getCurrentUser();
		model.addAttribute("pageName", "userChart");
		List<CourseScoreDTO> courseScores = courseService.selectCourseScores(user.getId());
		model.addAttribute("courseScores", courseScores);

		List<CourseUserCountDTO> courseUserCount = courseService.selectCourseUserCounts(user.getId());
		model.addAttribute("courseUserCount", courseUserCount);

		if (user.getRole().equals("admin")) {
			return "adminChart";
		} else {
			return "userChart";
		}

	}

	@PostMapping("/uploadVideo")
	@ResponseBody
	public String uploadVideo(@RequestParam("video") MultipartFile videoFile, @RequestParam("userId") String userId, @RequestParam("testId") String testId, @RequestParam("courseId") String courseId, @RequestParam("duration") String duration2) throws InterruptedException {

		if (videoFile.isEmpty()) {
			return "{\"message\":\"비디오 파일이 비어 있습니다.\"}";
		}

		String uploadDir = "C:\\videoupload\\" + courseId + "\\";
		File uploadDirectory = new File(uploadDir);
		if (!uploadDirectory.exists()) {
			uploadDirectory.mkdirs();
		}

		// 사용자 ID와 시험 ID를 포함한 비디오 파일 경로
		String existingVideoPath = uploadDir + "video_" + userId + "_" + testId + ".webm"; // 기존 비디오 파일 경로
		String newVideoPath = uploadDir + videoFile.getOriginalFilename(); // 새 비디오 파일 경로

		// 임시 파일 경로
		File tempFile = new File(newVideoPath);

		try {
			// 새 비디오 파일을 임시로 저장
			videoFile.transferTo(tempFile);

			// 기존 비디오 파일이 존재하는 경우, 이어붙이기
			if (new File(existingVideoPath).exists()) {
				String duration = getVideoDuration(existingVideoPath); // 기존 비디오 길이 구하기
				System.out.println("기존 비디오 길이: " + duration + "초"); // 길이 출력

				if (!duration.equals("00:00:00")) {
					Map<String, Object> params = new HashMap<>();
					params.put("userId", Integer.parseInt(userId));
					params.put("testId", Integer.parseInt(testId));
					params.put("newPausePosition", duration);

					questionService.updateExamPausePosition(params);
				}

				String mergedFilePath = uploadDir + "merged_video_" + userId + "_" + testId + ".webm"; // 병합된 파일 경로
				mergeVideos(existingVideoPath, tempFile.getAbsolutePath(), mergedFilePath);

				// 기존 비디오 파일을 새로운 병합된 파일로 교체
				File mergedFile = new File(mergedFilePath);
				File existingFile = new File(existingVideoPath);
				if (existingFile.delete()) {
					mergedFile.renameTo(existingFile);
				}

				// 임시 파일 삭제
				tempFile.delete();

				return "{\"message\":\"비디오 업로드 및 이어붙이기 성공: " + existingVideoPath + "\"}";
			} else {

				tempFile.renameTo(new File(existingVideoPath));
				String videoDuration = convertToHMSFormat(duration2);
				System.out.println(videoDuration);
				return "{\"message\":\"비디오 업로드 성공: " + existingVideoPath + "\"}";
			}
		} catch (IOException e) {
			e.printStackTrace();
			return "{\"message\":\"비디오 업로드 실패: " + e.getMessage() + "\"}";
		}
	}

	private void mergeVideos(String video1, String video2, String outputFilePath) throws IOException, InterruptedException {
		String fileListPath = "C:\\videoupload\\filelist.txt";
		try (FileWriter writer = new FileWriter(fileListPath)) {
			writer.write("file '" + video1 + "'\n");
			writer.write("file '" + video2 + "'\n");
		}

		ProcessBuilder processBuilder = new ProcessBuilder("ffmpeg", "-f", "concat", "-safe", "0", "-i", fileListPath, "-c", "copy", outputFilePath);
		processBuilder.redirectErrorStream(true);
		Process process = processBuilder.start();

		// FFmpeg의 출력 읽기
		try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
			String line;
			while ((line = reader.readLine()) != null) {

			}
		}

		int exitCode = process.waitFor();
		if (exitCode != 0) {
			throw new RuntimeException("FFmpeg 이어붙이기 프로세스가 실패했습니다. 종료 코드: " + exitCode);
		}

		// 임시 파일 목록 삭제
		new File(fileListPath).delete();
	}

	private String getVideoDuration(String videoPath) throws IOException, InterruptedException {
		System.out.println("@@ media_player_time start @@");
		String returnData = "0";

		try {
			FFprobe ffprobe = new FFprobe("C:\\ffmpeg-2024-11-03-git-df00705e00-full_build\\bin\\ffprobe.exe"); // window에 설치된  ffprobe.exe 경로
			FFmpegProbeResult probeResult = ffprobe.probe(videoPath);
			FFmpegFormat format = probeResult.getFormat();
			double seconds = format.duration;

			int hours = (int) (seconds / 3600);
			int minutes = (int) ((seconds % 3600) / 60);
			int sec = (int) (seconds % 60);

			returnData = String.format("%02d:%02d:%02d", hours, minutes, sec);
			System.out.println("Video Duration: " + returnData);

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			System.out.println("@@ media_player_time end @@");
		}

		return returnData;

	}

	public String convertToHMSFormat(String videoDuration) {
		String returnData = "00:00:00";

		try {

			String[] timeParts = videoDuration.split("\\.");
			int seconds = 0;
			int milliseconds = 0;

			if (timeParts.length == 2) {
				// 초와 밀리초로 분리된 경우
				seconds = Integer.parseInt(timeParts[0]);
				milliseconds = Integer.parseInt(timeParts[1]);
			} else {
				// 밀리초 정보가 없는 경우
				seconds = Integer.parseInt(timeParts[0]);
			}

			seconds += milliseconds / 100;

			// "시:분:초" 형식으로 변환
			int minutes = seconds / 60;
			seconds = seconds % 60;

			returnData = String.format("%02d:%02d:%02d", 0, minutes, seconds);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnData;
	}

}
