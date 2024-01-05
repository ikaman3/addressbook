package egovframework.ictway.phh.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.ictway.phh.service.AdrPHHVO;

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
@Repository("adrPhhDAO")
public class AdrPHHDAO extends EgovAbstractMapper {
	
	/**
	 * 검색된 목록을 조회한다.
	 * @param adrVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public List<?> selectAdrPHHList(AdrPHHVO adrVO) {
		return selectList("AdrPHHDAO.selectAdrPHHList", adrVO);
	}

	/**
	 * 검색된 목록의 총 건 수를 조회한다.
	 * @param adrVO - 조회할 정보가 담긴 VO
	 * @return 목록 건 수
	 */
	public int selectAdrPHHListCnt(AdrPHHVO adrVO) {
		return (Integer)selectOne("AdrPHHDAO.selectAdrPHHListCnt", adrVO);
	}
	
	/**
	 * 정보를 조회한다.
	 * @param adrVO - 조회할 정보가 담긴 VO
	 * @return 목록
	 */
	public AdrPHHVO selectAdrPHHDetail(AdrPHHVO adrVO) {
		return selectOne("AdrPHHDAO.selectAdrPHHDetail", adrVO);
	}
	
	/**
	 * 정보를 등록한다.
	 * @param adrVO - 등록할 정보가 담긴 VO
	 * @return void
	 */
	public void insertAdrPHHAct(AdrPHHVO adrVO) {
		insert("AdrPHHDAO.insertAdrPHHAct", adrVO);
	}

	/**
	 * 정보를 수정한다.
	 * @param adrVO - 수정할 정보가 담긴 VO
	 * @return void
	 */
	public void updateAdrPHHAct(AdrPHHVO adrVO) {
		update("AdrPHHDAO.updateAdrPHHAct", adrVO);
	}

	/**
	 * 정보를 삭제한다.
	 * @param adrVO - 삭제할 정보가 담긴 VO
	 * @return void
	 */
	public void deleteAdrPHHAct(AdrPHHVO adrVO) {
		update("AdrPHHDAO.deleteAdrPHHAct", adrVO);
	}
}
