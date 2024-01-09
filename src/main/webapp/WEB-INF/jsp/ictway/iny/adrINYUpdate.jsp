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
	function selectAdrINYList(){
		document.searchListForm.action = "<c:url value='/ictway/iny/selectAdrINYList.do'/>";
		document.searchListForm.submit();
	}
	
	//수정 취소
	function goToBack(){
		if (confirm('<spring:message code="common.reset.msg" />')) {
			history.back();
		}
	}
	
	//주소록 수정
	function updateAdrINYAct(){
			
		if (confirm('<spring:message code="common.update.msg" />')) {
	   		const formElement = document.updateForm;
	       	const formData = new FormData(formElement);
	       	
	       	fetch("<c:url value='/ictway/iny/updateAdrINYAct.do'/>",{
	   			method: "POST",
	   			cache: "no-cache",
	    			headers: {},
	    			body: formData
	       	})
	       	.then(response => response.json())
	       	.then(data => {
	       		alert("<spring:message code="success.common.update"/>");
	       		document.searchListForm.action = "<c:url value='/ictway/iny/selectAdrINYDetail.do'/>";
	       		document.searchListForm.submit();
	       	})
	       	.catch(error => {
	   			console.log(error);
	   			alert("에러가 발생하였습니다.");
	   		});
	   	}
	}
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
									
	                                <h1 class="tit_1">주소록</h1>
									<p class="txt_1">INY 주소록 수정 입니다.</p>
									<h2 class="tit_2">주소록 수정</h2>
	
	                                <div class="board_view2">
	                                    <table>
	                                        <colgroup>
	                                            <col style="width: 190px;">
	                                            <col style="width: auto;">
	                                        </colgroup>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="bkmkAt">즐겨찾기</label>
	                                            </td>
                                                <td>
	                                                <select id="bkmkAt" title="즐겨찾기" name="bkmkAt" class="f_txt w_full">
	                                                	<option hidden="" disabled="disabled" value=""></option>
	                                                	<option value="BKM001" <c:out value="${resultVO.bkmkAt eq 'BKM001' ? 'selected' : ''}"/>>예</option>
	                                                	<option value="BKM002" <c:out value="${resultVO.bkmkAt eq 'BKM002' ? 'selected' : ''}"/>>아니요</option>
	                                                </select>
	                                                <form:errors path="bkmkAt" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="userNm">이름</label>
													<span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                            	<form:input path="userNm" class="f_txt w_full" title="이름" size="60" maxlength="60"/>
	                                                <br/><form:errors path="userNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="brthdy">생년월일</label>
													<span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                            	<form:input path="brthdy" class="f_txt w_full" title="생년월일" size="60" maxlength="60"/>
	                                                <br/><form:errors path="brthdy" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="sexdstnCode">성별</label>
													<span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <select id="sexdstnCode" title="성별" name="sexdstnCode" class="f_txt w_full">
	                                                	
	                                                	<option value="SEX001" <c:out value="${resultVO.sexdstnCode eq 'SEX001' ? 'selected' : ''}"/>>남자</option>
	                                                	<option value="SEX002" <c:out value="${resultVO.sexdstnCode eq 'SEX002' ? 'selected' : ''}"/>>여자</option>
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
	                                            	<form:input path="adres" class="f_txt w_full" title="주소" size="60" maxlength="60"/>
	                                                <br/><form:errors path="adres" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="detailAdres">상세주소</label>
													<span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                            	<form:input path="detailAdres" class="f_txt w_full" title="상세주소" size="60" maxlength="60"/>
	                                                <br/><form:errors path="detailAdres" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="moblphonNo">휴대폰번호</label>
													<span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                            	<form:input path="moblphonNo" class="f_txt w_full" size="60" maxlength="60"/>
	                                                <br/><form:errors path="moblphonNo" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="emailaddr">이메일주소</label>
													<span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                            	<form:input path="emailaddr" class="f_txt w_full" size="60" maxlength="60"/>
	                                                <br/><form:errors path="emailaddr" />
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
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="groupNm">그룹명칭</label>
	                                            </td>
	                                            <td>
	                                            	<form:input path="groupNm" class="f_txt w_full" size="60" maxlength="60"/>
	                                                <br/><form:errors path="groupNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyNm">회사명칭</label>
	                                            </td>
	                                            <td>
	                                            	<form:input path="cmpnyNm" class="f_txt w_full" size="60" maxlength="60"/>
	                                                <br/><form:errors path="cmpnyNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="deptNm">부서명칭</label>
	                                            </td>
	                                            <td>
	                                            	<form:input path="deptNm" class="f_txt w_full" size="60" maxlength="60"/>
	                                                <br/><form:errors path="deptNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="clsfNm">직급명칭</label>
	                                            </td>
	                                            <td>
	                                            	<form:input path="clsfNm" class="f_txt w_full" size="60" maxlength="60"/>
	                                                <br/><form:errors path="clsfNm" />
	                                            </td>
	                                        </tr>
	                                    </table>
	                                </div>
	
									<!-- 목록/저장버튼  시작-->
	                                <div class="board_view_bot">
	                                    <div class="left_col btn3">
	                                    </div>
	
	                                    <div class="right_col btn1">
	                                       	<a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="updateAdrINYAct();"><spring:message code='button.save' /></a><!-- 저장 -->
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