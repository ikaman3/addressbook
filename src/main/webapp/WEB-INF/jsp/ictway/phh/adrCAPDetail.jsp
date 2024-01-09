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
	function selectAdrCAPList(){
		document.searchListForm.action = "<c:url value='/ictway/phh/selectAdrCAPList.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 수정 화면
	function selectAdrCAPUpdate(){
		document.searchListForm.action = "<c:url value='/ictway/phh/selectAdrCAPUpdate.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 정보 삭제
	function deleteAdrCAPAct(){
		if (confirm('<spring:message code="common.delete.msg" />')) {
    		const formElement = document.searchListForm;
        	const formData = new FormData(formElement);
        	
        	fetch("<c:url value='/ictway/phh/deleteAdrCAPAct.do'/>",{
    			method: "POST",
    			cache: "no-cache",
     			headers: {},
     			body: formData
        	})
        	.then(response => response.json())
        	.then(data => {
        		alert("<spring:message code="success.common.delete"/>");
        		location.href = "<c:url value='/ictway/phh/selectAdrCAPList.do'/>";
        	})
        	.catch(error => {
    			console.log(error);
    			alert("에러가 발생하였습니다.");
    		});
    	}
	}
	
</script>

<title>샘플 포털 > 주소록 > 박현희</title>

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
										<li><a href="<c:url value="/ictway/phh/selectAdrCAPList.do"/>">김진광</a></li>
										<li><a href="<c:url value="/ictway/phh/selectAdrCAPList.do"/>">주소록 목록</a></li>
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
								<p class="txt_1">박현희 - 주소록 제작 프로젝트(CAP)</p>
								<h2 class="tit_2">주소록 상세</h2>

                                <!-- 주소록 상세보기 -->
                                <div class="board_view2">
                                    
                                    
                                    
	                                    <table>
	                                        <colgroup>
	                                            <col style="width: 190px;">
	                                            <col style="width: auto;">
	                                        </colgroup>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="userNm">이름</label>
	                                            </td>
	                                            <td>
	                                                <c:out value="${resultVO.userNm}" />
	                                            </td>
	                                            <td class="lb">
	                                                <label for="sexdstnCode">성별</label>
	                                            </td>
	                                            <td>
	                                            	<c:choose>
                                                		<c:when test="${resultVO.sexdstnCode eq 'SX001'}">여성</c:when>
                                                		<c:when test="${resultVO.sexdstnCode eq 'SX002'}">남성</c:when>
                                                	</c:choose>
	                                            
	                                            </td>
	                                        </tr>
	                                        
							                <tr>
	                                            <td class="lb">
	                                                <label for="mbtlnum">휴대폰</label>
	                                            </td>
	                                            <td>
	                                                <c:out value="${resultVO.mbtlnum}" />
	                                            </td>
	                                            <td class="lb">
	                                                <label for="emailaddr">이메일</label>
	                                            </td>
	                                            <td>
	                                                <c:out value="${resultVO.emailaddr}" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="brthdy">생년월일</label>
	                                            </td>
	                                            <td>
	                                                <c:out value="${resultVO.brthdy}" escapeXml="false"/>
	                                            </td>
	                                            <td class="lb">
	                                                <label for="adresGroupCode">그룹</label>
	                                            </td>
	                                            <td>
	                                            	<c:choose>
                                                		<c:when test="${resultVO.adresGroupCode eq 'GR001'}">가족</c:when>
                                                		<c:when test="${resultVO.adresGroupCode eq 'GR002'}">친구</c:when>
                                                		<c:when test="${resultVO.adresGroupCode eq 'GR003'}">현직장</c:when>
                                                		<c:when test="${resultVO.adresGroupCode eq 'GR004'}">구직장</c:when>
                                                		<c:when test="${resultVO.adresGroupCode eq 'GR005'}">동호회</c:when>
                                                		<c:when test="${resultVO.adresGroupCode eq 'GR006'}">기타</c:when>
                                                	</c:choose>
	                              
	                                            </td>
	                                        </tr>
	                                        
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="adres">주소</label>
	                                            </td>
	                                            <td colspan="3">
	                                                <c:out value="${resultVO.adres}" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="detailAdres">상세주소</label>
	                                            </td>
	                                            <td colspan="3">
	                                                <c:out value="${resultVO.detailAdres}" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="memo">메모</label>
	                                            </td>
	                                            <td colspan = "3">
	                                                <c:out value="${fn:replace(resultVO.memo , crlf , '<br/>')}" escapeXml="false" />
	                                            </td>
	                                        </tr> 
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyTeamNm">회사소속팀명</label>
	                                            </td>
	                                            <td colspan="3">
	                                                <c:out value="${resultVO.cmpnyTeamNm}" />
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyClsfNm">회사직급</label>
	                                            </td>
	                                            <td colspan="3">
	                                                <c:out value="${resultVO.cmpnyClsfNm}" />
	                                            </td>
	                                        </tr>
	                                        
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyClsfNm">즐겨찾기 여부</label>
	                                            </td>
	                                            <td colspan="3">
	                                                <%-- <input id=bkmkAt name="bkmkAt" type="radio" size="60" value="Y">예 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	                                                <input id=bkmkAt name="bkmkAt" type="radio" size="60" value="N">아니요
	                                                <br/><form:errors path="bkmkAt" /> --%>
	                                                
	                                                <c:choose>
                                                		<c:when test="${resultVO.bkmkAt eq 'Y'}">예</c:when>
                                                		<c:when test="${resultVO.bkmkAt eq 'N'}">아니오</c:when>
                                                	</c:choose>
	                                                
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyClsfNm">등록일시</label>
	                                            </td>
	                                            <td colspan="3">
	                                                <fmt:parseDate value = "${resultVO.adbkCreatDt}" pattern = "yyyy-MM-dd HH:mm:ss" var = "date"/>
	                                                <fmt:formatDate value="${date}" pattern="yyyy-MM-dd HH:mm:ss"/>
	                                            </td>
	                                        </tr>
	                                        
	                                        
	                                        
	       
	                                    </table>
	                                </div>

                                    <div class="board_article">
                                    	<%-- <c:out value="${fn:replace(resultVO.adrCn , crlf , '<br/>')}" escapeXml="false" /> --%>
                                    </div>

									<!-- 버튼 시작 -->
                                    <div class="board_view_bot">
                                        <div class="left_col btn3">
                                            <a href="javascript:void(0);" class="btn btn_skyblue_h46 w_100" onclick="selectAdrCAPUpdate();">수정</a>
                                            <a href="javascript:void(0);" class="btn btn_skyblue_h46 w_100" onclick="deleteAdrCAPAct();">삭제</a>
                                        </div>

                                        <div class="right_col btn1">
                                            <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="selectAdrCAPList();">목록</a>
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