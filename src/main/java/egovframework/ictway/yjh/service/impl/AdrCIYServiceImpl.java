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

import java.time.ZonedDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

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
@Service("adrCIYService")
public class AdrCIYServiceImpl implements AdrCIYService {
	ZoneId koreaTimeZone = ZoneId.of("Asia/Seoul");
	
	@Resource(name = "adrCIYDAO")
    private AdrCIYDAO adrCIYDAO;
	
	/** yjh-adrIdGnrService */
	@Resource(name="yjh-adrIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Override
	public Map<String, Object> selectAdrList(AdrCIYVO adrCIYVO) throws Exception {

		/** 목록 조회 */
		List<?> list = adrCIYDAO.selectAdrList(adrCIYVO);
		/** 목록 조회 건 수 */
		int cnt = adrCIYDAO.selectAdrListCnt(adrCIYVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
	}

	@Override
	public AdrCIYVO selectAdrDetail(AdrCIYVO adrCIYVO) throws Exception {
		// TODO 상세조회에 대한 조건 로직 추가
		return adrCIYDAO.selectAdrDetail(adrCIYVO);
	}
    
	@Override
	public String registAdrAct(AdrCIYVO adrCIYVO) throws FdlException, Exception {
		//고유아이디 셋팅
		String uniqId = idgenService.getNextStringId();
		adrCIYVO.setAdbkId(uniqId);
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrCIYVO.setAdbkWrterId(user.getUniqId());
		
		// 현재 시간 셋팅
		ZonedDateTime currentTimeInKorea = ZonedDateTime.now(koreaTimeZone);
	    // 포맷팅을 위한 DateTimeFormatter 생성
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss z");
	    String formattedTime = currentTimeInKorea.format(formatter);
		adrCIYVO.setAdbkCreatDt(formattedTime);
		
		adrCIYDAO.insertAdrAct(adrCIYVO);
		return uniqId;
	}

	@Override
	public void updateAdrAct(AdrCIYVO adrCIYVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrCIYVO.setAdbkUpdusrId(user.getUniqId());
		adrCIYDAO.updateAdrAct(adrCIYVO);
		
		// 현재 시간 셋팅
		ZonedDateTime currentTimeInKorea = ZonedDateTime.now(koreaTimeZone);
	    // 포맷팅을 위한 DateTimeFormatter 생성
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss z");
	    String formattedTime = currentTimeInKorea.format(formatter);
	    // 수정일자 변경
	    adrCIYVO.setAdbkUpdtDt(formattedTime);
	}

	@Override
	public void deleteAdrAct(AdrCIYVO adrCIYVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		adrCIYVO.setAdbkDltrId(user.getUniqId());
		adrCIYDAO.deleteAdrAct(adrCIYVO);
		
		// 현재 시간 셋팅
		ZonedDateTime currentTimeInKorea = ZonedDateTime.now(koreaTimeZone);
	    // 포맷팅을 위한 DateTimeFormatter 생성
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss z");
	    String formattedTime = currentTimeInKorea.format(formatter);
	    // 삭제일시 셋팅
	    adrCIYVO.setAdbkDeleteDt(formattedTime);
	    
	    // 삭제여부 셋팅
	    adrCIYVO.setAdbkDeleteAt("Y");
;	}
}
