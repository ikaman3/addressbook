package egovframework.ictway.kjk.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class KjkAdrController {

	@RequestMapping("/ictway/kjk/selectAdrList.do")
	public String selectAdrList() throws Exception {
		log.debug("hihi");
		return "";
	}
}
