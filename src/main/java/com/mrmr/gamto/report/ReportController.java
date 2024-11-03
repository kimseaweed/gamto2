package com.mrmr.gamto.report;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mrmr.gamto.report.dao.IBookReportDAO;
import com.mrmr.gamto.report.dto.BookReportDTO;
import com.mrmr.gamto.report.dto.PageDTO;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/report")
public class ReportController {
	@Autowired
	IBookReportDAO dao;

	/* 페이징하는 리스트 test */
	@RequestMapping()
	public String boardList(@RequestParam(required=false, defaultValue="1")
				int pageNo, Model model) {
		PageDTO page = new PageDTO(pageNo,10,dao.countBoard());
		
		Map<String, Integer> map = new HashMap<>();
		
		map.put("startNo", page.getStartNo());
		map.put("endNo", page.getEndNo());
		List<BookReportDTO> list = dao.getPageList(map);
		
		model.addAttribute("page",page);
		model.addAttribute("list",list);
		
		return "list/list";
	}
	
	@RequestMapping("/view")
	public String freeview(HttpServletRequest request, HttpServletResponse response, Model model) {
		String rId = request.getParameter("r_seq_number");
		
		//새로고침시 조회수 +1 되지않고 하루동안 쿠키 유지
		Cookie oldCookie = null;
		Cookie[] cookies = request.getCookies();

		if (cookies != null) {
			for (Cookie cookie : cookies) {
//				System.out.println("cookie.getName " + cookie.getName());
//				System.out.println("cookie.getValue " + cookie.getValue());
				if (cookie.getName().equals("postView")) {
					oldCookie = cookie;
				}
			}
		}

		if (oldCookie != null) {
			if (!oldCookie.getValue().contains("[" + rId + "]")) {
				dao.updateCnt(rId);
				oldCookie.setValue(oldCookie.getValue() + "_[" + rId + "]");
				oldCookie.setPath("/");
				oldCookie.setMaxAge(60 * 60 * 24);
				response.addCookie(oldCookie);
			}
		} else {
			dao.updateCnt(rId);
			Cookie newCookie = new Cookie("postView", "[" + rId + "]");
			newCookie.setPath("/");
			newCookie.setMaxAge(60 * 60 * 24);
			response.addCookie(newCookie);
		}
		
		model.addAttribute("dto", dao.viewDao(rId));
		model.addAttribute("myLike",dao);
		
		return "list/view";
	}
	
	@RequestMapping("/write")
	public String freeWrite(HttpServletRequest request, Model model) {
		String rTitle = request.getParameter("r_title");
		String rName = request.getParameter("r_writer");		
		String rContent = request.getParameter("r_content");
		String rCategory = request.getParameter("r_category");
		
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("item1", rTitle);
		map.put("item2", rName);
		map.put("item3", rContent);
		map.put("item4", rCategory);
		dao.writeDao(map);
		
		return "redirect:/report";
	}
	
	@RequestMapping("/updateForm")
	public String updateForm(HttpSession session, HttpServletRequest request, Model model) {
		String rId = request.getParameter("r_seq_number");
		String u_id = (String)session.getAttribute("u_id");
		if(u_id==null||u_id.equals("")) {
			model.addAttribute("error",0);
			return "member/login";
		}else{
			BookReportDTO dto= dao.viewDao(rId); 
			if(u_id.equals(dto.getR_writer())) {				
				model.addAttribute("updateForm", dto);
				model.addAttribute("requestType", "update");
				return "write/write";			
			}else {
			model.addAttribute("script","<script>alert('권한이없습니다.');history.back();</script>");
			return "script";
			}
		}	
	}
	
	@RequestMapping("/good")
	public String goodCount(HttpServletRequest request, Model model) {
		String rId = request.getParameter("r_seq_number");
		dao.goodCnt(rId);
		 
		return "redirect:/list/view?r_seq_number="+rId;
	}
	
	@RequestMapping("/delete")
	public String delete(HttpServletRequest request, Model model) {
		String rId = request.getParameter("r_seq_number");
		dao.deleteDao(rId);
		return "redirect:/report";
	}
	
	@RequestMapping("/SearchTotal")
	public String SearchTotal(HttpServletRequest request, @RequestParam(required=false, defaultValue="1")
				int pageNo, Model model) {
		
		PageDTO page = new PageDTO(pageNo,10,dao.countBoard());
		String item = request.getParameter("item");
		String text = request.getParameter("text");

		Map<String, String> map = new HashMap<>();
		
		map.put("startNo", Integer.toString(page.getStartNo()));
		map.put("endNo",  Integer.toString(page.getEndNo()));
		map.put("item", item);
		map.put("text", text);
		
		List<BookReportDTO> list = dao.SearchTotal(map);
		
		model.addAttribute("page",page);
		model.addAttribute("list",list);
		
		return "list/list";
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
//			System.out.println(l_number);
			
			int result = dao.likeCheck(l_board,l_numberValue, l_id);
			
			if(result==0) {
				int num = dao.goodCnt(l_number);
				dao.insertLike(l_board,l_numberValue, l_id);
				
				return "1";
			}else{
				dao.badCnt(l_number);
				dao.deleteLike(l_board,l_numberValue, l_id);
				return "0";
			}
		}
	}
}