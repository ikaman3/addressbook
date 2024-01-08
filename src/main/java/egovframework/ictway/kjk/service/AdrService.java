package egovframework.ictway.kjk.service;

import java.util.Map;

import org.egovframe.rte.fdl.cmmn.exception.FdlException;

/**
 * 주소록 정보 관리를 위한 서비스 인터페이스
 * @author ICTWAY
 * @since 2024.12.29
 * @version 1.0
 * @Modification
 * <pre>
 *2024.12.29 / 김진광 / 최초생성
 * </pre>
 * @see
 */
public interface AdrService {

	/**
	 * 검색된 목록과 건 수를 조회한다.
	 * @param adrVO - 조회할 정보가 담긴 VO
	 * @return Map - resultList(목록), resultCnt(목록 건 수)
	 * @exception Exception
	 */
	Map<String, Object> selectAdrList(AdrVO adrVO) throws Exception;

	/**
	 * 정보를 조회한다.
	 * @param adrVO - 조회할 정보가 담긴 VO
	 * @return 정보 1건
	 * @exception Exception
	 */	
	AdrVO selectAdrDetail(AdrVO adrVO) throws Exception;
	
	/**
	 * 정보를 등록한다.
	 * @param adrVO - 등록할 정보가 담긴 VO
	 * @return pk
	 * @exception FdlException
	 * @throws Exception 
	 */
	String registAdrAct(AdrVO adrVO) throws FdlException, Exception;

	/**
	 * 정보를 수정한다.
	 * @param adrVO - 수정할 정보가 담긴 VO
	 * @return true/false - 성공 실패 여부
	 * @exception Exception
	 */	
	Boolean updateAdrAct(AdrVO adrVO) throws Exception;

	/**
	 * 정보를 삭제한다.
	 * @param adrVO - 삭제할 정보가 담긴 VO
	 * @return true/false - 성공 실패 여부
	 * @exception Exception
	 */	
	Boolean deleteAdrAct(AdrVO adrVO) throws Exception;
}
