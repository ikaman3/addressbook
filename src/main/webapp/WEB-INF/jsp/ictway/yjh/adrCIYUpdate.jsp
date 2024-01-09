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
	//유효성 검사
	function validateForm(formElement) {
		// 필드명을 객체로 관리
		const fields = {
		    userNm: formElement.querySelector("#userNm").value,
		    brthdy: formElement.querySelector("#brthdy").value,
		    sexdstnCode: formElement.querySelector('input[name="sexdstnCode"]:checked') ? 
		    		formElement.querySelector('input[name="sexdstnCode"]:checked').value : "",
		    mbtlnum: formElement.querySelector("#mbtlnum").value,
		    emailaddr: formElement.querySelector("#emailaddr").value
		};
		
		let validMsg = "";
		let isValid = true;
		// 필드값을 담은 객체를 이용하여 반복문으로 접근
		for (const fieldName in fields) {
		    const fieldValue = fields[fieldName];
			switch(fieldName) {
				case "userNm":
					if (fieldValue === "") {
						validMsg = "이름을 입력하세요";
						isValid = false;
					}
					break;
				case "brthdy":
					const brthdyPattern = /^[0-9]{8}$/;
					if (!brthdyPattern.test(fieldValue)) {
						validMsg = "생년월일은 8자리의 숫자여야 합니다 (예: 19990213)";
				        isValid = false;
				    }
					break;
				case "sexdstnCode":
					if (fieldValue === "") {
						validMsg = "성별을 선택해주세요";
						isValid = false;
					}
					break;
				case "mbtlnum":
				    const mbtlnumPattern = /^[0-9]{11}$/;
				    if (!mbtlnumPattern.test(fieldValue)) {
				        validMsg = "휴대폰 번호는 11자리의 숫자여야 합니다 (예: 01012345678)";
				        isValid = false;
				    }
					break;
				case "emailaddr":
				    const emailPattern = /^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+\.?[a-zA-Z]*$/;
				    if (!emailPattern.test(fieldValue)) {
				        validMsg = "올바른 이메일 주소를 입력하세요 (예: yes@myemail.com)";
				        isValid = false;
				    }
					break;
				default:
					break;
				}
			
				if (!isValid) {
					alert(validMsg);
			        return false;
			    }
		}
		
	    // 모든 조건을 통과하면 제출
	    return true;
	}
	
	//주소록 목록조회
	function selectAdrCIYList(){
		document.searchListForm.action = "<c:url value='/ictway/yjh/selectAdrCIYList.do'/>";
		document.searchListForm.submit();
	}
	
	//수정 취소
	function goToBack(){
		if (confirm('<spring:message code="common.reset.msg" />')) {
			history.back();
		}
	}
	
	//주소록 수정
	function updateAdrCIYAct(){
   		const formElement = document.updateForm;
	    if (!validateForm(formElement)) {
	        throw new Error('유효성 검사에 실패했습니다.');
	    }
	    
		if (confirm('<spring:message code="common.update.msg" />')) {
        	const formData = new FormData(formElement);
        	
        	fetch("<c:url value='/ictway/yjh/updateAdrCIYAct.do'/>",{
    			method: "POST",
    			cache: "no-cache",
     			headers: {},
     			body: formData
        	})
        	.then(response => response.json())
        	.then(data => {
        		alert("<spring:message code="success.common.update"/>");
        		document.searchListForm.action = "<c:url value='/ictway/yjh/selectAdrCIYDetail.do'/>";
        		document.searchListForm.submit();
        	})
        	.catch(error => {
    			console.log(error);
    			alert("에러가 발생하였습니다.");
    		});
    	}
	}
	
	function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
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
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }
				
                adres = addr + extraAddr;
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("adres").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAdres").focus();
            }
        }).open();
    }
</script>

<title>샘플 포털 > 주소록 > 윤준현</title>

<style type="text/css">
	.ui-datepicker-trigger {
		margin-left: 10px;
		vertical-align: middle;
	}
	
 	.board_view2 table {
		display: flex;
	    flex-direction: column;
	    height: auto;
	}
	
	.board_view2 table tr {
		height: 85px;
	}	
	
	.board_view2 table tr td.lb {
	    width: 15%;
	}
	
	.board_view2 table tr td:not(.lb) {
	    width: 85%;
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
										<li><a href="<c:url value="/ictway/yjh/selectAdrCIYList.do"/>">윤준현</a></li>
										<li><a href="<c:url value="/ictway/yjh/selectAdrCIYList.do"/>">주소록 목록</a></li>
										<li><a href="javascript:void(0);">주소록 수정</a></li>
									</ul>
                                </div>
                                <!--// Location -->

								<!-- 검색 form 시작 -->
								<form:form modelAttribute="searchVO" name="searchListForm" method="post">
									<form:hidden path="pageIndex"/>
									<form:hidden path="searchCondition"/>
									<form:hidden path="searchKeyword"/>
									
									<form:hidden path="adbkId"/>
								</form:form>
								<!-- 검색 form 끝 -->
								
								<form:form modelAttribute="resultVO" name="updateForm" method="post" enctype="multipart/form-data" >
									<form:hidden path="adbkId"/>
									
	                                <h1 class="tit_1">주소록</h1>
									<p class="txt_1">Contact ICTWAY</p>
									<h2 class="tit_2">주소록 수정</h2>
	
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
	                                                <input id="userNm" name="userNm" type="text" size="50" maxlength="50" class="f_txt w_full" placeholder="예)홍길동" value="${resultVO.userNm}" >
	                                                <br/><form:errors path="userNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="mbtlnum">휴대폰번호</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                            	<input id="mbtlnum" name="mbtlnum" type="tel" maxlength="11" class="f_txt w_full" placeholder="01012345678" value="${resultVO.mbtlnum}" >
	                                                <br/><form:errors path="mbtlnum" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="emailaddr">이메일</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                            	<input id="emailaddr" name="emailaddr" type="email" size="50"  maxlength="50" class="f_txt w_full" placeholder="yes@myemail.com" value="${resultVO.emailaddr}">
	                                                <br/><form:errors path="emailaddr" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="sexdstnCode">성별</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="sexdstnCode" name="sexdstnCode" type="radio" value="SX001" <c:if test="${resultVO.sexdstnCode == 'SX001'}">checked</c:if>>여성</input>
	                                                <input id="sexdstnCode" name="sexdstnCode" type="radio" value="SX002" <c:if test="${resultVO.sexdstnCode == 'SX002'}">checked</c:if>>남성</input>
	                                                <br/><form:errors path="sexdstnCode" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="brthdy">생년월일</label>
	                                            </td>
	                                            <td>
	                                                <input id="brthdy" name="brthdy" type="text" size="8" maxlength="8" class="f_txtar w_full" placeholder="예)19990213" title="yyyymmdd와 같은 8자리 숫자" value="${resultVO.brthdy}">
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="adres">주소</label>
	                                            </td>
	                                            <td>
													<div style="display: flex; align-items: center;">
													    <input type="text" id="sample6_postcode" placeholder="우편번호" class="f_txt" style="width: 70%;">
													    <div style="width: 3%;"></div><!-- 간격 조절용 div -->
													    <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" style="width: 20%;" class="item btn btn_blue_46 w_100">
													</div>
													<input type="text" id="adres" name="adres" placeholder="주소" size="50"  maxlength="50" class="f_txt w_full"  value="${resultVO.adres}" >
													<input type="text" id="detailAdres" name="detailAdres" placeholder="상세주소" size="50"  maxlength="50" class="f_txt w_full" value="${resultVO.detailAdres}">
													<input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
													<form:errors path="adres" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="adresGroupCode">그룹</label>
	                                            </td>
	                                            <td>
		                                           	<form:select action="#" path="adresGroupCode">
														<form:option value="">해당 없음</form:option>
														<form:option value="GR001">가족</form:option>
														<form:option value="GR002">친구</form:option>
														<form:option value="GR003">현 직장</form:option>
														<form:option value="GR004">구 직장</form:option>
														<form:option value="GR005">동호회</form:option>
														<form:option value="GR006">기타</form:option>
													</form:select>
	                                                <br/><form:errors path="adresGroupCode" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyNm">회사</label>
	                                            </td>
	                                            <td>
	                                                <input id="cmpnyNm" name="cmpnyNm" type="text" size="50"  maxlength="50" class="f_txt w_full" value="${resultVO.cmpnyNm}">
	                                                <br/><form:errors path="cmpnyNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyTeamNm">소속부서</label>
	                                            </td>
	                                            <td>
	                                                <input id="cmpnyTeamNm" name="cmpnyTeamNm" type="text" size="50"  maxlength="50" class="f_txt w_full" value="${resultVO.cmpnyTeamNm}">
	                                                <br/><form:errors path="cmpnyTeamNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyClsfNm">직급</label>
	                                            </td>
	                                            <td>
	                                                <input id="cmpnyClsfNm" name="cmpnyClsfNm" type="text" size="50"  maxlength="50" class="f_txt w_full" value="${resultVO.cmpnyClsfNm}">
	                                                <br/><form:errors path="cmpnyClsfNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="bkmkAt">즐겨찾기</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
                                	                <input id="bkmkAt" name="bkmkAt" type="radio" value="Y" <c:if test="${resultVO.bkmkAt == 'Y'}">checked</c:if>>등록</input>
	                                                <input id="bkmkAt" name="bkmkAt" type="radio" value="N" <c:if test="${resultVO.bkmkAt == 'N'}">checked</c:if>>미등록</input>
	                                                <br/><form:errors path="bkmkAt" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="memo">메모</label>
	                                            </td>
	                                            <td>
	                                                <input id="memo" name="memo" type="text" size="50"  maxlength="50" class="f_txt w_full" value="${resultVO.memo}">
	                                                <br/><form:errors path="memo" />
	                                            </td>
	                                        </tr>
	                                    </table>
										
	                                </div>
	
									<!-- 목록/저장버튼  시작-->
	                                <div class="board_view_bot">
	                                    <div class="left_col btn3">
	                                    </div>
	
	                                    <div class="right_col btn1">
	                                       	<a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="updateAdrCIYAct();"><spring:message code='button.save' /></a><!-- 저장 -->
	                                        <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="goToBack();"><spring:message code="button.reset" /></a><!-- 취소 -->
	                                    </div>
	                                </div>
	                                <!-- 목록/저장버튼  끝-->
                                
                                </form:form>
                                
                                <!--// 게시판 -->
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