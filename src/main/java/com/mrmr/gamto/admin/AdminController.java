package com.mrmr.gamto.admin;

import java.io.IOException;
import java.util.Map;

import com.mrmr.gamto.utils.AlertUtil;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.mrmr.gamto.admin.dto.AdminMemberDTO;
import com.mrmr.gamto.admin.service.AdminService;
import com.mrmr.gamto.store.dto.StoreDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {
	private final int onePageNumDefault = 20;

	@Autowired
	AdminService adminService;

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

	// admin url 진입
	@RequestMapping("")
	public String inAdmin() {
		return "redirect:/admin/login";
	}

	// 관리자 추가 폼
	@GetMapping("/new")
	public String getAdmin() {
		return "admin/adminJoinForm";
	}

	// 관리자 추가 액션
	@PostMapping("/new")
	public String postAdmin(AdminMemberDTO dto, Model model) {
		adminService.postAdmin(dto, model);
		return "redirect:/admin/login";
	}

	// 관리자 로그인 폼
	@GetMapping("/login")
	public String getAdminLogin() {
		return "admin/adminLoginForm";
	}

	// 관리자 로그인 액션
	@PostMapping("/login")
	public String postAdminLogin(String admin_id, String admin_password, HttpSession session,
			HttpServletRequest request, Model model) {
		adminService.postAdminLogin(admin_id, admin_password, request, session, model);
		return "admin/adminLoginForm";
	}

	// 관리자 로그아웃
	@GetMapping("/logout")
	public String adminLogout(HttpSession session) {
		session.invalidate();
		return "admin/adminLoginForm";
	}

	// 감토지기 관리 진입
	@RequestMapping("/admin-member")
	public String adminMember() {
		return "redirect:/admin/admin-member/" + onePageNumDefault + "/1";
	}

	// 감토지기 리스트 불러오기
	@RequestMapping("/admin-member/{onePageNo}/{pageNo}")
	public String adminMemberList(Model model, @PathVariable String onePageNo, @PathVariable String pageNo,String changePageNo) {
		return adminService.adminMemberList(model, onePageNo, pageNo, changePageNo);
	}

	// 감토지기 삭제
	@ResponseBody
	@DeleteMapping("/admin-member/{admin_id}")
	public int deleteAdminMember(@PathVariable String admin_id,HttpSession session) {
		return adminService.deleteAdminMember(admin_id, session);
	}

	// 감토지기 권한 수정
	@ResponseBody
	@PutMapping("/admin-member/{admin_id}")
	public int UpdateAdminMember(HttpSession session,@RequestBody Map<String,String> role,@PathVariable String admin_id) {
		return adminService.updateAdminMember(session, role, admin_id);
	}
	
	/*** 회원 관리기능 ***********************************************/
	//회원 관리 /admin/member
	@RequestMapping("/member")
	public String Member() {
		return "redirect:/admin/member/" + onePageNumDefault + "/1";
	}
	@RequestMapping("/member/{onePageNo}/{pageNo}")
	public String memberList(Model model, @PathVariable String onePageNo, @PathVariable String pageNo,String changePageNo) {
		return adminService.memberList(model, onePageNo, pageNo, changePageNo);
	}
	//수정, 정지
	@ResponseBody
	@PutMapping("/member/state/{u_id}")
	public int updateMember(HttpSession session,@RequestBody Map<String,String> mapstate,@PathVariable String u_id) {
		return adminService.updateMember(session, mapstate, u_id);
	}

	/*** ask 문의관리기능 ***********************************************/
	@RequestMapping("/ask")
	public String askboard() {
		return "redirect:ask/" + onePageNumDefault + "/1";
	}
	//문의 리스트
	@RequestMapping("/ask/{onePageNo}/{pageNo}")
	public String askboard(Model model, @PathVariable String onePageNo, @PathVariable String pageNo,
			String changePageNo) {
		return adminService.adkboard(model, onePageNo, pageNo, changePageNo);
	}
	//문의기록 보기
	@GetMapping("/ask/view/{a_seq_number}")
	public String askview(HttpSession session, Model model, @PathVariable("a_seq_number") int a_seq_number) {
		return adminService.askview(session, model, a_seq_number);
	}
	//신고진행사항
	@ResponseBody
	@PutMapping("/ask/view/{a_seq_number}")
	public int askviewPut(HttpSession session, Model model, @PathVariable("a_seq_number") int a_seq_number,
		@RequestBody Map<String,String> a_complete) {
		return  adminService.askviewPut(session, model, a_seq_number, a_complete);
	}

	@GetMapping("/ask/{a_seq_number}/file")
	public String askFile(@PathVariable("a_seq_number") int a_seq_number) {
		return "";
	}

	@GetMapping("/ask/search")
	public String asksearch(HttpSession session, Model model, String pageNo, String a_category, String query) {
		return adminService.asksearch(session, model, pageNo, a_category, query);
	}

	/*** accuse 신고관리기능 ***********************************************/
	@RequestMapping("/accuse")
	public String accuseboard() {
		return "redirect:accuse/20/1";
	}

	@RequestMapping("/accuse/{onePageNo}/{pageNo}")
	public String accuseboard(Model model, @PathVariable String onePageNo, @PathVariable String pageNo,
			String changePageNo) {
		return adminService.accuseboard(model, onePageNo, pageNo, changePageNo);
	}

	@GetMapping("/accuse/view/{ac_seq_number}")
	public String accuseview(HttpSession session, Model model, @PathVariable("ac_seq_number") int ac_seq_number) {
		return adminService.accuseview(session, model, ac_seq_number);
	}
	// 신고상태 변경
	@ResponseBody
	@PutMapping("/accuse/view/{ac_seq_number}")
	public int accuseviewPut(HttpSession session, Model model, @PathVariable("ac_seq_number") int ac_seq_number,
			@RequestBody Map<String,String> ac_complete) {
		return adminService.accuseviewPut(session, model, ac_seq_number, ac_complete);
	}

	@GetMapping("/accuse/search")
	public String accusesearch(HttpSession session, Model model, String pageNo, String a_category, String query) {
		return adminService.accusesearch(session, model, pageNo, a_category, query);
	}
	
	/*** 게시판 관리기능 ***********************************************/
	@RequestMapping("/board")
	public String board() {
		return "redirect:/admin/board/20/1";
	}

	@RequestMapping("/board/{onePageNo}/{pageNo}")
	public String boardList(Model model, @PathVariable String onePageNo, @PathVariable String pageNo, String changePageNo) {
		return adminService.boardList(model, onePageNo, pageNo, changePageNo);
	}
	//게시판 삭제 복구 - 너의생각
	@ResponseBody
	@PutMapping("/{board}/{seq_number}")
	public int deleteContent(HttpSession session,@PathVariable String board,@PathVariable String seq_number) {
		return adminService.deleteContent(session, board, seq_number);
	}
	
	/*** 댓글 관리기능 ***********************************************/
	//코멘트url진입
	@RequestMapping("/comment")
	public String comment() {
		return "redirect:/admin/comment/" + onePageNumDefault + "/1";
	}
	//댓글 리스트
	@RequestMapping("/comment/{onePageNo}/{pageNo}")
	public String commentList(Model model, @PathVariable String onePageNo, @PathVariable String pageNo, String changePageNo) {
		return adminService.commentList(model, onePageNo, pageNo, changePageNo);
	}
	//댓글 삭제처리
	@ResponseBody
	@PutMapping("/comment/{c_seq_number}")
	public int deleteComment(HttpSession session,@PathVariable String c_seq_number) {
		return adminService.deleteComment(session, c_seq_number);
	}

	/*** store 상점관리기능 ***********************************************/	
	@RequestMapping("/store")
	public String storeboard() {
		return"redirect:store/"+onePageNumDefault+"/1";
	}
	//상점 관리 진입
	@RequestMapping("/store/{onePageNo}/{pageNo}")
	public String storeList( Model model,@PathVariable String onePageNo,@PathVariable String pageNo,String changePageNo) {
		return adminService.storeList(model, onePageNo, pageNo, changePageNo);
	}
	// 상점 등록 진입
	@GetMapping("/store/new")
	public String insertStoreForm() {
		return "admin/storeForm";
	}

	// 상점 등록 액션
	@PostMapping("/store/new")
	public String insertStore(StoreDTO dto, MultipartFile filename){
		return adminService.insertStoreForm(dto, filename);
	}
	
	// 상점 수정 폼
	@GetMapping("/store/edit/{b_code}")
	public String edittStoreForm(@PathVariable String b_code,Model model) {
		return adminService.edittStoreForm(b_code, model);
	}
	
	// 상점 수정 액션
	@PostMapping("/store/edit/{b_code}")
	public String editStore(StoreDTO dto, MultipartFile filename,Model model) {
		return adminService.editStore(dto, filename, model);
	}

}
