package egovframework.ictway.psp.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.ictway.psp.service.AdrPSPVO;
import egovframework.ictway.psp.service.AdrPSPService;
import lombok.extern.slf4j.Slf4j;

/**
 * 주소록 정보의 목록조회, 상세조회, 등록화면조회, 수정화면조회, 등록, 수정, 삭제, 파일업로드, 파일다운로드를 위한 컨트롤러 클래스
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
public class AdrPSPController {

	@Resource(name = "adrPSPService")
	private AdrPSPService AdrPSPService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	/**
	 * 주소록 목록조회
	 * @param request - session에 menuNo set 
	 * @param addrVO - 주소록 VO
	 * @return 주소록 목록
	 * @exception Exception
	 */
	@RequestMapping("/ictway/psp/selectAdrPSPList.do")
	public String selectAdrPSPList(@ModelAttribute("searchVO") AdrPSPVO AdrPSPVO, ModelMap model, HttpServletRequest request) throws Exception {
		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("menuNo", "9000000");

		/** paging */
		AdrPSPVO.setPageUnit(propertyService.getInt("pageUnit"));
		AdrPSPVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(AdrPSPVO.getPageIndex()); /** 현재 페이지 번호 */
		paginationInfo.setRecordCountPerPage(AdrPSPVO.getPageUnit()); /** 한 페이지당 게시되는 게시물 건 수 */
		paginationInfo.setPageSize(AdrPSPVO.getPageSize()); /** 페이지 리스트에 게시되는 페이지 건 수 */
		
		AdrPSPVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		AdrPSPVO.setLastIndex(paginationInfo.getLastRecordIndex());
		AdrPSPVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> map = AdrPSPService.selectAdrList(AdrPSPVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		/* return "cop/bbs/EgovNoticeList"; */
		return "ictway/kjk/AdrPSPList";
	}
	
	/**
	 * 주소록 상세조회
	 * @param request
	 * @param addrVO - 주소록 VO
	 * @return 주소록 상세
	 * @exception Exception
	 */
	@RequestMapping("/ictway/kjk/selectAdrPSPDetail.do")
	public String selectAdrPSPDetail(@ModelAttribute("searchVO") AdrPSPVO AdrPSPVO, ModelMap model) throws Exception {
		
		AdrPSPVO resultVO = AdrPSPService.selectAdrDetail(AdrPSPVO);
		model.addAttribute("resultVO", resultVO);
		
		/* return "cop/bbs/EgovNoticeInqire"; */
		return "ictway/kjk/AdrPSPDetail";
	}
	
	/**
	 * 주소록 등록 화면
	 * @param addrVO - 주소록 VO
	 * @return 주소록 등록 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/kjk/selectAdrPSPRegist.do")
	public String selectAdrPSPRegist(@ModelAttribute("searchVO") AdrPSPVO AdrPSPVO, ModelMap model) throws Exception {
		
		/*return "cop/bbs/EgovNoticeRegist";*/
		return "ictway/kjk/AdrPSPRegist";
	}
	
	/**
     * 주소록 정보 등록
     * @param AdrPSPVO - 주소록 VO
     * @return AdrPSPId
     * @throws Exception
     */
    @RequestMapping("/ictway/kjk/registAdrPSPAct.do")
    public ModelAndView registAdrPSPAct(AdrPSPVO AdrPSPVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		Long AdrPSPId = AdrPSPService.registAdrAct(AdrPSPVO);
		mav.addObject("AdrPSPId", AdrPSPId);
		
		return mav;
    }
	
	/**
	 * 주소록 수정 화면
	 * @param addrVO - 주소록 VO
	 * @return 주소록 수정 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/kjk/selectAdrPSPUpdate.do")
	public String selectAdrPSPUpdate(@ModelAttribute("searchVO") AdrPSPVO AdrPSPVO, ModelMap model) throws Exception {
		
		AdrPSPVO resultVO = AdrPSPService.selectAdrDetail(AdrPSPVO);
		model.addAttribute("resultVO", resultVO);
		
		return "ictway/kjk/AdrPSPUpdate";
	}
	
	/**
     * 주소록 정보 수정
     * @param AdrPSPVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/kjk/updateAdrPSPAct.do")
    public ModelAndView updateAdrPSPAct(AdrPSPVO AdrPSPVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		AdrPSPService.updateAdrAct(AdrPSPVO);
		
		return mav;
    }
    
    /**
     * 주소록 정보 삭제
     * @param AdrPSPVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/kjk/deleteAdrPSPAct.do")
    public ModelAndView deleteAdrPSPAct(AdrPSPVO AdrPSPVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		AdrPSPService.deleteAdrAct(AdrPSPVO);
		
		return mav;
    }
}