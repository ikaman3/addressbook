package egovframework.ictway.psp.service.impl;

import java.util.List;


import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.ictway.psp.service.AdrPSPVO;

/**
 * 주소록 정보 관리를 위한 데이터 처리 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 현승민 / 최초생성
 * </pre>
 * @see
 */
@Repository("adrPSPDAO")
public class AdrPSPDAO extends EgovAbstractMapper {
	
	/**
	 * 검색된 목록을 조회한다.
	 * @param AdrPSPVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public List<?> selectAdrPSPList(AdrPSPVO AdrPSPVO) {
		return selectList("AdrPSPDAO.selectAdrPSPList", AdrPSPVO);
	}

	/**
	 * 검색된 목록의 총 건 수를 조회한다.
	 * @param AdrPSPVO - 조회할 정보가 담긴 VO
	 * @return 목록 건 수
	 */
	public int selectAdrPSPListCnt(AdrPSPVO AdrPSPVO) {
		return (Integer)selectOne("AdrPSPDAO.selectAdrPSPListCnt", AdrPSPVO);
	}
	
	/**
	 * 정보를 조회한다.
	 * @param AdrPSPVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public AdrPSPVO selectAdrPSPDetail(AdrPSPVO AdrPSPVO) {
		return selectOne("AdrPSPDAO.selectAdrPSPDetail", AdrPSPVO);
	}
	
	/**
	 * 정보를 등록한다.
	 * @param AdrPSPVO - 등록할 정보가 담긴 VO
	 * @return void
	 */
	public void insertAdrPSPAct(AdrPSPVO AdrPSPVO) {
		insert("AdrPSPDAO.insertAdrPSPAct", AdrPSPVO);
	}

	/**
	 * 정보를 수정한다.
	 * @param AdrPSPVO - 수정할 정보가 담긴 VO
	 * @return void
	 */
	public void updateAdrPSPAct(AdrPSPVO AdrPSPVO) {
		update("AdrPSPDAO.updateAdrPSPAct", AdrPSPVO);
	}

	/**
	 * 정보를 삭제한다.
	 * @param AdrPSPVO - 삭제할 정보가 담긴 VO
	 * @return void
	 */
	public void deleteAdrPSPAct(AdrPSPVO AdrPSPVO) {
		update("AdrPSPDAO.deleteAdrPSPAct", AdrPSPVO);
	}
}