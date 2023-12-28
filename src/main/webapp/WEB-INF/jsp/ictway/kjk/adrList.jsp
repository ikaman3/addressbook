<%--
  Class Name :
  Description :
  Modification Information

       수정일              수정자             수정내용
    ----------  ---------   ---------------------------
    2009.03.19  이삼섭             최초 생성
    2011.08.31  JJY         경량환경 버전 생성
    2021.08.12  신용호              신규 디자인 적용

    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.19
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images_old/egovframework/cop/bbs/" />

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

<!-- <link rel="stylesheet" href="<c:url value='/'/>css_old/default.css" type="text/css" > -->


<script type="text/javascript">
</script>

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
										<li><a class="home" href="">Home</a></li>
										<li><a href="">알림마당</a></li>
									</ul>
								</div>
								<!--// Location -->

								<h1 class="tit_1">알림마당</h1>

								<p class="txt_1">표준프레임워크센터에서 회원여러분들께 알려드리는 모든 소식을 모았습니다.</p>

								<h2 class="tit_2">
								</h2>

								<!-- 검색조건 -->
								<div class="condition">
								
									<form name="frm" action="" method="post">
									
									</form>
									
								</div>
								<!--// 검색조건 -->

								<!-- 게시판 -->
								<div class="board_list">
								</div>

								<div class="board_list_bot">
									<div class="paging" id="paging_div">
										<ul>
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