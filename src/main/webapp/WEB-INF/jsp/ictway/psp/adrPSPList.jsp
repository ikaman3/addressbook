<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
	function selectAdrPSPList(pageIndex){
		document.searchListForm.adbkSn.value = 0;
		document.searchListForm.pageIndex.value = pageIndex;
		document.searchListForm.action = "<c:url value='/ictway/psp/selectAdrPSPList.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 상세조회
	function selectAdrPSPDetail(adbkSn){
		document.searchListForm.adbkSn.value = adbkSn;
		document.searchListForm.action = "<c:url value='/ictway/psp/selectAdrPSPDetail.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 등록 화면
	function selectAdrPSPRegist(){
		document.searchListForm.adbkSn.value = 0;
		document.searchListForm.action = "<c:url value='/ictway/psp/selectAdrPSPRegist.do'/>";
		document.searchListForm.submit();
	}
</script>
<title>샘플 포털 > 주소록 > 현승민</title>

</head>
<body>
	<!-- wrap start -->
	<div id="wrap">
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
										<li><a href="<c:url value="/ictway/psp/selectAdrPSPList.do"/>">현승민</a></li>
										<li><a href="javascript:void(0);">주소록 목록</a></li>
									</ul>
								</div>
								<!--// Location -->

								<h1 class="tit_1">주소록</h1>
								<p class="txt_1">아이씨티웨이(주) 신입사원 대상 개발자 교육 샘플 주소록입니다.</p>
								<h2 class="tit_2">주소록 목록</h2>

								<!-- 검색조건 -->
								<div class="condition">
								
									<!-- 검색 form 시작 -->
									<form:form modelAttribute="searchVO" name="searchListForm" method="post">
										<form:hidden path="pageIndex"/>
										<input type="hidden" name="adbkSn">
										
										<label class="item f_select" for="searchCondition">
											<select name="searchCondition" id="searchCondition" title="검색조건 선택">
												<option value="0" <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if>>주소록 사용자 명칭</option>
												<option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>주소록 사용자 이메일</option>
											</select>
										</label>
										<span class="item f_search">
											<input class="f_input w_500" type="text" name="searchKeyword" value='<c:out value="${searchVO.searchKeyword}"/>' title="검색어 입력">
											<button class="btn" type="submit" onclick="selectAdrPSPList('1'); return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
										</span>
										<a href="javascript:void(0);" onclick="selectAdrPSPRegist();" class="item btn btn_blue_46 w_100"><spring:message code="button.create" /></a><!-- 등록 -->
									</form:form>
									<!-- 검색 form 끝 -->
								</div>
								<!--// 검색조건 -->

								<!-- 주소록 -->
								<div class="board_list">
									<table>
										<colgroup>
											<col style="width: 80px;">
											<col style="width: auto;">
											<col style="width: auto;">
											<col style="width: 100px;">
											<col style="width: 100px;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">번호</th>
												<th scope="col">주소록 사용자 명칭</th>
												<th scope="col">주소록 사용자 이메일</th>
												<th scope="col">등록자</th>
												<th scope="col">등록일</th>
												
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${resultList}" var="resultVO" varStatus="status">
											<tr>
												<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageUnit + status.count) }"/></td>
												<td class="al">
													<a href="javascript:void(0);" onclick="selectAdrPSPDetail('<c:out value="${resultVO.adbkSn}"/>'); return false;" class="lnk">
														<c:out value="${resultVO.userNm }" escapeXml="false"/>
													</a>
												</td>
												<td><c:out value="${resultVO.emailaddr}"></c:out></td>
												<td><c:out value="${resultVO.registUserNm}" /></td>
												<td><fmt:formatDate value="${resultVO.registDt }" pattern="yyyy-MM-dd"/></td>
											</tr>
										</c:forEach>
										<c:if test="${fn:length(resultList) == 0}">
											<tr>
												<td colspan="4"><spring:message code="common.nodata.msg" /></td>
                                        	</tr>
										</c:if>
										</tbody>
									</table>
								</div>

								<div class="board_list_bot">
									<div class="paging" id="paging_div">
										<ul>
											<ui:pagination paginationInfo="${paginationInfo}" type="renew" jsFunction="selectAdrPSPList" />
										</ul>
									</div>
								</div>
								<!--// 게시판 -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<c:import url="/sym/mms/EgovFooter.do" />

	</div>


</body>
</html>