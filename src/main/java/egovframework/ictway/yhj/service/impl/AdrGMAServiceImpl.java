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
import egovframework.ictway.yhj.service.AddressInfoVO;
import egovframework.ictway.yhj.service.AdrGMAService;

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
public class AdrGMAServiceImpl implements AdrGMAService {

	@Resource(name = "adrGMADAO")
    private AdrGMADAO adrGMADAO;
	
	/** kjk-adrIdGnrService */
	@Resource(name="kjk-adrIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Override
	public Map<String, Object> selectAdrList(AddressInfoVO addressInfoVO) throws Exception {

		/** 목록 조회 */
		List<?> list = adrGMADAO.selectAdrList(addressInfoVO);
		/** 목록 조회 건 수 */
		int cnt = adrGMADAO.selectAdrListCnt(addressInfoVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}

	@Override
	public AddressInfoVO selectAdrDetail(AddressInfoVO addressInfoVO) throws Exception {
		// TODO 상세조회에 대한 조건 로직 추가
		return adrGMADAO.selectAdrDetail(addressInfoVO);
	}

	@Override
	public String registAdrAct(AddressInfoVO addressInfoVO) throws FdlException, Exception {
		//고유아이디 셋팅
		String uniqId = idgenService.getNextStringId();
		addressInfoVO.setAdbkSn(uniqId);
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		addressInfoVO.setAdbkWrterNm(user.getUniqId());
		
		adrGMADAO.insertAdrAct(addressInfoVO);
		return uniqId;
	}

	@Override
	public void updateAdrAct(AddressInfoVO addressInfoVO) throws Exception {
		adrGMADAO.updateAdrAct(addressInfoVO);
	}

	@Override
	public void deleteAdrAct(AddressInfoVO addressInfoVO) throws Exception {
		adrGMADAO.deleteAdrAct(addressInfoVO);
	}

}
