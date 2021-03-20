<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Beans.MissionBean"%>
<%@ page import="Date.DateCalc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css"
	href="/ESTIS/Estis/Css/adminmission.css" />
	<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<title>Insert title here</title>
</head>
<body>
	<!--메뉴-->
	<jsp:include page="Admin_Top.jsp" flush="true" />
	<!--내용-->
	<div class="missiontitle">
		<b>외친소 Mission Managemet</b>
		<hr class="titleline">
	</div>
	<br>
	<div class="title">
		<br> <i class="fa fa-chevron-circle-right fa-lg"
			aria-hidden="true" style="color: #687672 !important;"></i>
		<n>미션 세부사항</n><br><br>
		<div style="margin-left:10px">우측의 신청현황을 클릭시, 해당 미션의 Exchange Student 등록 페이지로 이동합니다.<br>
		Exchange Student 등록 후, 외친소 매칭을 진행해주십시오.</div>
	</div>
	
	<div class="detail_mLpeople">
		<i class="fa fa-smile-o" aria-hidden="true" style="background-color: yellow !important;"></i>
		<ml>신청현황</ml>
	</div>
	<br>
	<div class="detail_mission">
		<%
			MissionBean missionOne = (MissionBean) request.getAttribute("mission");
		%>
		<div class="container">
			<h2><%=missionOne.getTitle()%></h2>
			<%
				DateCalc d = new DateCalc();
				String result = d.dateCalc(missionOne.getApplystart(), missionOne.getApplyend(),
						missionOne.getPerformstart(), missionOne.getPerformend(), missionOne.getResultdate());
			%>
			<%=result%>인 미션입니다.<br> <br>
			<%
				if (result.equals("모집중")) {
			%>
			신청기간<label class="list"> <%=missionOne.getApplystart()%> ~ <%=missionOne.getApplyend()%></label>
			<%
				}
				if (result.equals("모집중") || result.equals("선별중") || result.equals("활동중") || result.equals("모집완료")) {
			%>
			활동기간<label class="list"> <%=missionOne.getPerformstart()%> ~
				<%=missionOne.getPerformend()%></label>
			<%
				}
				if (result.equals("모집중") || result.equals("선별중")) {
			%>
			결과발표<label class="list" style="color: red;"> <%=missionOne.getResultdate()%></label>
			<%
				}
			%>
			활동내용<label class="list"> <%=missionOne.getContent()%></label>
		</div>
	</div>
   <%if (result.equals("선별중")) {%>
   <div class="detail_ks" style="cursor: pointer;" 
      onclick="location.href='/ESTIS/Estis/Admin_missionMember.jsp?missionid=<%=missionOne.getMissionid()%>&imffkscnt=<%=request.getAttribute("imffkscnt")%>&imfffscnt=<%=request.getAttribute("imfffscnt")%>'" 
      title="클릭 시, 해당 미션 신청자 관리 페이지로 이동합니다.">
   <%}else if(result.equals("모집중")||result.equals("모집완료")||result.equals("모집예정")){ %>
   <div class="detail_ks"
      title="클릭 시, 해당 미션 팀 현황 페이지로 이동합니다.">
   <%}else{ %>
   <div class="detail_ks" style="cursor: pointer;" 
      onclick="location.href='/ESTIS/AdminIMFFMatchingController?missionid=<%=missionOne.getMissionid()%>&matching=complete'"
      title="클릭 시, 해당 미션 팀 현황 페이지로 이동합니다.">
   <%} %>
		한국인 학생:&nbsp<%=request.getAttribute("imffkscnt")%>&nbsp명
		<div class="detail_fs">외국인 학생:&nbsp<%=request.getAttribute("imfffscnt")%>&nbsp명</div>
	</div>

	<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>