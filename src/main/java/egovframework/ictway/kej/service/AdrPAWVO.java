package egovframework.ictway.kej.service;
import java.io.Serializable;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
* 주소정보 관리 정보 처리를 위한 VO 클래스
* @author ICTWAY
* @since 2024.01.05
* @version 1.0
* @Modification
* <pre>
*2024.01.05 / 김은지 / 최초생성
* </pre>
* @see
*/
@NoArgsConstructor
@Getter @Setter
public class AdrPAWVO  extends ComDefaultVO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/** 주소록아이디 */
	private String adbkId;

	/** 이름 */
	private String nm;

	/** 생년월일 */
	private String brthdy;

	/** 성별코드 */
	private String sexdstnCode;

	/** 주소 */
	private String adres;

	/** 상세주소 */
	private String detailAdres;

	/** 전화번호 */
	private String telno;

	/** 이메일주소 */
	private String emailaddr;

	/** 메모 */
	private String memo;

	/** 사진파일경로 */
	private String photoFlpth;

	/** 사진명 */
	private String photoNm;

	/** 사진확장자명 */
	private String photoExtsnNm;

	/** 그룹코드 */
	private String groupCode;

	/** 회사소속명 */
	private String cmpnyPsitnNm;

	/** 회사소속팀명 */
	private String cmpnyPsitnTeamNm;

	/** 회사소속직급명 */
	private String cmpnyPsitnClsfNm;

	/** 즐겨찾기여부 */
	private String bkmkAt;

	/** 주소록최초작성일시 */
	private String adbkFrstWritngDt;

	/** 주소록최초작성자아이디 */
	private String adbkFrstWrterId;

	/** 주소록최초작성자명 */
	private String adbkFrstWrterNm;

	/** 주소록최종수정일시 */
	private String adbkLastUpdtDt;

	/** 주소록최종수정자아이디 */
	private String adbkLastUpdusrId;

	/** 주소록최종수정자명 */
	private String adbkLastUpdusrNm;

	/** 주소록삭제여부 */
	private String adbkDeleteAt;

	/** 주소록삭제일시 */
	private String adbkDeleteDt;

	/** 주소록삭제자아이디 */
	private String adbkDltrId;

	/** 주소록삭제자명 */
	private String adbkDltrNm;

}