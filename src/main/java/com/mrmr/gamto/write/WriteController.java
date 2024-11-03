package com.mrmr.gamto.write;

import com.mrmr.gamto.utils.AlertUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.mrmr.gamto.report.dto.BookReportDTO;
import com.mrmr.gamto.utils.GamtoService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;

@Slf4j
@Controller
public class WriteController {

	@Autowired
	WriteService writeService;
	@Autowired
	GamtoService gamtoservice;

	@ExceptionHandler(Exception.class)
	public void handleException(Exception ex, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
		log.error(ex.getMessage(), ex);
		AlertUtil.HeaderAlertError(model);
		String referer = request.getHeader("Referer");
		if (referer != null) {
			response.sendRedirect(referer);
		} else {
			response.sendRedirect(request.getContextPath() + "/");
		}
	}

	@RequestMapping("/report/new")
	public String writeForm(HttpSession session, Model model) {
		return gamtoservice.needLogin(session, model, "/report/new", "write/write");
	}

	@PostMapping("/report")
	public String create(MultipartFile filename, BookReportDTO bookReportDTO) {
		return writeService.create(filename, bookReportDTO);
	}

	@PutMapping("/reportupdate/{r_seq_number}")
	public String update(String showImg, MultipartFile filename, BookReportDTO bookReportDTO) throws Exception {
		return writeService.update(showImg, filename, bookReportDTO);
	}

}