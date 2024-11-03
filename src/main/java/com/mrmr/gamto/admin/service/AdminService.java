package com.mrmr.gamto.admin.service;

import java.io.File;
import java.security.MessageDigest;
import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.mrmr.gamto.admin.dao.AdminDAO;
import com.mrmr.gamto.admin.dto.AdminMemberDTO;
import com.mrmr.gamto.freeboard.dto.CommentDTO;
import com.mrmr.gamto.help.dto.AccuseDTO;
import com.mrmr.gamto.help.dto.AskDTO;
import com.mrmr.gamto.member.dto.MemberDTO;
import com.mrmr.gamto.member.dto.MyBoardDTO;
import com.mrmr.gamto.store.dao.StoreDAO;
import com.mrmr.gamto.store.dto.StoreDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminService {

    @Autowired
    AdminDAO adminDAO;
    @Autowired
    StoreDAO storedao;

    private int onePageNumDefault = 20;


    //store 업로드 파일 보관 경로
    private String projectPath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\img\\book\\";
    private String deletePath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\img\\book\\deleted\\";

    public String saveFile(MultipartFile file) throws Exception {
        //저장할 파일이름을 "UUIT_원본파일이름"으로 명명
        String fileName = file.getOriginalFilename();
        //경로와 파일명을 지정하여 파일객체 생성
        File savefile = new File(projectPath + fileName);
        //파일저장
        file.transferTo(savefile);
        log.info(fileName + "파일 저장 완료");
        //db에 저장할 용도로 파일이름 리턴
        return fileName;
    }

    public String saveUUIDFile(MultipartFile file) throws Exception {
        //랜덤UUID 생성
        UUID uuid = UUID.randomUUID();
        //저장할 파일이름을 "UUIT_원본파일이름"으로 명명
        String fileName = uuid + "_" + file.getOriginalFilename();
        //경로와 파일명을 지정하여 파일객체 생성
        File savefile = new File(projectPath + fileName);
        //파일저장
        file.transferTo(savefile);
        log.info(fileName + "파일 저장 완료");
        //db에 저장할 용도로 파일이름 리턴
        return fileName;
    }

    public void deleteFile(String oldfilename) throws Exception {
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


    //(new SHA().Encrypt("my password"));
    @Value("${admin-secretkey}")
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
            log.error("An error occurred: {}", e.getMessage(), e);
        }
        return encryptedText;
    }

    // 관리자 로그인 액션
    public void postAdmin(AdminMemberDTO dto, Model model) {
        try {
            dto.setAdmin_password(encrypt(dto.getAdmin_password()));
            int result = adminDAO.insertAdminMember(dto);
            if (result != 1) {
                model.addAttribute("alert", "alert('등록되지 않았습니다.');");
            } else {
                model.addAttribute("alert", "alert('등록이 완료되었습니다.");
            }
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
    }

    // 관리자 로그인 액션
    public void postAdminLogin(String admin_id, String admin_password, HttpServletRequest request, HttpSession session, Model model) {
        try {
            AdminMemberDTO dto = adminDAO.selectAdminMember("where admin_id = '" + admin_id + "'");
            if (dto == null) { // 일치 레코드 없음
                model.addAttribute("alert", "alert('존재하지 않는 아이디입니다.')");
            } else if (admin_id.equals(dto.getAdmin_id())) { //아이디 일치함
                admin_password = encrypt(admin_password); //입력비번 암호화
                if (admin_password.equals(dto.getAdmin_password())) {  //비번일치
                    if (dto.getAdmin_role() < 4) { //권한이 3 이하만 로그인가능
                        session.invalidate(); //기존세션 삭제
                        HttpSession newsession = request.getSession(true); //세션 새로 생성
                        newsession.setAttribute("admin_id", dto.getAdmin_id()); //아이디
                        newsession.setAttribute("admin_role", dto.getAdmin_role()); //권한
                        newsession.setAttribute("admin_name", dto.getAdmin_name()); //이름
                        newsession.setAttribute("u_id", "<b>감토지기</b>"); //승인된 관리자
                    } else {
                        model.addAttribute("alert", "alert('아직 승인되지 않습니다.');");
                    }
                } else {
                    model.addAttribute("alert", "alert('비밀번호가 일치하지 않습니다.');");
                }
            }
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
    }

    // 감토지기 리스트 불러오기
    public String adminMemberList(Model model, String onePageNo, String pageNo, String changePageNo) {
        try {
            if (changePageNo != null) {
                if (!changePageNo.equals(onePageNo)) {
                    return "redirect:/admin/admin-member/" + changePageNo + "/" + pageNo;
                }
            }
            List<AdminMemberDTO> list = adminDAO.adminListDao(pageNo, onePageNo, "");
            if (!list.isEmpty()) {
                model.addAttribute("adminList", list);
                model.addAttribute("pageNo", pageNo);
                model.addAttribute("onePageNo", onePageNo);
            } else {
                model.addAttribute("adminList", null);
            }
            return "admin/adminMemberList";
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
        return "admin/adminMemberList";
    }

    // 감토지기 삭제
    public int deleteAdminMember(String admin_id, HttpSession session) {
        try {
            Integer role = (Integer) session.getAttribute("role");
            if (role == 1) {
                return 1;
            }
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
        return 2;
    }

    // 감토지기 권한 수정
    public int updateAdminMember(HttpSession session, Map<String, String> role, String admin_id) {
        String admin_role = role.get("admin_role");
        try {
            Integer requestrole = (Integer) session.getAttribute("admin_ role");
            if (requestrole.intValue() > 1) {
                return 2;
            }
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
        return adminDAO.updateAdminMember(admin_id, admin_role);
    }

    public String memberList(Model model, String onePageNo, String pageNo, String changePageNo) {
        try {
            if (changePageNo != null) {
                if (!changePageNo.equals(onePageNo)) {
                    return "redirect:/admin/member/" + changePageNo + "/" + pageNo;
                }
            }
            List<MemberDTO> list = adminDAO.memberListDao(pageNo, onePageNo, "");
            if (!list.isEmpty()) {
                model.addAttribute("memberList", list);
                model.addAttribute("pageNo", pageNo);
                model.addAttribute("onePageNo", onePageNo);
            } else {
                model.addAttribute("memberList", null);
            }
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
        return "admin/memberList";
    }

    //
    public int updateMember(HttpSession session, Map<String, String> mapstate, String u_id) {
        try {
            if (session.getAttribute("admin_role") == null) {
                return 2;
            }
            Integer requestrole = (Integer) session.getAttribute("admin_role");
            if (requestrole.intValue() > 1) {
                return 2;
            }
            String state = mapstate.get("state");
            return adminDAO.updateMember(u_id, state);
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
        return 2;
    }

    public String adkboard(Model model, String onePageNo, String pageNo, String changePageNo) {
        try {
            if (changePageNo != null) {
                if (!changePageNo.equals(onePageNo)) {
                    return "redirect:/admin/ask/" + changePageNo + "/" + pageNo;
                }
            }
            List<AskDTO> list = adminDAO.askListDao(pageNo, onePageNo);
            if (!list.isEmpty()) {
                model.addAttribute("askList", list);
                model.addAttribute("pageNo", pageNo);
                model.addAttribute("onePageNo", onePageNo);
            } else {
                model.addAttribute("askList", null);
            }
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
        return "admin/askBoard";
    }

    public String askview(HttpSession session, Model model, int a_seq_number) {
        try {
            AskDTO dto = adminDAO.askViewDao(a_seq_number);
            model.addAttribute("dto", dto);
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
        return "admin/askPage";
    }

    public int askviewPut(HttpSession session, Model model, int a_seq_number, Map<String, String> a_complete) {
        try {
            if (session.getAttribute("admin_role") == null) {
                return 2;
            }
            Integer requestrole = (Integer) session.getAttribute("admin_role");
            if (requestrole.intValue() > 1) {
                return 2;
            }
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
        return adminDAO.askUpdateComplete(a_seq_number, a_complete.get("a_complete"));
    }

    public String accuseboard(Model model, String onePageNo, String pageNo, String changePageNo) {
        try {
            if (changePageNo != null) {
                if (!changePageNo.equals(onePageNo)) {
                    log.debug(changePageNo + "개 표시로 바꿔달라는 request가 있습니다.");
                    return "redirect:/admin/accuse/" + changePageNo + "/" + pageNo;
                }
            }
            List<AccuseDTO> list = adminDAO.accuseListDao(pageNo, onePageNo);
            if (list.size() > 0) {
                model.addAttribute("accuseList", list);
                model.addAttribute("pageNo", pageNo);
                model.addAttribute("onePageNo", onePageNo);
            } else {
                log.debug("accuseboard 요청 처리결과 : 값이 없습니다.");
            }
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
        return "admin/accuseBoard";
    }

    public String accuseview(HttpSession session, Model model, int ac_seq_number) {
        try {
            AccuseDTO dto = adminDAO.accuseViewDao(ac_seq_number);
            model.addAttribute("dto", dto);
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
        return "admin/accusePage";
    }


    public int accuseviewPut(HttpSession session, Model model, int ac_seq_number, Map<String, String> ac_complete) {
        try {
            if (session.getAttribute("admin_role") == null) {
                return 2;
            }
            Integer requestrole = (Integer) session.getAttribute("admin_role");
            if (requestrole.intValue() > 1) {
                return 2;
            }
            //System.out.println();
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
        return adminDAO.accuseUpdateComplete(ac_seq_number, ac_complete.get("ac_complete"));
    }


    public String accusesearch(HttpSession session, Model model, String pageNo, String aCategory, String query) {
        try {
            model.addAttribute("MaxPageNo", "");
            model.addAttribute("accuseList", "");
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
        return "admin/accuseBoard";
    }


    public String boardList(Model model, String onePageNo, String pageNo, String changePageNo) {
        try {
            if (changePageNo != null) {
                if (!changePageNo.equals(onePageNo)) {
                    log.debug(changePageNo + "개 표시로 바꿔달라는 request가 있습니다.");
                    return "redirect:/admin/board/" + changePageNo + "/" + pageNo;
                }
            }
            List<MyBoardDTO> list = adminDAO.boardListDao(pageNo, onePageNo,"");
            if (list.size() > 0) {
                model.addAttribute("boardList", list);
                model.addAttribute("pageNo", pageNo);
                model.addAttribute("onePageNo", onePageNo);
            }
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
            return "admin/board";
    }

    public String asksearch(HttpSession session, Model model, String pageNo, String aCategory, String query) {
        model.addAttribute("MaxPageNo", "");
        model.addAttribute("askList", "");
        return "admin/askBoard";
    }


    public int deleteContent(HttpSession session, String board, String seq_number) {
        try {
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
            return adminDAO.deleteBoard(table,deleted,col_seq_number,seq_number);
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
            return 2;
    }

    public String commentList(Model model, String onePageNo, String pageNo, String changePageNo) {
        try {
            if (changePageNo != null) {
                if (!changePageNo.equals(onePageNo)) {
                    log.debug(changePageNo + "개 표시로 바꿔달라는 request가 있습니다.");
                    return "redirect:/admin/comment/" + changePageNo + "/" + pageNo;
                }
            }
            List<CommentDTO> list = adminDAO.commentListDao(pageNo, onePageNo,"");
            if (list.size() > 0) {
                model.addAttribute("commentList", list);
                model.addAttribute("pageNo", pageNo);
                model.addAttribute("onePageNo", onePageNo);
            }
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
            return "admin/commentboard";
    }


    public int deleteComment(HttpSession session, String c_seq_number) {
        try {
            if(session.getAttribute("admin_role")==null) {
                return 2;
            }
            Integer requestrole = (Integer)session.getAttribute("admin_role");
            if(requestrole.intValue()>1) {
                return 2;
            }
            return adminDAO.deleteComment(c_seq_number);
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
        return 2;
    }

    public String storeList(Model model, String onePageNo, String pageNo, String changePageNo) {
        try {
            log.debug("storeList 요청"+pageNo+"페이지를"+onePageNo+"개 요청");
            if(changePageNo!=null) {
                if(!changePageNo.equals(onePageNo)) {
                    log.debug(changePageNo+"개 표시로 바꿔달라는 request가 있습니다.");
                    return "redirect:/admin/store/"+changePageNo+"/"+pageNo;
                }
            }
            List<StoreDTO> list = adminDAO.storeListDao(pageNo,onePageNo,"");
            if(list.size()>0) {
                model.addAttribute("storeList",list);
                model.addAttribute("pageNo",pageNo);
                model.addAttribute("onePageNo",onePageNo);
            }else {
                model.addAttribute("storeList", null);
                log.debug("storeboard 요청 처리결과 : 값이 없습니다.");
            }
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
            return "admin/storelist";
    }


    public String insertStoreForm(StoreDTO dto, MultipartFile filename) {
        try {
            if(filename!=null){
                dto.setB_filename(saveFile(filename));
            }
            adminDAO.insertStoreDao(dto);
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
            return "redirect:/admin/store";
    }


    public String edittStoreForm(String b_code, Model model) {
        try {
            StoreDTO dto = storedao.viewDao(b_code);
            if(dto==null) {
                model.addAttribute("alert","alert('존재하지 않는 상품입니다.')");
            }else {
                model.addAttribute("book",dto);
                model.addAttribute("command","edit");
            }
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
            return "admin/storeForm";
    }

    public String editStore(StoreDTO dto, MultipartFile filename, Model model) {
        try {
            String oldfile = dto.getB_filename();
            if(filename.getOriginalFilename().equals(oldfile)) {
                dto.setB_filename(saveFile(filename));
                deleteFile(oldfile);
            }
            int result = adminDAO.updateStoreDao(dto);
            log.trace("상품등록완료" + dto.toString());
            if(result==1) {
                model.addAttribute("alert","alert('수정 완료했습니다')");
            }else {
                model.addAttribute("alert","alert('수정 실패했습니다')");
            }
        } catch (Exception e) {
            log.error("An error occurred: {}", e.getMessage(), e);
        }
            return "redirect:/admin/store";
    }
}
