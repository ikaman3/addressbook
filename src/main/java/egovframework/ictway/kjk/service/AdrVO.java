package egovframework.ictway.kjk.service;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
* 주소록 정보 처리를 위한 VO 클래스
* @author ICTWAY
* @since 2023.12.29
* @version 1.0
* @Modification
* <pre>
*2023.12.29 / 김진광 / 최초생성
* </pre>
* @see
*/
@NoArgsConstructor
@Getter @Setter
public class AdrVO extends ComDefaultVO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/** 주소록아이디 */
	private String adrId;

	/** 주소록제목 */
	@NotNull(message = "주소록제목은 필수 입력값입니다.")
	@Size(max=50, message="{max}자 이하로 입력해야 합니다.")
	private String adrSj;

	/** 주소록내용 */
	@NotNull(message = "주소록내용은 필수 입력값입니다.")
	@Size(max=500, message="{max}자 이하로 입력해야 합니다.")
	private String adrCn;

	/** 사용여부 */
	private String useAt;

	/** 첨부파일아이디 */
	private String atchFileId;

	/** 최초등록일시 */
	private String frstRegistPnttm;

	/** 최초등록아이디 */
	private String frstRegisterId;

	/** 최종수정일시 */
	private String lastUpdtPnttm;

	/** 최종수정아이디 */
	private String lastUpdusrId;
	
	/** 최초등록자명 */
	private String frstRegisterNm;
	
	/** 최종수정자명 */
	private String lastUpdusrNm;

}