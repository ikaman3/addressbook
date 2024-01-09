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
	function selectAdrCIYList(){
		document.searchListForm.action = "<c:url value='/ictway/yjh/selectAdrCIYList.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 수정 화면
	function selectAdrUpdate(){
		document.searchListForm.action = "<c:url value='/ictway/yjh/selectAdrCIYUpdate.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 정보 삭제
	function deleteAdrAct(){
		if (confirm('<spring:message code="common.delete.msg" />')) {
    		const formElement = document.searchListForm;
        	const formData = new FormData(formElement);
        	
        	fetch("<c:url value='/ictway/yjh/deleteAdrCIYAct.do'/>",{
    			method: "POST",
    			cache: "no-cache",
     			headers: {},
     			body: formData
        	})
        	.then(response => response.json())
        	.then(data => {
        		alert("<spring:message code="success.common.delete"/>");
        		location.href = "<c:url value='/ictway/yjh/selectAdrCIYList.do'/>";
        	})
        	.catch(error => {
    			console.log(error);
    			alert("에러가 발생하였습니다.");
    		});
    	}
	}
	
</script>

<title>샘플 포털 > 주소록 > 윤준현</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
	.board_article {
		padding: 20px 10px 20px 25px;
        display: flex;
        align-items: center; /* 세로 가운데 정렬 */
	}
	.board_article label {
        margin-right: 10px; /* 레이블과 컨텐츠 사이 여백 */
        min-width: 100px; /* 레이블의 최소 너비 설정 (필요에 따라 조절) */
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
										<li><a href="javascript:void(0);">주소록 상세</a></li>
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

                              	<h1 class="tit_1">주소록</h1>
								<p class="txt_1">Contact ICTWAY</p>
								<h2 class="tit_2">주소록 상세</h2>

                                <!-- 주소록 상세보기 -->
                                <div class="board_view">
                                    <div class="board_view_top">
                                        <div class="tit"><c:out value="주소록 상세조회" /></div>
                                        <div class="info">
                                            <dl>
                                                <dt>등록일</dt>
                                                <fmt:parseDate value="${resultVO.adbkCreatDt}" var="dateValue" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                <dd><fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/></dd>
                                            </dl>
                                            <c:if test="${resultVO.adbkUpdtDt != null}">
	                                            <dl>
	                                                <dt>수정일</dt>
	                                                <fmt:parseDate value="${resultVO.adbkUpdtDt}" var="dateValue" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                	<dd><fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/></dd>
	                                            </dl>                                            
                                            </c:if>
                                            <c:if test="${resultVO.adbkDeleteDt != null}">
	                                            <dl>
	                                                <dt>삭제일</dt>
	                                                <fmt:parseDate value="${resultVO.adbkDeleteDt}" var="dateValue" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                	<dd><fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/></dd>
	                                            </dl>                                            
                                            </c:if>
                                        </div>
                                    </div>
                                    
                                    <div class="board_article">
                                    	<label>이름</label>	
                                    	<c:out value="${fn:replace(resultVO.userNm , crlf , '<br/>')}" escapeXml="false" />                                 
                                    </div>
                                    <div class="board_article">
                                        <label>휴대폰 번호</label>
                                    	<c:out value="${fn:replace(resultVO.mbtlnum , crlf , '<br/>')}" escapeXml="false" />
                                    </div>
                                    <div class="board_article">
                                    	<label>이메일</label>
                                    	<c:out value="${fn:replace(resultVO.emailaddr , crlf , '<br/>')}" escapeXml="false" />
                                    </div>
                                    <div class="board_article">
                                    	<label>생년월일</label>
                                    	<c:out value="${fn:replace(resultVO.brthdy , crlf , '<br/>')}" escapeXml="false" />
                                    </div>
                                    <div class="board_article">
                                    	<label>성별</label>
                                    	<c:if test="${resultVO.sexdstnCode == 'SX001'}">
	                                    	<c:out value="여성" escapeXml="false" />                                	
                                    	</c:if>
                            	        <c:if test="${resultVO.sexdstnCode == 'SX002'}">
	                                    	<c:out value="남성" escapeXml="false" />                                	
                                    	</c:if>
                                    </div>
                                    <div class="board_article">
                                    	<label>주소</label>
                                    	<c:out value="${fn:replace(resultVO.adres , crlf , '<br/>')}" escapeXml="false" />
                                    </div>
                                    <div class="board_article">
                                    	<label>상세주소</label>
                                    	<c:out value="${fn:replace(resultVO.detailAdres , crlf , '<br/>')}" escapeXml="false" />
                                    </div>
                                    <div class="board_article">
										<label>그룹</label>
										<c:if test="${resultVO.adresGroupCode == 'GR001'}">
	                                    	<c:out value="가족" escapeXml="false" />                                	
                                    	</c:if>
										<c:if test="${resultVO.adresGroupCode == 'GR002'}">
	                                    	<c:out value="친구" escapeXml="false" />                                	
                                    	</c:if>
                                    	<c:if test="${resultVO.adresGroupCode == 'GR003'}">
	                                    	<c:out value="현 직장" escapeXml="false" />                                	
                                    	</c:if>
                                    	<c:if test="${resultVO.adresGroupCode == 'GR004'}">
	                                    	<c:out value="구 직장" escapeXml="false" />                                	
                                    	</c:if>
                                    	<c:if test="${resultVO.adresGroupCode == 'GR005'}">
	                                    	<c:out value="동호회" escapeXml="false" />                                	
                                    	</c:if>
                                    	<c:if test="${resultVO.adresGroupCode == 'GR006'}">
	                                    	<c:out value="기타" escapeXml="false" />                                	
                                    	</c:if>
                                    	<c:if test="${resultVO.adresGroupCode == ''}">
	                                    	<c:out value="해당 없음" escapeXml="false" />                                	
                                    	</c:if>
                                    </div>
                                    <div class="board_article">
										<label>회사</label>
                                    	<c:out value="${fn:replace(resultVO.cmpnyNm , crlf , '<br/>')}" escapeXml="false" />
                                    </div>
                                    <div class="board_article">
										<label>부서</label>
                                    	<c:out value="${fn:replace(resultVO.cmpnyTeamNm , crlf , '<br/>')}" escapeXml="false" />
                                    </div>
                                    <div class="board_article">
										<label>직급</label>
                                    	<c:out value="${fn:replace(resultVO.cmpnyClsfNm , crlf , '<br/>')}" escapeXml="false" />
                                    </div>
                                    <div class="board_article">
										<label for="bkmkAt">즐겨찾기</label>
										<c:if test="${resultVO.bkmkAt == 'Y'}">
	                                    	<c:out value="등록" escapeXml="false" />                                	
                                    	</c:if>
                                    	<c:if test="${resultVO.bkmkAt == 'N'}">
	                                    	<c:out value="미등록" escapeXml="false" />                                	
                                    	</c:if>
                                    </div>
                                    <div class="board_article">
                                    	<label>메모</label>
                                    	<c:out value="${fn:replace(resultVO.memo , crlf , '<br/>')}" escapeXml="false" />
                                    </div>

									<!-- 버튼 시작 -->
                                    <div class="board_view_bot">
                                        <div class="left_col btn3">
                                            <a href="javascript:void(0);" class="btn btn_skyblue_h46 w_100" onclick="selectAdrUpdate();">수정</a>
                                            <a href="javascript:void(0);" class="btn btn_skyblue_h46 w_100" onclick="deleteAdrAct();">삭제</a>
                                        </div>

                                        <div class="right_col btn1">
                                            <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="selectAdrCIYList();">목록</a>
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
<script>
    // JavaScript를 사용하여 select 요소를 비활성화 상태로 만듭니다.
    document.getElementById("adresGroupCode").disabled = true;
</script>
</html>