package egovframework.ictway.kjk.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.LoginVO;
import egovframework.ictway.kjk.service.AdrService;
import egovframework.ictway.kjk.service.AdrVO;

/**
 * 주소록 정보 관리를 위한 구현 클래스
 * @author ICTWAY
 * @since 2024.12.29
 * @version 1.0
 * @Modification
 * <pre>
 *2024.12.29 / 김진광 / 최초생성
 * </pre>
 * @see
 */
@Service("adrService")
public class AdrServiceImpl implements AdrService {

	@Resource(name = "adrDAO")
    private AdrDAO adrDAO;
	
	/** kjk-adrIdGnrService */
	@Resource(name="kjk-adrIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Override
	public Map<String, Object> selectAdrList(AdrVO adrVO) throws Exception {

		/** 목록 조회 */
		List<?> list = adrDAO.selectAdrList(adrVO);
		/** 목록 조회 건 수 */
		int cnt = adrDAO.selectAdrListCnt(adrVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}

	@Override
	public AdrVO selectAdrDetail(AdrVO adrVO) throws Exception {
		return adrDAO.selectAdrDetail(adrVO);
	}

	@Override
	public String registAdrAct(AdrVO adrVO) throws FdlException, Exception {
		//고유아이디 셋팅
		String uniqId = idgenService.getNextStringId();
		adrVO.setAdrId(uniqId);
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrVO.setFrstRegisterId(user.getUniqId());
		
		adrDAO.insertAdrAct(adrVO);
		return uniqId;
	}

	@Override
	public Boolean updateAdrAct(AdrVO adrVO) throws Exception {
		boolean result = false;
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		AdrVO resultVO = adrDAO.selectAdrDetail(adrVO);
		Boolean isAdmin = EgovUserDetailsHelper.getAuthorities().contains("ROLE_ADMIN");
		
		if(resultVO.getFrstRegisterId().equals(user.getUniqId()) || isAdmin) { //등록자 또는 관리자만 action할 수 있는 로직
			adrVO.setLastUpdusrId(user.getUniqId());
			adrDAO.updateAdrAct(adrVO);
			result = true;
		}
		
		return result;
	}

	@Override
	public Boolean deleteAdrAct(AdrVO adrVO) throws Exception {
		boolean result = false;
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		AdrVO resultVO = adrDAO.selectAdrDetail(adrVO);
		Boolean isAdmin = EgovUserDetailsHelper.getAuthorities().contains("ROLE_ADMIN");
		
		if(resultVO.getFrstRegisterId().equals(user.getUniqId()) || isAdmin) { //등록자 또는 관리자만 action할 수 있는 로직
			adrVO.setLastUpdusrId(user.getUniqId());
			adrDAO.deleteAdrAct(adrVO);
			result = true;
		}
		
		return result;
	}

}
