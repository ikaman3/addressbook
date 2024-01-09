package egovframework.ictway.yja.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.web.EgovImageProcessController;
import egovframework.ictway.yja.service.AdrITAService;
import egovframework.ictway.yja.service.AdrITAVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 주소록 정보의 목록조회, 상세조회, 등록화면조회, 수정화면조회, 등록, 수정, 삭제, 파일업로드, 파일다운로드를 위한 컨트롤러 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 유지애 / 최초생성
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
	
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileService;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovImageProcessController.class);
	
	/**
	 * 주소록 목록조회
	 * @param request - session에 menuNo set 
	 * @param adrITAVO - 주소록 VO
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
    public ModelAndView registAdrITAAct(MultipartHttpServletRequest multiRequest, AdrITAVO adrITAVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	List<FileVO> result = null;
    	String atchFileId = "";
    	String extension = "";
    	String adrs = "";

		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "ITA_", 0, "", "");
			if(result.size() > 0) {
			atchFileId = result.get(0).getStreFileNm();
			extension = result.get(0).fileExtsn;
			adrs = result.get(0).getFileStreCours();
			}
		}
    	
    	adrITAVO.setPhotoNm(atchFileId);
    	adrITAVO.setPhotoExtsnNm(extension);
    	adrITAVO.setPhotoCours(adrs);
    	
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
    public ModelAndView updateAdrITAAct(MultipartHttpServletRequest multiRequest, AdrITAVO adrITAVO, ModelMap model) throws Exception { 

    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	List<FileVO> result = null;
    	String atchFileId = "";
    	String extension = "";
    	String adrs = "";

		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "ITA_", 0, "", "");
			if(result.size() > 0) {
			atchFileId = result.get(0).getStreFileNm();
			extension = result.get(0).fileExtsn;
			adrs = result.get(0).getFileStreCours();
			}
		}
    	
    	adrITAVO.setPhotoNm(atchFileId);
    	adrITAVO.setPhotoExtsnNm(extension);
    	adrITAVO.setPhotoCours(adrs);
    	
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
    
    @RequestMapping("/ictway/yja/getImage.do")
	public void getImageInf(AdrITAVO adrITAVO, SessionVO sessionVO, ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletResponse response) throws Exception {

    	AdrITAVO fvo = adrITAService.selectAdrITADetail(adrITAVO);
		
    	String fileStreCours = fvo.getPhotoCours();
    	String streFileNm = fvo.getPhotoNm();
    	
		File file = new File(fileStreCours, streFileNm);
		FileInputStream fis = null;
//		new FileInputStream(file);

		BufferedInputStream in = null;
		ByteArrayOutputStream bStream = null;
		try {
			fis = new FileInputStream(file);
			in = new BufferedInputStream(fis);
			bStream = new ByteArrayOutputStream();
			int imgByte;
			while ((imgByte = in.read()) != -1) {
				bStream.write(imgByte);
			}

			String type = "";

			if (fvo.getPhotoExtsnNm() != null && !"".equals(fvo.getPhotoExtsnNm())) {
				if ("jpg".equals(fvo.getPhotoExtsnNm().toLowerCase())) {
					type = "image/jpeg";
				} else {
					type = "image/" + fvo.getPhotoExtsnNm().toLowerCase();
				}
				type = "image/" + fvo.getPhotoExtsnNm().toLowerCase();

			} else {
				LOGGER.debug("Image fileType is null.");
			}

			response.setHeader("Content-Type", type);
			response.setContentLength(bStream.size());
			bStream.writeTo(response.getOutputStream());
			response.getOutputStream().flush();
			response.getOutputStream().close();

		} catch (IOException e) {
			LOGGER.debug("{}", e);
		} finally {
			if (bStream != null) {
				try {
					bStream.close();
				} catch (IOException est) {
					LOGGER.debug("IGNORED: {}", est.getMessage());
				}
			}
			if (in != null) {
				try {
					in.close();
				} catch (IOException ei) {
					LOGGER.debug("IGNORED: {}", ei.getMessage());
				}
			}
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException efis) {
					LOGGER.debug("IGNORED: {}", efis.getMessage());
				}
			}
		}
	}
}
