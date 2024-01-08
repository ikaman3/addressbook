package egovframework.ictway.yhj.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.ictway.yhj.service.AdrGMAVO;

/**
 * 주소록 정보 관리를 위한 데이터 처리 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 염혜정 / 최초생성
 * </pre>
 * @see
 */
@Repository("adrGMADAO")
public class AdrGMADAO extends EgovAbstractMapper {
	
	/**
	 * 검색된 목록을 조회한다.
	 * @param AdrGMAVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public List<?> selectAdrGMAList(AdrGMAVO adrGMAVO) {
		return selectList("adrGMADAO.selectAdrGMAList", adrGMAVO);
	}

	/**
	 * 검색된 목록의 총 건 수를 조회한다.
	 * @param AdrGMAVO - 조회할 정보가 담긴 VO
	 * @return 목록 건 수
	 */
	public int selectAdrGMAListCnt(AdrGMAVO adrGMAVO) {
		return (Integer)selectOne("adrGMADAO.selectAdrGMAListCnt", adrGMAVO);
	}
	
	/**
	 * 정보를 조회한다.
	 * @param AdrGMAVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public AdrGMAVO selectAdrGMADetail(AdrGMAVO adrGMAVO) {
		return selectOne("adrGMADAO.selectAdrGMADetail", adrGMAVO);
	}
	
	/**
	 * 정보를 등록한다.
	 * @param AdrGMAVO - 등록할 정보가 담긴 VO
	 * @return void
	 */
	public void insertAdrGMAAct(AdrGMAVO adrGMAVO) {
		insert("adrGMADAO.insertAdrGMAAct", adrGMAVO);
	}

	/**
	 * 정보를 수정한다.
	 * @param AdrGMAVO - 수정할 정보가 담긴 VO
	 * @return void
	 */
	public void updateAdrGMAAct(AdrGMAVO adrGMAVO) {
		update("adrGMADAO.updateAdrGMAAct", adrGMAVO);
	}

	/**
	 * 정보를 삭제한다.
	 * @param AdrGMAVO - 삭제할 정보가 담긴 VO
	 * @return void
	 */
	public void deleteAdrGMAAct(AdrGMAVO adrGMAVO) {
		update("adrGMADAO.deleteAdrGMAAct", adrGMAVO);
	}
}
