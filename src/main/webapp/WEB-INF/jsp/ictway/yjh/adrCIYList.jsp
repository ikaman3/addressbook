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
	function selectAdrCIYList(pageIndex){
		document.searchListForm.adbkId.value = "";
		document.searchListForm.pageIndex.value = pageIndex;
		document.searchListForm.action = "<c:url value='/ictway/yjh/selectAdrCIYList.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 상세조회
	function selectAdrDetail(adbkId){
		document.searchListForm.adbkId.value = adbkId;
		document.searchListForm.action = "<c:url value='/ictway/yjh/selectAdrCIYDetail.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 등록 화면
	function selectAdrCIYRegist(){
		document.searchListForm.adbkId.value = "";
		document.searchListForm.action = "<c:url value='/ictway/yjh/selectAdrCIYRegist.do'/>";
		document.searchListForm.submit();
	}
	
	function setSearchCondition(condition) {
		document.searchListForm.elements["searchVO.searchCondition"].value = condition;
	    selectAdrCIYList('1');
	}
	

	
</script>
<title>샘플 포털 > 주소록 > 윤준현</title>

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
										<li><a href="<c:url value="/ictway/yjh/selectAdrCIYList.do"/>">윤준현</a></li>
										<li><a href="javascript:void(0);">주소록 목록</a></li>
									</ul>
								</div>
								<!--// Location -->

								<h1 class="tit_1">주소록</h1>
								<p class="txt_1">Contact ICTWAY</p>
								<h2 class="tit_2">주소록 목록</h2>

								<!-- 검색조건 -->
								<div class="condition">
								
									<!-- 검색 form 시작 -->
									<form:form modelAttribute="searchVO" name="searchListForm" method="post">
										<form:hidden path="pageIndex"/>
										<input type="hidden" name="adbkId">
										
										<label class="item f_select" for="searchCondition">
											<select name="searchCondition" id="searchCondition" title="검색조건 선택">
												<option value="0" <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if>>이름</option>
												<option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>휴대폰번호</option>
												<option value="2" <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>그룹</option>
												<option value="3" <c:if test="${searchVO.searchCondition == '3'}">selected="selected"</c:if>>회사</option>
												<option value="4" <c:if test="${searchVO.searchCondition == '4'}">selected="selected"</c:if>>즐겨찾기</option>
											</select>
										</label>
										<span class="item f_search">
											<input class="f_input w_500" type="text" name="searchKeyword" value='<c:out value="${searchVO.searchKeyword}"/>' title="검색어 입력">
											<button class="btn" type="submit" onclick="selectAdrCIYList('1'); return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
										</span>
										<a href="javascript:void(0);" onclick="selectAdrCIYRegist();" class="item btn btn_blue_46 w_100"><spring:message code="button.create" /></a><!-- 등록 -->
									</form:form>
									<!-- 검색 form 끝 -->
								</div>
								<!--// 검색조건 -->
								<div class="board_list">
									<table>
										<colgroup>
											<col style="width: 100px;">
											<col style="width: auto;">
											<col style="width: auto;">
											<col style="width: auto;">
											<col style="width: auto;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">번호</th>
												<th scope="col">이름</th>
												<th scope="col">휴대폰 번호</th>
												<th scope="col">그룹</th>
												<th scope="col">회사</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${resultList}" var="resultVO" varStatus="status">
											<tr>
												<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageUnit + status.count) }"/></td>
												<td class="al">
													<a href="javascript:void(0);" onclick="selectAdrDetail('<c:out value="${resultVO.adbkId}"/>'); return false;" class="lnk">
														<c:out value="${resultVO.userNm }" escapeXml="false"/>
													</a>
												</td>
												<td><c:out value="${resultVO.mbtlnum}" /></td>
												<c:if test="${resultVO.adresGroupCode == ''}"><td></td></c:if>
												<c:if test="${resultVO.adresGroupCode == 'GR001'}"><td>가족</td></c:if>
												<c:if test="${resultVO.adresGroupCode == 'GR002'}"><td>친구</td></c:if>
												<c:if test="${resultVO.adresGroupCode == 'GR003'}"><td>현 직장</td></c:if>
												<c:if test="${resultVO.adresGroupCode == 'GR004'}"><td>구 직장</td></c:if>
												<c:if test="${resultVO.adresGroupCode == 'GR005'}"><td>동호회</td></c:if>
												<c:if test="${resultVO.adresGroupCode == 'GR006'}"><td>기타</td></c:if>
												<td><c:out value="${resultVO.cmpnyNm}" /></td>
											</tr>
										</c:forEach>
										<c:if test="${fn:length(resultList) == 0}">
											<tr>
												<td colspan="5"><spring:message code="common.nodata.msg" /></td>
                                        	</tr>
										</c:if>
										</tbody>
									</table>
								</div>

								<div class="board_list_bot">
									<div class="paging" id="paging_div">
										<ul>
											<ui:pagination paginationInfo="${paginationInfo}" type="renew" jsFunction="selectAdrCIYList" />
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