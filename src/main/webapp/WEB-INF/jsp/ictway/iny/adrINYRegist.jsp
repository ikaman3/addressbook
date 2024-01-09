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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
    
	//주소록 목록조회
	function selectAdrINYList(){
		document.searchListForm.action = "<c:url value='/ictway/iny/selectAdrINYList.do'/>";
		document.searchListForm.submit();
	}
	
	//생년월일 숫자인지 유효성 검사
	function isNumeric(str) {
		
		const strVal = str.value;
		const regExp = /^[0-9]*$/;
		if(strVal.length > 8 || !regExp.test(strVal)) {  
			alert("양식에 맞게 다시 입력해주세요. (ex)20240109");
			return false;
		}
		return true;
	}
	
	//휴대폰번호 유효성 검사
	function isPhoneNumeric(str) {
		
		const strVal = str.value;
		const regExp = /^[0-9]*$/;
		if(strVal.length > 11 || !regExp.test(strVal)) {  
			alert("양식에 맞게 다시 입력해주세요. (ex)01012345678");
			return false;
		}
		return true;
	}
	
	//주소록 등록
	function registAdrINYAct() {
		
    	if (confirm('<spring:message code="common.regist.msg" />')) {
    		const formElement = document.registForm;
        	const formData = new FormData(formElement);
        	
        	fetch("<c:url value='/ictway/iny/registAdrINYAct.do'/>",{
    			method: "POST",
    			cache: "no-cache",
     			headers: {},
     			body: formData
        	})
        	.then(response => response.json())
        	.then(data => {
        		alert("<spring:message code="success.common.insert"/>");
        		location.href = "<c:url value='/ictway/iny/selectAdrINYList.do'/>";
        	})
        	.catch(error => {
    			console.log(error);
    			alert("에러가 발생하였습니다.");
    		});
    	}
    }
	
	function sample_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	debugger;
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수

	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }

	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                //document.getElementById("sample_extraAddress").value = extraAddr;
	            
	            } else {
	                //document.getElementById("sample_extraAddress").value = '';
	            }

	            adres = addr + extraAddr;
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('sample_postcode').value = data.zonecode;
	            document.getElementById("adres").value = addr;
	            document.getElementById("adres").value = addr + extraAddr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("detailAdres").focus();
	        }
	    }).open();
	}
    
	var maxFileNum = document.frm.posblAtchFileNumber.value;
	if(maxFileNum==null || maxFileNum==""){
		maxFileNum = 3;
	}     
	var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
</script>

<title>샘플 포털 > 주소록 > 윤현종</title>

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
										<li><a href="<c:url value="/ictway/iny/selectAdrINYList.do"/>">윤현종</a></li>
										<li><a href="<c:url value="/ictway/iny/selectAdrINYList.do"/>">주소록 목록</a></li>
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
									<p class="txt_1">INY 주소록 등록 입니다.</p>
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
	                                                <input id="userNm" name="userNm" type="text" size="60" value=""  maxlength="60" class="f_txt w_full required" title="제목">
	                                                <br/><form:errors path="userNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="brthdy">생년월일</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="brthdy" name="brthdy" type="text" size="60" value=""  maxlength="60" class="f_txt w_full required" title="생년월일" 
	                                                 placeholder="ex)20240109" oninput="isNumeric(this);">
	                                                <br/><form:errors path="brthdy" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="sexdstnCode">성별</label>
	                                                <span class="req">필수</span>
	                                            </td>
                                                <td>
	                                                <select id="sexdstnCode" title="성별" name="sexdstnCode" class="f_txt w_full required">
	                                                	<option hidden="" disabled="disabled" value="" selected>선택하세요</option>
	                                                	<option value="SEX001">남자</option>
	                                                	<option value="SEX002">여자</option>
	                                                </select>
	                                                <form:errors path="sexdstnCode" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="adres">주소</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                              	<input type="text" id="sample_postcode" placeholder="우편번호">
												    <input type="button" onclick="sample_execDaumPostcode()" value="우편번호 찾기"><br>
												    <input type="text" id="adres" name="adres" placeholder="주소" class="required" title="주소" size="40">
		
												    <input type="text" id="detailAdres" name="detailAdres" placeholder="상세주소" size="30">
	                                                <form:errors path="adres" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="moblphonNo">휴대폰번호</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="moblphonNo" name="moblphonNo" type="text" size="60" value=""  maxlength="60" class="f_txt w_full required" title="휴대폰번호" 
	                                                 placeholder="ex)01012345678" oninput="isPhoneNumeric(this)">
	                                                <br/><form:errors path="moblphonNo" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="emailaddr">이메일주소</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="emailaddr" name="emailaddr" type="text" size="60" value=""  maxlength="60" class="f_txt w_full required" title="이메일주소">
	                                                <br/><form:errors path="emailaddr" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="memo">메모</label>
	                                            </td>
	                                            <td>
	                                                <textarea id="memo" name="memo" class="textarea f_txtar w_full h_200" cols="30" rows="10" ></textarea>
	                                                <form:errors path="memo" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="groupNm">그룹명칭</label>
	                                            </td>
	                                            <td>
	                                                <input id="groupNm" name="groupNm" type="text" size="60" value=""  maxlength="60" class="f_txt w_full">
	                                                <br/><form:errors path="groupNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyNm">회사명칭</label>
	                                            </td>
	                                            <td>
	                                                <input id="cmpnyNm" name="cmpnyNm" type="text" size="60" value=""  maxlength="60" class="f_txt w_full">
	                                                <br/><form:errors path="cmpnyNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="deptNm">부서명칭</label>
	                                            </td>
	                                            <td>
	                                                <input id="deptNm" name="deptNm" type="text" size="60" value=""  maxlength="60" class="f_txt w_full">
	                                                <br/><form:errors path="deptNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="clsfNm">직급명칭</label>
	                                            </td>
	                                            <td>
	                                                <input id="clsfNm" name="clsfNm" type="text" size="60" value=""  maxlength="60" class="f_txt w_full">
	                                                <br/><form:errors path="clsfNm" />
	                                            </td>
	                                        </tr>
	                                    </table>
	                                </div>

	                                <div class="board_view_bot">
	                                    <div class="left_col btn3">
	                                    </div>
	
	                                    <div class="right_col btn1">
	                                        <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="registAdrINYAct();"><spring:message code="button.save" /></a>
	                                        <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="selectAdrINYList();"><spring:message code="button.list" /></a>
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