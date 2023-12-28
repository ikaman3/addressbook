package egovframework.ictway.kjk.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class KjkAdrController {

	@RequestMapping("/ictway/kjk/selectAdrList.do")
	public String selectAdrList(HttpServletRequest request) throws Exception {
		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("menuNo", "9000000");
		log.debug("hihi");
		/* return "cop/bbs/EgovNoticeList"; */
		return "ictway/kjk/adrList";
	}
}
