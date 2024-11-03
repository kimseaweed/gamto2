package com.mrmr.gamto.write;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.mrmr.gamto.report.dao.IBookReportDAO;
import com.mrmr.gamto.report.dto.BookReportDTO;
import com.mrmr.gamto.utils.GamtoService;
import com.mrmr.gamto.write.dao.WriteDAO;
import com.mrmr.gamto.write.service.WriteService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class WriteController {

	@Autowired
	WriteDAO writedao;
	@Autowired
	WriteService service;
	@Autowired
	GamtoService gamtoservice;


	@RequestMapping("/report/new")
	public String writeForm(HttpSession session, Model model) {
		return gamtoservice.needLogin(session, model, "/report/new", "write/write");
	}

	@PostMapping("/report")
	public String create(MultipartFile filename, BookReportDTO dto) {
		try {
			dto.setR_filename(service.saveFile(filename));
			writedao.writeBookReport(dto);
		}catch (Exception e) {
			log.error("An error occurred: {}", e.getMessage(), e);
		}
		return "redirect:/report";
	}

	@PutMapping("/reportupdate/{r_seq_number}")
	public String update(String showImg, MultipartFile filename, BookReportDTO dto) throws Exception {
		// 상황1 : 기존에 있다가 안바꿨다 ->삭제x 업로드x 랜덤셋팅x
		// 상황2 : 기존에 있다가 새로운걸로 바꿨다 ->삭제o 업로드o 랜덤셋팅x
		// 상황3 : 기존에 있다가 기본이미지 하고싶다 ->삭제o 업로드x 랜덤셋팅o
		// 상황4 : 기존에 없었는데 새로 등록했다 ->삭제x 업로드o 랜덤셋팅x
		// 상황5 : 기존에 없었는데 바꾸진 않았다 ->삭제x 업로드x 랜덤셋팅x
		// 상황6 : 기존에 없었는데 기본이미지 하고싶다 ->삭제x 업로드x 랜덤셋팅o
		// 변화가 있는경우 (상황2,3,4,6)
		if (!showImg.equals(dto.getR_filename())) {
			// 상황2,3
			if (!dto.getR_filename().substring(0, 6).equals("default")) {
				service.deleteFile(dto.getR_filename());
			}
			// (상황4,6) 여기서시작 + (상황2,3) 처리후 이어서 진행
			dto.setR_filename(service.saveFile(filename));
		}
		// 변화가 없는경우 여기서 시작 (상황1,5) + 변화 처리한 (상황 나머지) => 업로드
		writedao.updateBookReport(dto);
		return "redirect:/report/view?r_seq_number=" + dto.getR_seq_number();
	}


}