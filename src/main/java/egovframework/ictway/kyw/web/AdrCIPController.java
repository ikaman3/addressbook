package egovframework.ictway.kyw.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.ictway.kyw.service.AdrCIPService;
import egovframework.ictway.kyw.service.AdrCIPVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 주소록 정보의 목록조회, 상세조회, 등록화면조회, 수정화면조회, 등록, 수정, 삭제, 파일업로드, 파일다운로드를 위한 컨트롤러 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 김예원 / 최초생성
 * </pre>
 * @see
 */
@Slf4j
@Controller
public class AdrCIPController {

	@Resource(name = "adrCIPService")
	private AdrCIPService adrCIPService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	/**
	 * 주소록 목록조회
	 * @param request - session에 menuNo set 
	 * @param adrCIPVO - 주소록 VO
	 * @return 주소록 목록
	 * @exception Exception
	 */
	@RequestMapping("/ictway/kyw/selectAdrCIPList.do")
	public String selectAdrCIPList(@ModelAttribute("searchVO") AdrCIPVO adrCIPVO, ModelMap model, HttpServletRequest request) throws Exception {
		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("menuNo", "9000000");

		/** paging */
		adrCIPVO.setPageUnit(propertyService.getInt("pageUnit"));
		adrCIPVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(adrCIPVO.getPageIndex()); /** 현재 페이지 번호 */
		paginationInfo.setRecordCountPerPage(adrCIPVO.getPageUnit()); /** 한 페이지당 게시되는 게시물 건 수 */
		paginationInfo.setPageSize(adrCIPVO.getPageSize()); /** 페이지 리스트에 게시되는 페이지 건 수 */
		
		adrCIPVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		adrCIPVO.setLastIndex(paginationInfo.getLastRecordIndex());
		adrCIPVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> map = adrCIPService.selectAdrCIPList(adrCIPVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		/* return "cop/bbs/EgovNoticeList"; */
		return "ictway/kyw/adrCIPList";
	}
	
	/**
	 * 주소록 상세조회
	 * @param request
	 * @param adrCIPVO - 주소록 VO
	 * @return 주소록 상세
	 * @exception Exception
	 */
	@RequestMapping("/ictway/kyw/selectAdrCIPDetail.do")
	public String selectAdrCIPDetail(@ModelAttribute("searchVO") AdrCIPVO adrCIPVO, ModelMap model) throws Exception {
		
		AdrCIPVO resultVO = adrCIPService.selectAdrCIPDetail(adrCIPVO);
		model.addAttribute("resultVO", resultVO);
		
		/* return "cop/bbs/EgovNoticeInqire"; */
		return "ictway/kyw/adrCIPDetail";
	}
	
	/**
	 * 주소록 등록 화면
	 * @param adrCIPVO - 주소록 VO
	 * @return 주소록 등록 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/kyw/selectAdrCIPRegist.do")
	public String selectAdrCIPRegist(@ModelAttribute("searchVO") AdrCIPVO adrCIPVO, ModelMap model) throws Exception {
		
		/*return "cop/bbs/EgovNoticeRegist";*/
		return "ictway/kyw/adrCIPRegist";
	}
	
	/**
     * 주소록 정보 등록
     * @param adrCIPVO - 주소록 VO
     * @return adrCIPId
     * @throws Exception
     */
    @RequestMapping("/ictway/kyw/registAdrCIPAct.do")
    public ModelAndView registAdrCIPAct(AdrCIPVO adrCIPVO, ModelMap model) throws Exception { 

    	LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	ModelAndView mav = new ModelAndView("jsonView");
    	
		String adrCIPId = adrCIPService.registAdrCIPAct(adrCIPVO);
		mav.addObject("adrCIPId", adrCIPId);
		
		return mav;
    }
	
	/**
	 * 주소록 수정 화면
	 * @param adrCIPVO - 주소록 VO
	 * @return 주소록 수정 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/kyw/selectAdrCIPUpdate.do")
	public String selectAdrCIPUpdate(@ModelAttribute("searchVO") AdrCIPVO adrCIPVO, ModelMap model) throws Exception {
		
		AdrCIPVO resultVO = adrCIPService.selectAdrCIPDetail(adrCIPVO);
		model.addAttribute("resultVO", resultVO);
		
		return "ictway/kyw/adrCIPUpdate";
	}
	
	/**
     * 주소록 정보 수정
     * @param adrCIPVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/kyw/updateAdrCIPAct.do")
    public ModelAndView updateAdrCIPAct(AdrCIPVO adrCIPVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		adrCIPService.updateAdrCIPAct(adrCIPVO);
		
		return mav;
    }
    
    /**
     * 주소록 정보 삭제
     * @param adrCIPVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/kyw/deleteAdrCIPAct.do")
    public ModelAndView deleteAdrCIPAct(AdrCIPVO adrCIPVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		adrCIPService.deleteAdrCIPAct(adrCIPVO);
		
		return mav;
    }
}
