package egovframework.ictway.nsh.web;

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
import egovframework.ictway.nsh.service.AdrAMSService;
import egovframework.ictway.nsh.service.AdrAMSVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 주소록 정보의 목록조회, 상세조회, 등록화면조회, 수정화면조회, 등록, 수정, 삭제, 파일업로드, 파일다운로드를 위한 컨트롤러 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 남시현 / 최초생성
 * </pre>
 * @see
 */
@Slf4j
@Controller
public class AdrAMSController {

	@Resource(name = "adrAMSService")
	private AdrAMSService adrAMSService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	/**
	 * 주소록 목록조회
	 * @param request - session에 menuNo set 
	 * @param addrAMSVO - 주소록 VO
	 * @return 주소록 목록
	 * @exception Exception
	 */
	@RequestMapping("/ictway/nsh/selectAdrAMSList.do")
	public String selectAdrAMSList(@ModelAttribute("searchVO") AdrAMSVO adrAMSVO, ModelMap model, HttpServletRequest request) throws Exception {
		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("menuNo", "9000000");

		/** paging */
		adrAMSVO.setPageUnit(propertyService.getInt("pageUnit"));
		adrAMSVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(adrAMSVO.getPageIndex()); /** 현재 페이지 번호 */
		paginationInfo.setRecordCountPerPage(adrAMSVO.getPageUnit()); /** 한 페이지당 게시되는 게시물 건 수 */
		paginationInfo.setPageSize(adrAMSVO.getPageSize()); /** 페이지 리스트에 게시되는 페이지 건 수 */
		
		adrAMSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		adrAMSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		adrAMSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> map = adrAMSService.selectAdrAMSList(adrAMSVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		/* return "cop/bbs/EgovNoticeList"; */
		return "ictway/nsh/adrAMSList";
	}
	
	/**
	 * 주소록 상세조회
	 * @param request
	 * @param adrAMSVO - 주소록 VO
	 * @return 주소록 상세
	 * @exception Exception
	 */
	@RequestMapping("/ictway/nsh/selectAdrAMSDetail.do")
	public String selectAdrAMSDetail(@ModelAttribute("searchVO") AdrAMSVO adrAMSVO, ModelMap model) throws Exception {
		AdrAMSVO resultVO = adrAMSService.selectAdrAMSDetail(adrAMSVO);
		model.addAttribute("resultVO", resultVO);
		
		/* return "cop/bbs/EgovNoticeInqire"; */
		return "ictway/nsh/adrAMSDetail";
	}
	
	/**
	 * 주소록 등록 화면
	 * @param adrAMSVO - 주소록 VO
	 * @return 주소록 등록 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/nsh/selectAdrAMSRegist.do")
	public String selectAdrRegist(@ModelAttribute("searchVO") AdrAMSVO adrAMSVO, ModelMap model) throws Exception {
		
		/*return "cop/bbs/EgovNoticeRegist";*/
		return "ictway/nsh/adrAMSRegist";
	}
	
	/**
     * 주소록 정보 등록
     * @param adrAMSVO - 주소록 VO
     * @return adrAMSId
     * @throws Exception
     */
    @RequestMapping("/ictway/nsh/registAdrAMSAct.do")
    public ModelAndView registAdrAMSAct(AdrAMSVO adrVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		String adrAMSId = adrAMSService.registAdrAMSAct(adrVO);
		mav.addObject("adrAMSId", adrAMSId);
		
		return mav;
    }
	
	/**
	 * 주소록 수정 화면
	 * @param adrAMSVO - 주소록 VO
	 * @return 주소록 수정 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/nsh/selectAdrAMSUpdate.do")
	public String selectAdrAMSUpdate(@ModelAttribute("searchVO") AdrAMSVO adrVO, ModelMap model) throws Exception {
		AdrAMSVO resultVO = adrAMSService.selectAdrAMSDetail(adrVO);
		model.addAttribute("resultVO", resultVO);
		
		return "ictway/nsh/adrAMSUpdate";
	}
	
	/**
     * 주소록 정보 수정
     * @param adrAMSVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/nsh/updateAdrAMSAct.do")
    public ModelAndView updateAdrAMSAct(AdrAMSVO adrAMSVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		adrAMSService.updateAdrAMSAct(adrAMSVO);
		
		return mav;
    }
    
    /**
     * 주소록 정보 삭제
     * @param adrAMSVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/nsh/deleteAdrAMSAct.do")
    public ModelAndView deleteAdrAMSAct(AdrAMSVO adrAMSVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		adrAMSService.deleteAdrAMSAct(adrAMSVO);
		
		return mav;
    }
}
