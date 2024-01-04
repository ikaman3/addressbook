package egovframework.ictway.yja.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.ictway.yja.service.AdrITAVO;

/**
 * 주소록 정보 관리를 위한 데이터 처리 클래스
 * @author ICTWAY
 * @since 2024.12.29
 * @version 1.0
 * @Modification
 * <pre>
 *2024.12.29 / 유지애 / 최초생성
 * </pre>
 * @see
 */
@Repository("adrITADAO")
public class AdrITADAO extends EgovAbstractMapper {
	
	/**
	 * 검색된 목록을 조회한다.
	 * @param adrITAVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public List<AdrITAVO> selectAdrITAList(AdrITAVO adrITAVO) {
		return selectList("AdrITADAO.selectAdrITAList", adrITAVO);
	}

	/**
	 * 검색된 목록의 총 건 수를 조회한다.
	 * @param adrITAVO - 조회할 정보가 담긴 VO
	 * @return 목록 건 수
	 */
	public int selectAdrITAListCnt(AdrITAVO adrITAVO) {
		return (Integer)selectOne("AdrITADAO.selectAdrITAListCnt", adrITAVO);
	}
	
	/**
	 * 정보를 조회한다.
	 * @param adrITAVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public AdrITAVO selectAdrITADetail(AdrITAVO adrITAVO) {
		return selectOne("AdrITADAO.selectAdrITADetail", adrITAVO);
	}
	
	/**
	 * 정보를 등록한다.
	 * @param adrITAVO - 등록할 정보가 담긴 VO
	 * @return void
	 */
	public void insertAdrITAAct(AdrITAVO adrITAVO) {
		insert("AdrITADAO.insertAdrITAAct", adrITAVO);
	}

	/**
	 * 정보를 수정한다.
	 * @param adrITAVO - 수정할 정보가 담긴 VO
	 * @return void
	 */
	public void updateAdrITAAct(AdrITAVO adrITAVO) {
		update("AdrITADAO.updateAdrITAAct", adrITAVO);
	}

	/**
	 * 정보를 삭제한다.
	 * @param adrITAVO - 삭제할 정보가 담긴 VO
	 * @return void
	 */
	public void deleteAdrITAAct(AdrITAVO adrITAVO) {
		update("AdrITADAO.deleteAdrITAAct", adrITAVO);
	}
}
