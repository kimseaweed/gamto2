package com.mrmr.gamto.write;

import java.io.File;
import java.util.UUID;

import com.mrmr.gamto.report.dto.BookReportDTO;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WriteService {
	private final WriteDAO writeDAO;
	//write 업로드 파일 보관 경로
	private String projectPath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\userUpload\\";
	private String deletePath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\userUpload\\deleted\\";

	public WriteService(WriteDAO writeDAO) {
		this.writeDAO = writeDAO;
	}

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

	public String create(MultipartFile filename, BookReportDTO bookReportDTO){
		try {
			bookReportDTO.setR_filename(saveFile(filename));
			writeDAO.writeBookReport(bookReportDTO);

		} catch (Exception e) {
			log.error("An error occurred: {}", e.getMessage(), e);
		}
			return "redirect:/report";
	}


	public String update(String showImg, MultipartFile filename, BookReportDTO bookReportDTO) {
		try {
			// 상황1 : 기존에 있다가 안바꿨다 ->삭제x 업로드x 랜덤셋팅x
			// 상황2 : 기존에 있다가 새로운걸로 바꿨다 ->삭제o 업로드o 랜덤셋팅x
			// 상황3 : 기존에 있다가 기본이미지 하고싶다 ->삭제o 업로드x 랜덤셋팅o
			// 상황4 : 기존에 없었는데 새로 등록했다 ->삭제x 업로드o 랜덤셋팅x
			// 상황5 : 기존에 없었는데 바꾸진 않았다 ->삭제x 업로드x 랜덤셋팅x
			// 상황6 : 기존에 없었는데 기본이미지 하고싶다 ->삭제x 업로드x 랜덤셋팅o
			// 변화가 있는경우 (상황2,3,4,6)
			if (!showImg.equals(bookReportDTO.getR_filename())) {
				// 상황2,3
				if (!bookReportDTO.getR_filename().substring(0, 6).equals("default")) {
					deleteFile(bookReportDTO.getR_filename());
				}
				// (상황4,6) 여기서시작 + (상황2,3) 처리후 이어서 진행
				bookReportDTO.setR_filename(saveFile(filename));
			}
			// 변화가 없는경우 여기서 시작 (상황1,5) + 변화 처리한 (상황 나머지) => 업로드
			writeDAO.updateBookReport(bookReportDTO);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
			return "redirect:/report/view?r_seq_number=" + bookReportDTO.getR_seq_number();
	}
}
