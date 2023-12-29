package egovframework.ictway.kjk.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

/**
 * sample 주소록 정보의 목록조회, 상세조회, 등록화면조회, 수정화면조회, 등록, 수정, 삭제, 파일업로드, 파일다운로드를 위한 컨트롤러 클래스
 * @author ICTWAY
 * @since 2023.12.28
 * @version 1.0
 * @Modification
 * <pre>
 *2023.12.28 / 김진광 / 최초생성
 * </pre>
 * @see
 */
@Slf4j
@Controller
public class KjkAdrController {

	/**
	 * sample 주소록 목록조회
	 * @param request - session에 menuNo set 
	 * @param addrVO - 주소록 VO
	 * @return sample 주소록 목록
	 * @exception Exception
	 */
	@RequestMapping("/ictway/kjk/selectAdrList.do")
	public String selectAdrList(HttpServletRequest request) throws Exception {
		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("menuNo", "9000000");
		log.debug("adrList");
		/* return "cop/bbs/EgovNoticeList"; */
		return "ictway/kjk/adrList";
	}
	
	/**
	 * sample 주소록 상세조회
	 * @param request
	 * @param addrVO - 주소록 VO
	 * @return sample 주소록 상세
	 * @exception Exception
	 */
	@RequestMapping("/ictway/kjk/selectAdrDetail.do")
	public String selectAdrDetail(HttpServletRequest request) throws Exception {
		log.debug("adrDetail");
		/* return "cop/bbs/EgovNoticeInqire"; */
		return "ictway/kjk/adrDetail";
	}
}
