package com.mrmr.gamto.admin.service;

import java.io.File;
import java.security.MessageDigest;
import java.util.Base64;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminService {
	//store 업로드 파일 보관 경로
	private String projectPath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\img\\book\\";
	private String deletePath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\img\\book\\deleted\\";

	public String saveFile(MultipartFile file) throws Exception {
		//저장할 파일이름을 "UUIT_원본파일이름"으로 명명
		String fileName = file.getOriginalFilename();
		//경로와 파일명을 지정하여 파일객체 생성
		File savefile = new File(projectPath + fileName);
		//파일저장
		file.transferTo(savefile);
		log.info(fileName+"파일 저장 완료");
		//db에 저장할 용도로 파일이름 리턴
		return fileName;
	}
	public String saveUUIDFile(MultipartFile file) throws Exception {
		//랜덤UUID 생성
		UUID uuid = UUID.randomUUID();
		//저장할 파일이름을 "UUIT_원본파일이름"으로 명명
		String fileName = uuid + "_" +file.getOriginalFilename();
		//경로와 파일명을 지정하여 파일객체 생성
		File savefile = new File(projectPath + fileName);
		//파일저장
		file.transferTo(savefile);
		log.info(fileName+"파일 저장 완료");
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
	

	//(new SHA().Encrypt("my password"));
	@Value("${admin-secretkey}")
	private String SECRET_KEY;
	//sha256 암호화
    public String encrypt(String text) {
        String encryptedText = "";
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
            String dataWithSaltAndKey = text + SECRET_KEY;
            messageDigest.update(dataWithSaltAndKey.getBytes("UTF-8"));
            encryptedText = new String(Base64.getEncoder().encode(messageDigest.digest()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return encryptedText;
    }
}
