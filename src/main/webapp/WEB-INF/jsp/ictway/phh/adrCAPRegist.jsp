<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- 
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	<script src="<c:url value='/'/>js/jquery.js"></script>
	<script src="<c:url value='/'/>js/jqueryui.js"></script>
	<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">

<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>" ></script>
<%--
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
--%>
<script type="text/javascript">
    
	//주소록 목록조회
	function selectAdrCAPList(){
		document.searchListForm.action = "<c:url value='/ictway/phh/selectAdrCAPList.do'/>";
		document.searchListForm.submit();
	}
		
	
	//생년월일 숫자인지 유효성 검사
	function isNumeric(str) {
		
		const strVal = str.value;
		const regExp = /^[0-9]*$/;
		if(!regExp.test(strVal)) {
			alert("숫자만 입력 가능합니다. 다시 입력해주세요.");
			str.value = strVal.substring(0,strVal.length-1);
			return false;
		} 
		return true;
		
	}
	 
	
	
	//주소록 등록
	function registAdrCAPAct() {
		const formElement = document.registForm;
		let validFailAt = "N"; //유효성검사실패여부
		let validMsg = "";
		let firstAt = "Y";
		let focusObject;
		
		formElement.querySelectorAll(".required").forEach(v=>{

			if(!!!v.value) {
				if("Y" === firstAt){
					focusObject = v;
					firstAt = "N";
				}
				validMsg += v.title + "은(는) 필수 입력 값입니다.\n";
				validFailAt = "Y";
			}
		});
		
		if("Y" === validFailAt){
			alert(validMsg);
			focusObject.focus();
			return;
		}
		
		
		
    	if (confirm('<spring:message code="common.regist.msg" />')) {
    		/* const formElement = document.registForm; */
        	const formData = new FormData(formElement);
        	
        	fetch("<c:url value='/ictway/phh/registAdrCAPAct.do'/>",{
    			method: "POST",
    			cache: "no-cache",
     			headers: {},
     			body: formData
        	})
        	.then(response => response.json())
        	.then(data => {
        		alert("<spring:message code="success.common.insert"/>");
        		location.href = "<c:url value='/ictway/phh/selectAdrCAPList.do'/>";
        	})
        	.catch(error => {
    			console.log(error);
    			alert("에러가 발생하였습니다.");
    		});
    	}
    }
    
</script>

<title>샘플 포털 > 주소록 > 박현희</title>

<style type="text/css">
.ui-datepicker-trigger {
	margin-left: 10px;
	vertical-align: middle;
}
</style>

</head>
<body>

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
        <!-- header start -->
	    <c:import url="/sym/mms/EgovHeader.do" />
	    <!-- //header end -->

        <div class="container">
            <div class="sub_layout">
                <div class="sub_in">
                    <div class="layout">
                        <!-- Left menu -->
	                    <c:import url="/sym/mms/EgovMenuLeft.do" />
	                    <!--// Left menu -->
        
                        <div class="content_wrap">
                            <div id="contents" class="content">
                                 <!-- Location -->
                                 <div class="location">
                                    <ul>
										<li><a class="home" href="<c:url value="/"/>">Home</a></li>
										<li><a href="javascript:void(0);">주소록</a></li>
										<li><a href="<c:url value="/ictway/phh/selectAdrCAPList.do"/>">박현희</a></li>
										<li><a href="<c:url value="/ictway/phh/selectAdrCAPList.do"/>">주소록 목록</a></li>
										<li><a href="javascript:void(0);">주소록 등록</a></li>
									</ul>
                                </div>
                                <!--// Location -->
                                
                                <!-- 검색 form 시작 -->
								<form:form modelAttribute="searchVO" name="searchListForm" method="post">
									<form:hidden path="pageIndex"/>
									<form:hidden path="searchCondition"/>
									<form:hidden path="searchKeyword"/>
								</form:form>
								<!-- 검색 form 끝 -->

								<form name="registForm" method="post" enctype="multipart/form-data" >

	                                <h1 class="tit_1">주소록</h1>
									<p class="txt_1">아이씨티웨이(주) 신입사원 대상 개발자 교육 샘플 주소록입니다.</p>
									<h2 class="tit_2">주소록 등록</h2>

	                                <div class="board_view2">
	                                    <table>
	                                        <colgroup>
	                                            <col style="width: 190px;">
	                                            <col style="width: auto;">
	                                        </colgroup>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="userNm">이름</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="userNm" name="userNm" type="text" size="60" value=""  maxlength="60" class="f_txt w_full required" title="이름">
	                                                <br/><form:errors path="userNm" />
	                                            </td>
	                                            <td class="lb">
	                                                <label for="sexdstnCode">성별</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                            	
	                                            	<select name="sexdstnCode" id="sexdstnCode" class="f_txt w_full required" title="성별">
	                                            		<option value="">선택</option>
	                                            		<option value="SX001">여성</option>
	                                            		<option value="SX002">남성</option>
	                                            		
	                                            	</select>
	                                            
	                                            </td>
	                                        </tr>
	                                        
							                <tr>
	                                            <td class="lb">
	                                                <label for="mbtlnum">휴대폰</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="mbtlnum" name="mbtlnum" type="text" size="60" value=""  maxlength="11" class="f_txt w_full required" title="휴대폰" placeholder="ex) 01012345678" oninput="isNumeric(this);">
	                                                <br/><form:errors path="mbtlnum" />
	                                            </td>
	                                            <td class="lb">
	                                                <label for="emailaddr">이메일</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="emailaddr" name="emailaddr" type="text" size="60" value=""  maxlength="60" class="f_txt w_full required" title="이메일">
	                                                <br/><form:errors path="emailaddr" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="brthdy">생년월일</label>
	                                            </td>
	                                            <td>
	                                                <input id="brthdy" name="brthdy" type="text" size="60" value=""  maxlength="8" class="f_txt w_full" placeholder="ex) 19980101" oninput="isNumeric(this);">
	                                                <br/><form:errors path="brthdy" />
	                                            </td>
	                                            <td class="lb">
	                                                <label for="adresGroupCode">그룹</label>
	                                            </td>
	                                            <td>
	                                            
	                                            	<select name="adresGroupCode" id="adresGroupCode" class="f_txt w_full">
	                                            		<option>선택</option>
	                                            		<option value="GR001">가족</option>
	                                            		<option value="GR002">친구</option>
	                                            		<option value="GR003">현직장</option>
	                                            		<option value="GR004">구직장</option>
	                                            		<option value="GR005">동호회</option>
	                                            		<option value="GR006">기타</option>
	                                            		
	                                            		
	                                            	</select>
	                              
	                                            </td>
	                                        </tr>
	                                        
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="adres">주소</label>
	                                            </td>
	                                            <td colspan="3">
	                                                <input id="adres" name="adres" type="text" size="60" value=""  maxlength="60" class="f_txt w_full">
	                                                <br/><form:errors path="adres" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="detailAdres">상세주소</label>
	                                            </td>
	                                            <td colspan="3">
	                                                <input id="detailAdres" name="detailAdres" type="text" size="60" value=""  maxlength="60" class="f_txt w_full">
	                                                <br/><form:errors path="detailAdres" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="memo">메모</label>
	                                            </td>
	                                            <td colspan = "3">
	                                                <textarea id="memo" name="memo" class="textarea f_txtar w_full h_200" cols="30" rows="10" ></textarea>
	                                                <form:errors path="memo" />
	                                            </td>
	                                        </tr>
	                                        
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyNm">회사명</label>
	                                            </td>
	                                            <td colspan="3">
	                                                <input id="cmpnyNm" name="cmpnyNm" type="text" size="60" value=""  maxlength="60" class="f_txt w_full">
	                                                <br/><form:errors path="cmpnyNm" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyTeamNm">회사소속팀명</label>
	                                            </td>
	                                            <td colspan="3">
	                                                <input id="cmpnyTeamNm" name="cmpnyTeamNm" type="text" size="60" value=""  maxlength="60" class="f_txt w_full">
	                                                <br/><form:errors path="cmpnyTeamNm" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyClsfNm">회사직급</label>
	                                            </td>
	                                            <td colspan="3">
	                                                <input id="cmpnyClsfNm" name="cmpnyClsfNm" type="text" size="60" value=""  maxlength="60" class="f_txt w_full">
	                                                <br/><form:errors path="cmpnyClsfNm" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyClsfNm">즐겨찾기 여부</label>
	                                            </td>
	                                            <td colspan="3">
	                                                <input id=bkmkAt name="bkmkAt" type="radio" size="60" value="Y">예 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	                                                <input id=bkmkAt name="bkmkAt" type="radio" size="60" value="N">아니요
	                                                <br/><form:errors path="bkmkAt" />
	                                            </td>
	                                        </tr>
   
	                                    </table>
	                                </div>

	                                <div class="board_view_bot">
	                                    <div class="left_col btn3">
	                                    </div>
	
	                                    <div class="right_col btn1">
	                                        <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="registAdrCAPAct();"><spring:message code="button.save" /></a>
	                                        <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="selectAdrCAPList();"><spring:message code="button.list" /></a>
	                                    </div>
	                                </div>
	                                
	                                <!--// 주소록 -->
                                
                                </form>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- footer 시작 -->
	    <c:import url="/sym/mms/EgovFooter.do" />
	    <!-- //footer 끝 -->
    </div>
    
</body>
</html>