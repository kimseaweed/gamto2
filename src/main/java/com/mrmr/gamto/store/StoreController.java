package com.mrmr.gamto.store;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mrmr.gamto.freeboard.dto.PagingVO;
import com.mrmr.gamto.store.dao.StoreDAO;
import com.mrmr.gamto.store.dto.CartDTO;
import com.mrmr.gamto.store.dto.StoreDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/store")
public class StoreController {
	@Autowired
	StoreDAO dao;
	
	
	@RequestMapping("")
	public String BookList(@RequestParam(required=false, defaultValue="1") int pageNo, Model model) {

			PagingVO page = new PagingVO(pageNo,10,dao.countBookList());
			
			Map<String, Integer> map = new HashMap<>();
			
			map.put("startNo", page.getStartNo());
			map.put("endNo", page.getEndNo());
			List<StoreDTO> list = dao.getPageList(map);
			
			model.addAttribute("page",page);
			model.addAttribute("store",list);

		return "store/store";
	}
	
	@RequestMapping("/view")
	public String view(HttpServletRequest request, Model model) {
		String s_code = request.getParameter("b_code");
		model.addAttribute("dto", dao.viewDao(s_code));
		return "store/view";
	}
	
	@RequestMapping("/delete")
	public String delete(Model model, HttpServletRequest request) {
		dao.deleteDao(request.getParameter(""));
		
		return "redirect:store";
	}
	
	@RequestMapping("/cart") //장바구니 목록 
	public String cart(Model model, HttpServletRequest request, HttpSession session) {
		String getId =(String)session.getAttribute("u_id");
		if(getId == null) {
			return "redirect:/member/login";
		} else {
			List<CartDTO> dto = dao.cartDao(getId);
			model.addAttribute("cart", dto);
			model.addAttribute("u_id", getId);
			return "store/cart";
		}
		
	}
	
	@PostMapping("/addCart") // 장바구니 담기 
	@ResponseBody
	public int addCart(String b_code, String b_quantity,  HttpSession session) {
		String getId =(String)session.getAttribute("u_id");
		if(getId == null) {
			return -1;
		} else {
			int result = dao.addCartDao(getId, b_code, b_quantity);
			return result;
		}
	}
	
	@PostMapping("/updateQuantity") // 장바구니에서 수량 변경하기  
	@ResponseBody
	public int updateQuantity(String cart_code, String cart_quantity, HttpSession session) {
		String getId =(String)session.getAttribute("u_id");
		if(getId == null) {
			return -1;
		} else {
			int result = dao.updateQuantity(getId, cart_code, cart_quantity);
			return result;
		}
	}
	
	@RequestMapping("/removeCart") //장바구니 목록 삭제  
	public String removeCart(Model model, String b_code, HttpSession session) {
		String getId =(String)session.getAttribute("u_id");
		dao.removeCartDao(getId, b_code);
		return "redirect:/store/cart";
	}
	
	@RequestMapping("/removeAllCart") //장바구니 목록 전체 삭제 
	public String removeAllCartDao(Model model, HttpServletRequest request, HttpSession session) {
		String getId =(String)session.getAttribute("u_id");
		dao.removeAllCartDao(getId);
		return "store/cart";
	}
	
	@RequestMapping("/header") //해더 장바구니뱃지
	@ResponseBody
	public int listNum(HttpSession session) {
		String getId =(String)session.getAttribute("u_id");
		if(getId == null) { 
			return 0;
		} else {
			int result = dao.listNumDao(getId);
			return result;
		}
	}

    //검색기능 	
	@RequestMapping("/SearchTotal")
	public String SearchTotal(HttpServletRequest request, @RequestParam(required=false, defaultValue="1")
				int pageNo, Model model) {
		
		PagingVO page = new PagingVO(pageNo,10,dao.countBookList());
		String item = request.getParameter("item");
		String text = request.getParameter("text");

		Map<String, String> map = new HashMap<>();
		
		map.put("startNo", Integer.toString(page.getStartNo()));
		map.put("endNo",  Integer.toString(page.getEndNo()));
		map.put("item", item);
		map.put("text", text);
		
		List<StoreDTO> list = dao.SearchTotal(map);
		
		model.addAttribute("page",page);
		model.addAttribute("store",list);
		
		return "store/store";
	}

	@RequestMapping("/purchaseList") //장바구니 목록 전체 삭제 
	public String purchaseList(Model model, HttpSession session) {
    	String u_id = (String)session.getAttribute("u_id");
    	model.addAttribute("purchaseList", dao.purchaseList(u_id));
		return "store/purchaseList";
	}
}