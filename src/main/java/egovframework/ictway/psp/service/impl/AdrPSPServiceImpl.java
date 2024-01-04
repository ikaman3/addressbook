package egovframework.ictway.psp.service.impl;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.LoginVO;
import egovframework.ictway.psp.service.AdrPSPService;
import egovframework.ictway.psp.service.AdrPSPVO;

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
public class AdrPSPServiceImpl implements AdrPSPService {

	@Resource(name = "AdrPSPDAO")
    private AdrPSPDAO AdrPSPDAO;
	
	/** kjk-adrIdGnrService */
	@Resource(name="kjk-adrIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Override
	public Map<String, Object> selectAdrList(AdrPSPVO AdrPSPVO) throws Exception {

		/** 목록 조회 */
		List<?> list = AdrPSPDAO.selectAdrList(AdrPSPVO);
		/** 목록 조회 건 수 */
		int cnt = AdrPSPDAO.selectAdrListCnt(AdrPSPVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}

	@Override
	public AdrPSPVO selectAdrDetail(AdrPSPVO AdrPSPVO) throws Exception {
		// TODO 상세조회에 대한 조건 로직 추가
		return AdrPSPDAO.selectAdrDetail(AdrPSPVO);
	}

	@Override
	public Long registAdrAct(AdrPSPVO AdrPSPVO) throws FdlException, Exception {
		
		//고유아이디 셋팅
		Long uniqId = idgenService.getNextLongId();
		AdrPSPVO.setAdbkSn(uniqId);
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		AdrPSPVO.setUsrId(user.getUniqId());
		
		AdrPSPDAO.insertAdrAct(AdrPSPVO);
		return uniqId;
	}

	@Override
	public void updateAdrAct(AdrPSPVO AdrPSPVO) throws Exception {
		//로그인 유저 이름
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		AdrPSPVO.setUsrId(user.getUniqId());
		AdrPSPDAO.updateAdrAct(AdrPSPVO);
	}

	@Override
	public void deleteAdrAct(AdrPSPVO AdrPSPVO) throws Exception {
		// 로그인 유저 이름
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		AdrPSPVO.setUsrId(user.getUniqId());
		AdrPSPDAO.deleteAdrAct(AdrPSPVO);
	}

}