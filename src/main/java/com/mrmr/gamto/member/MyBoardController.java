package com.mrmr.gamto.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mrmr.gamto.member.dao.MemberDAO;
import com.mrmr.gamto.member.dto.MyBoardDTO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping()
public class MyBoardController {
	@Autowired
	MemberDAO dao;
	
	@RequestMapping("/myboard")
	public String MyBoardDao(HttpSession session, Model model, @RequestParam(required=false, defaultValue="1") int pageNo) {
		String u_id = (String)session.getAttribute("u_id");
		PagingVO page = new PagingVO(pageNo,10,dao.countBoard(u_id,u_id));
		
		int startNo=(pageNo-1)*10+1;
		int endNo= pageNo*10;
		
		/*
		 * Map<String, Integer> map = new HashMap<>(); map.put("startNo",
		 * page.getStartNo()); map.put("endNo", page.getEndNo());
		 */
		List<MyBoardDTO> list = dao.getPageList(u_id,startNo,endNo);
		
		model.addAttribute("page",page);
		model.addAttribute("list",list);
		
		//System.out.println("u_id : "+u_id);
		/* model.addAttribute("list", dao.MyBoardDao(u_id,u_id)); */
		return "/member/myBoard";
	}
}
