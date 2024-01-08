<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%pageContext.setAttribute("crlf", "\r\n"); %>
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

<script type="text/javascript">
	//주소록 목록조회
	function selectAdrINYList(){
		document.searchListForm.action = "<c:url value='/ictway/iny/selectAdrINYList.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 수정 화면
	function selectAdrINYUpdate(){
		document.searchListForm.action = "<c:url value='/ictway/iny/selectAdrINYUpdate.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 정보 삭제
	function deleteAdrINYAct(){
		if (confirm('<spring:message code="common.delete.msg" />')) {
    		const formElement = document.searchListForm;
        	const formData = new FormData(formElement);
        	
        	fetch("<c:url value='/ictway/iny/deleteAdrINYAct.do'/>",{
    			method: "POST",
    			cache: "no-cache",
     			headers: {},
     			body: formData
        	})
        	.then(response => response.json())
        	.then(data => {
        		alert("<spring:message code="success.common.delete"/>");
        		location.href = "<c:url value='/ictway/iny/selectAdrINYList.do'/>";
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
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
	.board_article {padding: 20px 10px 50px 25px;}
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
										<li><a href="javascript:void(0);">주소록 상세</a></li>
                                    </ul>
                                </div>
                                <!--// Location -->
                                
                                <!-- 검색 form 시작 -->
								<form:form modelAttribute="searchVO" name="searchListForm" method="post">
									<form:hidden path="pageIndex"/>
									<form:hidden path="searchCondition"/>
									<form:hidden path="searchKeyword"/>
									
									<%-- <form:hidden path="adrId"/> --%>
								</form:form>
								<!-- 검색 form 끝 -->

                              	<h1 class="tit_1">주소록</h1>
								<p class="txt_1">INY 주소록 상세조회 입니다.</p>
								<h2 class="tit_2">주소록 상세</h2>

                                <!-- 주소록 상세보기 -->
                                <div class="board_view">
                                    <div class="board_view_top">
                                        <div class="tit"><c:out value="${resultVO.userNm}" /></div>
                                        <div class="info">
                                            <dl>
                                                <dt>이름</dt>
                                                <dd><c:out value="${resultVO.userNm}" /></dd>
                                            </dl>
                                            <dl>
                                                <dt>생년월일</dt>
                                                <dd><c:out value="${resultVO.brthdy}" /></dd>
                                            </dl>
                                            <dl>
                                                <dt>성별</dt>
                                                <dd><c:out value="${resultVO.sexdstnCode}" /></dd>
                                            </dl>
                                        </div>
                                        <div class="info">
                                            <dl>
                                                <dt>주소</dt>
                                                <dd><c:out value="${resultVO.adres}" /></dd>
                                            </dl>
                                            <dl>
                                                <dt>상세주소</dt>
                                                <dd><c:out value="${resultVO.detailAdres}" /></dd>
                                            </dl>
                                            <dl>
                                                <dt>그룹명칭</dt>
                                                <dd><c:out value="${resultVO.groupNm}" /></dd>
                                            </dl>
                                        </div>
                                        <div class="info">
                                            <dl>
                                                <dt>회사명칭</dt>
                                                <dd><c:out value="${resultVO.cmpnyNm}" /></dd>
                                            </dl>
                                            <dl>
                                                <dt>부서명칭</dt>
                                                <dd><c:out value="${resultVO.deptNm}" /></dd>
                                            </dl>
                                            <dl>
                                                <dt>직급명칭</dt>
                                                <dd><c:out value="${resultVO.clsfNm}" /></dd>
                                            </dl>
                                        </div>
                                        <div class="info">
                                            <dl>
                                                <dt>메모</dt>
                                                <dd><c:out value="${resultVO.memo}" /></dd>
                                            </dl>
                                        </div>
                                        <div class="info">
                                            <dl>
                                                <dt>사진명칭</dt>
                                                <dd><c:out value="${resultVO.photoNm}" /></dd>
                                            </dl>
                                            <dl>
                                                <dt>사진경로</dt>
                                                <dd><c:out value="${resultVO.photoCours}" /></dd>
                                            </dl>
                                            <dl>
                                                <dt>사진확장자</dt>
                                                <dd><c:out value="${resultVO.photoExtsnNm}" /></dd>
                                            </dl>
                                        </div>
                                    </div>

									<!-- 버튼 시작 -->
                                    <div class="board_view_bot">
                                        <div class="left_col btn3">
                                            <a href="javascript:void(0);" class="btn btn_skyblue_h46 w_100" onclick="selectAdrINYUpdate();">수정</a>
                                            <a href="javascript:void(0);" class="btn btn_skyblue_h46 w_100" onclick="deleteAdrINYAct();">삭제</a>
                                        </div>

                                        <div class="right_col btn1">
                                            <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="selectAdrINYList();">목록</a>
                                        </div>
                                    </div>
                                    <!-- /버튼 끝 -->
                                </div>
                                <!-- 게시판 상세보기 -->
                                
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