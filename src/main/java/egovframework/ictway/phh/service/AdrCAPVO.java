package egovframework.ictway.phh.service;

import java.io.Serializable;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
* 주소 정보 정보 처리를 위한 VO 클래스
* @author ICTWAY
* @since 2024.01.04
* @version 1.0
* @Modification
* <pre>
*2024.01.04 / 박현희 / 최초생성
* </pre>
* @see
*/
@NoArgsConstructor
@Getter @Setter
public class AdrCAPVO extends ComDefaultVO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/** 주소록번호 */
	private String adbkId;

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
	private String mbtlnum;

	/** 이메일주소 */
	private String emailaddr;

	/** 메모 */
	private String memo;

	/** 사진파일경로 */
	private String photoFlpth;

	/** 사진파일명칭 */
	private String photoFileNm;

	/** 사진확장자명칭 */
	private String photoExtsnNm;

	/** 주소록그룹코드 */
	private String adresGroupCode;

	/** 회사명칭 */
	private String cmpnyNm;

	/** 회사팀명칭 */
	private String cmpnyTeamNm;

	/** 회사직급명칭 */
	private String cmpnyClsfNm;

	/** 즐겨찾기여부 */
	private String bkmkAt;

	/** 주소록생성일시 */
	private String adbkCreatDt;

	/** 주소록작성자번호 */
	private String adbkWrterId;

	/** 주소록수정일시 */
	private String adbkUpdtDt;

	/** 주소록수정자번호 */
	private String adbkUpdusrId;

	/** 주소록삭제자번호 */
	private String adbkDltrId;

	/** 주소록삭제일시 */
	private String adbkDeleteDt;

	/** 주소록삭제여부 */
	private String adbkDeleteAt;

}