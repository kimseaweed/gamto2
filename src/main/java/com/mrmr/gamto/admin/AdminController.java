package com.mrmr.gamto.admin;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mrmr.gamto.admin.dao.AdminDAO;
import com.mrmr.gamto.admin.dto.AdminMemberDTO;
import com.mrmr.gamto.admin.service.AdminService;
import com.mrmr.gamto.freeboard.dto.CommentDTO;
import com.mrmr.gamto.help.dto.AccuseDTO;
import com.mrmr.gamto.help.dto.AskDTO;
import com.mrmr.gamto.member.dto.MemberDTO;
import com.mrmr.gamto.member.dto.MyBoardDTO;
import com.mrmr.gamto.store.dao.StoreDAO;
import com.mrmr.gamto.store.dto.StoreDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

//@SessionAttribute(name = "userId", required = false)

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {
	private int onePageNumDefault = 20;

	@Autowired
	AdminDAO dao;
	@Autowired
	StoreDAO storedao;
	@Autowired
	AdminService service;

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
		//암호화된 비밀번호 셋팅
		dto.setAdmin_password(service.encrypt(dto.getAdmin_password()));
		int result = dao.insertAdminMember(dto);
		if (result != 1) {
			model.addAttribute("alert", "alert('등록되지 않았습니다.');");
		}else {
			model.addAttribute("alert", "alert('등록이 완료되었습니다.");
		}
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
		AdminMemberDTO dto = dao.selectAdminMember("where admin_id = '" + admin_id + "'");
		if (dto == null) { // 일치 레코드 없음
			model.addAttribute("alert", "alert('존재하지 않는 아이디입니다.')");
		} else if (admin_id.equals(dto.getAdmin_id())) { //아이디 일치함
			admin_password = service.encrypt(admin_password); //입력비번 암호화
			if (admin_password.equals(dto.getAdmin_password())) {  //비번일치
				if(dto.getAdmin_role()<4) { //권한이 3 이하만 로그인가능
				session.invalidate(); //기존세션 삭제
				HttpSession newsession = request.getSession(true); //세션 새로 생성
				newsession.setAttribute("admin_id", dto.getAdmin_id()); //아이디
				newsession.setAttribute("admin_role", dto.getAdmin_role()); //권한
				newsession.setAttribute("admin_name", dto.getAdmin_name()); //이름
				newsession.setAttribute("u_id", "<b>감토지기</b>"); //승인된 관리자					
				}else {
					model.addAttribute("alert", "alert('아직 승인되지 않습니다.');");
				}
			} else {
				model.addAttribute("alert", "alert('비밀번호가 일치하지 않습니다.');");
			}
		}
		return "admin/adminLoginForm";
	}

	// 관리자 로그아웃
	@GetMapping("/logout")
	public String adminLogout(HttpSession session) {
		session.invalidate();
		return "admin/adminLoginForm";
	}
	
	/*** 감토지기 관리기능 ***********************************************/
	// 진입
	@RequestMapping("/admin-member")
	public String adminMember() {
		return "redirect:/admin/admin-member/" + onePageNumDefault + "/1";
	}
	// 리스트 불러오기
	@RequestMapping("/admin-member/{onePageNo}/{pageNo}")
	public String adminMemberList(Model model, @PathVariable String onePageNo, @PathVariable String pageNo,String changePageNo) {
		log.debug("AdminMemberList 요청" + pageNo + "페이지를" + onePageNo + "개 요청");
		if (changePageNo != null) {
			if (!changePageNo.equals(onePageNo)) {
				log.debug(changePageNo + "개 표시로 바꿔달라는 request가 있습니다.");
				return "redirect:/admin/admin-member/" + changePageNo + "/" + pageNo;
			}
		}
		List<AdminMemberDTO> list = dao.adminListDao(pageNo, onePageNo,"");
		if (!list.isEmpty()) {
			model.addAttribute("adminList", list);
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("onePageNo", onePageNo);
		} else {
			log.debug("AdminMemberList 요청 처리결과 : 값이 없습니다.");
			model.addAttribute("adminList", null);
		}
		return "admin/adminMemberList";
	}
	// 감토지기 삭제
	@ResponseBody
	@DeleteMapping("/admin-member/{admin_id}")
	public int deleteAdminMember(@PathVariable String admin_id,HttpSession session) {
		Integer role = (Integer)session.getAttribute("role");
		if(role.intValue()>1) {
			return 2;
		}
		return dao.deleteAdminMember(admin_id);
	}
	// 감토지기 권한 수정
	@ResponseBody
	@PutMapping("/admin-member/{admin_id}")
	public int UpdateAdminMember(HttpSession session,@RequestBody Map<String,String> role,@PathVariable String admin_id) {
		Integer requestrole = (Integer)session.getAttribute("admin_ role");
		if(requestrole.intValue()>1) {
			return 2;
		}
		
		String admin_role=role.get("admin_role");
		return dao.updateAdminMember(admin_id,admin_role);
	}
	
	/*** 회원 관리기능 ***********************************************/
	//회원 관리 /admin/member
	@RequestMapping("/member")
	public String Member() {
		return "redirect:/admin/member/" + onePageNumDefault + "/1";
	}
	@RequestMapping("/member/{onePageNo}/{pageNo}")
	public String memberList(Model model, @PathVariable String onePageNo, @PathVariable String pageNo,String changePageNo) {
		log.debug("AdminMemberList 요청" + pageNo + "페이지를" + onePageNo + "개 요청");
		if (changePageNo != null) {
			if (!changePageNo.equals(onePageNo)) {
				log.debug(changePageNo + "개 표시로 바꿔달라는 request가 있습니다.");
				return "redirect:/admin/member/" + changePageNo + "/" + pageNo;
			}
		}
		List<MemberDTO> list = dao.memberListDao(pageNo, onePageNo,"");
		if (!list.isEmpty()) {
			model.addAttribute("memberList", list);
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("onePageNo", onePageNo);
		} else {
			log.debug("MemberList 요청 처리결과 : 값이 없습니다.");
			model.addAttribute("memberList", null);
		}
		return "admin/memberList";
		
	}
	//수정, 정지
	@ResponseBody
	@PutMapping("/member/state/{u_id}")
	public int UpdateMember(HttpSession session,@RequestBody Map<String,String> mapstate,@PathVariable String u_id) {
		if(session.getAttribute("admin_role")==null) {
			return 2;
		}
		Integer requestrole = (Integer)session.getAttribute("admin_role");
		if(requestrole.intValue()>1) {
			return 2;
		}
		String state = mapstate.get("state");
		return dao.updateMember(u_id,state);
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
		log.debug("askboard 요청" + pageNo + "페이지를" + onePageNo + "개 요청");
		if (changePageNo != null) {
			if (!changePageNo.equals(onePageNo)) {
				log.debug(changePageNo + "개 표시로 바꿔달라는 request가 있습니다.");
				return "redirect:/admin/ask/" + changePageNo + "/" + pageNo;
			}
		}
		List<AskDTO> list = dao.askListDao(pageNo, onePageNo);
		if (!list.isEmpty()) {
			model.addAttribute("askList", list);
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("onePageNo", onePageNo);
		} else {
			log.debug("askboard 요청 처리결과 : 값이 없습니다.");
			model.addAttribute("askList", null);
		}
		return "admin/askBoard";
	}
	//문의기록 보기
	@GetMapping("/ask/view/{a_seq_number}")
	public String askview(HttpSession session, Model model, @PathVariable("a_seq_number") int a_seq_number) {
		AskDTO dto = dao.askViewDao(a_seq_number);
		model.addAttribute("dto", dto);
		return "admin/askPage";
	}
	//신고진행사항
	@ResponseBody
	@PutMapping("/ask/view/{a_seq_number}")
	public int askviewPut(HttpSession session, Model model, @PathVariable("a_seq_number") int a_seq_number,
		@RequestBody Map<String,String> a_complete) {
		if(session.getAttribute("admin_role")==null) {
			return 2;
		}
		Integer requestrole = (Integer)session.getAttribute("admin_role");
		if(requestrole.intValue()>1) {
			return 2;
		}
		return dao.askUpdateComplete(a_seq_number,  a_complete.get("a_complete") );
	}

	@GetMapping("/ask/{a_seq_number}/file")
	public String askFile(@PathVariable("a_seq_number") int a_seq_number) {
		
		
		
		return "";
	}

	@GetMapping("/ask/search")
	public String asksearch(HttpSession session, Model model, String pageNo, String a_category, String query) {
		// dao.askSearchListDao(startNo,endNo,a_category,query)
		model.addAttribute("MaxPageNo", "");
		model.addAttribute("askList", "");
		return "admin/askBoard";
	}

	/*** accuse 신고관리기능 ***********************************************/
	@RequestMapping("/accuse")
	public String accuseboard() {
		return "redirect:accuse/20/1";
	}

	@RequestMapping("/accuse/{onePageNo}/{pageNo}")
	public String accuseboard(Model model, @PathVariable String onePageNo, @PathVariable String pageNo,
			String changePageNo) {
		log.debug("accuseboard 요청" + pageNo + "페이지를" + onePageNo + "개 요청");
		if (changePageNo != null) {
			if (!changePageNo.equals(onePageNo)) {
				log.debug(changePageNo + "개 표시로 바꿔달라는 request가 있습니다.");
				return "redirect:/admin/accuse/" + changePageNo + "/" + pageNo;
			}
		}
		List<AccuseDTO> list = dao.accuseListDao(pageNo, onePageNo);
		if (list.size() > 0) {
			model.addAttribute("accuseList", list);
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("onePageNo", onePageNo);
		} else {
			log.debug("accuseboard 요청 처리결과 : 값이 없습니다.");
		}
		return "admin/accuseBoard";
	}

	@GetMapping("/accuse/view/{ac_seq_number}")
	public String accuseview(HttpSession session, Model model, @PathVariable("ac_seq_number") int ac_seq_number) {
		AccuseDTO dto = dao.accuseViewDao(ac_seq_number);
		model.addAttribute("dto", dto);
		return "admin/accusePage";
	}
	// 신고상태 변경
	@ResponseBody
	@PutMapping("/accuse/view/{ac_seq_number}")
	public int accuseviewPut(HttpSession session, Model model, @PathVariable("ac_seq_number") int ac_seq_number,
			@RequestBody Map<String,String> ac_complete) {
		if(session.getAttribute("admin_role")==null) {
			return 2;
		}
		Integer requestrole = (Integer)session.getAttribute("admin_role");
		if(requestrole.intValue()>1) {
			return 2;
		}
		//System.out.println();
		return  dao.accuseUpdateComplete(ac_seq_number,  ac_complete.get("ac_complete") );
	}

	@GetMapping("/accuse/search")
	public String accusesearch(HttpSession session, Model model, String pageNo, String a_category, String query) {
		// dao.accuseSearchListDao(startNo,endNo,a_category,query)
		model.addAttribute("MaxPageNo", "");
		model.addAttribute("accuseList", "");
		return "admin/accuseBoard";
	}
	
	/*** 게시판 관리기능 ***********************************************/
	@RequestMapping("/board")
	public String board() {
		return "redirect:/admin/board/20/1";
	}

	@RequestMapping("/board/{onePageNo}/{pageNo}")
	public String boardList(Model model, @PathVariable String onePageNo, @PathVariable String pageNo, String changePageNo) {
		log.debug("board 요청" + pageNo + "페이지를" + onePageNo + "개 요청");
		if (changePageNo != null) {
			if (!changePageNo.equals(onePageNo)) {
				log.debug(changePageNo + "개 표시로 바꿔달라는 request가 있습니다.");
				return "redirect:/admin/board/" + changePageNo + "/" + pageNo;
			}
		}
		List<MyBoardDTO> list = dao.boardListDao(pageNo, onePageNo,"");
		if (list.size() > 0) {
			model.addAttribute("boardList", list);
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("onePageNo", onePageNo);
		} else {
			log.debug("boar 요청 처리결과 : 값이 없습니다.");
		}
		return "admin/board";
	}
	//게시판 삭제 복구 - 너의생각
	@ResponseBody
	@PutMapping("/{board}/{seq_number}")
	public int deleteComment(HttpSession session,@PathVariable String board,@PathVariable String seq_number) {
		//System.out.println("매핑 진입" + board+seq_number);
		
		
		if(session.getAttribute("admin_role")==null) {
			return 2;
		}
		Integer requestrole = (Integer)session.getAttribute("admin_role");
		if(requestrole.intValue()>1) {
			return 2;
		}
		String table, deleted,col_seq_number;
		if(board.equals("report")) {
			table = "book_report";
			deleted = "r_delete";
			col_seq_number = "r_seq_number";
		}else {
			table = "free_board";
			deleted = "f_delete";
			col_seq_number = "f_seq_number";
		}
		return dao.deleteBoard(table,deleted,col_seq_number,seq_number);
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
		log.debug("comment 요청" + pageNo + "페이지를" + onePageNo + "개 요청");
		if (changePageNo != null) {
			if (!changePageNo.equals(onePageNo)) {
				log.debug(changePageNo + "개 표시로 바꿔달라는 request가 있습니다.");
				return "redirect:/admin/comment/" + changePageNo + "/" + pageNo;
			}
		}
		List<CommentDTO> list = dao.commentListDao(pageNo, onePageNo,"");
		if (list.size() > 0) {
			model.addAttribute("commentList", list);
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("onePageNo", onePageNo);
		} else {
			log.debug("comment 요청 처리결과 : 값이 없습니다.");
		}
		return "admin/commentboard";
	}
	//댓글 삭제처리
	@ResponseBody
	@PutMapping("/comment/{c_seq_number}")
	public int deleteComment(HttpSession session,@PathVariable String c_seq_number) {
		if(session.getAttribute("admin_role")==null) {
			return 2;
		}
		Integer requestrole = (Integer)session.getAttribute("admin_role");
		if(requestrole.intValue()>1) {
			return 2;
		}
		return dao.deleteComment(c_seq_number);
	}
	

	/*** store 상점관리기능 ***********************************************/	
	@RequestMapping("/store")
	public String storeboard() {
		return"redirect:store/"+onePageNumDefault+"/1";
	}
	//상점 관리 진입
	@RequestMapping("/store/{onePageNo}/{pageNo}")
	public String storeList( Model model,@PathVariable String onePageNo,@PathVariable String pageNo,String changePageNo) {
		log.debug("storeList 요청"+pageNo+"페이지를"+onePageNo+"개 요청");
		if(changePageNo!=null) {
			if(!changePageNo.equals(onePageNo)) {
				log.debug(changePageNo+"개 표시로 바꿔달라는 request가 있습니다."); 
				return "redirect:/admin/store/"+changePageNo+"/"+pageNo;
				}
		}
		List<StoreDTO> list = dao.storeListDao(pageNo,onePageNo,"");
			if(list.size()>0) {
				model.addAttribute("storeList",list);
				model.addAttribute("pageNo",pageNo);
				model.addAttribute("onePageNo",onePageNo);
			}else {
				model.addAttribute("storeList", null);
				log.debug("storeboard 요청 처리결과 : 값이 없습니다.");
			}
			return "admin/storelist";
	}
	// 상점 등록 진입
	@GetMapping("/store/new")
	public String insertStoreForm() {
		return "admin/storeForm";
	}

	// 상점 등록 액션
	@PostMapping("/store/new")
	public String insertStore(StoreDTO dto, MultipartFile filename) throws Exception {
		if(filename!=null){
		dto.setB_filename(service.saveFile(filename));
		}
		dao.insertStoreDao(dto);
		log.trace("상품등록완료" + dto.toString());
		return "redirect:/admin/store";
	}
	
	// 상점 수정 폼
	@GetMapping("/store/edit/{b_code}")
	public String edittStoreForm(@PathVariable String b_code,Model model) {
		StoreDTO dto = storedao.viewDao(b_code);
		if(dto==null) {
			model.addAttribute("alert","alert('존재하지 않는 상품입니다.')");
		}else {
			model.addAttribute("book",dto);
			model.addAttribute("command","edit");
		}
		return "admin/storeForm";
	}
	
	// 상점 수정 액션
	@PostMapping("/store/edit/{b_code}")
	public String editStore(StoreDTO dto, MultipartFile filename,Model model) throws Exception {
		String oldfile = dto.getB_filename();
		if(filename.getOriginalFilename().equals(oldfile)) {
			dto.setB_filename(service.saveFile(filename));			
			service.deleteFile(oldfile);
			}
		int result = dao.updateStoreDao(dto);
		log.trace("상품등록완료" + dto.toString());
		if(result==1) {
			model.addAttribute("alert","alert('수정 완료했습니다')");
		}else {
			model.addAttribute("alert","alert('수정 실패했습니다')");
		}
		return "redirect:/admin/store";
	}
	
	
	

}
