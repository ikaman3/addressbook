package egovframework.ictway.phh.web;

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
import egovframework.ictway.phh.service.AdrCAPService;
import egovframework.ictway.phh.service.AdrCAPVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 주소 정보의 목록조회, 상세조회, 등록화면조회, 수정화면조회, 등록, 수정, 삭제, 파일업로드, 파일다운로드를 위한 컨트롤러 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 박현희 / 최초생성
 * </pre>
 * @see
 */
@Slf4j
@Controller
public class AdrCAPController {

	@Resource(name = "adrCAPService")
	private AdrCAPService adrCAPService;
	
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
	@RequestMapping("/ictway/phh/selectAdrCAPList.do")
	public String selectAdrCAPList(@ModelAttribute("searchVO") AdrCAPVO adrCAPVO, ModelMap model, HttpServletRequest request) throws Exception {
		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("menuNo", "9000000");

		/** paging */
		adrCAPVO.setPageUnit(propertyService.getInt("pageUnit"));
		adrCAPVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(adrCAPVO.getPageIndex()); /** 현재 페이지 번호 */
		paginationInfo.setRecordCountPerPage(adrCAPVO.getPageUnit()); /** 한 페이지당 게시되는 게시물 건 수 */
		paginationInfo.setPageSize(adrCAPVO.getPageSize()); /** 페이지 리스트에 게시되는 페이지 건 수 */
		
		adrCAPVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		adrCAPVO.setLastIndex(paginationInfo.getLastRecordIndex());
		adrCAPVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> map = adrCAPService.selectAdrCAPList(adrCAPVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		/* return "cop/bbs/EgovNoticeList"; */
		return "ictway/phh/adrCAPList";
	}
	
	/**
	 * 주소록 상세조회
	 * @param request
	 * @param addrVO - 주소록 VO
	 * @return 주소록 상세
	 * @exception Exception
	 */
	@RequestMapping("/ictway/phh/selectAdrCAPDetail.do")
	public String selectAdrCAPDetail(@ModelAttribute("searchVO") AdrCAPVO adrCAPVO, ModelMap model) throws Exception {
		
		AdrCAPVO resultVO = adrCAPService.selectAdrCAPDetail(adrCAPVO);
		model.addAttribute("resultVO", resultVO);
		
		/* return "cop/bbs/EgovNoticeInqire"; */
		return "ictway/phh/adrCAPDetail";
	}
	
	/**
	 * 주소록 등록 화면
	 * @param addrVO - 주소록 VO
	 * @return 주소록 등록 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/phh/selectAdrCAPRegist.do")
	public String selectAdrCAPRegist(@ModelAttribute("searchVO") AdrCAPVO adrCAPVO, ModelMap model) throws Exception {
		
		/*return "cop/bbs/EgovNoticeRegist";*/
		return "ictway/phh/adrCAPRegist";
	}
	
	/**
     * 주소록 정보 등록
     * @param adrCAPVO - 주소록 VO
     * @return adrId
     * @throws Exception
     */
    @RequestMapping("/ictway/phh/registAdrCAPAct.do")
    public ModelAndView registAdrCAPAct(AdrCAPVO adrCAPVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		String adrId = adrCAPService.registAdrCAPAct(adrCAPVO);
		mav.addObject("adrId", adrId);
		
		return mav;
    }
	
	/**
	 * 주소록 수정 화면
	 * @param addrVO - 주소록 VO
	 * @return 주소록 수정 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/phh/selectAdrCAPUpdate.do")
	public String selectAdrCAPUpdate(@ModelAttribute("searchVO") AdrCAPVO adrCAPVO, ModelMap model) throws Exception {
		
		AdrCAPVO resultVO = adrCAPService.selectAdrCAPDetail(adrCAPVO);
		model.addAttribute("resultVO", resultVO);
		
		return "ictway/phh/adrCAPUpdate";
	}
	
	/**
     * 주소록 정보 수정
     * @param adrCAPVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/phh/updateAdrCAPAct.do")
    public ModelAndView updateAdrCAPAct(AdrCAPVO adrCAPVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		adrCAPService.updateAdrCAPAct(adrCAPVO);
		
		return mav;
    }
    
    /**
     * 주소록 정보 삭제
     * @param adrCAPVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/phh/deleteAdrCAPAct.do")
    public ModelAndView deleteAdrCAPAct(AdrCAPVO adrCAPVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		adrCAPService.deleteAdrCAPAct(adrCAPVO);
		
		return mav;
    }
}
