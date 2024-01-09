<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper" %>
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
	function selectAdrPSPList(){
		document.searchListForm.action = "<c:url value='/ictway/psp/selectAdrPSPList.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 수정 화면
	function selectAdrPSPUpdate(adbkSn){
		document.searchListForm.adbkSn.value = adbkSn;
		document.searchListForm.action = "<c:url value='/ictway/psp/selectAdrPSPUpdate.do'/>";
		document.searchListForm.submit();
	}
	
	//주소록 정보 삭제
	function deleteAdrPSPAct(){
		if (confirm('<spring:message code="common.delete.msg" />')) {
    		const formElement = document.searchListForm;
        	const formData = new FormData(formElement);
        	
        	fetch("<c:url value='/ictway/psp/deleteAdrPSPAct.do'/>",{
    			method: "POST",
    			cache: "no-cache",
     			headers: {},
     			body: formData
        	})
        	.then(response => response.json())
        	.then(data => {
        		alert("<spring:message code="success.common.delete"/>");
        		location.href = "<c:url value='/ictway/psp/selectAdrPSPList.do'/>";
        	})
        	.catch(error => {
    			console.log(error);
    			alert("에러가 발생하였습니다.");
    		});
    	}
	}
	
	function registBkmkAdrPSPAct(){
		var usrId = '<c:out value = "${EgovUserDetailsHelper.getAuthenticatedUser().uniqId}"/>';
		var adbkSn = '<c:out value="${resultVO.adbkSn}"/>';
		
		
		
		fetch("<c:url value='/ictway/psp/registBkmkAdrPSPAct.do'/>",{
			method: "POST",
			cache: "no-cache",
 			headers: {},
 			body: formData
		}).catch(error => {
			console.log(error);
			alert("에러가 발생하였습니다.");
		});
	}
	
 	
	
	
</script>

<title>샘플 포털 > 주소록 > 현승민</title>

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
										<li><a href="<c:url value="/ictway/psp/selectAdrPSPList.do"/>">현승민</a></li>
										<li><a href="<c:url value="/ictway/psp/selectAdrPSPList.do"/>">주소록 목록</a></li>
										<li><a href="javascript:void(0);">주소록 상세</a></li>
                                    </ul>
                                </div>
                                <!--// Location -->
                                
                                <!-- 검색 form 시작 -->
								<form:form modelAttribute="searchVO" name="searchListForm" method="post">
									<form:hidden path="pageIndex"/>
									<form:hidden path="searchCondition"/>
									<form:hidden path="searchKeyword"/>
									
									<form:hidden path="adbkSn"/>
								</form:form>
								<!-- 검색 form 끝 -->

                              	<h1 class="tit_1">주소록</h1>
								<p class="txt_1">아이씨티웨이(주) 신입사원 대상 개발자 교육 샘플 주소록입니다.</p>
								<h2 class="tit_2">주소록 상세</h2>

                                <!-- 주소록 상세보기 -->
                                <div class="board_view">
                                    <div class="board_view_top">
                                        <div class="tit"><c:out value="${resultVO.userNm}" /></div>
                                        <div class="info">
                                            <dl>
                                                <dt>등록자</dt>
                                                <dd><c:out value="${resultVO.registUserNm}" /></dd>
                                            </dl>
                                            <dl>
                                                <dt>등록일</dt>
                                             
                                                
                                                <fmt:parseDate value ="${resultVO.registDt}" pattern = "yyyy-MM-dd" var = "date"/>
												<fmt:formatDate value="${date}" pattern="yyyy년 MM월 dd일"/>
                                            </dl>
                                            
                                            <dl>
                                                <dt>수정일</dt>
                                                
                                                <fmt:parseDate value ="${resultVO.updtDt}" pattern = "yyyy-MM-dd" var = "date"/>
												<fmt:formatDate value="${date}" pattern="yyyy년 MM월 dd일"/>

                                            </dl>
                                        </div>
                                    </div>
                                    
                                    <div class="board_view2">
                                    <table>
										<colgroup>
	                                    	<col style="width: 190px;">
	                                        <col style="width: auto;">
	                                    </colgroup>
	                                   
	                                   
	                                    <tr>
	                                    	<td class="lb">
	                                        	<label for="brthdy">생년월일</label>
	                                           	
	                                        </td>
	                                        
	                                        <td>
	                                        	<div id="brthdy", name="brthdy">
		                                    	<fmt:parseDate value ="${resultVO.brthdy}" pattern = "yyyyMMdd" var = "date"/>
												<fmt:formatDate value="${date}" pattern="yyyy-MM-dd"/>
		                                    	</div>
	                                        </td>
	                                    </tr>
	                                    
	                                    <tr>
	                                    	<td class="lb">
	                                        	<label for="sexdstnCode">성별</label>
	                                           	
	                                        </td>
	                                        
	                                        <td>
	                                        	<div id="sexdstnCode", name="sexdstnCode">
		                                    	<c:choose>
											        <c:when test="${resultVO.sexdstnCode == '0'}">
											            <c:out value="남자" escapeXml="false" />
											        </c:when>
											        <c:when test="${resultVO.sexdstnCode == '1'}">
											            <c:out value="여자" escapeXml="false" />
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
	                                    	<td class="lb">
	                                        	<label for="adres">주소</label>
	                                           	
	                                        </td>
	                                        
	                                        <td>
	                                        	<div id="adres", name="adres">
		                                    	<c:out value="${fn:replace(resultVO.adres , crlf , '<br/>')}" escapeXml="false" />
		                                    	</div>
	                                        </td>
	                                    </tr>
	                                    
	                                    <tr>
	                                    	<td class="lb">
	                                        	<label for="detailAdres">상세주소</label>
	                                           	
	                                        </td>
	                                        
	                                        <td>
	                                        	<div id=detailAdres, name="detailAdres">
		                                    	<c:out value="${fn:replace(resultVO.detailAdres , crlf , '<br/>')}" escapeXml="false" />
		                                    	</div>
	                                        </td>
	                                    </tr>
	                                    
	                                    <tr>
	                                    	<td class="lb">
	                                        	<label for="moblphonNo">휴대전화 번호</label>
	                                           	
	                                        </td>
	                                        
	                                        <td>
	                                        	<div id="moblphonNo", name="moblphonNo">
		                                    	
		                                    	</div>
	                                        </td>
	                                    </tr>
	                                    
	                                    <tr>
	                                    	<td class="lb">
	                                        	<label for="emailaddr">이메일</label>
	                                           	
	                                        </td>
	                                        
	                                        <td>
	                                        	<div id="emailaddr", name="emailaddr">
		                                    	<c:out value="${fn:replace(resultVO.emailaddr , crlf , '<br/>')}" escapeXml="false" />
		                                    	</div>
	                                        </td>
	                                    </tr>
	                                    
	                                    <tr>
	                                    	<td class="lb">
	                                        	<label for="memo">메모</label>
	                                           	
	                                        </td>
	                                        
	                                        <td>
	                                        	<div id="memo", name="memo">
	                                    			<c:out value="${fn:replace(resultVO.memo , crlf , '<br/>')}" escapeXml="false" />
		                                    	</div>
	                                        </td>
	                                    </tr>
	                                    
	                                    <tr>
	                                    	<td class="lb">
	                                        	<label for="cmpnyNm">회사명칭</label>
	                                           	
	                                        </td>
	                                        
	                                        <td>
	                                        	<div id="cmpnyNm", name=cmpnyNm>
		                                    	<c:out value="${fn:replace(resultVO.cmpnyNm , crlf , '<br/>')}" escapeXml="false" />
		                                    	</div>
	                                        </td>
	                                    </tr>
	                                    
	                                    <tr>
	                                    	<td class="lb">
	                                        	<label for="deptNm">부서명칭</label>
	                                           	
	                                        </td>
	                                        
	                                        <td>
	                                        	<div id="deptNm", name="deptNm">
		                                    	<c:out value="${fn:replace(resultVO.deptNm , crlf , '<br/>')}" escapeXml="false" />
		                                    	</div>
	                                        </td>
	                                    </tr>
	                                    
	                                    <tr>
	                                    	<td class="lb">
	                                        	<label for="clsfNm">직급명칭</label>
	                                           	
	                                        </td>
	                                        
	                                        <td>
	                                        	<div id="clsfNm", name="clsfNm">
		                                    	<c:out value="${fn:replace(resultVO.clsfNm , crlf , '<br/>')}" escapeXml="false" />
		                                    	</div>
	                                        </td>
	                                    </tr>
	                                    
	                                    <tr>
	                                    	<td class="lb">
	                                        	<label for="photo">사진</label>
	                                           	
	                                        </td>
	                                        
	                                        <td>
	                                        	<div id="photo", name="photo">
		                                    	<img src='<c:url value='/ictway/psp/getImage.do'/>?adbkSn=<c:out value="${resultVO.adbkSn}"/>' alt="파일보기링크" style="width:500px; height:300px" />
		                                    	</div>
	                                        </td>
	                                    </tr>
                                    
                                    </table>
                                    </div>
									<!-- 버튼 시작 -->
                                    <div class="board_view_bot">
                                        <div class="left_col btn3">
                                            <c:if test="${(EgovUserDetailsHelper.getAuthenticatedUser().uniqId eq resultVO.usrId) || fn:contains(EgovUserDetailsHelper.getAuthorities(), 'ROLE_ADMIN')}">
                                        
                                            	<a href="javascript:void(0);" class="btn btn_skyblue_h46 w_100" onclick="selectAdrPSPUpdate('<c:out value="${resultVO.adbkSn}"/>'); return false;">수정</a>
                                            	<a href="javascript:void(0);" class="btn btn_skyblue_h46 w_100" onclick="deleteAdrPSPAct();">삭제</a>
                                           	</c:if>
                                           	<a href="javascript:void(0);" class="btn btn_skyblue_h46 w_100" onclick="registBkmkAdrPSPAct();">즐겨찾기</a> 	
                                        </div>

                                        <div class="right_col btn1">
                                            <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="selectAdrPSPList();">목록</a>
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
	function phoneFormatter() {
			const num = "<c:out value="${resultVO.moblphonNo}"/>";
			var formatNum = '';
			try{
				if (num.length == 11) {
					formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
				} else if (num.length == 8) {
					formatNum = num.replace(/(\d{4})(\d{4})/, '$1-$2');
				} else {
					if (num.indexOf('02') == 0) {
						formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
					} else {
						formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
					}
				}
			} catch(e) {
				formatNum = num;
			}
			
			document.getElementById("moblphonNo").innerHTML= formatNum;
	
		} 
	 	
	 	
		
		phoneFormatter();
	
	</script>
</html>