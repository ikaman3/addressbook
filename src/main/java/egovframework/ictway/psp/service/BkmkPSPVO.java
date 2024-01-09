package egovframework.ictway.psp.service;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
* 즐겨찾기를 위한 VO 클래스
* @author ICTWAY
* @since 2024.01.09
* @version 1.0
* @Modification
* <pre>
*2024.01.09 / 현승민 / 최초생성
* </pre>
* @see
*/
@NoArgsConstructor
@Getter @Setter
public class BkmkPSPVO {

	private Integer bkmkSn;
	
	private long adbkSn;
	
	private String usrId;
	
}
