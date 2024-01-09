package egovframework.ictway.iny.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.LoginVO;
import egovframework.ictway.iny.service.AdrINYService;
import egovframework.ictway.iny.service.AdrINYVO;

/**
 * 주소록 정보 관리를 위한 구현 클래스
 * @author ICTWAY
 * @since 2024.12.29
 * @version 1.0
 * @Modification
 * <pre>
 *2024.12.29 / 윤현종 / 최초생성
 * </pre>
 * @see
 */
@Service("adrINYService")
public class AdrINYServiceImpl implements AdrINYService {

	@Resource(name = "adrINYDAO")
    private AdrINYDAO adrINYDAO;
	
	@Resource(name="iny-adrINYIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Override
	public Map<String, Object> selectAdrINYList(AdrINYVO abrINYVO) throws Exception {

		/** 목록 조회 */
		List<?> list = adrINYDAO.selectAdrINYList(abrINYVO);
		/** 목록 조회 건 수 */
		int cnt = adrINYDAO.selectAdrINYListCnt(abrINYVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}

	@Override
	public AdrINYVO selectAdrINYDetail(AdrINYVO abrINYVO) throws Exception {
		// TODO 상세조회에 대한 조건 로직 추가
		return adrINYDAO.selectAdrINYDetail(abrINYVO);
	}

	@Override
	public long registAdrINYAct(AdrINYVO abrINYVO) throws FdlException, Exception {

		//고유아이디셋팅 String -> long
		long uniqId = idgenService.getNextLongId();
		abrINYVO.setAdbkSn(uniqId);
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		abrINYVO.setRegistUserId(user.getUniqId());
		abrINYVO.setRegistUserNm(user.getUniqId());
		adrINYDAO.insertAdrINYAct(abrINYVO);
		return uniqId;
	}
		
	@Override
	public void updateAdrINYAct(AdrINYVO abrINYVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		abrINYVO.setRegistUserId(user.getUniqId());
		adrINYDAO.updateAdrINYAct(abrINYVO);
	}

	@Override
	public void deleteAdrINYAct(AdrINYVO abrINYVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		abrINYVO.setRegistUserId(user.getUniqId());
		adrINYDAO.deleteAdrINYAct(abrINYVO);
	}
	
}

