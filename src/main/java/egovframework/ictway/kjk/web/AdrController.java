package egovframework.ictway.kjk.web;

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
import egovframework.ictway.kjk.service.AdrService;
import egovframework.ictway.kjk.service.AdrVO;
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
public class AdrController {

	@Resource(name = "adrService")
	private AdrService adrService;
	
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
	@RequestMapping("/ictway/kjk/selectAdrList.do")
	public String selectAdrList(@ModelAttribute("searchVO") AdrVO adrVO, ModelMap model, HttpServletRequest request) throws Exception {
		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("menuNo", "9000000");

		/** paging */
		adrVO.setPageUnit(propertyService.getInt("pageUnit"));
		adrVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(adrVO.getPageIndex()); /** 현재 페이지 번호 */
		paginationInfo.setRecordCountPerPage(adrVO.getPageUnit()); /** 한 페이지당 게시되는 게시물 건 수 */
		paginationInfo.setPageSize(adrVO.getPageSize()); /** 페이지 리스트에 게시되는 페이지 건 수 */
		
		adrVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		adrVO.setLastIndex(paginationInfo.getLastRecordIndex());
		adrVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> map = adrService.selectAdrList(adrVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		/* return "cop/bbs/EgovNoticeList"; */
		return "ictway/kjk/adrList";
	}
	
	/**
	 * 주소록 상세조회
	 * @param request
	 * @param addrVO - 주소록 VO
	 * @return 주소록 상세
	 * @exception Exception
	 */
	@RequestMapping("/ictway/kjk/selectAdrDetail.do")
	public String selectAdrDetail(@ModelAttribute("searchVO") AdrVO adrVO, ModelMap model) throws Exception {
		
		AdrVO resultVO = adrService.selectAdrDetail(adrVO);
		model.addAttribute("resultVO", resultVO);
		
		/* return "cop/bbs/EgovNoticeInqire"; */
		return "ictway/kjk/adrDetail";
	}
	
	/**
	 * 주소록 등록 화면
	 * @param addrVO - 주소록 VO
	 * @return 주소록 등록 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/kjk/selectAdrRegist.do")
	public String selectAdrRegist(AdrVO adrVO, ModelMap model) throws Exception {
		
		return "ictway/kjk/adrRegist";
	}
	
	/**
     * 주소록 정보 등록
     * @param adrVO - 주소록 VO
     * @return adrId
     * @throws Exception
     */
    @RequestMapping("/ictway/kjk/registAdrAct.do")
    public ModelAndView registAdrAct(AdrVO adrVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		String adrId = adrService.registAdrAct(adrVO);
		mav.addObject("adrId", adrId);
		
		return mav;
    }
	
	/**
	 * 주소록 수정 화면
	 * @param addrVO - 주소록 VO
	 * @return 주소록 수정 화면
	 * @exception Exception
	 */
	@RequestMapping("/ictway/kjk/selectAdrUpdate.do")
	public String selectAdrUpdate(@ModelAttribute("searchVO") AdrVO adrVO, ModelMap model) throws Exception {
		
		AdrVO resultVO = adrService.selectAdrDetail(adrVO);
		model.addAttribute("resultVO", resultVO);
		
		return "ictway/kjk/adrUpdate";
	}
	
	/**
     * 주소록 정보 수정
     * @param adrVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/kjk/updateAdrAct.do")
    public ModelAndView updateAdrAct(AdrVO adrVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		adrService.updateAdrAct(adrVO);
		
		return mav;
    }
    
    /**
     * 주소록 정보 삭제
     * @param adrVO - 주소록 VO
     * @return 
     * @throws Exception
     */
    @RequestMapping("/ictway/kjk/deleteAdrAct.do")
    public ModelAndView deleteAdrAct(AdrVO adrVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
		adrService.deleteAdrAct(adrVO);
		
		return mav;
    }
}
