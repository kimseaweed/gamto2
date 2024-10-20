package com.mrmr.gamto.kakaoPay;


import java.net.http.HttpRequest;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mrmr.gamto.kakaoPay.service.KakaoPay;
import com.mrmr.gamto.member.dao.MemberDAO;
import com.mrmr.gamto.member.dto.MemberDTO;
import com.mrmr.gamto.store.dao.StoreDAO;
import com.mrmr.gamto.store.dto.CartDTO;
import com.mrmr.gamto.store.dto.OrderTableDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class KakaoPayController {
     
	
	private static final Logger log = LoggerFactory.getLogger(KakaoPayController.class);

	//@Setter(onMethod_ = @Autowired)
	@Autowired
    private KakaoPay kakaopay;
	@Autowired
    private MemberDAO memberDAO;
    @Autowired
    private StoreDAO store;
    

    
      @PostMapping("/kakaoPay")
      public String kakaoPay(Model model, HttpSession session) {        
   	  log.info("kakaoPay post............................................");
      String userId = (String)session.getAttribute("u_id");
      MemberDTO dto = store.orderDetail(userId);
      model.addAttribute("userInfo", dto);
      return "kakaoPay/kakaoPay";
   }
    
    @RequestMapping(value="/kakaoPay/insertKakaoPayInfo", method=RequestMethod.GET)
    @ResponseBody
    public void insertKakaoPayInfo(OrderTableDTO dto, HttpSession session) {
          store.insertKakaoPayInfo(dto);
          
        //return "<script>location.href='/kakaoPay/kakaoPaySuccessPage?code="+dto.getO_order_number()+"</script>";
    }
    @RequestMapping("/kakaoPay/kakaoPaySuccess")
    public String kakaoPaySuccess(Model model, String o_order_number) {
    	model.addAttribute("orderInfo", store.orderList(o_order_number));
    return "/kakaoPay/kakaoPaySuccess";
    }
    @RequestMapping("/kakaoPay/kakaoPayCancel")
    public String kakaoPayCancel(Model model) {
        model.addAttribute("script", "결제가 <b>취소</b>되었습니다.<br> 다시 시도해주세요. <br> <a href=\"/store/cart\" class=\"btn btn-success\"> 장바구니로 돌아가기 </a>");
       return "script";
    }
    @RequestMapping("/kakaoPay/kakaoPaySuccessFail")
    public String kakaoPaySuccessFail(Model model) {
       model.addAttribute("script", "결제가 <b>실패</b>되었습니다.<br> 다시 시도해주세요. <br> <a href=\"/store/cart\" class=\"btn btn-success\"> 장바구니로 돌아가기 </a>");
       return "script";
    }
    
}