package com.mrmr.gamto.help;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mrmr.gamto.help.dto.AccuseDTO;
import com.mrmr.gamto.help.dto.AskDTO;
import com.mrmr.gamto.help.dao.HelpDAO;
import com.mrmr.gamto.help.service.MemberHelpService;
import com.mrmr.gamto.member.dto.MemberDTO;
import com.mrmr.gamto.member.dao.MemberDAO;
import com.mrmr.gamto.utils.GamtoService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member/help")
public class MemberHelpController {

	@Autowired
	MemberHelpService service;
	@Autowired
	MemberDAO memberdao;
	@Autowired
	HelpDAO helpDao;
	@Autowired
	GamtoService gamtoService;
	
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
		int authcode = service.idSearch(u_name, u_email);
		if(authcode==1||authcode==2) {
			return authcode;			
		}else {
			session.setAttribute("authCode",authcode);
			session.setMaxInactiveInterval(60*10);//분
			return 0;
		}
	}
	
	//아이디찾기 : 인증코드 맞는지 확인하기
	@ResponseBody
	@GetMapping("/id/check")
	public int codeCheck(HttpSession session,String code,String u_email) {
		log.info("/id/check get 요청 : 입력값"+code);
		if(session.getAttribute("authCode")==null) {
			log.error("세션에 코드가 없습니다");
			return 2;	
		}		
		String authcode =session.getAttribute("authCode").toString();
		if(!(authcode.equals(code))){
			log.error("코드가 틀렸습니다");
			return 1;
		}else {
		session.setAttribute("authCode",u_email);
		log.info("세션의 코드와 일치하여 "+u_email+"로 변경했습니다");
		return 0;
		}
		
	}	
	
	//아이디찾기 : 인증코드 입력후 이동
	@RequestMapping("/id/res")
	public String ifOk(HttpSession session,Model model) {
		String message="";
		String u_email = (String)session.getAttribute("authCode");
		log.info("/id/res 요청"+u_email);
		if(u_email!=null) {
			if(u_email.indexOf("@")>0) {
				session.removeAttribute("authcode");
				MemberDTO dto = memberdao.findIdDao(u_email);
				message=  "가입하신 아이디는<br> <b>"+dto.getU_id()+"</b>입니다.<br>"
						+ "감사합니다. <br>";
			}else {
				message = "세션이 만료되었거나 잘못된 접근입니다.<br>처음부터 다시 진행해주세요.";
			}
		}else {
			message = "잘못된 요청입니다.<br>처음부터 다시 진행해주세요";
		}
		model.addAttribute("script",message);		
		return "script";
	}
	
	/*****/
	
	
	// 비밀번호찾기 : 로그인 여부 확인후 폼 이동
	@RequestMapping("/pw")
	public String resetPwPage(HttpSession session, Model model) {
		return gamtoService.noneLogin(session, model, "help/resetPw");
	}
	
	// 비밀번호찾기 : ajax 정보확인
	@PostMapping("/pw/check")
	@ResponseBody
	public int pwSearch(String u_id, String u_email) {
		return service.pwSearch(u_id, u_email);
	}

	// 비밀번호찾기 : 인증메일 전송완료
	@GetMapping("/pw/send")
	public String sendMail(Model model) {
		model.addAttribute("message", "인증메일이 발송되었습니다");
		return "script";
	}

	// 비밀번호찾기 : 인증링크 눌렀을때 연결되는 비번번경 페이지
	@GetMapping("/pw/token")
	public String subjectToken(@RequestParam(value = "t") String t, Model model) {
		String u_id = service.getClaim(t);
		model.addAttribute("u_id", u_id);
		return "help/changePw";
	}

	// 비밀번호찾기 : 비번 변경요청
	@PostMapping("/pw/token")
	public String subjectToken(String u_id, String u_pw, Model model) {
		int result = service.resetPw(u_id, u_pw);
		if (result == 1) {
			model.addAttribute("message", "비밀번호 변경이 완료되었습니다.");
		} else if (result == 0) {
			model.addAttribute("message",
					"<script>alert('기존비번과 동일한 비밀번호입니다. 다른비밀번호를 입력해주세요'); history.back();</script>");
		} else {
			model.addAttribute("message", "비밀번호 변경이 실패했습니다. 다시 인증해주세요."); // 시스템오류
		}
		return "script";
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
	public String insertAsk(AskDTO dto,MultipartFile filename, Model model) throws Exception {
		log.debug("ask POST 요청");	
		dto.setA_filename(service.saveFile(filename,"ask"));
		int result = helpDao.insertAskDao(dto);
		if(result>0) {
			log.debug("ask db등록 성공");	
			return "help/result";
		}else {
			log.debug("ask db등록 실패");
			model.addAttribute("<script> alert('서버 통신 오류입니다. 다시 시도해주세요.'); window.close() </script>");
			return "script";
		}
	}
	// 신고 인서트
	@PostMapping("/accuse")
	public String insertReport(AccuseDTO dto,MultipartFile filename, Model model) throws Exception {
		log.debug("accuse POST 요청");
		dto.setAc_filename(service.saveFile(filename,"accuse"));
		int result = helpDao.insertAccuseDao(dto);
		if(result>0) {
			log.debug("accuse db등록 성공");
			return "help/result";
		}else {
			log.debug("accuse db등록 실패");
			model.addAttribute("<script> alert('서버 통신 오류입니다. 다시 시도해주세요.'); window.close() </script>");
			return "script";
		}
	}
	
	
	
}
