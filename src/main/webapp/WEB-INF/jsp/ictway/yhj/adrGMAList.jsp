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
	function selectAdrGMAList(pageIndex){
		document.searchListForm.adbkId.value = "";
		document.searchListForm.pageIndex.value = pageIndex;
		document.searchListForm.action = "<c:url value='/ictway/yhj/selectAdrGMAList.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 상세조회
	function selectAdrGMADetail(adbkId){
		document.searchListForm.adbkId.value = adbkId;
		document.searchListForm.action = "<c:url value='/ictway/yhj/selectAdrGMADetail.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 등록 화면
	function selectAdrGMARegist(){
		document.searchListForm.adbkId.value = "";
		document.searchListForm.action = "<c:url value='/ictway/yhj/selectAdrGMARegist.do'/>";
		document.searchListForm.submit();
	}
</script>
<title>샘플 포털 > 주소록 > 염혜정</title>

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
										<li><a href="<c:url value="/ictway/yhj/selectAdrGMAList.do"/>">염혜정</a></li>
										<li><a href="javascript:void(0);">주소록 목록</a></li>
									</ul>
								</div>
								<!--// Location -->

								<h1 class="tit_1">주소록</h1>
								<p class="txt_1">염혜정 - 주소록 목록을 조회할 수 있는 페이지입니다.</p>
								<h2 class="tit_2">주소록 목록</h2>

								<!-- 검색조건 -->
								<div class="condition">
								
									<!-- 검색 form 시작 -->
									<form:form modelAttribute="searchVO" name="searchListForm" method="post">
										<form:hidden path="pageIndex"/>
										<input type="hidden" name="adbkId">
										
										<label class="item f_select" for="searchCondition">
											<select name="searchCondition" id="searchCondition" title="검색조건 선택">
												<option value="0" <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if>>사용자 이름</option>
												<option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>이메일</option>
												<option value="2" <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>즐겨찾기</option>
											</select>
										</label>
										<span class="item f_search">
											<input class="f_input w_500" type="text" name="searchKeyword" value='<c:out value="${searchVO.searchKeyword}"/>' title="검색어 입력">
											<button class="btn" type="submit" onclick="selectAdrGMAList('1'); return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
										</span>
										<a href="javascript:void(0);" onclick="selectAdrGMARegist();" class="item btn btn_blue_46 w_100"><spring:message code="button.create" /></a><!-- 등록 -->
									</form:form>
									<!-- 검색 form 끝 -->
								</div>
								<!--// 검색조건 -->

								<!-- 주소록 -->
								<div class="board_list">
									<table>
										<colgroup>
											<col style="width: 80px;">
											<col style="width: 200px;">
											<col style="width: 220px;">
											<col style="width: 250px;">
											<col style="width: auto;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">번호</th>
												<th scope="col">사용자 이름</th>
												<th scope="col">이메일</th>
												<th scope="col">휴대폰번호</th>
												<th scope="col">등록일</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${resultList}" var="resultVO" varStatus="status">
											<tr>
												<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageUnit + status.count) }"/></td>
												<td style="text-align: center;" class="al">
													<a href="javascript:void(0);" onclick="selectAdrGMADetail('<c:out value="${resultVO.adbkId}"/>'); return false;" class="lnk">
														<c:out value="${resultVO.userNm }" escapeXml="false"/>
													</a>
												</td>
												<td style="text-align: center;" class="al">
													<c:out value="${resultVO.emailaddr }" escapeXml="false"/>
												</td>
												<td style="text-align: center;" class="al">
													<c:out value="${resultVO.mbtlnum }" escapeXml="false"/>
												</td>
												<td style="text-align: center;" class="al">
													<fmt:parseDate value="${resultVO.adbkCreatDt}" var="dateValue" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                	<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd"/>
												</td>
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
											<ui:pagination paginationInfo="${paginationInfo}" type="renew" jsFunction="selectAdrGMAList" />
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