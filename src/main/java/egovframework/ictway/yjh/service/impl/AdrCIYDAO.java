package egovframework.ictway.yjh.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.ictway.yjh.service.AdrCIYVO;

/**
 * 주소록 정보 관리를 위한 데이터 처리 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 윤준현 / 최초생성
 * </pre>
 * @see
 */
@Repository("adrCIYDAO")
public class AdrCIYDAO extends EgovAbstractMapper {
	
	/**
	 * 검색된 목록을 조회한다.
	 * @param adrCIYVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public List<?> selectAdrCIYList(AdrCIYVO adrCIYVO) {
		return selectList("AdrCIYDAO.selectAdrCIYList", adrCIYVO);
	}

	/**
	 * 검색된 목록의 총 건 수를 조회한다.
	 * @param adrCIYVO - 조회할 정보가 담긴 VO
	 * @return 목록 건 수
	 */
	public int selectAdrCIYListCnt(AdrCIYVO adrCIYVO) {
		return (Integer)selectOne("AdrCIYDAO.selectAdrCIYListCnt", adrCIYVO);
	}
	
	/**
	 * 정보를 조회한다.
	 * @param adrCIYVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public AdrCIYVO selectAdrCIYDetail(AdrCIYVO adrCIYVO) {
		return selectOne("AdrCIYDAO.selectAdrCIYDetail", adrCIYVO);
	}
	
	/**
	 * 정보를 등록한다.
	 * @param adrCIYVO - 등록할 정보가 담긴 VO
	 * @return void
	 */
	public void insertAdrCIYAct(AdrCIYVO adrCIYVO) {
		insert("AdrCIYDAO.insertAdrCIYAct", adrCIYVO);
	}

	/**
	 * 정보를 수정한다.
	 * @param adrCIYVO - 수정할 정보가 담긴 VO
	 * @return void
	 */
	public void updateAdrCIYAct(AdrCIYVO adrCIYVO) {
		update("AdrCIYDAO.updateAdrCIYAct", adrCIYVO);
	}

	/**
	 * 정보를 삭제한다.
	 * @param adrCIYVO - 삭제할 정보가 담긴 VO
	 * @return void
	 */
	public void deleteAdrCIYAct(AdrCIYVO adrCIYVO) {
		update("AdrCIYDAO.deleteAdrCIYAct", adrCIYVO);
	}
}
