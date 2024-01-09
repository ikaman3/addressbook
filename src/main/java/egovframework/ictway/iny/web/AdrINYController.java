package egovframework.ictway.iny.web;

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
import egovframework.ictway.iny.service.AdrINYService;
import egovframework.ictway.iny.service.AdrINYVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 주소록 정보의 목록조회, 상세조회, 등록화면조회, 수정화면조회, 등록, 수정, 삭제, 파일업로드, 파일다운로드를 위한 컨트롤러 클래스
 * @author ICTWAY
 * @since 2023.12.28
 * @version 1.0
 * @Modification
 * <pre>
 *2023.12.29 / 윤현종 / 최초생성
 * </pre>
 * @see
 */
@Slf4j
@Controller
public class AdrINYController {

	@Resource(name = "adrINYService")
	private AdrINYService adrINYService;
	
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
	@RequestMapping("/ictway/iny/selectAdrINYList.do")
	public String selectAdrINYList(@ModelAttribute("searchVO") AdrINYVO adrINYVO, ModelMap model, HttpServletRequest request) throws Exception {
		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("menuNo", "9000000");

		/** paging */
		adrINYVO.setPageUnit(propertyService.getInt("pageUnit"));
		adrINYVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(adrINYVO.getPageIndex()); /** 현재 페이지 번호 */
		paginationInfo.setRecordCountPerPage(adrINYVO.getPageUnit()); /** 한 페이지당 게시되는 게시물 건 수 */
		paginationInfo.setPageSize(adrINYVO.getPageSize()); /** 페이지 리스트에 게시되는 페이지 건 수 */
		
		adrINYVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		adrINYVO.setLastIndex(paginationInfo.getLastRecordIndex());
		adrINYVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> map = adrINYService.selectAdrINYList(adrINYVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		/* return "cop/bbs/EgovNoticeList"; */
		return "ictway/iny/adrINYList";
	}
	
	/**
	 * 주소록 상세조회
	 * @param request
	 * @param addrVO - 주소록 VO
	 * @return 주소록 상세
	 * @exception Exception
	 */
	@RequestMapping("/ictway/iny/selectAdrINYDetail.do")
	public String selectAdrINYDetail(@ModelAttribute("searchVO") AdrINYVO adrINYVO, ModelMap model) throws Exception {
		
		AdrINYVO resultVO = adrINYService.selectAdrINYDetail(adrINYVO);
		model.addAttribute("resultVO", resultVO);
		
		/* return "cop/bbs/EgovNoticeInqire"; */
		return "ictway/iny/adrINYDetail";
	}
	
	/**
	 * 주소록 등록 화면
	 * @param addrVO - 주소록 VO
	 * @return 주소록 등록 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/iny/selectAdrINYRegist.do")
	public String selectAdrINYRegist(@ModelAttribute("searchVO") AdrINYVO adrINYVO, ModelMap model) throws Exception {
		
		/*return "cop/bbs/EgovNoticeRegist";*/
		return "ictway/iny/adrINYRegist";
	}
	
	/**
     * 주소록 정보 등록
     * @param adrINYVO - 주소록 VO
     * @return adrId
     * @throws Exception
     */
    @RequestMapping("/ictway/iny/registAdrINYAct.do")
    public ModelAndView registAdrINYAct(AdrINYVO adrINYVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		long adnkSn = adrINYService.registAdrINYAct(adrINYVO);
		mav.addObject("adrId", adnkSn);
		
		return mav;
    }
	
	/**
	 * 주소록 수정 화면
	 * @param addrVO - 주소록 VO
	 * @return 주소록 수정 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/iny/selectAdrINYUpdate.do")
	public String selectAdrINYUpdate(@ModelAttribute("searchVO") AdrINYVO adrINYVO, ModelMap model) throws Exception {
		
		AdrINYVO resultVO = adrINYService.selectAdrINYDetail(adrINYVO);
		model.addAttribute("resultVO", resultVO);
		
		return "ictway/iny/adrINYUpdate";
	}
	
	/**
     * 주소록 정보 수정	
     * @param adrINYVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/iny/updateAdrINYAct.do")
    public ModelAndView updateAdrINYAct(AdrINYVO adrINYVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		adrINYService.updateAdrINYAct(adrINYVO);
		
		return mav;
    }
    
    /**
     * 주소록 정보 삭제
     * @param adrINYVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/iny/deleteAdrINYAct.do")
    public ModelAndView deleteAdrINYAct(AdrINYVO adrINYVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		adrINYService.deleteAdrINYAct(adrINYVO);
		
		return mav;
    }
}
