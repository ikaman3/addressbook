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
	function selectAdrITAList(){
		document.searchListForm.action = "<c:url value='/ictway/yja/selectAdrITAList.do'/>";
		document.searchListForm.submit();
	}
	
	//수정 취소
	function goToBack(){
		if (confirm('<spring:message code="common.reset.msg" />')) {
			history.back();
		}
	}
	
	// 전화번호 입력 시 하이픈
	function addHyphenPhone(target) {
	    target.value = target.value
	        .replace(/[^0-9]/g, '')
	        .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
	}
	
	// 날짜 입력 시 하이픈
	function addHyphenBrth(target) {
	    target.value = target.value
	        .replace(/[^0-9]/g, '')
	        .replace(/^(\d{4})(\d{2})(\d{2})$/, `$1-$2-$3`);
	}
	
	//주소록 수정
	function updateAdrITAAct(){
		
		const formElement = document.updateForm;
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
		
		if (confirm('<spring:message code="common.update.msg" />')) {
        	const formData = new FormData(formElement);
        	
        	fetch("<c:url value='/ictway/yja/updateAdrITAAct.do'/>",{
    			method: "POST",
    			cache: "no-cache",
     			headers: {},
     			body: formData
        	})
        	.then(response => response.json())
        	.then(data => {
        		alert("<spring:message code="success.common.update"/>");
        		document.searchListForm.action = "<c:url value='/ictway/yja/selectAdrITADetail.do'/>";
        		document.searchListForm.submit();
        	})
        	.catch(error => {
    			console.log(error);
    			alert("에러가 발생하였습니다.");
    		});
    	}
	}
	
</script>

<title>샘플 포털 > 주소록 > 유지애</title>

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
										<li><a href="<c:url value="/ictway/yja/selectAdrITAList.do"/>">유지애</a></li>
										<li><a href="<c:url value="/ictway/yja/selectAdrITAList.do"/>">주소록 목록</a></li>
										<li><a href="javascript:void(0);">주소록 수정</a></li>
									</ul>
                                </div>
                                <!--// Location -->

								<!-- 검색 form 시작 -->
								<form:form modelAttribute="searchVO" name="searchListForm" method="post">
									<form:hidden path="pageIndex"/>
									<form:hidden path="searchCondition"/>
									<form:hidden path="searchKeyword"/>
									<form:hidden path="adbkSn"/>
								</form:form>
								<!-- 검색 form 끝 -->
								
								<form:form modelAttribute="resultVO" name="updateForm" method="post" enctype="multipart/form-data" >
									<form:hidden path="adbkSn"/>
									
	                                <h1 class="tit_1">알려주소</h1>
									<p class="txt_1">주소록 수정 화면</p>
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
	                                            	<form:input path="userNm" class="f_txt w_full required" size="60" maxlength="10" title="수정할 이름"/>
	                                                <br/><form:errors path="userNm" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="sexdstnCode">성별</label>
													<span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                            	<select name="sexdstnCode" class="f_txt w_full required" title="수정할 성별">
	                                            		<option value="남성" <c:if test="${resultVO.sexdstnCode eq '남성' }">selected</c:if> >남성</option>
	                                            		<option value="여성" <c:if test="${resultVO.sexdstnCode eq '여성' }">selected</c:if> >여성</option>
<%-- 	                                            		<option value="여성" <c:out value="${resultVO.sexdstnCode eq '여성' ? 'selected' : '' }"/> >여성</option> --%>
	                                            	</select>
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="moblphonNo">휴대폰번호</label>
													<span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                            	<form:input path="moblphonNo" class="f_txt w_full required" oninput="addHyphenPhone(this)" size="60" maxlength="13" title="수정할 휴대폰번호"/>
	                                                <br/><form:errors path="moblphonNo" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="emailaddr">이메일주소</label>
													<span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                            	<form:input path="emailaddr" class="f_txt w_full required" size="60" maxlength="60" title="수정할 이메일주소"/>
	                                                <br/><form:errors path="emailaddr" />
	                                            </td>
	                                        </tr>
	                                        
	                                         <tr>
	                                            <td class="lb">
	                                                <label for="groupNm">그룹</label>                                              
	                                            </td>
	                                            <td>
	                                                <select name="groupNm" class="f_txt w_full">
	                                            		<option value="가족" <c:if test="${resultVO.groupNm eq '가족' }">selected</c:if>>가족</option>
	                                            		<option value="친구" <c:if test="${resultVO.groupNm eq '친구' }">selected</c:if>>친구</option>
	                                            		<option value="현직장" <c:if test="${resultVO.groupNm eq '현직장' }">selected</c:if>>현직장</option>
	                                            		<option value="구직장" <c:if test="${resultVO.groupNm eq '구직장' }">selected</c:if>>구직장</option>
	                                            		<option value="동호회" <c:if test="${resultVO.groupNm eq '동호회' }">selected</c:if>>동호회</option>
	                                            	</select>
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="brthdy">생년월일</label>
	                                            </td>
	                                            <td>
	                                            	<form:input path="brthdy" class="f_txt w_full" oninput="addHyphenBrth(this)" title="제목" size="60" maxlength="10"/>
	                                                <br/><form:errors path="brthdy" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="adres">주소</label>
	                                            </td>
	                                            <td>
	                                            	<form:input path="adres" class="f_txt w_full" title="제목" size="60" maxlength="60"/>
	                                                <br/><form:errors path="adres" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="detailAdres">상세주소</label>
	                                            </td>
	                                            <td>
	                                            	<form:input path="detailAdres" class="f_txt w_full" title="제목" size="60" maxlength="60"/>
	                                                <br/><form:errors path="detailAdres" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyNm">회사명</label>
	                                            </td>
	                                            <td>
	                                            	<form:input path="cmpnyNm" class="f_txt w_full" title="제목" size="60" maxlength="60"/>
	                                                <br/><form:errors path="cmpnyNm" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="deptNm">부서명</label>
	                                            </td>
	                                            <td>
	                                            	<form:input path="deptNm" class="f_txt w_full" title="제목" size="60" maxlength="60"/>
	                                                <br/><form:errors path="deptNm" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="clsfNm">직급명</label>
	                                            </td>
	                                            <td>
	                                            	<form:input path="clsfNm" class="f_txt w_full" title="제목" size="60" maxlength="60"/>
	                                                <br/><form:errors path="clsfNm" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="bkmkAt">즐겨찾기</label>
	                                            </td>
	                                            <td>
	                                                <select name="bkmkAt" class="f_txt w_full">
	                                            		<option value="Y" <c:if test="${resultVO.bkmkAt eq 'Y' }">selected</c:if>>예</option>
	                                            		<option value="N" <c:if test="${resultVO.bkmkAt eq 'N' }">selected</c:if>>아니오</option>
	                                            	</select>
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="photoNm">사진첨부</label>
	                                            </td>
	                                            <td>
	                                                <div class="board_attach2" id="file_upload_posbl">
	                                                    <input name="file_1" id="egovComFileUploader" type="file" />
	                                                    <div id="egovComFileList"></div>
	                                                </div>
	                                                <div class="board_attach2" id="file_upload_imposbl">
	                                                </div>
	                                                <c:if test="${empty result.atchFileId}">
											            <input type="hidden" id="fileListCnt" name="fileListCnt" value="0" />
											        </c:if>
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="memo">메모</label>
	                                            </td>
	                                            <td>
	                                            	<form:textarea path="memo" cols="30" maxlength="500" rows="10" title="내용" htmlEscape="false" class="f_txtar w_full h_200"/>
													<form:errors path="memo" />
	                                            </td>
	                                        </tr>
	                                    </table>
										
	                                </div>
	
									<!-- 목록/저장버튼  시작-->
	                                <div class="board_view_bot">
	                                    <div class="left_col btn3">
	                                    </div>
	
	                                    <div class="right_col btn1">
	                                       	<a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="updateAdrITAAct();"><spring:message code='button.save' /></a><!-- 저장 -->
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