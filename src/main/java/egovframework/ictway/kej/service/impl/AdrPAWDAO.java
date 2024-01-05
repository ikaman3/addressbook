package egovframework.ictway.kej.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.ictway.kej.service.AdrPAWVO;

/**
 * 주소록 정보 관리를 위한 데이터 처리 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 김은지 / 최초생성
 * </pre>
 * @see
 */
@Repository("adrPAWDAO")
public class AdrPAWDAO extends EgovAbstractMapper {
	
	/**
	 * 검색된 목록을 조회한다.
	 * @param AdrPAWVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public List<?> selectAdrList(AdrPAWVO adrPAWVO) {
		return selectList("AdrPAWDAO.selectAdrList", adrPAWVO);
	}

	/**
	 * 검색된 목록의 총 건 수를 조회한다.
	 * @param AdrPAWVO - 조회할 정보가 담긴 VO
	 * @return 목록 건 수
	 */
	public int selectAdrListCnt(AdrPAWVO adrPAWVO) {
		return (Integer)selectOne("AdrPAWDAO.selectAdrListCnt", adrPAWVO);
	}
	
	/**
	 * 정보를 조회한다.
	 * @param AdrPAWVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public AdrPAWVO selectAdrDetail(AdrPAWVO adrPAWVO) {
		return selectOne("AdrPAWDAO.selectAdrDetail", adrPAWVO);
	}
	
	/**
	 * 정보를 등록한다.
	 * @param AdrPAWVO - 등록할 정보가 담긴 VO
	 * @return void
	 */
	public void insertAdrAct(AdrPAWVO adrPAWVO) {
		insert("AdrPAWDAO.insertAdrAct", adrPAWVO);
	}

	/**
	 * 정보를 수정한다.
	 * @param AdrPAWVO - 수정할 정보가 담긴 VO
	 * @return void
	 */
	public void updateAdrAct(AdrPAWVO adrPAWVO) {
		update("AdrPAWDAO.updateAdrAct", adrPAWVO);
	}

	/**
	 * 정보를 삭제한다.
	 * @param AdrPAWVO - 삭제할 정보가 담긴 VO
	 * @return void
	 */
	public void deleteAdrAct(AdrPAWVO adrPAWVO) {
		update("AdrPAWDAO.deleteAdrAct", adrPAWVO);
	}
}
