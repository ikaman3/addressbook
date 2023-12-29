package egovframework.ictway.kjk.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.ictway.kjk.service.AdrVO;

/**
 * 주소록 정보 관리를 위한 데이터 처리 클래스
 * @author ICTWAY
 * @since 2024.12.29
 * @version 1.0
 * @Modification
 * <pre>
 *2024.12.29 / 김진광 / 최초생성
 * </pre>
 * @see
 */
@Repository("adrDAO")
public class AdrDAO extends EgovAbstractMapper {
	
	/**
	 * 검색된 목록을 조회한다.
	 * @param adrVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public List<?> selectAdrList(AdrVO adrVO) {
		return selectList("AdrDAO.selectAdrList", adrVO);
	}

	/**
	 * 검색된 목록의 총 건 수를 조회한다.
	 * @param adrVO - 조회할 정보가 담긴 VO
	 * @return 목록 건 수
	 */
	public int selectAdrListCnt(AdrVO adrVO) {
		return (Integer)selectOne("AdrDAO.selectAdrListCnt", adrVO);
	}
	
	/**
	 * 정보를 조회한다.
	 * @param adrVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public AdrVO selectAdrDetail(AdrVO adrVO) {
		return selectOne("AdrDAO.selectAdrDetail", adrVO);
	}
	
	/**
	 * 정보를 등록한다.
	 * @param adrVO - 등록할 정보가 담긴 VO
	 * @return void
	 */
	public void insertAdrAct(AdrVO adrVO) {
		insert("AdrDAO.insertAdrAct", adrVO);
	}

	/**
	 * 정보를 수정한다.
	 * @param adrVO - 수정할 정보가 담긴 VO
	 * @return void
	 */
	public void updateAdrAct(AdrVO adrVO) {
		update("AdrDAO.updateAdrAct", adrVO);
	}

	/**
	 * 정보를 삭제한다.
	 * @param adrVO - 삭제할 정보가 담긴 VO
	 * @return void
	 */
	public void deleteAdrAct(AdrVO adrVO) {
		update("AdrDAO.deleteAdrAct", adrVO);
	}
}
