package egovframework.ictway.nsh.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.LoginVO;
import egovframework.ictway.nsh.service.AdrAMSService;
import egovframework.ictway.nsh.service.AdrAMSVO;

/**
 * 주소록 정보 관리를 위한 구현 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 남시현 / 최초생성
 * </pre>
 * @see
 */
@Service("adrAMSService")
public class AdrAMSServiceImpl implements AdrAMSService {

	@Resource(name = "adrAMSDAO")
    private AdrAMSDAO adrAMSDAO;
	
	/** nsh-adrAMSIdGnrService */
	@Resource(name="nsh-adrAMSIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Override
	public Map<String, Object> selectAdrAMSList(AdrAMSVO adrVO) throws Exception {

		/** 목록 조회 */
		List<?> list = adrAMSDAO.selectAdrAMSList(adrVO);
		/** 목록 조회 건 수 */
		int cnt = adrAMSDAO.selectAdrAMSListCnt(adrVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}

	@Override
	public AdrAMSVO selectAdrAMSDetail(AdrAMSVO adrAMSVO) throws Exception {
		// TODO 상세조회에 대한 조건 로직 추가
		adrAMSVO.getAdbkFrstWrterNm();
		/*
		 * String uniqId = idgenService.getNextStringId(); adrAMSVO.setAdbkId(uniqId);
		 * 
		 * LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		 * adrAMSVO.setAdbkFrstWrterId(user.getUniqId());
		 */
		
		return adrAMSDAO.selectAdrAMSDetail(adrAMSVO);
	}

	@Override
	public String registAdrAMSAct(AdrAMSVO adrAMSVO) throws FdlException, Exception {
		//고유아이디 셋팅
		String uniqId = idgenService.getNextStringId();
		adrAMSVO.setAdbkId(uniqId);
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrAMSVO.setAdbkFrstWrterId(user.getUniqId());
		
		adrAMSDAO.insertAdrAMSAct(adrAMSVO);
		return uniqId;
	}

	@Override
	public void updateAdrAMSAct(AdrAMSVO adrAMSVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrAMSVO.setAdbkLastUpdusrId(user.getUniqId());
		adrAMSDAO.updateAdrAMSAct(adrAMSVO);
	}

	@Override
	public void deleteAdrAMSAct(AdrAMSVO adrAMSVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrAMSVO.setAdbkDltrId(user.getUniqId());
		adrAMSDAO.deleteAdrAMSAct(adrAMSVO);
	}

}
