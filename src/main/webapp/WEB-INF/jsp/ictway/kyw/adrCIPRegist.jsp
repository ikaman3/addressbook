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
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
	function selectAdrCIPList(){
		document.searchListForm.action = "<c:url value='/ictway/kyw/selectAdrCIPList.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 등록
	function registAdrCIPAct() {
		
		//TODO Validation 추가
		const formElement = document.registForm;
		let validFailAt = "N"; //유효성 검사 실패 여부
		let validMsg = "";
		let firstAt = "Y";
		let focusObject;
		
		formElement.querySelectorAll(".required").forEach(v=>{
			if(!!!v.value){
				if("Y" === firstAt){
					focusObject = v;
					firstAt = "N";
				}
				validMsg += v.title + "은(는) 필수 입력 값입니다. \n";
				validFailAt = "Y";
			}
		});
		
		if("Y" === validFailAt){
			alert(validMsg);
			focusObject.focus();
			return;
		}
		
    	if (confirm('<spring:message code="common.regist.msg" />')) {
    		const formElement = document.registForm;
        	const formData = new FormData(formElement);
        	
        	fetch("<c:url value='/ictway/kyw/registAdrCIPAct.do'/>",{
    			method: "POST",
    			cache: "no-cache",
     			headers: {},
     			body: formData
        	})
        	.then(response => response.json())
        	.then(data => {
        		alert("<spring:message code="success.common.insert"/>");
        		location.href = "<c:url value='/ictway/kyw/selectAdrCIPList.do'/>";
        	})
        	.catch(error => {
    			console.log(error);
    			alert("에러가 발생하였습니다.");
    		});
    	}
    }
	
	//숫자만 입력
	function oninputPhone(target) {
	    target.value = target.value
        .replace(/[^0-9]/g, '')
        .replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{4,5})([0-9]{4})/g, "$1-$2-$3");
	}
	
	//주소록 등록 - 체크박스 1개만 선택
	function clickCheck(target) {
		document.querySelectorAll('input[type=checkbox]')
			.forEach(el => el.checked = false);
		target.checked = true;
	}
	
	//이메일 검증 스크립트
	function verifyEmail(){
		var emailVal = $("#emailaddr").val();
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if (emailVal.match(regExp) == null){
			alert("올바른 이메일 형식을 입력해주세요.");
		}
	}
	
	//카카오 주소 API
    function sample4_execDaumPostcode() {

        new daum.Postcode({
            oncomplete: function(data) {
            	
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
               // document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
               /*  // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                } */

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
	
	
    
</script>

<title>샘플 포털 > 주소록 > 김예원</title>

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
										<li><a href="<c:url value="/ictway/kyw/selectAdrCIPList.do"/>">김예원</a></li>
										<li><a href="<c:url value="/ictway/kyw/selectAdrCIPList.do"/>">주소록 목록</a></li>
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
									<p class="txt_1">주머니 속 연락처</p>
									<h2 class="tit_2">주소록 등록</h2>

	                                <div class="board_view2">
	                                    <table>
	                                        <colgroup>
	                                            <col style="width: 150px;">
	                                            <col style="width: 335px;">
	                                            <col style="width: 150px;">
	                                            <col style="width: auto;">
	                                        </colgroup>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="nm">이름</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="nm" name="nm" title="이름" type="text" size="20" value="" maxlength="20" class="f_txt w_full required">
	                                                <br/><form:errors path="nm" />
	                                            </td>	                                            
	                                        	<td class="lb">	                                        		
	                                                <label for="sexdstnCode">성별</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                        	<td>
	                                        		<select name="sexdstnCode" id="sexdstnCode" title="성별" class="required" style="width: 100px; height: 45px; font-size: 15px; text-align: center">
	                                        			<option value="">▼ 선택</option>
	                                        			<option value="SE001">남자</option>
	                                        			<option value="SE002">여자</option>
	                                        			<option value="SE003">없음</option>
	                                        		</select>
	                                        		<br/><form:errors path="sexdstnCode" />
	                                            </td>	                                            
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="telno">전화번호</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="telno" name="telno" type="text" title="전화번호" oninput="oninputPhone(this);" size="20" value="" maxlength="11" placeholder="-제외 11자리 입력  ex.01012345678" class="f_txt w_full required">
	                                                <br/><form:errors path="telno" />
	                                            </td>
	                                            <td class="lb">
	                                                <label for="bkmkAt">즐겨찾기</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                            	<label>
	                                            		<input id="bkmkAt" name="bkmkAt" type="radio" value="Y">&nbsp;&nbsp;O&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                                            	</label>
	                                            	<label>
	                                            		<input id="bkmkAt" name="bkmkAt" type="radio" value="N" checked="checked">&nbsp;&nbsp;X&nbsp;&nbsp;
	                                            	</label>
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                        	<td class="lb">
	                                                <label for="brthdy">생년월일</label>	                                                
	                                            </td>
	                                            <td>
	                                                <input id="brthdy" name="brthdy" type="date" size="8" value="" maxlength="8" class="f_txt w_full">
	                                            </td>
	                                         	<td class="lb">
	                                                <label for="emailaddr">이메일 주소</label>
	                                            </td>
	                                            <td>
	                                                <input id="emailaddr" name="emailaddr" type="text" onchange="verifyEmail(this)" title="이메일 주소" size="50" value="" maxlength="500" class="f_txt w_full">
	                                            	<br/><form:errors path="emailaddr" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="adres">주소</label>	                                                
	                                            </td>
	                                            <td colspan="3">
	                                            	<input type="text" id="sample4_postcode" placeholder="우편번호" class="f_txt w_400 read only">
	                                            	<input type="button" class="f_txt w_150" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
	                                            	<input type="text" id="sample4_roadAddress" name="adres" placeholder="도로명주소" class="f_txt w_full read only">
	                                            	<span id="guide" style="color:#999;display:none"></span>
	                                            	<input type="text" id="sample4_detailAddress" name="detailAdres" placeholder="상세주소" class="f_txt w_full">
	                                            	<form:errors path="adres" />
													<form:errors path="detailAdres" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                        	<td class="lb">	                                        		
	                                                <label for="groupCode">그룹</label>	
	                                            </td>
	                                        	<td>
	                                        		<select name="groupCode" id="groupCode" style="width: 100px; height: 45px; font-size: 15px; text-align: center">
	                                        			<option value="">▼ 선택</option>
	                                        			<option value="GR001">가족</option>
	                                        			<option value="GR002">친구</option>
	                                        			<option value="GR003">현직장</option>
	                                        			<option value="GR004">구직장</option>
	                                        			<option value="GR005">동호회</option>
	                                        		</select>
	                                            </td>
	                                            <td class="lb">
	                                                <label for="cmpnyPsitnNm">회사명</label>	                                                
	                                            </td>
	                                            <td>
	                                                <input id="cmpnyPsitnNm" name="cmpnyPsitnNm" type="text" size="50" value="" maxlength="50" class="f_txt w_full">
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyPsitnTeamNm">회사 팀명</label>	                                                
	                                            </td>
	                                            <td>
	                                                <input id="cmpnyPsitnTeamNm" name="cmpnyPsitnTeamNm" type="text" size="100" value="" maxlength="100" class="f_txt w_full">
	                                            </td>
	                                            <td class="lb">
	                                                <label for="cmpnyPsitnClsfNm">직급</label>	                                                
	                                            </td>
	                                            <td>
	                                                <input id="cmpnyPsitnClsfNm" name="cmpnyPsitnClsfNm" type="text" size="50" value="" maxlength="50" class="f_txt w_full">
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="memo">메모</label>
	                                            </td>
	                                            <td colspan="3">
	                                                <textarea id="memo" name="memo" class="textarea f_txtar w_full h_35" cols="20" rows="10"></textarea>
	                                            </td>
	                                        </tr>
	                                    </table>
	                                </div>

	                                <div class="board_view_bot">
	                                    <div class="left_col btn3">
	                                    </div>
	
	                                    <div class="right_col btn1">
	                                        <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="registAdrCIPAct();"><spring:message code="button.save" /></a>
	                                        <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="selectAdrCIPList();"><spring:message code="button.list" /></a>
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