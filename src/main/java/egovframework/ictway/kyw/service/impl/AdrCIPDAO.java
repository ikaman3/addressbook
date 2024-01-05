package egovframework.ictway.kyw.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.ictway.kyw.service.AdrCIPVO;

/**
 * 주소록 정보 관리를 위한 데이터 처리 클래스
 * @author ICTWAY
 * @since 2024.01.04
 * @version 1.0
 * @Modification
 * <pre>
 *2024.01.04 / 김예원 / 최초생성
 * </pre>
 * @see
 */
@Repository("adrCIPDAO")
public class AdrCIPDAO extends EgovAbstractMapper {
	
	/**
	 * 검색된 목록을 조회한다.
	 * @param adrCIPVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public List<?> selectAdrCIPList(AdrCIPVO adrCIPVO) {
		return selectList("AdrCIPDAO.selectAdrCIPList", adrCIPVO);
	}

	/**
	 * 검색된 목록의 총 건 수를 조회한다.
	 * @param adrCIPVO - 조회할 정보가 담긴 VO
	 * @return 목록 건 수
	 */
	public int selectAdrCIPListCnt(AdrCIPVO adrCIPVO) {
		return (Integer)selectOne("AdrCIPDAO.selectAdrCIPListCnt", adrCIPVO);
	}
	
	/**
	 * 정보를 조회한다.
	 * @param adrCIPVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public AdrCIPVO selectAdrCIPDetail(AdrCIPVO adrCIPVO) {
		return selectOne("AdrCIPDAO.selectAdrCIPDetail", adrCIPVO);
	}
	
	/**
	 * 정보를 등록한다.
	 * @param adrCIPVO - 등록할 정보가 담긴 VO
	 * @return void
	 */
	public void registAdrCIPAct(AdrCIPVO adrCIPVO) {
		insert("AdrCIPDAO.registAdrCIPAct", adrCIPVO);
	}

	/**
	 * 정보를 수정한다.
	 * @param adrCIPVO - 수정할 정보가 담긴 VO
	 * @return void
	 */
	public void updateAdrCIPAct(AdrCIPVO adrCIPVO) {
		update("AdrCIPDAO.updateAdrCIPAct", adrCIPVO);
	}

	/**
	 * 정보를 삭제한다.
	 * @param adrCIPVO - 삭제할 정보가 담긴 VO
	 * @return void
	 */
	public void deleteAdrCIPAct(AdrCIPVO adrCIPVO) {
		update("AdrCIPDAO.deleteAdrCIPAct", adrCIPVO);
	}
}
