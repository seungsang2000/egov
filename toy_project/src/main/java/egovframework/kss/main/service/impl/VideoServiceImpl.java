package egovframework.kss.main.service.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.kss.main.service.QuestionService;
import egovframework.kss.main.service.VideoService;
import net.bramp.ffmpeg.FFprobe;
import net.bramp.ffmpeg.probe.FFmpegFormat;
import net.bramp.ffmpeg.probe.FFmpegProbeResult;

@Service("VideoService")
public class VideoServiceImpl implements VideoService {

	@Resource(name = "QuestionService")
	private QuestionService questionService;

	@Override
	public String uploadVideo(MultipartFile videoFile, String userId, String testId, String courseId, String duration) throws IOException, InterruptedException {
		if (videoFile.isEmpty()) {
			throw new IllegalArgumentException("비디오 파일이 비어 있습니다.");
		}

		// 업로드 디렉토리 설정
		String uploadDir = "C:\\videoupload\\" + courseId + "\\";
		File uploadDirectory = new File(uploadDir);
		if (!uploadDirectory.exists()) {
			uploadDirectory.mkdirs();
		}

		// 파일 경로 설정
		String existingVideoPath = uploadDir + "video_" + userId + "_" + testId + ".webm";
		String newVideoPath = uploadDir + videoFile.getOriginalFilename();

		// 임시 파일 경로
		File tempFile = new File(newVideoPath);
		videoFile.transferTo(tempFile);

		// 기존 파일 존재 여부 확인 및 처리
		if (new File(existingVideoPath).exists()) {
			String existingDuration = getVideoDuration(existingVideoPath);
			if (!existingDuration.equals("00:00:00")) {
				Map<String, Object> params = new HashMap<>();
				params.put("userId", Integer.parseInt(userId));
				params.put("testId", Integer.parseInt(testId));
				params.put("newPausePosition", existingDuration);
				questionService.updateExamPausePosition(params);
			}

			String mergedFilePath = uploadDir + "merged_video_" + userId + "_" + testId + ".webm";
			mergeVideos(existingVideoPath, tempFile.getAbsolutePath(), mergedFilePath);

			// 기존 파일 교체
			File mergedFile = new File(mergedFilePath);
			File existingFile = new File(existingVideoPath);
			if (existingFile.delete()) {
				mergedFile.renameTo(existingFile);
			}

			// 임시 파일 삭제
			tempFile.delete();
			return "비디오 업로드 및 이어붙이기 성공: " + existingVideoPath;
		} else {
			tempFile.renameTo(new File(existingVideoPath));
			return "비디오 업로드 성공: " + existingVideoPath;
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
