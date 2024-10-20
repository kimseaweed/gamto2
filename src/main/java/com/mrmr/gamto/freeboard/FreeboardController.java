package com.mrmr.gamto.freeboard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mrmr.gamto.freeboard.dao.IFreeboardDAO;
import com.mrmr.gamto.freeboard.dto.FreeboardDTO;
import com.mrmr.gamto.freeboard.dto.PagingVO;
import com.mrmr.gamto.utils.GamtoService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/board")
public class FreeboardController {
	@Autowired
	IFreeboardDAO dao;
	@Autowired
	GamtoService gamtoService;

	/* 페이징하는 리스트 test */
	@RequestMapping()
	public String boardList(@RequestParam(required=false, defaultValue="1")
				int pageNo, Model model) {
		PagingVO page = new PagingVO(pageNo,10,dao.countBoard());
		
		Map<String, Integer> map = new HashMap<>();
		
		map.put("startNo", page.getStartNo());
		map.put("endNo", page.getEndNo());
		List<FreeboardDTO> list = dao.getPageList(map);
		model.addAttribute("page",page);
		model.addAttribute("board",list);
		model.addAttribute("dao",dao);
		
		return "freeboard/board";
	}
	
	@RequestMapping("/view")
	public String freeview(HttpServletRequest request, HttpServletResponse response, Model model) {
		String fId = request.getParameter("f_seq_number");
		
		//새로고침시 조회수 +1 되지않고 하루동안 쿠키 유지
		Cookie oldCookie = null;
		Cookie[] cookies = request.getCookies();

		if (cookies != null) {
			for (Cookie cookie : cookies) {

				if (cookie.getName().equals("postView")) {
					oldCookie = cookie;
				}
			}
		}

		if (oldCookie != null) {
			if (!oldCookie.getValue().contains("[" + fId + "]")) {
				dao.updateCnt(fId);
				oldCookie.setValue(oldCookie.getValue() + "_[" + fId + "]");
				oldCookie.setPath("/");
				oldCookie.setMaxAge(60 * 60 * 24);
				response.addCookie(oldCookie);
			}
		} else {
			dao.updateCnt(fId);
			Cookie newCookie = new Cookie("postView", "[" + fId + "]");
			newCookie.setPath("/");
			newCookie.setMaxAge(60 * 60 * 24);
			response.addCookie(newCookie);
		}
		
		model.addAttribute("dto", dao.viewDao(fId));
		
		model.addAttribute("cDto",dao.cListDao(fId));
		model.addAttribute("result", dao.commentTotal(fId));
		model.addAttribute("myLike",dao);
		
		return "freeboard/view";
	}
	
	@RequestMapping("/writeForm")
	public String writeForm(HttpSession session, Model model) {
		
		return gamtoService.needLogin(session, model,"/board/writeForm" , "freeboard/writeForm");
	}
	
	@RequestMapping("/write")
	public String freeWrite(HttpServletRequest request, Model model) {
		String fTitle = request.getParameter("f_title");
		String fName = request.getParameter("f_writer");		
		String fContent = request.getParameter("f_content");
		String fCategory = request.getParameter("f_category");
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("item1", fTitle);
		map.put("item2", fName);
		map.put("item3", fContent);
		map.put("item4", fCategory);
		dao.writeDao(map);
		
		return "redirect:/board";
	}
	
	@RequestMapping("/updateForm")
	public String updateForm(HttpServletRequest request, Model model) {
		String fId = request.getParameter("f_seq_number");
		model.addAttribute("updateForm", dao.viewDao(fId));
		
		return "freeboard/updateForm";
	}
	
	@RequestMapping("/update")
	public String update(HttpServletRequest request, Model model) {
		String fTitle = request.getParameter("f_title");		
		String fContent = request.getParameter("f_content");
		String fId = request.getParameter("f_seq_number");
		String fCategory = request.getParameter("f_category");
	
		Map<String,String> map = new HashMap<String,String>();
		
		map.put("item1", fTitle);
		map.put("item2", fContent);
		map.put("item3", fCategory);
		map.put("item4", fId);
		dao.updateDao(map);

		return "redirect:/board/view?f_seq_number="+fId;
	}
	
	@RequestMapping("/delete")
	public String delete(HttpServletRequest request, Model model) {
		String fId = request.getParameter("f_seq_number");
		dao.deleteDao(fId);
		return "redirect:/board";
	}
	
	@GetMapping("/getComentList")
	@ResponseBody
	private int getCommentList(@RequestParam("f_seq_number") String f_seq_number, @RequestParam("c_content") String c_content, @RequestParam("c_writer") String c_writer){
		
		return dao.cWriteDao(f_seq_number, c_writer, c_content);
	}
	
	@RequestMapping("/cUpdate")
	@ResponseBody
	public int commentUpdate(@RequestParam("c_seq_number")String c_seq_number,@RequestParam("c_content")String c_content) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("item1", c_content);
		map.put("item2", c_seq_number);
		int result = dao.cUpdateDao(map);
		
		return result;
	}
	
	@RequestMapping("/cDelete")
	@ResponseBody
	public int commentDelete(@RequestParam("c_seq_number")String c_seq_number) {
		
		int result = dao.cDeleteDao(c_seq_number);
		
		return result;
	}
	
	@RequestMapping("/SearchCategory")
	public String SearchCategory(HttpServletRequest request, @RequestParam(required=false, defaultValue="1")
				int pageNo, Model model) {
		
		PagingVO page = new PagingVO(pageNo,10,dao.countBoard());
		String fCategory = request.getParameter("f_category");
		
		Map<String, String> map = new HashMap<>();
		
		map.put("startNo", Integer.toString(page.getStartNo()));
		map.put("endNo",  Integer.toString(page.getEndNo()));
		map.put("category", fCategory);
		List<FreeboardDTO> list = dao.SearchCategory(map);
		
		model.addAttribute("page",page);
		model.addAttribute("board",list);
		
		return "freeboard/board";
	}
	
	@RequestMapping("/SearchTotal")
	public String SearchTotal(HttpServletRequest request, @RequestParam(required=false, defaultValue="1")
				int pageNo, Model model) {
		
		PagingVO page = new PagingVO(pageNo,10,dao.countBoard());
		String item = request.getParameter("item");
		String text = request.getParameter("text");

		Map<String, String> map = new HashMap<>();
		
		map.put("startNo", Integer.toString(page.getStartNo()));
		map.put("endNo",  Integer.toString(page.getEndNo()));
		map.put("item", item);
		map.put("text", text);
		
		List<FreeboardDTO> list = dao.SearchTotal(map);
		
		model.addAttribute("page",page);
		model.addAttribute("board",list);
		
		return "freeboard/board";
	}
	
	@ResponseBody
	@RequestMapping("/updateLike")
	public String updateLike(String l_number, HttpSession session) {
		
		String l_id =(String)session.getAttribute("u_id");
		int l_board = 2;
		
		if(l_id==null) {
			return "3";
		}else {
			int l_numberValue = Integer.parseInt(l_number);

			int result = dao.likeCheck(l_board, l_numberValue, l_id);

			if (result == 0) {
				int num = dao.goodCnt(l_number);
				dao.insertLike(l_board, l_numberValue, l_id);

				return "1";
			} else {
				dao.badCnt(l_number);
				dao.deleteLike(l_board, l_numberValue, l_id);
				return "0";
			}
			
			//상황 0 좋아요 성공
			//상황 1 로그인이 안되어있을때
		}
	}
	
	@ResponseBody
	@RequestMapping("/commentFeeling")
	public String commentGood(String l_number, HttpSession session, String feeling) {
		
		String l_id =(String)session.getAttribute("u_id");
		
		if(l_id==null) {
			return "3";
		}else {
			int l_numberValue = Integer.parseInt(l_number);

			int Goodresult = dao.likeCheck(3, l_numberValue, l_id);
			int BadResult = dao.likeCheck(4, l_numberValue, l_id);
			
			if (Goodresult == 0 && BadResult == 0) {
				if(feeling.equals("good")) {
					dao.cGoodCnt(l_number);
					dao.insertLike(3, l_numberValue, l_id);
					
					return "1";
				}else {
					dao.cBadCnt(l_number);
					dao.insertLike(4, l_numberValue, l_id);
					
					return "1";
				}
				
			} else if(Goodresult == 1 && BadResult == 0) {
				if(feeling.equals("good")) {
					dao.cGoodCancel(l_number);
					dao.deleteLike(3, l_numberValue, l_id);
					
					return "2";
				}else {
					
					return "0";	
				}
			} else if(Goodresult == 0 && BadResult == 1) {
				if(feeling.equals("good")) {
					
					return "0";
				}else {
					dao.cBadCancel(l_number);
					dao.deleteLike(4, l_numberValue, l_id);
					
					return "2";
				}
			} else {
				return "5";
			}
			
			//상황 0 좋아요 성공
			//상황 1 로그인이 안되어있을때
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}