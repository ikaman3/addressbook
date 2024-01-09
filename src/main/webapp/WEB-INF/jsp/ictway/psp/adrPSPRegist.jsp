<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- 
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
 --%>
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
	<script src="<c:url value='/'/>js/jquery.js"></script>
	<script src="<c:url value='/'/>js/jqueryui.js"></script>
	<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">

<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>" ></script>
<%--
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
--%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
    
	//주소록 목록조회
	function selectAdrPSPList(){
		document.searchListForm.action = "<c:url value='/ictway/psp/selectAdrPSPList.do'/>";
		document.searchListForm.submit();
	}
	
	
	//주소록 등록
	function registAdrPSPAct() {
		
		var form = registForm;
			/* alert("사용자 함수를 호출함"); */
		if (form.userNm.value == "")
		{
			alert("아이디를 입력하여 주시기 바랍니다.");
			document.getElementById("userNm").focus();
			return false;
		}
			
		if (form.year.value == "")
		{
			alert("생년을 입력하여 주시기 바랍니다.");
			document.getElementById("year").focus();
			return false;
		}
		
		if (form.month.value == "")
		{
			alert("월을 입력하여 주시기 바랍니다.");
			document.getElementById("month").focus();
			return false;
		}
		
		if (form.day.value == "")
		{
			alert("일을 입력하여 주시기 바랍니다.");
			document.getElementById("day").focus();
			return false;
		}
		
		if (form.sexdstnCode.value == "")
		{
			alert("성별을 입력하여 주시기 바랍니다.");
			return false;
		}
		
		if (form.adres.value == "")
		{
			alert("주소를 입력하여 주시기 바랍니다.");
			return false;
		}
		
		const phoneNumberPattern = /^010\d{8}$/;

		
		  if(!phoneNumberPattern.test(form.moblphonNo.value))    {    
			    alert('핸드폰 번호 형식을 확인 해주세요');    
				document.getElementById("moblphonNo").focus();  
			  return false;   
		}  

		
		if (form.moblphonNo.value == "")
		{
			alert("휴대전화를를 입력하여 주시기 바랍니다.");
			document.getElementById("moblphonNo").focus();
			return false;
		}
		
		
		var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

		if(emailaddr.length < 6 || !regExpEmail.test(form.emailaddr.value))    {       
			alert('메일형식을 확인 해주세요.')        
			document.getElementById("emailaddr").focus();

			return false;    
			}  

		
		
		if (form.emailaddr.value == "")
		{
			alert("이메일을 입력하여 주시기 바랍니다.");
			document.getElementById("emailaddr").focus();
			return false;
		}
		
		
		
		
		if (form.cmpnyNm.value == "")
		{
			alert("회사명칭을 입력하여 주시기 바랍니다.");
			document.getElementById("cmpnyNm").focus();
			return false;
		}
		
		if (form.deptNm.value == "")
		{
			alert("부서명칭을 입력하여 주시기 바랍니다.");
			document.getElementById("deptNm").focus();
			return false;
		}
		
		if (form.clsfNm.value == "")
		{
			alert("직급명칭을 입력하여 주시기 바랍니다.");
			document.getElementById("clsfNm").focus();
			return false;
		}
		
		
		
    	if (confirm('<spring:message code="common.regist.msg" />')) {
    		const formElement = document.registForm;
        	const formData = new FormData(formElement);
        	
        	 // 년/월/일 값 가져오기
            const year = document.getElementById("year").value;
            const month = document.getElementById("month").value;
            const day = document.getElementById("day").value
            
            
        	const brthdy =  year + month + day;
        	
            formData.append("brthdy", brthdy);
            
        	fetch("<c:url value='/ictway/psp/registAdrPSPAct.do'/>",{
    			method: "POST",
    			cache: "no-cache",
     			headers: {},
     			body: formData
        	})
        	.then(response => response.json())
        	.then(data => {
        		alert("<spring:message code="success.common.insert"/>");
        		location.href = "<c:url value='/ictway/psp/selectAdrPSPList.do'/>";
        	})
        	.catch(error => {
    			console.log(error);
    			alert("에러가 발생하였습니다.");
    		});
    	}
    }
	
	function sample6_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수

	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }

	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                document.getElementById("sample6_extraAddress").value = extraAddr;
	            
	            } else {
	                document.getElementById("sample6_extraAddress").value = '';
	            }

	            adres = addr + extraAddr;
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('sample6_postcode').value = data.zonecode;
	            document.getElementById("adres").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("detailAdres").focus();
	            
	        }
	    }).open();
	}
	
	
</script>



<title>샘플 포털 > 주소록 > 현승민</title>

<style type="text/css">
.ui-datepicker-trigger {
	margin-left: 10px;
	vertical-align: middle;
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
										<li><a href="<c:url value="/ictway/psp/selectAdrPSPList.do"/>">현승민</a></li>
										<li><a href="<c:url value="/ictway/psp/selectAdrPSPList.do"/>">주소록 목록</a></li>
										<li><a href="javascript:void(0);">주소록 등록</a></li>
									</ul>
                                </div>
                                <!--// Location -->
                                
                                <!-- 검색 form 시작 -->
								<form:form modelAttribute="searchVO" name="searchListForm" method="post">
									<form:hidden path="pageIndex"/>
									<form:hidden path="searchCondition"/>
									<form:hidden path="searchKeyword"/>
								</form:form>
								<!-- 검색 form 끝 -->

								<form name="registForm" method="post" enctype="multipart/form-data" >
									<input type="hidden" name="posblAtchFileNumber" value="1" />
									<input type="hidden" name="photoCours" value="Globals.fileStorePath"/>
									
	                                <h1 class="tit_1">주소록</h1>
									<p class="txt_1">아이씨티웨이(주) 신입사원 대상 개발자 교육 샘플 주소록입니다.</p>
									<h2 class="tit_2">주소록 등록</h2>

	                                <div class="board_view2">
	                                    <table>
	                                        <colgroup>
	                                            <col style="width: 190px;">
	                                            <col style="width: auto;">
	                                        </colgroup>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="userNm">이름</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input id="userNm" name="userNm" type="text" size="60" value=""  maxlength="60" class="f_txt w_full">
	                                                <br/><form:errors path="userNm" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="brthdy">생년월일</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <select id="year" name="year" class="form-control" style="width:100px; height:30px" class="f_txt w_full">
													  <option value="">년</option>
													  <c:forEach var="i" begin="1924" end="2024">
													    <option value="${i}">${i}</option>
													  </c:forEach>
													</select>
													  
													<select id="month" name="month" class="form-control" style="width:100px; height:30px" class="f_txt w_full">
													  <option value="">월</option>
													  <c:forEach var="i" begin="1" end="12">
													  <c:choose>
													      <c:when test="${i lt 10 }">
													          <option value="0${i}">0${i}</option>
													      </c:when>
													      <c:otherwise>
													          <option value="${i}">${i}</option>
													      </c:otherwise>
													  </c:choose>
													  </c:forEach>
													</select>
													  
													<select id="day" name="day" class="form-control" style="width:100px; height:30px" class="f_txt w_full">
													  <option value="">일</option>
													  <c:forEach var="i" begin="1" end="31">
													  <c:choose>
													      <c:when test="${i lt 10 }">
													          <option value="0${i}">0${i}</option>
													      </c:when>
													      <c:otherwise>
													          <option value="${i}">${i}</option>
													      </c:otherwise>
													  </c:choose>
													  </c:forEach>
													</select>
	                                            </td>
	                                        </tr>
	                                        
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="sexdstnCode">성별</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                            
	                                            	
	                                            	<label><input type='radio' name='sexdstnCode' value='0'/>남성</label>
	                                            	
	                                     
                                                	<label><input type='radio' name='sexdstnCode' value='1'style= "margin-left:20px"/>여성</label>
	                                               
	                                                <form:errors path="sexdstnCode" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                            	
	                                                <label for="adres">주소</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                              	<input type="hidden" id="sample6_postcode" placeholder="우편번호" style="width:100px; height:30px; margin-bottom:30px;">
												    <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" style="margin-bottom : 20px"><br>
												    <input type="text" id="adres" name="adres" placeholder="주소" style="width:400px; height:30px; margin-bottom:30px;" readonly><br>
		
												    <input type="text" id="detailAdres" name="detailAdres" placeholder="상세주소" style="width:100px; height:30px" class="f_txt w_full">
												    <input type="hidden" id="sample6_extraAddress" placeholder="참고항목" style="width:100px; height:30px">
	                                                <form:errors path="adres" />
	                                            </td>
	                                        </tr>

	                                        <tr>
	                                            <td class="lb">
	                                                <label for="moblphonNo">휴대폰번호</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input type="text" id="moblphonNo" name="moblphonNo" pattern="[0-9]{11}" title="11자리 숫자만 입력하세요" maxlength="11" class="f_txt w_full" required placeholder="ex) 01011112222">
	                                                <form:errors path="moblphonNo" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="emailaddr">이메일</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input type="text" id="emailaddr" name="emailaddr" class="f_txt w_full" placeholder="ex) abcd1234@gmail.com" >
	                                                <form:errors path="emailaddr" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="memo">메모</label>
	                                            </td>
	                                            <td>
	                                                <textarea id="memo" name="memo" class="textarea f_txtar w_full h_200" cols="30" rows="10" ></textarea>
	                                                <form:errors path="memo" />
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="cmpnyNm">회사 명칭</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input type="text" id="cmpnyNm" name="cmpnyNm" class="f_txt w_full" >
	                                                <form:errors path="cmpnyNm" />
	                                            </td>
	                                        </tr>
	                                        
	                                         <tr>
	                                            <td class="lb">
	                                                <label for="deptNm">부서 명칭</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input type="text" id="deptNm" name="deptNm" class="f_txt w_full" >
	                                                <form:errors path="deptNm" />
	                                            </td>
	                                        </tr>
	                                        
	                                         <tr>
	                                            <td class="lb">
	                                                <label for="clsfNm">직급 명칭</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <input type="text" id="clsfNm" name="clsfNm" class="f_txt w_full" >
	                                                <form:errors path="clsfNm" />
	                                            </td>
	                                        </tr>
	                                        
	                                         <tr>
	                                            <td class="lb">
	                                                <label for="photo">사진 첨부</label>
	                                            </td>
													<td><input name="photoNmTest" id="egovComFileUploader" type="file" />
														<div id="egovComFileList"></div>
													
													</td>
	                                        </tr>
	                                    </table>
	                                 
	                                </div>

	                                <div class="board_view_bot">
	                                    <div class="left_col btn3">
	                                    </div>
	
	                                    <div class="right_col btn1">
	                                        <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="registAdrPSPAct();"><spring:message code="button.save" /></a>
	                                        <a href="javascript:void(0);" class="btn btn_blue_46 w_100" onclick="selectAdrPSPList();"><spring:message code="button.list" /></a>
	                                    </div>
	                                </div>
	                                
	                                <!--// 주소록 -->
                                
                                </form>
                                
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