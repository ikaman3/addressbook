package egovframework.ictway.iny.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.ictway.iny.service.AdrINYVO;

/**
 * 주소록 정보 관리를 위한 데이터 처리 클래스
 * @author ICTWAY
 * @since 2024.12.29
 * @version 1.0
 * @Modification
 * <pre>
 *2024.12.29 / 윤현종 / 최초생성
 * </pre>
 * @see
 */
@Repository("adrINYDAO")
public class AdrINYDAO extends EgovAbstractMapper {
	
	/**
	 * 검색된 목록을 조회한다.
	 * @param adrINYVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public List<?> selectAdrINYList(AdrINYVO adrINYVO) {
		return selectList("AdrINYDAO.selectAdrINYList", adrINYVO);
	}

	/**
	 * 검색된 목록의 총 건 수를 조회한다.
	 * @param adrINYVO - 조회할 정보가 담긴 VO
	 * @return 목록 건 수
	 */
	public int selectAdrINYListCnt(AdrINYVO adrINYVO) {
		return (Integer)selectOne("AdrINYDAO.selectAdrINYListCnt", adrINYVO);
	}
	
	/**
	 * 정보를 조회한다.
	 * @param adrINYVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public AdrINYVO selectAdrINYDetail(AdrINYVO adrINYVO) {
		return selectOne("AdrINYDAO.selectAdrINYDetail", adrINYVO);
	}
	
	/**
	 * 정보를 등록한다.
	 * @param adrINYVO - 등록할 정보가 담긴 VO
	 * @return void
	 */
	public void insertAdrINYAct(AdrINYVO adrINYVO) {
		insert("AdrINYDAO.insertAdrINYAct", adrINYVO);
	}

	/**
	 * 정보를 수정한다.
	 * @param adrINYVO - 수정할 정보가 담긴 VO
	 * @return void
	 */
	public void updateAdrINYAct(AdrINYVO adrINYVO) {
		update("AdrINYDAO.updateAdrINYAct", adrINYVO);
	}

	/**
	 * 정보를 삭제한다.
	 * @param adrINYVO - 삭제할 정보가 담긴 VO
	 * @return void
	 */
	public void deleteAdrINYAct(AdrINYVO adrINYVO) {
		update("AdrINYDAO.deleteAdrINYAct", adrINYVO);
	}
}
