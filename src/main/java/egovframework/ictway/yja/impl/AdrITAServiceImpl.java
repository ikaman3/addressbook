package egovframework.ictway.yja.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.LoginVO;
import egovframework.ictway.yja.service.AdrITAService;
import egovframework.ictway.yja.service.AdrITAVO;

/**
 * 주소록 정보 관리를 위한 구현 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 유지애 / 최초생성
 * </pre>
 * @see
 */
@Service("adrITAService")
public class AdrITAServiceImpl implements AdrITAService {

	@Resource(name = "adrITADAO")
    private AdrITADAO adrITADAO;
	
	/** yja-adrITAIdGnrService */
	@Resource(name="yja-adrITAIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Override
	public Map<String, Object> selectAdrITAList(AdrITAVO adrITAVO) throws Exception {

		/** 목록 조회 */
		List<?> list = adrITADAO.selectAdrITAList(adrITAVO);
		/** 목록 조회 건 수 */
		int cnt = adrITADAO.selectAdrITAListCnt(adrITAVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}

	@Override
	public AdrITAVO selectAdrITADetail(AdrITAVO adrITAVO) throws Exception {
		// TODO 상세조회에 대한 조건 로직 추가
		return adrITADAO.selectAdrITADetail(adrITAVO);
	}

	@Override
	public String registAdrITAAct(AdrITAVO adrITAVO) throws FdlException, Exception {
		//고유아이디 셋팅
		Long uniqIdLong = idgenService.getNextLongId();
		adrITAVO.setAdbkSn(uniqIdLong);
		String uniqId = Long.toString(uniqIdLong);
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrITAVO.setRegistUserId(user.getUniqId());
		adrITADAO.insertAdrITAAct(adrITAVO);
		return uniqId;
	}

	@Override
	public void updateAdrITAAct(AdrITAVO adrITAVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrITAVO.setRegistUserId(user.getUniqId());
		adrITADAO.updateAdrITAAct(adrITAVO);
	}

	@Override
	public void deleteAdrITAAct(AdrITAVO adrITAVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrITAVO.setRegistUserId(user.getUniqId());
		adrITADAO.deleteAdrITAAct(adrITAVO);
	}

}
