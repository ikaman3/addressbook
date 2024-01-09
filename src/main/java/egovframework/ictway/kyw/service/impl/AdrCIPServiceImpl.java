package egovframework.ictway.kyw.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.LoginVO;
import egovframework.ictway.kjk.service.AdrVO;
import egovframework.ictway.kyw.service.AdrCIPService;
import egovframework.ictway.kyw.service.AdrCIPVO;

/**
 * 주소록 정보 관리를 위한 구현 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 김예원 / 최초생성
 * </pre>
 * @see
 */
@Service("adrCIPService")
public class AdrCIPServiceImpl implements AdrCIPService {

	@Resource(name = "adrCIPDAO")
    private AdrCIPDAO adrCIPDAO;
	
	/** kyw-adrCIPIdGnrService */
	@Resource(name="kyw-adrCIPIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Override
	public Map<String, Object> selectAdrCIPList(AdrCIPVO adrCIPVO) throws Exception {

		/** 목록 조회 */
		List<?> list = adrCIPDAO.selectAdrCIPList(adrCIPVO);
		/** 목록 조회 건 수 */
		int cnt = adrCIPDAO.selectAdrCIPListCnt(adrCIPVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}

	@Override
	public AdrCIPVO selectAdrCIPDetail(AdrCIPVO adrCIPVO) throws Exception {
		adrCIPVO.getAdbkFrstWrterNm();
		return adrCIPDAO.selectAdrCIPDetail(adrCIPVO);
	}

	@Override
	public String registAdrCIPAct(AdrCIPVO adrCIPVO) throws FdlException, Exception {
		//고유아이디 셋팅
		String uniqId = idgenService.getNextStringId();
		adrCIPVO.setAdbkId(uniqId);
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrCIPVO.setAdbkFrstWrterId(user.getUniqId());
		
		adrCIPDAO.registAdrCIPAct(adrCIPVO);
		return uniqId;
	}

	@Override
	public Boolean updateAdrCIPAct(AdrCIPVO adrCIPVO) throws Exception {
		boolean result = false;
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		AdrCIPVO resultVO = adrCIPDAO.selectAdrCIPDetail(adrCIPVO);
		Boolean isAdmin = EgovUserDetailsHelper.getAuthorities().contains("ROLE_ADMIN");
		
		if(resultVO.getAdbkFrstWrterId().equals(user.getUniqId()) || isAdmin) { //등록자 또는 관리자만 action할 수 있는 로직
			adrCIPVO.setAdbkLastUpdusrId(user.getUniqId());
			adrCIPDAO.updateAdrCIPAct(adrCIPVO);
			result = true;
		}
		
		return result;
	}

	@Override
	public void deleteAdrCIPAct(AdrCIPVO adrCIPVO) throws Exception {
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		AdrCIPVO resultVO = adrCIPDAO.selectAdrCIPDetail(adrCIPVO);
		adrCIPDAO.deleteAdrCIPAct(adrCIPVO);
		
	}
}
