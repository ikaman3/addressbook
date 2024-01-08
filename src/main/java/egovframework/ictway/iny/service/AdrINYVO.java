package egovframework.ictway.iny.service;

import java.io.Serializable;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
* 주소정보 정보 처리를 위한 VO 클래스
* @author ICTWAY
* @since 2024.01.04
* @version 1.0
* @Modification
* <pre>
*2024.01.04 / 윤현종 / 최초생성
* </pre>
* @see
*/
@NoArgsConstructor
@Getter @Setter
public class AdrINYVO extends ComDefaultVO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/** 주소록일련번호 */
	private long adbkSn;

	/** 사용자명칭 */
	private String userNm;

	/** 생년월일 */
	private String brthdy;

	/** 성별코드 */
	private String sexdstnCode;

	/** 주소 */
	private String adres;

	/** 상세주소 */
	private String detailAdres;

	/** 휴대폰번호 */
	private String moblphonNo;

	/** 이메일주소 */
	private String emailaddr;

	/** 메모 */
	private String memo;

	/** 그룹명칭 */
	private String groupNm;

	/** 회사명칭 */
	private String cmpnyNm;

	/** 부서명칭 */
	private String deptNm;

	/** 직급명칭 */
	private String clsfNm;

	/** 즐겨찾기여부 */
	private String bkmkAt;

	/** 사진명칭 */
	private String photoNm;

	/** 사진경로 */
	private String photoCours;

	/** 사진확장자명칭 */
	private String photoExtsnNm;

	/** 등록일시 */
	private String registDt;

	/** 수정일시 */
	private String updtDt;

	/** 등록사용자명칭 */
	private String registUserNm;
	
	/** 등록사용자아이디 */
	private String registUserId;

	/** 삭제여부 */
	private String deleteAt;

}