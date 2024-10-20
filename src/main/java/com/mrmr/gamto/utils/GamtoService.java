package com.mrmr.gamto.utils;
import java.security.MessageDigest;
import java.util.Base64;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;

@Component
public class GamtoService {
	
	/*1. 로그인 필요한 서비스에 로그인여부 확인후 로그인창 연결 메소드
	 *2. 로그인 되어있으면 안되는 서비스에 로그인되어있을시 뒤로가기 시키는 메소드
	 *3. 
	 * */
	
	//1)
	/** 로그인이 필요한 페이지에  사용합니다
	*로그인 안되어있으면 로그인페이지로,<br> 로그인되어있으면 입력한 view로 이동 및 모델에 u_id 셋팅<br><br>
	*@param session : 로그인아이디를 확인하는데 씁니다
	*@param model : 로그인되있으면 아이디를 전달하기위해 씁니다
	*@param url : 로그인후 다시요청할 url를 넣어주세요
	*@param view : 로그인이 되어있다면 표시할 뷰를 선택해주세요<br><br>
	*@return 컨트롤러의 리턴부분에 바로 사용할수있도록 뷰값을 리턴합니다.<br><br>
	*예시-> "/write" 요청시 "write/write"를 리턴하는 매핑이였다면 <br>
	*return GamtoService.needLogin(session, model, "/write", "write/write");<br>
	*결과1 => 로그인 안되어있으면 로그인이 필요하다는 메세지를 포함해 로그인페이지로 이동시키고, 로그인하면 /write로 이동시킨다. ${u_id}가 셋팅되어있으므로 바로 사용할수있다.<br>
	*결과2 => 로그인 되어있으면 매개변수로 지정한 view로 이동한다. ${u_id}가 셋팅되어있으므로 바로사용할수있다.<br><br>
	*@author 민지*/	
	public String needLogin(HttpSession session,Model model,String url,String view) {
		String u_id = (String) session.getAttribute("u_id");
		if(u_id==null) {
			return "redirect:/member/login?error=0&connect="+url;
		}else {
			model.addAttribute("u_id",u_id);
			return view;
		}
	}
	
	//2)
	/** 로그인 되어있지 않아야 하는 페이지에 사용합니다<br>
	 * 로그인 되어있으면 이미 로그인 되어있다고 alert 띄운후 뒤로 돌아갑니다<br>
	 * 로그인 되어있지 않다면 원래 리턴해야 하는 값으로 진행됩니다<br><br>
	 * @param session : 로그인 되어있는지 확인하기 위해 사용됩니다
	 * @param model : 로그인 되어있는 경우 스크립트를 띄우고 뒤로가기 위해 사용됩니다
	 * @param returnValue : 로그인 되어있지 않은게 맞다면 디른작업 없이 해당값을 리턴합니다.<br><br>
	 * @author 민지
	 * */
	public String noneLogin(HttpSession session,Model model,String returnValue) {
		String u_id = (String) session.getAttribute("u_id");
		if(u_id!=null) {
			String script= 
					"<script>"
					+ "alert('이미 로그인 되어있습니다.');"
					+ "hitory.back();"
					+ "</script>";
			model.addAttribute("script",script);		
			return "script";
		}else {
			return returnValue;
		}
	}
	
	
	//시크릿키
	@Value("${member-secretkey}")
	private String SECRET_KEY;

	//sha256 암호화
    public String encrypt(String text) {
        String encryptedText = "";
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
            String dataWithSaltAndKey = text + SECRET_KEY;
            messageDigest.update(dataWithSaltAndKey.getBytes("UTF-8"));
            encryptedText = new String(Base64.getEncoder().encode(messageDigest.digest()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return encryptedText;
    }
	
	
	
	
}
