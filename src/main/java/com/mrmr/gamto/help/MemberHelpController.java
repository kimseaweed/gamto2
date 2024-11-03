package com.mrmr.gamto.help;

import com.mrmr.gamto.utils.AlertUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.mrmr.gamto.member.dto.MemberDTO;
import com.mrmr.gamto.member.dao.MemberDAO;
import com.mrmr.gamto.utils.GamtoService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;

@Slf4j
@Controller
@RequestMapping("/member/help")
public class MemberHelpController {

	@Autowired
	GamtoService gamtoService;
	@Autowired
	MemberHelpService memberHelpService ;

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

	/*
	 * id : 폼이동 POST) 
	 * POST) id/check - ajax요청으로 인증번호 발송 
	 * POST) id/res - 아이디 보여줌
	 */
	//아이디 찾기 : 로그인여부 확인후 폼 이동
	@RequestMapping("/id") 
	public String emailCAuthentication(HttpSession session, Model model) {
		return gamtoService.noneLogin(session, model, "help/findId");
	}
	//아이디 찾기 : ajax 인증코드 발송
	@ResponseBody
	@PostMapping("/id/check")
	public int idSearch(String u_name,String u_email,HttpSession session) {
		return memberHelpService.idSearch(u_name,u_email,session);
	}
	
	//아이디찾기 : 인증코드 맞는지 확인하기
	@ResponseBody
	@GetMapping("/id/check")
	public int codeCheck(HttpSession session,String code,String u_email) {
		return  memberHelpService.codeCheck(session, code, u_email);
	}	
	
	//아이디찾기 : 인증코드 입력후 이동
	@RequestMapping("/id/res")
	public String ifOk(HttpSession session,Model model) {
		return memberHelpService.ifOk(session, model);
	}
	
	// 비밀번호찾기 : 로그인 여부 확인후 폼 이동
	@RequestMapping("/pw")
	public String resetPwPage(HttpSession session, Model model) {
		return gamtoService.noneLogin(session, model, "help/resetPw");
	}
	
	// 비밀번호찾기 : ajax 정보확인
	@PostMapping("/pw/check")
	@ResponseBody
	public int pwSearch(String u_id, String u_email) {
		return memberHelpService.pwSearch(u_id, u_email);
	}

	// 비밀번호찾기 : 인증메일 전송완료
	@GetMapping("/pw/send")
	public String sendMail(Model model) {
		return memberHelpService.sendMail(model);
	}

	// 비밀번호찾기 : 인증링크 눌렀을때 연결되는 비번번경 페이지
	@GetMapping("/pw/token")
	public String subjectToken(@RequestParam(value = "t") String t, Model model) {
		return memberHelpService.subjectToken(t, model);
	}

	// 비밀번호찾기 : 비번 변경요청
	@PostMapping("/pw/token")
	public String subjectTokenRequest(String u_id, String u_pw, Model model) {
		return memberHelpService.subjectTokenRequest(u_id,u_pw,model);
	}

	
	// 문의 1 (문의 및 건의)
	@GetMapping("/ask/new") 
	public String askForm(String c) {
		return "help/askForm";
	}
	
	// 문의 2 (신고)
	@GetMapping("/accuse/new") 
	public String reportForm() {
		return "help/accuseForm";
	}
	
	// 문의 인서트
	@PostMapping("/ask")
	public String insertAsk(AskDTO dto,MultipartFile filename, Model model) {
		return memberHelpService.insertReport(dto, filename, model);
	}
	// 신고 인서트
	@PostMapping("/accuse")
	public String insertReport(AccuseDTO dto,MultipartFile filename, Model model) {
		return memberHelpService.insertAsk(dto, filename, model);
	}
	
	
	
}
