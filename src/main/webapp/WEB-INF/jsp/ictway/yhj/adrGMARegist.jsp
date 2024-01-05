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
	function selectAdrGMAList(){
		document.searchListForm.action = "<c:url value='/ictway/yhj/selectAdrGMAList.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 등록
	function registAdrGMAAct() {
    	if (confirm('<spring:message code="common.regist.msg" />')) {
    		const formElement = document.registForm;
        	const formData = new FormData(formElement);
        	
        	fetch("<c:url value='/ictway/yhj/registAdrGMAAct.do'/>",{
    			method: "POST",
    			cache: "no-cache",
     			headers: {},
     			body: formData
        	})
        	.then(response => response.json())
        	.then(data => {
        		alert("<spring:message code="success.common.insert"/>");
        		location.href = "<c:url value='/ictway/yhj/selectAdrGMAList.do'/>";
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
										<li><a href="<c:url value="/ictway/yhj/selectAdrGMAList.do"/>">염혜정</a></li>
										<li><a href="<c:url value="/ictway/yhj/selectAdrGMAList.do"/>">주소록 목록</a></li>
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
									<p class="txt_1">염혜정 - 주소록 등록 화면입니다.</p>
									<h2 class="tit_2">주소록 등록</h2>

	                                <div class="board_view2">
	                                    <table>
	                                        <colgroup>
	                                            <col style="width: 190px;">
	                                            <col style="width: auto;">
	                                        </colgroup>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="adrSj">이름</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="userNm" name="userNm" type="text" size="50" value=""  maxlength="50" class="f_txt w_full">
	                                                <br/><form:errors path="userNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="brthdy">생년월일</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="brthdy" name="brthdy" type="date" value="" class="f_txt w_full" ></input>
	                                                <form:errors path="brthdy" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="sexdstnCode">성별</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                            	<input type="radio" name="sexdstnCode" value="SX001" /> 여성
	                                            	<input type="radio" name="sexdstnCode" value="SX002" /> 남성
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="adres">주소</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="adres" name="adres" type="text" size="50" value=""  maxlength="50" class="f_txt w_full" ></input>
	                                                <form:errors path="adrCn" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="mbtlnum">휴대폰번호</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="mbtlnum" name="mbtlnum" type="tel" size="50" value=""  maxlength="50" class="f_txt w_full" ></input>
	                                                <form:errors path="mbtlnum" />
	                                            </td>
	                                        </tr>
	                                         <tr>	                                        
	                                            <td class="lb">
	                                                <label for="emailaddr">이메일주소</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="emailaddr" name="emailaddr" type="text" size="50" value=""  maxlength="50" class="f_txt w_full" ></input>
	                                                <form:errors path="emailaddr" />
	                                            </td>
	                                        </tr>
	                                        <tr>	                                        
	                                            <td class="lb">
	                                                <label for="memo">메모</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="memo" name="memo" type="text" size="50" value=""  maxlength="50" class="f_txt w_full" ></input>
	                                                <form:errors path="memo" />
	                                            </td>
	                                        </tr>
	                                        <tr>	                                        
	                                            <td class="lb">
	                                                <label for="photoFlpth">사진</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="photoFlpth" name="photoFlpth" type="text" size="50" value=""  maxlength="50" class="f_txt w_full" ></input>
	                                                <form:errors path="photoFlpth" />
	                                            </td>
	                                        </tr>
	                                        <tr>	                                        
	                                            <td class="lb">
	                                                <label for="adresGroupCode">소속그룹</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="adresGroupCode" name="adresGroupCode" type="text" size="50" value=""  maxlength="50" class="f_txt w_full" ></input>
	                                                <form:errors path="adresGroupCode" />
	                                            </td>
	                                        </tr>
	                                        <tr>	                                        
	                                            <td class="lb">
	                                                <label for="cmpnyNm">회사</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="cmpnyNm" name="cmpnyNm" type="text" size="50" value=""  maxlength="50" class="f_txt w_full" ></input>
	                                                <form:errors path="cmpnyNm" />
	                                            </td>
	                                        </tr>
	                                    </table>
	                                </div>

	                                <div class="board_view_bot">
	                                    <div class="left_col btn3">
	                                    </div>
	
	                                    <div class="right_col btn1">
	                                        <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="registAdrGMAAct();"><spring:message code="button.save" /></a>
	                                        <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="selectAdrGMAList();"><spring:message code="button.list" /></a>
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