package egovframework.ictway.yja.web;

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
import egovframework.ictway.yja.service.AdrITAService;
import egovframework.ictway.yja.service.AdrITAVO;
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
public class AdrITAController {

	@Resource(name = "adrITAService")
	private AdrITAService adrITAService;
	
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
	@RequestMapping("/ictway/yja/selectAdrITAList.do")
	public String selectAdrITAList(@ModelAttribute("searchVO") AdrITAVO adrITAVO, ModelMap model, HttpServletRequest request) throws Exception {
		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("menuNo", "9000000");

		/** paging */
		adrITAVO.setPageUnit(propertyService.getInt("pageUnit"));
		adrITAVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(adrITAVO.getPageIndex()); /** 현재 페이지 번호 */
		paginationInfo.setRecordCountPerPage(adrITAVO.getPageUnit()); /** 한 페이지당 게시되는 게시물 건 수 */
		paginationInfo.setPageSize(adrITAVO.getPageSize()); /** 페이지 리스트에 게시되는 페이지 건 수 */
		
		adrITAVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		adrITAVO.setLastIndex(paginationInfo.getLastRecordIndex());
		adrITAVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> map = adrITAService.selectAdrITAList(adrITAVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		/* return "cop/bbs/EgovNoticeList"; */
		return "ictway/yja/adrITAList";
	}
	
	/**
	 * 주소록 상세조회
	 * @param request
	 * @param addrVO - 주소록 VO
	 * @return 주소록 상세
	 * @exception Exception
	 */
	@RequestMapping("/ictway/yja/selectAdrITADetail.do")
	public String selectAdrITADetail(@ModelAttribute("searchVO") AdrITAVO adrITAVO, ModelMap model) throws Exception {
		
		AdrITAVO resultVO = adrITAService.selectAdrITADetail(adrITAVO);
		model.addAttribute("resultVO", resultVO);
		
		/* return "cop/bbs/EgovNoticeInqire"; */
		return "ictway/yja/adrITADetail";
	}
	
	/**
	 * 주소록 등록 화면
	 * @param addrVO - 주소록 VO
	 * @return 주소록 등록 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/yja/selectAdrITARegist.do")
	public String selectAdrITARegist(@ModelAttribute("searchVO") AdrITAVO adrITAVO, ModelMap model) throws Exception {
		
		/*return "cop/bbs/EgovNoticeRegist";*/
		return "ictway/yja/adrITARegist";
	}
	
	/**
     * 주소록 정보 등록
     * @param adrITAVO - 주소록 VO
     * @return adrId
     * @throws Exception
     */
    @RequestMapping("/ictway/yja/registAdrITAAct.do")
    public ModelAndView registAdrITAAct(AdrITAVO adrITAVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		String adrId = adrITAService.registAdrITAAct(adrITAVO);
		mav.addObject("adrId", adrId);
		
		return mav;
    }
	
	/**
	 * 주소록 수정 화면
	 * @param addrVO - 주소록 VO
	 * @return 주소록 수정 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/yja/selectAdrITAUpdate.do")
	public String selectAdrITAUpdate(@ModelAttribute("searchVO") AdrITAVO adrITAVO, ModelMap model) throws Exception {
		
		AdrITAVO resultVO = adrITAService.selectAdrITADetail(adrITAVO);
		model.addAttribute("resultVO", resultVO);
		
		return "ictway/yja/adrITAUpdate";
	}
	
	/**
     * 주소록 정보 수정
     * @param adrITAVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/yja/updateAdrITAAct.do")
    public ModelAndView updateAdrITAAct(AdrITAVO adrITAVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		adrITAService.updateAdrITAAct(adrITAVO);
		
		return mav;
    }
    
    /**
     * 주소록 정보 삭제
     * @param adrITAVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/yja/deleteAdrITAAct.do")
    public ModelAndView deleteAdrITAAct(AdrITAVO adrITAVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		adrITAService.deleteAdrITAAct(adrITAVO);
		
		return mav;
    }
}
