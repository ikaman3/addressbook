package egovframework.ictway.yjh.web;

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
import egovframework.ictway.yjh.service.AdrCIYService;
import egovframework.ictway.yjh.service.AdrCIYVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 주소록 정보의 목록조회, 상세조회, 등록화면조회, 수정화면조회, 등록, 수정, 삭제, 파일업로드, 파일다운로드를 위한 컨트롤러 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 윤준현 / 최초생성
 * </pre>
 * @see
 */
@Slf4j
@Controller
public class AdrCIYController {

	@Resource(name = "adrCIYService")
	private AdrCIYService adrCIYService;
	
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
	@RequestMapping("/ictway/yjh/selectAdrCIYList.do")
	public String selectAdrCIYList(@ModelAttribute("searchVO") AdrCIYVO adrCIYVO, ModelMap model, HttpServletRequest request) throws Exception {
		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("menuNo", "9000000");

		/** paging */
		adrCIYVO.setPageUnit(propertyService.getInt("pageUnit"));
		adrCIYVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(adrCIYVO.getPageIndex()); /** 현재 페이지 번호 */
		paginationInfo.setRecordCountPerPage(adrCIYVO.getPageUnit()); /** 한 페이지당 게시되는 게시물 건 수 */
		paginationInfo.setPageSize(adrCIYVO.getPageSize()); /** 페이지 리스트에 게시되는 페이지 건 수 */
		
		adrCIYVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		adrCIYVO.setLastIndex(paginationInfo.getLastRecordIndex());
		adrCIYVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> map = adrCIYService.selectAdrCIYList(adrCIYVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		/* return "cop/bbs/EgovNoticeList"; */
		return "ictway/yjh/adrCIYList";
	}
	
	/**
	 * 주소록 상세조회
	 * @param request
	 * @param addrVO - 주소록 VO
	 * @return 주소록 상세
	 * @exception Exception
	 */
	@RequestMapping("/ictway/yjh/selectAdrCIYDetail.do")
	public String selectAdrCIYDetail(@ModelAttribute("searchVO") AdrCIYVO adrCIYVO, ModelMap model) throws Exception {
		
		AdrCIYVO resultVO = adrCIYService.selectAdrCIYDetail(adrCIYVO);
		model.addAttribute("resultVO", resultVO);
		
		/* return "cop/bbs/EgovNoticeInqire"; */
		return "ictway/yjh/adrCIYDetail";
	}
	
	/**
	 * 주소록 등록 화면
	 * @param addrVO - 주소록 VO
	 * @return 주소록 등록 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/yjh/selectAdrCIYRegist.do")
	public String selectAdrRegist(@ModelAttribute("searchVO") AdrCIYVO adrCIYVO, ModelMap model) throws Exception {
		
		/*return "cop/bbs/EgovNoticeRegist";*/
		return "ictway/yjh/adrCIYRegist";
	}
	
	/**
     * 주소록 정보 등록
     * @param adrCIYVO - 주소록 VO
     * @return adrId
     * @throws Exception
     */
    @RequestMapping("/ictway/yjh/registAdrCIYAct.do")
    public ModelAndView registAdrCIYAct(AdrCIYVO adrCIYVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		String adrId = adrCIYService.registAdrCIYAct(adrCIYVO);
		mav.addObject("adrId", adrId);
		
		return mav;
    }
	
	/**
	 * 주소록 수정 화면
	 * @param addrVO - 주소록 VO
	 * @return 주소록 수정 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/yjh/selectAdrCIYUpdate.do")
	public String selectAdrUpdate(@ModelAttribute("searchVO") AdrCIYVO adrCIYVO, ModelMap model, HttpServletRequest request) throws Exception {
		AdrCIYVO resultVO = adrCIYService.selectAdrCIYDetail(adrCIYVO);
		model.addAttribute("resultVO", resultVO);
		
		return "ictway/yjh/adrCIYUpdate";
	}
	
	/**
     * 주소록 정보 수정
     * @param adrCIYVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/yjh/updateAdrCIYAct.do")
    public ModelAndView updateAdrCIYAct(AdrCIYVO adrCIYVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		adrCIYService.updateAdrCIYAct(adrCIYVO);
		
		return mav;
    }
    
    /**
     * 주소록 정보 삭제
     * @param adrCIYVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/yjh/deleteAdrCIYAct.do")
    public ModelAndView deleteAdrCIYAct(AdrCIYVO adrCIYVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		adrCIYService.deleteAdrCIYAct(adrCIYVO);
		
		return mav;
    }
}
