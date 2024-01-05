package egovframework.ictway.nsh.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.ictway.nsh.service.AdrAMSVO;

/**
 * 주소록 정보 관리를 위한 데이터 처리 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 남시현 / 최초생성
 * </pre>
 * @see
 */
@Repository("adrAMSDAO")
public class AdrAMSDAO extends EgovAbstractMapper {
	
	/**
	 * 검색된 목록을 조회한다.
	 * @param adrAMSVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public List<?> selectAdrAMSList(AdrAMSVO adrAMSVO) {
		return selectList("AdrAMSDAO.selectAdrAMSList", adrAMSVO);
	}

	/**
	 * 검색된 목록의 총 건 수를 조회한다.
	 * @param adrAMSVO - 조회할 정보가 담긴 VO
	 * @return 목록 건 수
	 */
	public int selectAdrAMSListCnt(AdrAMSVO adrAMSVO) {
		return (Integer)selectOne("AdrAMSDAO.selectAdrAMSListCnt", adrAMSVO);
	}
	
	/**
	 * 정보를 조회한다.
	 * @param adrAMSVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public AdrAMSVO selectAdrAMSDetail(AdrAMSVO adrAMSVO) {
		return selectOne("AdrAMSDAO.selectAdrAMSDetail", adrAMSVO);
	}
	
	/**
	 * 정보를 등록한다.
	 * @param adrAMSVO - 등록할 정보가 담긴 VO
	 * @return void
	 */
	public void insertAdrAMSAct(AdrAMSVO adrAMSVO) {
		insert("AdrAMSDAO.insertAdrAMSAct", adrAMSVO);
	}

	/**
	 * 정보를 수정한다.
	 * @param adrAMSVO - 수정할 정보가 담긴 VO
	 * @return void
	 */
	public void updateAdrAMSAct(AdrAMSVO adrAMSVO) {
		update("AdrAMSDAO.updateAdrAMSAct", adrAMSVO);
	}

	/**
	 * 정보를 삭제한다.
	 * @param adrAMSVO - 삭제할 정보가 담긴 VO
	 * @return void
	 */
	public void deleteAdrAMSAct(AdrAMSVO adrAMSVO) {
		update("AdrAMSDAO.deleteAdrAMSAct", adrAMSVO);
	}
}
