package egovframework.ictway.yhj.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.LoginVO;
import egovframework.ictway.yhj.service.AdrGMAVO;
import egovframework.ictway.yhj.utils.AuthGMA;
import egovframework.ictway.yhj.utils.UploadFileService;
import egovframework.ictway.yhj.service.AdrGMAService;

/**
 * 주소록 정보 관리를 위한 구현 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 염혜정 / 최초생성
 * </pre>
 * @see
 */
@Service("adrGMAService")
public class AdrGMAServiceImpl implements AdrGMAService {

	@Resource(name = "adrGMADAO")
    private AdrGMADAO adrGMADAO;
	
	@Autowired
	private UploadFileService uploadFileService;
	
	/** yhj-adrIdGnrService */
	@Resource(name="yhj-adrGMAIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Override
	public Map<String, Object> selectAdrGMAList(AdrGMAVO adrGMAVO) throws Exception {

		/** 목록 조회 */
		List<?> list = adrGMADAO.selectAdrGMAList(adrGMAVO);
		/** 목록 조회 건 수 */
		int cnt = adrGMADAO.selectAdrGMAListCnt(adrGMAVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}

	@Override
	public AdrGMAVO selectAdrGMADetail(AdrGMAVO adrGMAVO) throws Exception {
		// TODO 상세조회에 대한 조건 로직 추가
		return adrGMADAO.selectAdrGMADetail(adrGMAVO);
	}

	@Override
	public String registAdrGMAAct(AdrGMAVO adrGMAVO,
			MultipartFile image) throws FdlException, Exception {
		
		if(! image.isEmpty()) {
			String fileName = uploadFileService.uploadFile(image);
			adrGMAVO.setPhotoFlpth(UploadFileService.saveFilePathGMA);
			adrGMAVO.setPhotoFileNm(FilenameUtils.getBaseName(fileName));
			adrGMAVO.setPhotoExtsnNm(FilenameUtils.getExtension(fileName));
		}
		
		//고유아이디 셋팅
		String uniqId = idgenService.getNextStringId();
		adrGMAVO.setAdbkId(uniqId);
	
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrGMAVO.setAdbkWrterId(user.getUniqId());
		
		adrGMADAO.insertAdrGMAAct(adrGMAVO);
		return uniqId;
	}

	@Override
	public Boolean updateAdrGMAAct(AdrGMAVO adrGMAVO, MultipartFile image) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		AdrGMAVO resultVO = adrGMADAO.selectAdrGMADetail(adrGMAVO);
			
		if(! AuthGMA.isSameUserAsAdrGMAWrter(resultVO, user)) return false;
		
		if(! image.isEmpty()) {
			String fileName = uploadFileService.uploadFile(image);
			adrGMAVO.setPhotoFlpth(UploadFileService.saveFilePathGMA);
			adrGMAVO.setPhotoFileNm(FilenameUtils.getBaseName(fileName));
			adrGMAVO.setPhotoExtsnNm(FilenameUtils.getExtension(fileName));
		}
		
		adrGMAVO.setAdbkUpdusrId(user.getUniqId());
		adrGMADAO.updateAdrGMAAct(adrGMAVO);
		
		return true;
	}

	@Override
	public Boolean deleteAdrGMAAct(AdrGMAVO adrGMAVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		AdrGMAVO resultVO = adrGMADAO.selectAdrGMADetail(adrGMAVO);
		
		if(! AuthGMA.isSameUserAsAdrGMAWrter(resultVO, user)) return false;
		
		adrGMAVO.setAdbkDltrId(user.getUniqId());
		adrGMADAO.deleteAdrGMAAct(adrGMAVO);
		
		return true;
	}

}
