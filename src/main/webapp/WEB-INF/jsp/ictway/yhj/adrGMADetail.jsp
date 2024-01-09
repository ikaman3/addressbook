<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper" %>
<%
pageContext.setAttribute("crlf", "\r\n");
%>
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
	function selectAdrGMAList(){
		document.searchListForm.action = "<c:url value='/ictway/yhj/selectAdrGMAList.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 수정 화면
	function selectAdrGMAUpdate(){
		document.searchListForm.action = "<c:url value='/ictway/yhj/selectAdrGMAUpdate.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 정보 삭제
	function deleteAdrGMAAct(){
		if (confirm('<spring:message code="common.delete.msg" />')) {
    		const formElement = document.searchListForm;
        	const formData = new FormData(formElement);
        	
        	fetch("<c:url value='/ictway/yhj/deleteAdrGMAAct.do'/>",{
    			method: "POST",
    			cache: "no-cache",
     			headers: {},
     			body: formData
        	})
        	.then(response => response.json())
        	.then(data => {
        		alert("<spring:message code="success.common.delete"/>");
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
h1 {
	font-size: 12px;
}

caption {
	visibility: hidden;
	font-size: 0;
	height: 0;
	margin: 0;
	padding: 0;
	line-height: 0;
}

.board_article {
	padding: 20px 10px 50px 25px;
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
										<li><a href="javascript:void(0);">주소록 상세</a></li>
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

								<h1 class="tit_1">주소록</h1>
								<p class="txt_1">염혜정 - 주소록입니다.</p>
								<h2 class="tit_2">주소록 상세</h2>

								<!-- 주소록 상세보기 -->
								<div class="board_view">
									<div class="board_view_top">
										<div class="tit">주소록</div>
									</div>

									<div class="board_view2">
										<table>
											<colgroup>
												<col style="width: 190px;">
												<col style="width: auto;">
											</colgroup>
											
											<tr>
												<td class="lb"><label for="userNm">이름</label></td>

												<td>
													<div id="userNm" , name="userNm">
														<c:out
															value="${fn:replace(resultVO.userNm , crlf , '<br/>')}"
															escapeXml="false" />
													</div>
												</td>
											</tr>


											<tr>
												<td class="lb"><label for="brthdy">생년월일</label></td>

												<td>
													<div id="brthdy" , name="brthdy">
														<fmt:parseDate value="${resultVO.brthdy}"
															pattern="yyyyMMdd" var="date" />
														<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" />
													</div>
												</td>
											</tr>

											<tr>
												<td class="lb"><label for="sexdstnCode">성별</label></td>

												<td>
													<div id="sexdstnCode" , name="sexdstnCode">
														<c:choose>
															<c:when test="${resultVO.sexdstnCode == 'SX001'}">
																<c:out value="여자" escapeXml="false" />
															</c:when>
															<c:when test="${resultVO.sexdstnCode == 'SX002'}">
																<c:out value="남자" escapeXml="false" />
															</c:when>
															<c:otherwise>
																<!-- 다른 값이 올 경우에 대한 처리 -->
																<c:out value="${resultVO.sexdstnCode}" />
															</c:otherwise>
														</c:choose>
													</div>
												</td>
											</tr>

											<tr>
												<td class="lb"><label for="adres">주소</label></td>

												<td>
													<div id="adres" , name="adres">
														<c:out
															value="${fn:replace(resultVO.adres , crlf , '<br/>')}"
															escapeXml="false" />
													</div>
												</td>
											</tr>

											<tr>
												<td class="lb"><label for="detailAdres">상세주소</label></td>

												<td>
													<div id=detailAdres, name="detailAdres">
														<c:out
															value="${fn:replace(resultVO.detailAdres , crlf , '<br/>')}"
															escapeXml="false" />
													</div>
												</td>
											</tr>

											<tr>
												<td class="lb"><label for="mbtlnum">휴대폰번호</label>

												</td>

												<td>
													<div id="mbtlnum" , name="mbtlnum">
														<c:out
															value="${fn:replace(resultVO.mbtlnum , crlf , '<br/>')}"
															escapeXml="false" />
													</div>
												</td>
											</tr>

											<tr>
												<td class="lb"><label for="emailaddr">이메일</label></td>

												<td>
													<div id="emailaddr" , name="emailaddr">
														<c:out
															value="${fn:replace(resultVO.emailaddr , crlf , '<br/>')}"
															escapeXml="false" />
													</div>
												</td>
											</tr>

											<tr>
												<td class="lb"><label for="memo">메모</label></td>

												<td>
													<div id="memo" , name="memo">
														<c:out
															value="${fn:replace(resultVO.memo , crlf , '<br/>')}"
															escapeXml="false" />
													</div>
												</td>
											</tr>
											
											<tr>
												<td class="lb"><label for="photo">사진</label></td>

												<td>
													<div id="photo" , name="photo">
														<img
															src='<c:url value='/ictway/yhj/getImage.do'/>?adbkId=<c:out value="${resultVO.adbkId}"/>'/>
													</div>
												</td>
											</tr>

											<tr>
												<td class="lb"><label for="cmpnyNm">회사</label></td>

												<td>
													<div id="cmpnyNm" , name=cmpnyNm>
														<c:out
															value="${fn:replace(resultVO.cmpnyNm , crlf , '<br/>')}"
															escapeXml="false" />
													</div>
												</td>
											</tr>

											<tr>
												<td class="lb"><label for="cmpnyTeamNm">팀</label></td>

												<td>
													<div id="cmpnyTeamNm" , name="cmpnyTeamNm">
														<c:out
															value="${fn:replace(resultVO.cmpnyTeamNm , crlf , '<br/>')}"
															escapeXml="false" />
													</div>
												</td>
											</tr>

											<tr>
												<td class="lb"><label for=cmpnyClsfNm>직급</label></td>

												<td>
													<div id="cmpnyClsfNm" , name="cmpnyClsfNm">
														<c:out
															value="${fn:replace(resultVO.cmpnyClsfNm , crlf , '<br/>')}"
															escapeXml="false" />
													</div>
												</td>
											</tr>
											
											<tr>
												<td class="lb"><label for="bkmkAt">즐겨찾기</label></td>

												<td>
													<div id="bkmkAt" , name="bkmkAt">
														<c:choose>
															<c:when test="${resultVO.bkmkAt == 'Y'}">
																즐겨찾기 등록
															</c:when>
															<c:when test="${resultVO.bkmkAt == 'N'}">
																즐겨찾기 미등록
															</c:when>
															<c:otherwise>
																<!-- 다른 값이 올 경우에 대한 처리 -->
																<c:out value="${resultVO.bkmkAt}" />
															</c:otherwise>
														</c:choose>
													</div>
												</td>
											</tr>
											
											<tr>
												<td class="lb"><label for=adbkCreatDt>작성날짜</label></td>

												<td>
													<div id="adbkCreatDt" , name="adbkCreatDt">
														<fmt:parseDate value="${resultVO.adbkCreatDt}" var="dateValue" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                		<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd"/>	
													</div>
												</td>
											</tr>

											

										</table>
									</div>

									<!-- 버튼 시작 -->
									<div class="board_view_bot">
									<c:if test="${(EgovUserDetailsHelper.getAuthenticatedUser().uniqId eq resultVO.adbkWrterId) || fn:contains(EgovUserDetailsHelper.getAuthorities(), 'ROLE_ADMIN')}">
										<div class="left_col btn3">
											<a href="javascript:void(0);"
												class="btn btn_skyblue_h46 w_100"
												onclick="selectAdrGMAUpdate();">수정</a> <a
												href="javascript:void(0);" class="btn btn_skyblue_h46 w_100"
												onclick="deleteAdrGMAAct();">삭제</a>
										</div>
										</c:if>

										<div class="right_col btn1">
											<a href="javascript:void(0);" class="btn btn_blue_46 w_100"
												onclick="selectAdrGMAList();">목록</a>
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

	<script>
	const GENDER_CODES = {
	SX001: "여성",
	SX002: "남성"
	};
												
	const sexdstnCode = "${resultVO.sexdstnCode}";
	const sexdstnCodeTd = document.getElementById("sexdstnCode");
	sexdstnCodeTd.textContent = GENDER_CODES[sexdstnCode];
	
</script>
</body>
</html>