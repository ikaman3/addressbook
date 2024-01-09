package egovframework.ictway.yjh.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.LoginVO;
import egovframework.ictway.yjh.service.AdrCIYService;
import egovframework.ictway.yjh.service.AdrCIYVO;

/**
 * 주소정보 관리를 위한 구현 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 윤준현 / 최초생성
 * </pre>
 * @see
 */
@Service("adrCIYService")
public class AdrCIYServiceImpl implements AdrCIYService {
	@Resource(name = "adrCIYDAO")
    private AdrCIYDAO adrCIYDAO;
	
	/** yjh-adrCIYIdGnrService */
	@Resource(name="yjh-adrCIYIdGnrService")
	private EgovIdGnrService idgenService;
	
	// 주소정보 목록 조회
	@Override
	public Map<String, Object> selectAdrCIYList(AdrCIYVO adrCIYVO) throws Exception {

		/** 목록 조회 */
		List<?> list = adrCIYDAO.selectAdrCIYList(adrCIYVO);
		/** 목록 조회 건 수 */
		int cnt = adrCIYDAO.selectAdrCIYListCnt(adrCIYVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}
	
	// 주소정보 상세조회
	@Override
	public AdrCIYVO selectAdrCIYDetail(AdrCIYVO adrCIYVO) throws Exception {
		// TODO 상세조회에 대한 조건 로직 추가
		return adrCIYDAO.selectAdrCIYDetail(adrCIYVO);
	}
    
	// 주소정보 생성
	@Override
	public String registAdrCIYAct(AdrCIYVO adrCIYVO) throws FdlException, Exception {
		//고유아이디 셋팅
		String uniqId = idgenService.getNextStringId();
		adrCIYVO.setAdbkId(uniqId);
		// 생성자 아이디 셋팅
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrCIYVO.setAdbkWrterId(user.getUniqId());
		
		adrCIYDAO.insertAdrCIYAct(adrCIYVO);
		return uniqId;
	}
	
	// 주소정보 수정
	@Override
	public void updateAdrCIYAct(AdrCIYVO adrCIYVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		// 수정자 아이디 셋팅
		adrCIYVO.setAdbkUpdusrId(user.getUniqId());
		
	    adrCIYDAO.updateAdrCIYAct(adrCIYVO);
	}

	// 주소정보 삭제
	@Override
	public void deleteAdrCIYAct(AdrCIYVO adrCIYVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		// 삭제자 아이디 셋팅
		adrCIYVO.setAdbkDltrId(user.getUniqId());
		
	    adrCIYDAO.deleteAdrCIYAct(adrCIYVO);
	}
}
