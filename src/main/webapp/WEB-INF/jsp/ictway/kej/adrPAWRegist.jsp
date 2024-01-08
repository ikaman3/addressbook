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
	function selectAdrPAWList(){
		document.searchListForm.action = "<c:url value='/ictway/kej/selectAdrPAWList.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 등록
	function registAdrPAWAct() {
    	if (confirm('<spring:message code="common.regist.msg" />')) {
    		const formElement = document.registForm;
        	const formData = new FormData(formElement);
        	
        	fetch("<c:url value='/ictway/kej/registAdrPAWAct.do'/>",{
    			method: "POST",
    			cache: "no-cache",
     			headers: {},
     			body: formData
        	})
        	.then(response => response.json())
        	.then(data => {
        		alert("<spring:message code="success.common.insert"/>");
        		location.href = "<c:url value='/ictway/kej/selectAdrPAWList.do'/>";
        	})
        	.catch(error => {
    			console.log(error);
    			alert("에러가 발생하였습니다.");
    		});
    	}
    }
    
</script>

<title>샘플 포털 > 주소록 > 김은지</title>

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
										<li><a href="<c:url value="/ictway/kej/selectAdrPAWList.do"/>">김은지</a></li>
										<li><a href="<c:url value="/ictway/kej/selectAdrPAWList.do"/>">주소록 목록</a></li>
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
									<p class="txt_1">ICTWAY 신입사원 김은지의 샘플 주소록입니다.</p>
									<h2 class="tit_2">주소록 등록</h2>

	                                <div class="board_view2">
	                                    <table>
	                                        <colgroup>
	                                            <col style="width: 100px;">
	                                            <col style="width: auto;">
	                                        </colgroup>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="nm">이름</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="nm" name="nm" type="text" size="60" value=""  maxlength="60" class="f_txt w_full">
	                                                <br/><form:errors path="adrSj" />
	                                            </td>
	                                            <td class="lb">
	                                                <label for="brthdy">생년월일</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="brthdy" name="brthdy" type="text" size="60" value=""  maxlength="60" class="f_txt w_full">
	                                                <br/><form:errors path="adrSj" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="telno">전화번호</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <textarea id="telno" name="telno" class="textarea f_txtar w_full h_200" cols="30" rows="10" ></textarea>
	                                                <form:errors path="adrCn" />
	                                            </td>
	                                            <td class="lb">
	                                                <label for="emailaddr">이메일주소</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <textarea id="emailaddr" name="emailaddr" class="textarea f_txtar w_full h_200" cols="30" rows="10" ></textarea>
	                                                <form:errors path="adrCn" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="sexdstnCode">성별</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <textarea id="sexdstnCode" name="sexdstnCode" class="textarea f_txtar w_full h_200" cols="30" rows="10" ></textarea>
	                                                <form:errors path="adrCn" />
	                                            </td>
	                                            <td class="lb">
	                                                <label for="bkmkAt">즐겨찾기 여부</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <label><input type="radio" name="bkmkAt" value="Y">Y</label>
	                                                <label><input type="radio" name="bkmkAt" value="N">N</label>
	                                                <form:errors path="adrCn" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="adres">주소</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <textarea id="adres" name="adres" class="textarea f_txtar w_full h_200" cols="30" rows="10" ></textarea>
	                                                <form:errors path="adrCn" />
	                                            </td>
	                                            <td class="lb">
	                                                <label for="detailAdres">상세주소</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <textarea id="detailAdres" name="detailAdres" class="textarea f_txtar w_full h_200" cols="30" rows="10" ></textarea>
	                                                <form:errors path="adrCn" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="memo">메모</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <textarea id="memo" name="memo" class="textarea f_txtar w_full h_200" cols="30" rows="10" ></textarea>
	                                                <form:errors path="adrCn" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="groupCode">그룹코드</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <textarea id="groupCode" name="groupCode" class="textarea f_txtar w_full h_200" cols="30" rows="10" ></textarea>
	                                                <form:errors path="adrCn" />
	                                            </td>
	                                            <td class="lb">
	                                                <label for="cmpnyPsitnNm">회사소속명</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <textarea id="cmpnyPsitnNm" name="cmpnyPsitnNm" class="textarea f_txtar w_full h_200" cols="30" rows="10" ></textarea>
	                                                <form:errors path="adrCn" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyPsitnTeamNm">회사소속팀명</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <textarea id="cmpnyPsitnTeamNm" name="cmpnyPsitnTeamNm" class="textarea f_txtar w_full h_200" cols="30" rows="10" ></textarea>
	                                                <form:errors path="adrCn" />
	                                            </td>
	                                            <td class="lb">
	                                                <label for="cmpnyPsitnClsfNm">회사소속직급명</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <textarea id="cmpnyPsitnClsfNm" name="cmpnyPsitnClsfNm" class="textarea f_txtar w_full h_200" cols="30" rows="10" ></textarea>
	                                                <form:errors path="adrCn" />
	                                            </td>
	                                        </tr>
	                                    </table>
	                                </div>

	                                <div class="board_view_bot">
	                                    <div class="left_col btn3">
	                                    </div>
	
	                                    <div class="right_col btn1">
	                                        <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="registAdrPAWAct();"><spring:message code="button.save" /></a>
	                                        <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="selectAdrPAWList();"><spring:message code="button.list" /></a>
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