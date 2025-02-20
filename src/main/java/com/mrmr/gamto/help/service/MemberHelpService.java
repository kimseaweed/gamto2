package com.mrmr.gamto.help.service;

import java.io.File;
import java.security.Key;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;

import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mrmr.gamto.member.dao.MemberDAO;
import com.mrmr.gamto.member.dto.MemberDTO;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.xml.bind.DatatypeConverter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberHelpService {
	@Autowired
	public MemberDAO dao;
	
	/** 메일관련정보 */
	private final JavaMailSender javaMailSender;
	private static final String SENDER = "gamt5476@gmail.com";
	
	/** 메일발송하기 <br>
	 * @param u_name : 이메일로 검색한 결과와 입력값이 일치하는지 확인한다
	 * @param u_email : 이메일을 기준으로 검색한다
	 * @return2 : 이메일에 맞는 검색결과가 null
	 * @return1 : 검색된결과와 입력한 이름이 일치하지 않음
	 * @return인증코드 : 본인이 확인되어 인증코드를 발송하였다 
	 * */
	private void sendMail(String u_email,String messageSubject,String messageBody) {
		MimeMessage message = javaMailSender.createMimeMessage();
		try {
			message.setFrom(SENDER);
			message.setRecipients(MimeMessage.RecipientType.TO, u_email);
			message.setSubject(messageSubject);
			message.setText(messageBody, "utf-8", "html");
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		javaMailSender.send(message);
		log.debug(messageSubject+"로 메일 발송");
	};
	
	/** 랜덤숫자 5자리 리턴 
	 * @return 	0이상 90000미만의 랜덤수를 생성하여 1000을 더한다 <br> 즉 10000이상 99999이하의 숫자가 생성된다*/
	private int createNumber() {
		return ((int) (Math.random() * (90000)) + 10000);
		}
	
	/** 아이디 찾기 : 입력결과로 검색<br>
	 * @param u_name : 이메일로 검색한 결과와 입력값이 일치하는지 확인한다
	 * @param u_email : 이메일을 기준으로 검색한다
	 * @return2 : 이메일에 맞는 검색결과가 null
	 * @return1 : 검색된결과와 입력한 이름이 일치하지 않음
	 * @return인증코드 : 본인이 확인되어 인증코드를 발송하였다 
	 * */
	public int idSearch(String u_name, String u_email) {
		MemberDTO memberdto = dao.findIdDao(u_email);
		if(memberdto==null) { 
			return 2;
		}else if(!memberdto.getU_name().equals(u_name)){
			return 1;
		}else {
			int code = createNumber();
			String subject = "[감토] 아이디 찾기 인증번호";
			String body = "<div style=\"text-align:center\"><p><b>" + u_name + "</b>님의 아이디 확인 인증번호를 안내해드립니다. </p>"
					+ "<div style=\"border:1px solid gray; padding: 10px 20px;width: fit-content;margin: 0 auto;\"><h1>" + code + "</h1></div>"
					+ "<p>인증번호 발송을 요청한 페이지에 인증번호를 입력하시면 아이디를 안내해드립니다."
					+ "<br>인증코드는 10분동안만 유효합니다. <br> 감사합니다.</p></div>";
			sendMail(u_email,subject,body);
			return code;
		}
	}
	
	/***********************/
	
	/** 비밀번호 확인 : JWT시크릿키 */
	private static final String SECRET_KEY = "SecretkeywhattodowithcharacterlimitannoyingHowtofill256bits";
	/** 비밀번호 확인 : 토큰 생성*/
	private String createToken(String u_id) {
		// 서명알고리즘. H로 시작하는걸로(HMAC hash알고리즘) 해야한다.
		SignatureAlgorithm algorithm = SignatureAlgorithm.HS256;
		//시크릿키를 64진법으로 변환한다.
		byte[] secretKeyBytes = DatatypeConverter.parseBase64Binary(SECRET_KEY);
		// java Security. 변환된 시크릿키와 알고리즘을 넣어 키를 생성한다.
		Key signingKey = new SecretKeySpec(secretKeyBytes, algorithm.getJcaName());
		// 만료시간. 밀리초*60초*몇분인지.
		long expTime = 1000*60*10;
		
		return Jwts.builder() //JWT생성 빌더
				.setSubject(u_id)
				.signWith(signingKey, algorithm) //이 알고리즘으로 서명한다
				.setExpiration( //만료시간 설정
						new Date(System.currentTimeMillis()+expTime)) //현재시간에 만료시간을 더한다.
				//헤더정보,발급자,대상자 등 더 많은 정보와 검증과정을 만들수있다.
				.compact(); // 위 내용을 종합하여 JWT생성하여 리턴
	}
	/** 비밀번호 찾기 : 입력결과로 검색<br>
	 * @param u_id : 아이디로 검색한 결과값이 있는지 확인한다
	 * @param u_email : 결과값의 이메일과 입력값이 일치하는지 확인한다
	 * @return2 : 아이디에 일치하는검색결과가 없다
	 * @return1 : 검색결과는 있으나 이메일이 일치하지 않는다
	 * @return0 : 본인이 확인되어 인증링크를 발송하였다 
	 * */
	public int pwSearch(String u_id, String u_email) {
		MemberDTO  memberdto = dao.readMemberDao(u_id);
		if(memberdto==null) {
			return 2;
		}else if(!memberdto.getU_email().equals(u_email)){
			return 1;
		}else {
			String subject = "[감토] 비밀번호 재설정 인증메일";
			String body = "<div style=\"text-align:center\"><p><b>" + memberdto.getU_name() + "</b>님의 비밀번호를 <br> 재설정 하기 위한 인증 메일을 보내드립니다.<br> </p>"
							+ "<div style=\"border:1px solid gray; padding: 10px 20px;width: fit-content;margin: 0 auto;\"><h1><a href=\"https://gamto.kro.kr//member/help/pw/token?t="
							+ createToken(memberdto.getU_id()) 
							+ "\"> 메일 인증하기</a></h1></div>"
							+ "<p><br>링크를 클릭하시면 비밀전호 재설정을 진행합니다. <br> 해당 메일은 10분 후 만료됩니다.</p></div>";
			sendMail(u_email,subject,body);
			return 0;
		}
	}
	/** 비밀번호 확인 : 토큰 복호화*/
	public String getClaim(String token) {
		//클레임이란 JWT의 Payload(내용) 부분의 한 조각을 뜻한다. 여러클레임이 들어있을수도 있다.
		Claims claims =  Jwts.parserBuilder() //복호화빌더
				.setSigningKey(DatatypeConverter.parseBase64Binary(SECRET_KEY))
				.build()
				.parseClaimsJws(token)
				.getBody();
		return claims.getSubject();
	}
	
	/** 이전비번을 로드 및 비교하여 같으면 변경하지 않는다*/
	public int resetPw(String u_id,String u_pw) {
		String u_pwBefore = dao.ResetPwCheck(u_id);
		if(u_pwBefore.equals("")||u_pwBefore==null) {
			return -1; //값이없음
		}else if(u_pwBefore.equals(u_pw)) {
			return 0; //이전비번과 같음
		}else {
			return dao.ResetPwDo(u_id, u_pw); //성공함
		}
	}
	
	
	//중복방지를 위한 uuid를 붙인 파일저장 기능
	/**@param folderName : help폴더의 ask로 저장할건지 accuse로 저장할건지 입력
	 * */
	public String saveFile(MultipartFile file,String folderName) throws Exception {
		if (file == null ||file.getOriginalFilename().equals("")) {
			return "";
		}
		//프로젝트디렉토리 + 지정한 폴더
		String projectPath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\help\\"+folderName+"\\";
		//랜덤UUID 생성
		UUID uuid = UUID.randomUUID();
		//저장할 파일이름을 "UUIT_원본파일이름"으로 명명
		String fileName = uuid + "_" + file.getOriginalFilename();
		//경로와 파일명을 지정하여 파일객체 생성
		File savefile = new File(projectPath + fileName);
		//파일저장
		file.transferTo(savefile);
		//db에 저장할 파일이름 리턴
		log.debug(fileName+"을 저장했습니다.");
		return fileName;
	}
	/*
	 * 	public void deleteFile(String oldfilename) throws Exception {
		//파일경로 + 삭제할 파일명으로 파일객체 생성 
		File deleteFile = new File(projectPath + oldfilename);
		//일치하는 파일이 있다면 파일을 이동한다.
		if (deleteFile.exists()) { 
			deleteFile.renameTo(new File(deletePath));
			//deleteFile.delete(); //파일삭제
			log.info("파일 이동 완료");
		} else {
			log.error("deleteFile 에러. 파일이없습니다");
		}
	}
	  
	 */

}
