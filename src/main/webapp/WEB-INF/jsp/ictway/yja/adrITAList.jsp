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
	function selectAdrITAList(pageIndex){
		document.searchListForm.adbkSn.value = 0;
		document.searchListForm.pageIndex.value = pageIndex;
		document.searchListForm.action = "<c:url value='/ictway/yja/selectAdrITAList.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 상세조회
	function selectAdrITADetail(adbkSn){
		document.searchListForm.adbkSn.value = adbkSn;
		document.searchListForm.action = "<c:url value='/ictway/yja/selectAdrITADetail.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 등록 화면
	function selectAdrITARegist(){
		document.searchListForm.adbkSn.value = 0;
		document.searchListForm.action = "<c:url value='/ictway/yja/selectAdrITARegist.do'/>";
		document.searchListForm.submit();
	}
</script>
<title>샘플 포털 > 주소록 > 유지애</title>

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
										<li><a href="<c:url value="/ictway/yja/selectAdrITAList.do"/>">유지애</a></li>
										<li><a href="javascript:void(0);">주소록 목록</a></li>
									</ul>
								</div>
								<!--// Location -->

								<h1 class="tit_1">알려주소</h1>
								<p class="txt_1">주소록 목록 페이지 <br>이름을 클릭하면 상세 페이지로 이동합니다</p>
								<h2 class="tit_2">주소록 목록</h2>

								<!-- 검색조건 -->
								<div class="condition">
								
									<!-- 검색 form 시작 -->
									<form:form modelAttribute="searchVO" name="searchListForm" method="post">
										<form:hidden path="pageIndex"/>
 										<input type="hidden" name="adbkSn"> 
										
										<label class="item f_select" for="searchCondition">
											<select name="searchCondition" id="searchCondition" title="검색조건 선택">
												<option value="0" <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if>>이름</option>
												<option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>휴대폰번호</option>
												<option value="2" <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>그룹</option>
											</select>
										</label>
										<span class="item f_search">
											<input class="f_input w_500" type="text" name="searchKeyword" value='<c:out value="${searchVO.searchKeyword}"/>' title="검색어 입력">
											<button class="btn" type="submit" onclick="selectAdrITAList('1'); return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
										</span>
										<a href="javascript:void(0);" onclick="selectAdrITARegist();" class="item btn btn_blue_46 w_100"><spring:message code="button.create" /></a><!-- 등록 -->
									</form:form>
									<!-- 검색 form 끝 -->
								</div>
								<!--// 검색조건 -->

								<!-- 주소록 -->
								<div class="board_list">
									<table>
										<colgroup>
											<col style="width: 80px;">
											<col style="width: 80px;">
											<col style="width: 200px;">
											<col style="width: 100px;">
											<col style="width: 100px;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">번호</th>
												<th scope="col">이름</th>
												<th scope="col">휴대폰번호</th>
												<th scope="col">그룹</th>
												<th scope="col">등록일</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${resultList}" var="resultVO" varStatus="status">
											<tr>
												<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageUnit + status.count) }"/></td>
												<td>
													<a href="javascript:void(0);" onclick="selectAdrITADetail('<c:out value="${resultVO.adbkSn}"/>'); return false;" class="lnk">
														<c:out value="${resultVO.userNm}" escapeXml="false"/>
													</a>
												</td>
												<td><c:out value="${resultVO.moblphonNo}" /></td>
												<td><c:out value="${resultVO.groupNm}" /></td>
												<td><fmt:formatDate value="${resultVO.registDt}" pattern="yyyy-MM-dd"/></td>
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
											<ui:pagination paginationInfo="${paginationInfo}" type="renew" jsFunction="selectAdrITAList" />
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