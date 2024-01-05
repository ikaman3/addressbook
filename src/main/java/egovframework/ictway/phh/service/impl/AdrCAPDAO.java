package egovframework.ictway.phh.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.ictway.phh.service.AdrCAPVO;

/**
 * 주소 정보 정보 관리를 위한 데이터 처리 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 박현희 / 최초생성
 * </pre>
 * @see
 */
@Repository("adrCAPDAO")
public class AdrCAPDAO extends EgovAbstractMapper {
	
	/**
	 * 검색된 목록을 조회한다.
	 * @param adrCAPVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public List<?> selectAdrCAPList(AdrCAPVO adrCAPVO) {
		return selectList("AdrCAPDAO.selectAdrCAPList", adrCAPVO);
	}

	/**
	 * 검색된 목록의 총 건 수를 조회한다.
	 * @param adrCAPVO - 조회할 정보가 담긴 VO
	 * @return 목록 건 수
	 */
	public int selectAdrCAPListCnt(AdrCAPVO adrCAPVO) {
		return (Integer)selectOne("AdrCAPDAO.selectAdrCAPListCnt", adrCAPVO);
	}
	
	/**
	 * 정보를 조회한다.
	 * @param adrCAPVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public AdrCAPVO selectAdrCAPDetail(AdrCAPVO adrCAPVO) {
		return selectOne("AdrCAPDAO.selectAdrCAPDetail", adrCAPVO);
	}
	
	/**
	 * 정보를 등록한다.
	 * @param adrCAPVO - 등록할 정보가 담긴 VO
	 * @return void
	 */
	public void insertAdrCAPAct(AdrCAPVO adrCAPVO) {
		insert("AdrCAPDAO.insertAdrCAPAct", adrCAPVO);
	}

	/**
	 * 정보를 수정한다.
	 * @param adrCAPVO - 수정할 정보가 담긴 VO
	 * @return void
	 */
	public void updateAdrCAPAct(AdrCAPVO adrCAPVO) {
		update("AdrCAPDAO.updateAdrCAPAct", adrCAPVO);
	}

	/**
	 * 정보를 삭제한다.
	 * @param adrCAPVO - 삭제할 정보가 담긴 VO
	 * @return void
	 */
	public void deleteAdrCAPAct(AdrCAPVO adrCAPVO) {
		update("AdrCAPDAO.deleteAdrCAPAct", adrCAPVO);
	}
}
