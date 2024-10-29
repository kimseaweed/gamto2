package com.mrmr.gamto.member;
import com.mrmr.gamto.member.seviec.MemberService;
import com.mrmr.gamto.utils.GamtoService;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mrmr.gamto.member.dao.MemberDAO;
import com.mrmr.gamto.member.dto.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	MemberDAO dao;
	@Autowired
	GamtoService gamtoService;
    @Autowired
    private MemberService memberService;

	@GetMapping
	public String Member(HttpSession session) {
		//여기에 마이페이지 이동 + 로그인 안한경우 로그인창 연결 해주세요
		String u_id = (String)session.getAttribute("name");
		if(u_id==null) {
		return "member/login";
		}
		return "member/myPage";
	}
	@RequestMapping("/myPage")
	public String needLoginMember(HttpSession session, Model model) {
		String u_id = (String) session.getAttribute("u_id");      
	    model.addAttribute("rows",dao.readMemberDao(u_id));
		return "member/myPage";
	}
	@RequestMapping("/login")
	public String needLoginMember(String connect,Model model) {
		model.addAttribute("connect",connect);
		return "member/loginMemberForm";
	}
	
	@RequestMapping("/processLoginMember")
	public String processLoginMember(HttpSession session,String u_id, String u_pw, Model model,String connect) {
		//로그인 정보확인
		MemberDTO dto = dao.loginDao(u_id, gamtoService.encrypt(u_pw));
		if(u_id.trim().equals("")||u_pw.trim().equals("")) {
			model.addAttribute("connect",connect);
			model.addAttribute("error",1);
			return "member/loginMemberForm";
			// 로그인폼 입력을 안하거나 빈칸이라서
		}else if(dto == null) {
			model.addAttribute("connect",connect);
			model.addAttribute("error",2);
			return "member/loginMemberForm";
			// 로그인정보가 없어 실패메세지
		}else if(dto.getU_delete().equals("1")){
			model.addAttribute("connect",connect);
			model.addAttribute("error",3);
			return "member/loginMemberForm";
			// 로그인정보가 있으나 탈퇴회원
		}else if(dto.getU_delete().equals("2")){
			model.addAttribute("connect",connect);
			model.addAttribute("error",4);
			return "member/loginMemberForm";
			// 로그인정보가 있으나 정지회원
		}else {
			session.setAttribute("u_id", u_id);
			if(connect=="") connect="/";
			return "redirect:"+connect;
			// 로그인정보가 있어서 원래 가려던 페이지로 연결
		}
	}

	//회원가입폼
	@RequestMapping("/addMember")
	public String addMember() {
		return "/member/addMember";
	}

	//중복체크 api
	@GetMapping("/api/dupVailCheck")
	@ResponseBody
	public int dupVailCheck(String column, String value) {
		try {
			if(!memberService.dupVailCheck(column,value)){return 1;
			}else {
				return 0;
			}
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	//회원가입액션
	@PostMapping
	public String addMember(@Valid MemberDTO memberdto, BindingResult bindingResult, Model model, RedirectAttributes redirectAttributes) {
		try {
			return memberService.addMember(memberdto, bindingResult, model, redirectAttributes);
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("headerAlert", "오류발생. 다시 시도해주세요.");
			return "member/addMember";
		}
	}


	@RequestMapping("/memberCheck")
	public String userlistPage(Model model) {
		model.addAttribute("list", dao.listDao());
		return "/member/memberCheck";
	}

	@RequestMapping("/deleteMember")
	public String u_delete(HttpServletRequest request) {
		return "/member/deleteMember";
	}
	@RequestMapping("/delete")
	public String delete(HttpServletRequest request) {
		dao.deleteMemberDao(request.getParameter("u_id"));
		return "member/logoutMember";
	}
	
	
	@RequestMapping("/logoutMember")
	public String logoutMember() {
		return "member/logoutMember";
	}

	 @RequestMapping("/updateMember")
	 public String updateMember(HttpSession session, Model model) {
	    String u_id = (String) session.getAttribute("u_id");      
	    model.addAttribute("rows",dao.readMemberDao(u_id));
	    return "/member/updateMember";
	 }
	 
	
	@RequestMapping("/processUpdateMember")
	public String processUpdateMember(MemberDTO dto,String mail1,String mail2) {
		 dto.setU_pw(gamtoService.encrypt(dto.getU_pw()));
		 dto.setU_email(mail1+"@"+mail2);
		 dao.updateMemberDao(dto);
		 return "/index";
	}

}
