<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<script type="text/javascript"
	src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/js/EgovCalPopup.js'/>"></script>
<%--
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
--%>
<script type="text/javascript">
	//주소록 목록조회
	function selectAdrGMAList(){
		document.searchListForm.action = "<c:url value='/ictway/yhj/selectAdrGMAList.do'/>";
		document.searchListForm.submit();
	}
	
	//수정 취소
	function goToBack(){
		if (confirm('<spring:message code="common.reset.msg" />')) {
			history.back();
		}
	}
	
	//휴대폰번호 유효성 검사
	function isValidPhoneNumber(phoneNumber) {
        let phoneRegex = /^\d{3}-\d{4}-\d{4}$/;
        return phoneRegex.test(phoneNumber);
    }
	
	//이메일형식 유효성검사
	function isValidEmail(emailaddr) {
    	let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    	return emailRegex.test(emailaddr);
	}
	
	function validateForm() {
        let sexdstnCode = document.querySelector('input[name="sexdstnCode"]:checked');
        let mbtlnum = document.getElementById("mbtlnum").value;
        let emailaddr = document.getElementById("emailaddr").value;
        
        if ( !sexdstnCode || mbtlnum.trim() === '' || emailaddr.trim() === '') {
            alert("필수 입력값을 모두 입력해주세요.");
            return false;
        }

        if (!isValidPhoneNumber(mbtlnum)) {
            alert("휴대폰 번호 형식이 올바르지 않습니다. (000-0000-0000)");
            return false;
        }
        
        if (!isValidEmail(emailaddr)) {
            alert("이메일 형식이 올바르지 않습니다. ex) example@naver.com");
            return false;
        }

        return true;
    }
	
	//주소록 수정
	function updateAdrGMAAct(){
		
		if (!validateForm()) return;
		
		if (confirm('<spring:message code="common.update.msg" />')) {
    		const formElement = document.updateForm;
        	const formData = new FormData(formElement);
        	
        	fetch("<c:url value='/ictway/yhj/updateAdrGMAAct.do'/>",{
    			method: "POST",
    			cache: "no-cache",
     			headers: {},
     			body: formData
        	})
        	.then(response => response.json())
        	.then(data => {
        		alert("<spring:message code="success.common.update"/>");
        		document.searchListForm.action = "<c:url value='/ictway/yhj/selectAdrGMADetail.do'/>";
        		document.searchListForm.submit();
        	})
        	.catch(error => {
    			console.log(error);
    			alert("에러가 발생하였습니다.");
    		});
    	}
	}
	
</script>

<title>샘플 포털 > 주소록 > 염혜정</title>

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
										<li><a
											href="<c:url value="/ictway/yhj/selectAdrGMAList.do"/>">염혜정</a></li>
										<li><a
											href="<c:url value="/ictway/yhj/selectAdrGMAList.do"/>">주소록
												목록</a></li>
										<li><a href="javascript:void(0);">주소록 수정</a></li>
									</ul>
								</div>
								<!--// Location -->

								<!-- 검색 form 시작 -->
								<form:form modelAttribute="searchVO" name="searchListForm"
									method="post">
									<form:hidden path="pageIndex" />
									<form:hidden path="searchCondition" />
									<form:hidden path="searchKeyword" />

									<form:hidden path="adbkId" />
								</form:form>
								<!-- 검색 form 끝 -->

								<form:form modelAttribute="resultVO" name="updateForm"
									method="post" enctype="multipart/form-data">
									<form:hidden path="adbkId" />

									<h1 class="tit_1">주소록</h1>
									<p class="txt_1">주소록 - 수정 페이지</p>
									<h2 class="tit_2">주소록 수정</h2>

									<div class="board_view2">
										<table>
											<colgroup>
												<col style="width: 190px;">
												<col style="width: auto;">
											</colgroup>
											<tr>
												<td class="lb"><label for="adrSj">이름</label></td>
												<td><c:out value="${resultVO.userNm}" /></td>
											</tr>
											<tr>
												<td class="lb"><label for="brthdy">생년월일</label></td>
												<td><fmt:parseDate value="${resultVO.brthdy}"
															pattern="yyyyMMdd" var="date" />
														<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" /></td>
											</tr>
											<tr>
												<td class="lb"><label for="sexdstnCode">성별</label> <span
													class="req">필수</span></td>
												<td><c:choose>
															<c:when test="${resultVO.sexdstnCode == 'SX001'}">
																<input type="radio" name="sexdstnCode" value="SX001" checked="checked" /> 여성 
																<input type="radio" name="sexdstnCode" value="SX002" /> 남성
															</c:when>
															<c:when test="${resultVO.sexdstnCode == 'SX002'}">
																<input type="radio" name="sexdstnCode" value="SX001" /> 여성 
																<input type="radio" name="sexdstnCode" value="SX002" checked="checked" /> 남성
															</c:when>
															<c:otherwise>
																<!-- 다른 값이 올 경우에 대한 처리 -->
																<c:out value="${resultVO.sexdstnCode}" />
															</c:otherwise>
														</c:choose></td>
											</tr>
											<tr>
												<script
													src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
												<script>
												    function sample6_execDaumPostcode() {
												        new daum.Postcode({
												            oncomplete: function(data) {
												                var addr = '';
												                var extraAddr = '';
												
												                if (data.userSelectedType === 'R') { 
												                    addr = data.roadAddress;
												                } else { 
												                    addr = data.jibunAddress;
												                }
												
												                if(data.userSelectedType === 'R'){
												                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
												                        extraAddr += data.bname;
												                    }
												                    if(data.buildingName !== '' && data.apartment === 'Y'){
												                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
												                    }
												                    if(extraAddr !== ''){
												                        extraAddr = ' (' + extraAddr + ')';
												                    }
												                    document.getElementById("sample6_extraAddress").value = extraAddr;
												                
												                } else {
												                    document.getElementById("sample6_extraAddress").value = '';
												                }
												
												                document.getElementById('sample6_postcode').value = data.zonecode;
												                document.getElementById("sample6_address").value = addr;
												                document.getElementById("sample6_detailAddress").focus();
												            }
												        }).open();
												    }
												</script>
												<td class="lb"><label for="adres">주소</label></td>
												<td><input type="text" id="sample6_postcode"
													placeholder="우편번호"> <input type="button"
													onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
													<input name="adres" type="text" id="sample6_address"
													placeholder="주소" value="<c:out value="${resultVO.adres}" />"><br> <input
													name="detailAdres" type="text" id="sample6_detailAddress"
													placeholder="상세주소" value="<c:out value="${resultVO.detailAdres}" />"> <input type="text"
													id="sample6_extraAddress" placeholder="참고항목"></td>
											</tr>
											<tr>
												<td class="lb"><label for="mbtlnum">휴대폰번호</label> <span
													class="req">필수</span></td>
												<td><input id="mbtlnum" name="mbtlnum" type="tel"
													size="50" value="<c:out value="${resultVO.mbtlnum}" />" maxlength="50" class="f_txt w_full"
													placeholder="010-0000-0000 형식으로 입력해주세요."></input> <form:errors
														path="mbtlnum" /></td>
											</tr>
											<tr>
												<td class="lb"><label for="emailaddr">이메일주소</label> <span
													class="req">필수</span></td>
												<td><input id="emailaddr" name="emailaddr" type="text"
													size="50" value="<c:out value="${resultVO.emailaddr}" />" maxlength="50" class="f_txt w_full"></input>
													<form:errors path="emailaddr" /></td>
											</tr>
											<tr>
												<td class="lb"><label for="memo">메모</label></td>
												<td><input id="memo" name="memo" type="text" size="50"
													value="<c:out value="${resultVO.memo}" />" maxlength="50" class="f_txt w_full"></input></td>
											</tr>
											<tr>
												<td class="lb"><label for="photoFlpth">사진</label></td>
												<td><input id="photoFlpth" name="image" type="file"
													value="" class="f_txt w_full"></input></td>
											</tr>
											<tr>
												<td class="lb"><label for="adresGroupCode">소속그룹</label>
												</td>
												<td><select id="adresGroupCode" name="adresGroupCode"
													class="f_txt w_full">
														<option value="">선택 안 함</option>
														<option value="GR001">가족</option>
														<option value="GR002">친구</option>
														<option value="GR003">현 직장</option>
														<option value="GR004">구 직장</option>
														<option value="GR005">동호회</option>
														<option value="GR006">기타</option>
												</select></td>
											</tr>
											<tr>
												<td class="lb"><label for="cmpnyNm">회사</label></td>
												<td><input id="cmpnyNm" name="cmpnyNm" type="text"
													size="50" value="<c:out value="${resultVO.cmpnyNm}" />" maxlength="50" class="f_txt w_full"></input>
												</td>
											</tr>
										</table>
									</div>

									<!-- 목록/저장버튼  시작-->
									<div class="board_view_bot">
										<div class="left_col btn3"></div>

										<div class="right_col btn1">
											<a href="javascript:void(0);" class="btn btn_blue_46 w_100"
												onclick="updateAdrGMAAct();"><spring:message
													code='button.save' /></a>
											<!-- 저장 -->
											<a href="javascript:void(0);" class="btn btn_blue_46 w_100"
												onclick="goToBack();"><spring:message
													code="button.reset" /></a>
											<!-- 취소 -->
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