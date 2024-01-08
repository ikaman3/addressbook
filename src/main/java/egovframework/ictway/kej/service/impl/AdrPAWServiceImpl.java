package egovframework.ictway.kej.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.LoginVO;
import egovframework.ictway.kej.service.AdrPAWService;
import egovframework.ictway.kej.service.AdrPAWVO;

/**
 * 주소록 정보 관리를 위한 구현 클래스
 * @author ICTWAY
 * @since 2023.12.29
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 김은지 / 최초생성
 * </pre>
 * @see
 */
@Service("AdrPAWService")
public class AdrPAWServiceImpl implements AdrPAWService {

	@Resource(name = "adrPAWDAO")
    private AdrPAWDAO adrPAWDAO;
	
	/** kej-adrIdGnrService */
	@Resource(name="kej-adrPAWIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Override
	public Map<String, Object> selectAdrPAWList(AdrPAWVO adrPAWVO) throws Exception {

		/** 목록 조회 */
		List<?> list = adrPAWDAO.selectAdrPAWList(adrPAWVO);
		/** 목록 조회 건 수 */
		int cnt = adrPAWDAO.selectAdrPAWListCnt(adrPAWVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}

	@Override
	public AdrPAWVO selectAdrPAWDetail(AdrPAWVO adrPAWVO) throws Exception {
		// TODO 상세조회에 대한 조건 로직 추가
		return adrPAWDAO.selectAdrPAWDetail(adrPAWVO);
	}

	@Override
	public String registAdrPAWAct(AdrPAWVO adrPAWVO) throws FdlException, Exception {
		//고유아이디 셋팅
		String uniqId = idgenService.getNextStringId();
		adrPAWVO.setAdbkId(uniqId);
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrPAWVO.setAdbkFrstWrterId(user.getUniqId());
		adrPAWVO.setAdbkFrstWrterNm(user.getName());
		
		adrPAWDAO.insertAdrPAWAct(adrPAWVO);
		return uniqId;
	}

	@Override
	public void updateAdrPAWAct(AdrPAWVO adrPAWVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrPAWVO.setAdbkLastUpdusrId(user.getUniqId());
		adrPAWDAO.updateAdrPAWAct(adrPAWVO);
	}

	@Override
	public void deleteAdrPAWAct(AdrPAWVO adrPAWVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrPAWVO.setAdbkDltrId(user.getUniqId());
		adrPAWDAO.deleteAdrPAWAct(adrPAWVO);
	}

	

}
