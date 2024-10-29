package com.mrmr.gamto.member.seviec;

import com.mrmr.gamto.member.dao.MemberDAO;
import com.mrmr.gamto.member.dto.MemberDTO;
import com.mrmr.gamto.utils.GamtoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Service
public class MemberService {
    @Autowired
    private GamtoService gamtoService;
    @Autowired
    private MemberDAO memberDAO;


    //회원가입 액션
    public String addMember(MemberDTO dto, BindingResult bindingResult, Model model, RedirectAttributes redirectAttributes) {
        try {
            if (bindingResult.hasErrors()) {
                model.addAttribute("headerAlert", bindingResult.getFieldError().getDefaultMessage());
                return "member/addMember";
            }

            dto.setU_pw(gamtoService.encrypt(dto.getU_pw()));

            if (memberDAO.dupVailCheck("u_id", dto.getU_id())) {
                model.addAttribute("headerAlertR", "중복된 아이디입니다.");
                return "member/addMember";
            } else if (memberDAO.dupVailCheck("u_email", dto.getU_email())) {
                model.addAttribute("headerAlertR", "중복된 이메일입니다.");
                return "member/addMember";
            } else {
                memberDAO.addMemberDao(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("headerAlert", "오류발생. 다시 시도해주세요.");
            return "member/addMember";
        }

        redirectAttributes.addFlashAttribute("headerAlertB", "가입을 환영합니다. 로그인해주세요.");
        return "redirect:/member/login";
    }

    //중복체크
    public boolean dupVailCheck(String column, String value) {
        try {
            return memberDAO.dupVailCheck(column, value);
        }catch (Exception e) {
            return false;
        }
    }
}
