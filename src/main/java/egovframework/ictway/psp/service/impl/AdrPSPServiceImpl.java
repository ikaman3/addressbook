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
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 현승민 / 최초생성
 * </pre>
 * @see
 */
@Service("adrPSPService")
public class AdrPSPServiceImpl implements AdrPSPService {

	@Resource(name = "adrPSPDAO")
    private AdrPSPDAO AdrPSPDAO;
	
	/** psp-adrIdGnrService */
	@Resource(name="psp-adrPSPIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Override
	public Map<String, Object> selectAdrPSPList(AdrPSPVO AdrPSPVO) throws Exception {

		/** 목록 조회 */
		List<?> list = AdrPSPDAO.selectAdrPSPList(AdrPSPVO);
		/** 목록 조회 건 수 */
		int cnt = AdrPSPDAO.selectAdrPSPListCnt(AdrPSPVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}

	@Override
	public AdrPSPVO selectAdrPSPDetail(AdrPSPVO AdrPSPVO) throws Exception {
		// TODO 상세조회에 대한 조건 로직 추가
		return AdrPSPDAO.selectAdrPSPDetail(AdrPSPVO);
	}

	@Override
	public Long registAdrPSPAct(AdrPSPVO AdrPSPVO) throws FdlException, Exception {
		
		//고유아이디 셋팅
		Long uniqId = idgenService.getNextLongId();
		AdrPSPVO.setAdbkSn(uniqId);
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		AdrPSPVO.setUsrId(user.getUniqId());
		AdrPSPVO.setRegistUserNm(user.getName());
		
		AdrPSPDAO.insertAdrPSPAct(AdrPSPVO);
		return uniqId;
	}

	@Override
	public void updateAdrPSPAct(AdrPSPVO AdrPSPVO) throws Exception {
		//로그인 유저 이름
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		AdrPSPVO.setUsrId(user.getUniqId());
		AdrPSPVO.setRegistUserNm(user.getName());
		AdrPSPDAO.updateAdrPSPAct(AdrPSPVO);
	}

	@Override
	public void deleteAdrPSPAct(AdrPSPVO AdrPSPVO) throws Exception {
		// 로그인 유저 이름
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		AdrPSPVO.setUsrId(user.getUniqId());
		AdrPSPDAO.deleteAdrPSPAct(AdrPSPVO);
	}

}