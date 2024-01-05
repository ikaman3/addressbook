package egovframework.ictway.kej.web;

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
import egovframework.ictway.kej.service.AdrPAWService;
import egovframework.ictway.kej.service.AdrPAWVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 주소록 정보의 목록조회, 상세조회, 등록화면조회, 수정화면조회, 등록, 수정, 삭제, 파일업로드, 파일다운로드를 위한 컨트롤러 클래스
 * @author ICTWAY
 * @since 2023.12.29
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 김은지 / 최초생성
 * </pre>
 * @see
 */
@Slf4j
@Controller
public class AdrPAWController {

	@Resource(name = "AdrPAWService")
	private AdrPAWService AdrPAWService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	/**
	 * 주소록 목록조회
	 * @param request - session에 menuNo set 
	 * @param adrPAWVO - 주소록 VO
	 * @return 주소록 목록
	 * @exception Exception
	 */
	@RequestMapping("/ictway/kej/selectAdrPAWList.do")
	public String selectAdrPAWList(@ModelAttribute("searchVO") AdrPAWVO AdrPAWVO, ModelMap model, HttpServletRequest request) throws Exception {
		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("menuNo", "9000000");

		/** paging */
		AdrPAWVO.setPageUnit(propertyService.getInt("pageUnit"));
		AdrPAWVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(AdrPAWVO.getPageIndex()); /** 현재 페이지 번호 */
		paginationInfo.setRecordCountPerPage(AdrPAWVO.getPageUnit()); /** 한 페이지당 게시되는 게시물 건 수 */
		paginationInfo.setPageSize(AdrPAWVO.getPageSize()); /** 페이지 리스트에 게시되는 페이지 건 수 */
		
		AdrPAWVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		AdrPAWVO.setLastIndex(paginationInfo.getLastRecordIndex());
		AdrPAWVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> map = AdrPAWService.selectAdrPAWList(AdrPAWVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		/* return "cop/bbs/EgovNoticeList"; */
		return "ictway/kej/adrPAWList";
	}
	
	/**
	 * 주소록 상세조회
	 * @param request
	 * @param adrPAWVO - 주소록 VO
	 * @return 주소록 상세
	 * @exception Exception
	 */
	@RequestMapping("/ictway/kej/selectAdrPAWDetail.do")
	public String selectAdrPAWDetail(@ModelAttribute("searchVO") AdrPAWVO AdrPAWVO, ModelMap model) throws Exception {
		
		AdrPAWVO resultVO = AdrPAWService.selectAdrPAWDetail(AdrPAWVO);
		model.addAttribute("resultVO", resultVO);
		
		/* return "cop/bbs/EgovNoticeInqire"; */
		return "ictway/kej/adrPAWDetail";
	}
	
	/**
	 * 주소록 등록 화면
	 * @param adrPAWVO - 주소록 VO
	 * @return 주소록 등록 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/kej/selectAdrPAWRegist.do")
	public String selectAdrPAWRegist(@ModelAttribute("searchVO") AdrPAWVO AdrPAWVO, ModelMap model) throws Exception {
		
		/*return "cop/bbs/EgovNoticeRegist";*/
		return "ictway/kej/adrPAWRegist";
	}
	
	/**
     * 주소록 정보 등록
     * @param AdrPAWVO - 주소록 VO
     * @return adrPAWId
     * @throws Exception
     */
    @RequestMapping("/ictway/kej/registAdrPAWAct.do")
    public ModelAndView registAdrPAWAct(AdrPAWVO AdrPAWVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		String adrPAWId = AdrPAWService.registAdrPAWAct(AdrPAWVO);
		mav.addObject("adrPAWId", adrPAWId);
		
		return mav;
    }
	
	/**
	 * 주소록 수정 화면
	 * @param adrPAWVO - 주소록 VO
	 * @return 주소록 수정 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/kej/selectAdrPAWUpdate.do")
	public String selectAdrPAWUpdate(@ModelAttribute("searchVO") AdrPAWVO AdrPAWVO, ModelMap model) throws Exception {
		
		AdrPAWVO resultVO = AdrPAWService.selectAdrPAWDetail(AdrPAWVO);
		model.addAttribute("resultVO", resultVO);
		
		return "ictway/kej/adrPAWUpdate";
	}
	
	/**
     * 주소록 정보 수정
     * @param AdrPAWVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/kej/updateAdrPAWAct.do")
    public ModelAndView updateAdrPAWAct(AdrPAWVO AdrPAWVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		AdrPAWService.updateAdrPAWAct(AdrPAWVO);
		
		return mav;
    }
    
    /**
     * 주소록 정보 삭제
     * @param AdrPAWVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/kej/deleteAdrPAWAct.do")
    public ModelAndView deleteAdrPAWAct(AdrPAWVO AdrPAWVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		AdrPAWService.deleteAdrPAWAct(AdrPAWVO);
		
		return mav;
    }
}
