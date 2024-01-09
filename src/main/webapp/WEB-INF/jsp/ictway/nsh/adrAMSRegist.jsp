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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%--
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
--%>
<script type="text/javascript">
    
	//주소록 목록조회
	function selectAdrAMSList(){
		document.searchListForm.action = "<c:url value='/ictway/nsh/selectAdrAMSList.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 등록
	function registAdrAMSAct() {
		const formElement = document.registForm;
		let validFailAt = "N"; // 유효성 검사 여부
		let validMsg = "";
		let firstAt = "Y";
		let focusObject;
		
		formElement.querySelectorAll(".required").forEach(v=>{
			if (!!!v.value) {
				if ("Y" === firstAt) {
					focusObject = v;
					firstAt = "N";
				}
				validMsg += v.title + "은(는) 필수 입력 값입니다.\n";
				validFailAt = "Y";
			}
		});
		
		if ("Y" === validFailAt) {
			alert(validMsg);
			focusObject.focus();
			return;
		}
		
		if (confirm('<spring:message code="common.regist.msg" />')) {
	    	const formElement = document.registForm;
	        const formData = new FormData(formElement);
	        	
	        fetch("<c:url value='/ictway/nsh/registAdrAMSAct.do'/>",{
	    		method: "POST",
	    		cache: "no-cache",
	     		headers: {},
	     		body: formData
	        })
	        .then(response => response.json())
	        .then(data => {
	        	alert("<spring:message code="success.common.insert"/>");
	        	location.href = "<c:url value='/ictway/nsh/selectAdrAMSList.do'/>";
	        })
	        .catch(error => {
	    		console.log(error);
	    		alert("에러가 발생하였습니다.");
	    	});
	    }
    }
	
	// 전화번호 입력 시 하이픈 자동 추가
	function oninputPhone(target) {
	    target.value = target.value
	        .replace(/[^0-9]/g, '')
	        .replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3");
	}
	
	// 다음 우편번호 API
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
                

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
	
	// 이메일 유효성 검사
	function validEmail(obj){
	    if(validEmailCheck(obj)==false){
	        alert('올바른 이메일 주소를 입력해주세요.')
	        obj.value='';
	        obj.focus();
	        return false;
    	}
	}

	function validEmailCheck(obj){
	    var pattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	    return (obj.value.match(pattern)!=null);
	}

</script>
    
</script>

<title>샘플 포털 > 주소록 > 남시현</title>

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
										<li><a href="<c:url value="/ictway/nsh/selectAdrAMSList.do"/>">남시현</a></li>
										<li><a href="<c:url value="/ictway/nsh/selectAdrAMSList.do"/>">주소록 목록</a></li>
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
									<p class="txt_1">AMS 주소록입니다.</p>
									<h2 class="tit_2">주소록 등록</h2>

	                                <div class="board_view2">
	                                    <table>
	                                        <colgroup>
	                                            <col style="width: 190px;">
	                                            <col style="width: auto;">
	                                        </colgroup>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="nm">이름</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="nm" title="이름" name="nm" type="text" size="60" value=""  maxlength="60" class="f_txt w_full required">
	                                                <br/><form:errors path="nm" />
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
	                                                	<option value="SEX01">남자</option>
	                                                	<option value="SEX02">여자</option>
	                                                	<option value="SEX03">공개 안 함</option>
	                                                </select>
	                                                <form:errors path="sexdstnCode" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="telno">전화번호</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="telno" title="전화번호" name="telno" type="text" oninput="oninputPhone(this)" size="60" maxlength="13" class="f_txt w_full required" placeholder="하이픈(-) 없이 입력하세요">
	                                                <form:errors path="telno" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="emailaddr">이메일주소</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                            	<input type="text" title="이메일주소" id="emailaddr" name="emailaddr" onchange="validEmail(this)" class="f_txt w_full required" placeholder="gildong@gmail.com">
													<div id="result"></div>
	                                                <form:errors path="emailaddr" />
	                                            </td>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="brthdy">생년월일</label>
	                                            </td>
	                                            <td>
	                                                <input id="brthdy" name="brthdy" type="date" size="60" value=""  maxlength="60" class="f_txt w_full">
	                                                <br/><form:errors path="brthdy" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="adres">주소</label>
	                                            </td>
	                                            <td>
	                                                <input type="text" id="sample4_postcode" name="adresNo" class="f_txt" placeholder="우편번호" style="width:45%;" readonly>
													<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" style="width:130px; height:46px; border-radius:5px; border:none; color:#fff; font-size:16px; text-align:center; line-height:46px; background:#169bd5; margin-left: 10px;"><br>
													<input type="text" id="sample4_roadAddress" name="adres" class="f_txt w_full" placeholder="도로명주소" style="margin-top: 10px; margin-bottom:10px" readonly>
													<span id="guide" style="color:#999;display:none"></span>
													<input type="text" id="sample4_detailAddress" name="detailAdres" class="f_txt w_full" placeholder="상세주소">
													<form:errors path="adres" />
													<form:errors path="detailAdres" />
	                                            </td>
	                                        </tr>
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
	                                                <label for="groupCode">그룹 지정</label>
	                                            </td>
	                                            <td>
	                                                <select id="groupCode" name="groupCode" class="f_txt w_full">
	                                                	<option hidden="" disabled="disabled" value="" selected>선택하세요</option>
	                                                	<option value="GRP01">가족</option>
	                                                	<option value="GRP02">친구</option>
	                                                	<option value="GRP03">현직장</option>
	                                                	<option value="GRP04">구직장</option>
	                                                	<option value="GRP05">동호회</option>
	                                                </select>
	                                                <form:errors path="groupCode" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyPsitnNm">회사소속명</label>
	                                            </td>
	                                            <td>
	                                                <input id="cmpnyPsitnNm" name="cmpnyPsitnNm" class="f_txt w_full"></input>
	                                                <form:errors path="cmpnyPsitnNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyPsitnTeamNm">회사소속팀명</label>
	                                            </td>
	                                            <td>
	                                                <input id="cmpnyPsitnTeamNm" name="cmpnyPsitnTeamNm" class="f_txt w_full"></input>
	                                                <form:errors path="cmpnyPsitnTeamNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyPsitnClsfNm">회사소속직급명</label>
	                                            </td>
	                                            <td>
	                                                <input id="cmpnyPsitnClsfNm" name="cmpnyPsitnClsfNm" class="f_txt w_full"></input>
	                                                <form:errors path="cmpnyPsitnClsfNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="bkmkAt">즐겨찾기</label>
	                                            </td>
	                                            <td>
	                                            	<label>
	                                            		<input type="radio" id="bkmkAt" name="bkmkAt" value="N" checked="checked">추가하지 않음</input></br>
	                                            	</label>
	                                                <label>
	                                                	<input type="radio" id="bkmkAt" name="bkmkAt" value="Y">추가</input>
	                                                </label>
	                                                <form:errors path="bkmkAt" />
	                                            </td>
	                                        </tr>
	                                    </table>
	                                </div>

	                                <div class="board_view_bot">
	                                    <div class="left_col btn3">
	                                    </div>
	
	                                    <div class="right_col btn1">
	                                        <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="registAdrAMSAct();"><spring:message code="button.save" /></a>
	                                        <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="selectAdrAMSList();"><spring:message code="button.list" /></a>
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