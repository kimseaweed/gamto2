package com.mrmr.gamto.write.service;

import java.io.File;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WriteService {
	//write 업로드 파일 보관 경로
	private String projectPath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\userUpload\\";
	private String deletePath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\userUpload\\deleted\\";

	public String saveFile(MultipartFile file) throws Exception {
		//저장한 파일이 없다면 기본이미지 1~5 선택하여 리턴
		if (file.getOriginalFilename().equals("") || file == null) {
			return "default" + ((int) (Math.random() * 5) + 1) + ".png";
		}
		//랜덤UUID 생성
		UUID uuid = UUID.randomUUID();
		//저장할 파일이름을 "UUIT_원본파일이름"으로 명명
		String fileName = uuid + "_" + file.getOriginalFilename();
		//경로와 파일명을 지정하여 파일객체 생성
		File savefile = new File(projectPath + fileName);
		//파일저장
		file.transferTo(savefile);
		//db에 저장할 용도로 파일이름 리턴
		return fileName;
	}

	public void deleteFile(String oldfilename) throws Exception {
		//파일경로 + 삭제할 파일명으로 파일객체 생성 
		File deleteFile = new File(projectPath + oldfilename);
		//일치하는 파일이 있다면 파일을 이동한다.
		if (deleteFile.exists()) { 
			deleteFile.renameTo(new File(deletePath));
			//deleteFile.delete(); //파일삭제
			log.info("파일 이동 완료");
		} else {
			log.error("deleteFile 에러. 파일이없습니다");
		}
	}
}
