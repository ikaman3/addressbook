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
	function selectAdrCIPList(){
		document.searchListForm.action = "<c:url value='/ictway/kyw/selectAdrCIPList.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 수정 화면
	function selectAdrCIPUpdate(){
		document.searchListForm.action = "<c:url value='/ictway/kyw/selectAdrCIPUpdate.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 정보 삭제
	function deleteAdrCIPAct(){
		if (confirm('<spring:message code="common.delete.msg" />')) {
    		const formElement = document.searchListForm;
        	const formData = new FormData(formElement);
        	
        	fetch("<c:url value='/ictway/kyw/deleteAdrCIPAct.do'/>",{
    			method: "POST",
    			cache: "no-cache",
     			headers: {},
     			body: formData
        	})
        	.then(response => response.json())
        	.then(data => {
        		alert("<spring:message code="success.common.delete"/>");
        		location.href = "<c:url value='/ictway/kyw/selectAdrCIPList.do'/>";
        	})
        	.catch(error => {
    			console.log(error);
    			alert("에러가 발생하였습니다.");
    		});
    	}
	}
	
</script>

<title>샘플 포털 > 주소록 > 김예원</title>

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
										<li><a href="<c:url value="/ictway/kyw/selectAdrCIPList.do"/>">김예원</a></li>
										<li><a href="<c:url value="/ictway/kyw/selectAdrCIPList.do"/>">주소록 목록</a></li>
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
								<p class="txt_1">주머니 속 연락처</p>
								<h2 class="tit_2">주소록 상세</h2>

                                <!-- 주소록 상세보기 -->
                                <div class="board_view">
                                <div class="board_view2">
                                    <table>
	                                        <colgroup>
	                                            <col style="width: 150px;">
	                                            <col style="width: 335px;">
	                                            <col style="width: 150px;">
	                                            <col style="width: auto;">
	                                        </colgroup>
                                    
                                            <tr>
                                                <td class="lb">
	                                                <label for="nm">이름</label>
	                                            </td>
                                                <td><c:out value="${fn:replace(resultVO.nm, crlf , '<br/>')}" escapeXml="false" /></td>
                                                <td class="lb">	                                        		
	                                                <label for="sexdstnCode">성별</label>
	                                            </td>
                                                <td>
                                                	<c:choose>
														<c:when test="${resultVO.sexdstnCode eq 'SE001'}">남자</br></c:when>
														<c:when test="${resultVO.sexdstnCode eq 'SE002'}">여자</br></c:when>
														<c:when test="${resultVO.sexdstnCode eq 'SE003'}">없음</br></c:when>
													</c:choose>
												</td>
                                            </tr>
                                            <tr>
                                                <td class="lb">
	                                                <label for="telno">전화번호</label>
	                                            </td>
                                                <td><c:out value="${fn:replace(resultVO.telno, crlf , '<br/>')}" escapeXml="false" /></td>
                                                <td class="lb">
	                                                <label for="bkmkAt">즐겨찾기</label>
	                                            </td>
                                                <td>
                                                	<c:choose>
														<c:when test="${resultVO.bkmkAt eq 'Y'}">O</br></c:when>
														<c:when test="${resultVO.bkmkAt eq 'N'}">X</br></c:when>
													</c:choose>
                                               </td>
                                            </tr>
                                            <tr>
                                            	<td class="lb">
	                                                <label for="brthdy">생년월일</label>	                                                
	                                            </td>
                                                <td><c:out value="${fn:replace(resultVO.brthdy, crlf , '<br/>')}" escapeXml="false" /></td>
                                            	<td class="lb">
	                                                <label for="emailaddr">이메일 주소</label>
	                                            </td>
                                                <td><c:out value="${fn:replace(resultVO.emailaddr, crlf , '<br/>')}" escapeXml="false" /></td>
                                                
                                            </tr>
                                            <tr>
                                            	<td class="lb">
	                                                <label for="adres">주소</label>	                                                
	                                            </td>
	                                            <td colspan="3"><c:out value="${fn:replace(resultVO.adres, crlf , '<br/>')}" escapeXml="false" /></td>
                                            </tr>
                                            <tr>
                                                <td class="lb">
	                                                <label for="detailAdres">상세주소</label>	                                                
	                                            </td>
	                                            <td colspan="3"><c:out value="${fn:replace(resultVO.detailAdres, crlf , '<br/>')}" escapeXml="false" /></td>
                                            </tr>
                                            <tr>
                                                <td class="lb">	                                        		
	                                                <label for="groupCode">그룹</label>	
	                                            </td>
                                                <td>
                                                	<c:choose>
														<c:when test="${resultVO.groupCode eq 'GR001'}">가족</br></c:when>
														<c:when test="${resultVO.groupCode eq 'GR002'}">친구</br></c:when>
														<c:when test="${resultVO.groupCode eq 'GR003'}">현직장</br></c:when>
														<c:when test="${resultVO.groupCode eq 'GR004'}">구직장</br></c:when>
														<c:when test="${resultVO.groupCode eq 'GR005'}">동호회</br></c:when>
													</c:choose>
												</td>
                                                <td class="lb">
	                                                <label for="cmpnyPsitnNm">회사명</label>	                                                
	                                            </td>
                                                <td><c:out value="${fn:replace(resultVO.cmpnyPsitnNm, crlf , '<br/>')}" escapeXml="false" /></td>
                                            </tr>
                                            <tr>
                                                <td class="lb">
	                                                <label for="cmpnyPsitnTeamNm">회사 팀명</label>	                                                
	                                            </td>
                                                <td><c:out value="${fn:replace(resultVO.cmpnyPsitnTeamNm, crlf , '<br/>')}" escapeXml="false" /></td>
                                                <td class="lb">
	                                                <label for="cmpnyPsitnClsfNm">직급</label>	                                                
	                                            </td>
                                                <td><c:out value="${fn:replace(resultVO.cmpnyPsitnClsfNm, crlf , '<br/>')}" escapeXml="false" /></td>
                                            </tr>
                                            <tr>
                                                <td class="lb">
	                                                <label for="memo">메모</label>	                                                
	                                            </td>
                                                <td colspan="3"><c:out value="${fn:replace(resultVO.memo, crlf , '<br/>')}" escapeXml="false" /></td>
                                            </tr>
                                            <tr>
                                                <td class="lb">
                                              		<label for="adbkFrstWritngDt">최초 작성일</label>
                                              	</td>
                                                <td colspan="3"><c:out value="${fn:replace(resultVO.adbkFrstWritngDt, crlf , '<br/>')}" escapeXml="false" /></td>
                                            </tr>
                                            <tr>
                                                <td class="lb">
                                              		<label for="adbkLastUpdtDt">최종 수정일</label>
                                              	</td>
                                                <td colspan="3"><c:out value="${fn:replace(resultVO.adbkLastUpdtDt, crlf , '<br/>')}" escapeXml="false" /></td>
                                            </tr>
                                        </table>
                                    </div>

                                    <%-- <div class="board_article">
                                    	<c:out value="${fn:replace(resultVO.adrCn , crlf , '<br/>')}" escapeXml="false" />
                                    </div> --%>

									<!-- 버튼 시작 -->
                                    <div class="board_view_bot">
                                        <div class="left_col btn3">
                                            <a href="javascript:void(0);" class="btn btn_skyblue_h46 w_100" onclick="selectAdrCIPUpdate();">수정</a>
                                            <a href="javascript:void(0);" class="btn btn_skyblue_h46 w_100" onclick="deleteAdrCIPAct();">삭제</a>
                                        </div>

                                        <div class="right_col btn1">
                                            <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="selectAdrCIPList();">목록</a>
                                        </div>
                                    </div>
                                    <!-- /버튼 끝 -->
                                <!-- 게시판 상세보기 -->
                                </div>
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