package egovframework.ictway.yhj.utils;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;

import egovframework.com.cmm.LoginVO;
import egovframework.ictway.yhj.service.AdrGMAVO;

public class AuthGMA {
	
	public static Boolean isSameUserAsAdrGMAWrter(AdrGMAVO resultVO, LoginVO user) {
		String adbkWrterId = resultVO.getAdbkWrterId();
		String userUniqId = user.getUniqId();
		Boolean isAdmin = EgovUserDetailsHelper.getAuthorities().contains("ROLE_ADMIN");
		
		return adbkWrterId.equals(userUniqId) || isAdmin;
	}

}
