package egovframework.ictway.phh.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.LoginVO;
import egovframework.ictway.phh.service.AdrCAPService;
import egovframework.ictway.phh.service.AdrCAPVO;

/**
 * 주소 정보 정보 관리를 위한 구현 클래스
 * @author ICTWAY
 * @since 2024.12.29
 * @version 1.0
 * @Modification
 * <pre>
 *2024.12.29 / 박현희 / 최초생성
 * </pre>
 * @see
 */
@Service("adrCAPService")
public class AdrCAPServiceImpl implements AdrCAPService {

	@Resource(name = "adrCAPDAO")
    private AdrCAPDAO adrCAPDAO;
	
	/** phh-adrCAPIdGnrService */
	@Resource(name="phh-adrCAPIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Override
	public Map<String, Object> selectAdrCAPList(AdrCAPVO adrCAPVO) throws Exception {

		/** 목록 조회 */
		List<?> list = adrCAPDAO.selectAdrCAPList(adrCAPVO);
		/** 목록 조회 건 수 */
		int cnt = adrCAPDAO.selectAdrCAPListCnt(adrCAPVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}

	@Override
	public AdrCAPVO selectAdrCAPDetail(AdrCAPVO adrCAPVO) throws Exception {
		// TODO 상세조회에 대한 조건 로직 추가
		return adrCAPDAO.selectAdrCAPDetail(adrCAPVO);
	}

	@Override
	public String registAdrCAPAct(AdrCAPVO adrCAPVO) throws FdlException, Exception {
		//고유아이디 셋팅
		String uniqId = idgenService.getNextStringId();
		adrCAPVO.setAdbkId(uniqId);
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrCAPVO.setAdbkWrterId(user.getUniqId());
		
		adrCAPDAO.insertAdrCAPAct(adrCAPVO);
		return uniqId;
	}

	@Override
	public void updateAdrCAPAct(AdrCAPVO adrCAPVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrCAPVO.setAdbkUpdusrId(user.getUniqId());
		adrCAPDAO.updateAdrCAPAct(adrCAPVO);
	}

	@Override
	public void deleteAdrCAPAct(AdrCAPVO adrCAPVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrCAPVO.setAdbkDltrId(user.getUniqId());
		adrCAPDAO.deleteAdrCAPAct(adrCAPVO);
	}

}
