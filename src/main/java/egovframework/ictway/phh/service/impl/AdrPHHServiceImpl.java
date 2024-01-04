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
import egovframework.ictway.phh.service.AdrPHHService;
import egovframework.ictway.phh.service.AdrPHHVO;

/**
 * 주소록 정보 관리를 위한 구현 클래스
 * @author ICTWAY
 * @since 2024.12.29
 * @version 1.0
 * @Modification
 * <pre>
 *2024.12.29 / 박현희 / 최초생성
 * </pre>
 * @see
 */
@Service("adrPhhService")
public class AdrPHHServiceImpl implements AdrPHHService {

	@Resource(name = "adrPhhDAO")
    private AdrPHHDAO adrDAO;
	
	/** kjk-adrIdGnrService */
	@Resource(name="kjk-adrIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Override
	public Map<String, Object> selectAdrPHHList(AdrPHHVO adrVO) throws Exception {

		/** 목록 조회 */
		List<?> list = adrDAO.selectAdrPHHList(adrVO);
		/** 목록 조회 건 수 */
		int cnt = adrDAO.selectAdrPHHListCnt(adrVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}

	@Override
	public AdrPHHVO selectAdrPHHDetail(AdrPHHVO adrVO) throws Exception {
		// TODO 상세조회에 대한 조건 로직 추가
		return adrDAO.selectAdrPHHDetail(adrVO);
	}

	@Override
	public String registAdrPHHAct(AdrPHHVO adrVO) throws FdlException, Exception {
		//고유아이디 셋팅
		String uniqId = idgenService.getNextStringId();
		adrVO.setAdbkId(uniqId);
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrVO.setAdbkWrterId(user.getUniqId());
		
		adrDAO.insertAdrPHHAct(adrVO);
		return uniqId;
	}

	@Override
	public void updateAdrPHHAct(AdrPHHVO adrVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrVO.setAdbkUpdusrId(user.getUniqId());
		adrDAO.updateAdrPHHAct(adrVO);
	}

	@Override
	public void deleteAdrPHHAct(AdrPHHVO adrVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrVO.setAdbkDltrId(user.getUniqId());
		adrDAO.deleteAdrPHHAct(adrVO);
	}

}
