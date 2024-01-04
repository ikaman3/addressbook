package egovframework.ictway.yhj.service;

import java.io.Serializable;

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
*2024.01.04 / ??? / 최초생성
* </pre>
* @see
*/
@NoArgsConstructor
@Getter @Setter
public class AddressInfoVO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/** 주소록일련번호 */
	private String adbkSn;

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

	/** 사진원본파일경로 */
	private String photoOrignlFlpth;

	/** 사진보안파일경로 */
	private String photoScrtyFlpth;

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

	/** 주소록작성자명칭 */
	private String adbkWrterNm;

	/** 주소록생성일시 */
	private String adbkCreatDt;

	/** 주소록수정일시 */
	private String adbkUpdtDt;

	/** 주소록삭제여부 */
	private String adbkDeleteAt;

}