package egovframework.ictway.yhj.service;

import java.util.Map;

import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.springframework.web.multipart.MultipartFile;

/**
 * 주소록 정보 관리를 위한 서비스 인터페이스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 염혜정 / 최초생성
 * </pre>
 * @see
 */
public interface AdrGMAService {

	/**
	 * 검색된 목록과 건 수를 조회한다.
	 * @param adrGMAVO - 조회할 정보가 담긴 VO
	 * @return Map - resultList(목록), resultCnt(목록 건 수)
	 * @exception Exception
	 */
	Map<String, Object> selectAdrGMAList(AdrGMAVO adrGMAVO) throws Exception;

	/**
	 * 정보를 조회한다.
	 * @param adrGMAVO - 조회할 정보가 담긴 VO
	 * @return 정보 1건
	 * @exception Exception
	 */	
	AdrGMAVO selectAdrGMADetail(AdrGMAVO adrGMAVO) throws Exception;
	
	/**
	 * 정보를 등록한다.
	 * @param adrGMAVO - 등록할 정보가 담긴 VO
	 * @return pk
	 * @exception FdlException
	 * @throws Exception 
	 */
	String registAdrGMAAct(AdrGMAVO adrGMAVO, MultipartFile image) throws FdlException, Exception;

	/**
	 * 정보를 수정한다.
	 * @param adrGMAVO - 수정할 정보가 담긴 VO
	 * @return true/false - 성공 실패 여부
	 * @exception Exception
	 */	
	Boolean updateAdrGMAAct(AdrGMAVO adrGMAVO, MultipartFile image) throws Exception;

	/**
	 * 정보를 삭제한다.
	 * @param adrGMAVO - 삭제할 정보가 담긴 VO
	 * @return true/false - 성공 실패 여부
	 * @exception Exception
	 */	
	Boolean deleteAdrGMAAct(AdrGMAVO adrGMAVO) throws Exception;
}
