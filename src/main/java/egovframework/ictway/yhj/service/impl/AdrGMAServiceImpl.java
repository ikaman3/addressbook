package egovframework.ictway.yhj.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.LoginVO;
import egovframework.ictway.yhj.service.AdrGMAVO;
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
	
	/** yhj-adrIdGnrService */
	@Resource(name="kjk-adrIdGnrService")
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
	public String registAdrGMAAct(AdrGMAVO adrGMAVO) throws FdlException, Exception {
		//고유아이디 셋팅
		String uniqId = idgenService.getNextStringId();
		adrGMAVO.setAdbkId(uniqId);
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrGMAVO.setAdbkWrterId(user.getUniqId());
		
		adrGMADAO.insertAdrGMAAct(adrGMAVO);
		return uniqId;
	}

	@Override
	public void updateAdrGMAAct(AdrGMAVO adrGMAVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrGMAVO.setAdbkUpdusrId(user.getUniqId());
		adrGMADAO.updateAdrGMAAct(adrGMAVO);
	}

	@Override
	public void deleteAdrGMAAct(AdrGMAVO adrGMAVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrGMAVO.setAdbkDltrId(user.getUniqId());
		adrGMADAO.deleteAdrGMAAct(adrGMAVO);
	}

}
