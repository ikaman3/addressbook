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
	@Resource(name="yhj-adrIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Override
	public Map<String, Object> selectAddressInfoList(AddressInfoVO addressInfoVO) throws Exception {

		/** 목록 조회 */
		List<?> list = adrGMADAO.selectAddressInfoList(addressInfoVO);
		/** 목록 조회 건 수 */
		int cnt = adrGMADAO.selectAddressInfoListCnt(addressInfoVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}

	@Override
	public AddressInfoVO selectAddressInfoDetail(AddressInfoVO addressInfoVO) throws Exception {
		// TODO 상세조회에 대한 조건 로직 추가
		return adrGMADAO.selectAddressInfoDetail(addressInfoVO);
	}

	@Override
	public String registAddressInfoAct(AddressInfoVO addressInfoVO) throws FdlException, Exception {
		//고유아이디 셋팅
		String uniqId = idgenService.getNextStringId();
		addressInfoVO.setAdbkId(uniqId);
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		addressInfoVO.setAdbkWrterId(user.getUniqId());
		
		adrGMADAO.insertAddressInfoAct(addressInfoVO);
		return uniqId;
	}

	@Override
	public void updateAddressInfoAct(AddressInfoVO addressInfoVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		addressInfoVO.setAdbkUpdusrId(user.getUniqId());
		adrGMADAO.updateAddressInfoAct(addressInfoVO);
	}

	@Override
	public void deleteAddressInfoAct(AddressInfoVO addressInfoVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		addressInfoVO.setAdbkDltrId(user.getUniqId());
		adrGMADAO.deleteAddressInfoAct(addressInfoVO);
	}

}
