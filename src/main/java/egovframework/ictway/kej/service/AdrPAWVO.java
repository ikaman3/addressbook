package egovframework.ictway.kej.service;

import java.io.Serializable;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
* 주소정보 관리 정보 처리를 위한 VO 클래스
* @author ICTWAY
* @since 2024.01.04
* @version 1.0
* @Modification
* <pre>
*2024.01.04 / 김은지 / 최초생성
* </pre>
* @see
*/
@NoArgsConstructor
@Getter @Setter
public class AdrPAWVO extends ComDefaultVO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/** 주소록일련번호 */
	private long adbkSn;

	/** 사용자명 */
	private String userNm;

	/** 사용자생년월일 */
	private String userBrthdy;

	/** 사용자성별코드 */
	private String userSexdstnCode;

	/** 사용자주소 */
	private String userAdres;

	/** 사용자상세주소 */
	private String userDetailAdres;

	/** 사용자전화번호 */
	private String userTelno;

	/** 사용자이메일주소 */
	private String userEmailaddr;

	/** 사용자메모 */
	private String userMemo;

	/** 사용자사진파일경로 */
	private String userPhotoFlpth;

	/** 사용자사진명 */
	private String userPhotoNm;

	/** 사용자사진확장자명 */
	private String userPhotoExtsnNm;

	/** 사용자그룹코드 */
	private String userGroupCode;

	/** 사용자회사소속명 */
	private String userCmpnyPsitnNm;

	/** 사용자회사소속팀명 */
	private String userCmpnyPsitnTeamNm;

	/** 사용자회사소속직급명 */
	private String userCmpnyPsitnClsfNm;

	/** 즐겨찾기여부 */
	private String bkmkAt;

	/** 주소록생성일시 */
	private String adbkCreatDt;

	/** 주소록수정일시 */
	private String adbkUpdtDt;

	/** 주소록삭제여부 */
	private String adbkDeleteAt;

	/** 주소록작성자명 */
	private String adbkWrterNm;

}