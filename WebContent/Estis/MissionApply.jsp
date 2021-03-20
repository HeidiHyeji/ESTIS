<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="Beans.MissionBean, Date.DateCalc"%>
   <jsp:useBean id="userinfo" class="Beans.WriterBean" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:useBean id="missionone" class="Beans.MissionBean" scope="request" />
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/missionApply.css" />
</head>
<body>
<jsp:include page="Top.jsp" flush="true" />
   
<form action="/ESTIS/MissionController" method="post" style="border: 1px solid #ccc">
   <div class="container">
      <% MissionBean missionOne = (MissionBean)missionone; 
         DateCalc current = new DateCalc();%>
      <h2><%=missionOne.getTitle() %></h2>
      활동기간<label class="list">
      <%=missionOne.getPerformstart()%>~<%=missionOne.getPerformend() %></label>
      결과발표<label class="list"><%=missionOne.getResultdate() %></label>
      언어
      <select id="language" name="language">
         <option value="english">English</option>
         <option value="chinese">Chinese</option>
      </select>
      동행신청
      <input type="text" placeholder="동행자 ID입력" name="party">
      지원동기
      <textarea id="reason" name="reason" placeholder="지원동기 입력" style="height: 200px" required></textarea>
      <input type="hidden" name="missionid" id="missionid" value="<%=missionOne.getMissionid()%>">
      <input type="hidden" name="ksid" id="ksid" value="<%=userinfo.getWriterid()%>">
      <input type="hidden" name="applydate" id="applydate" value="<%=current.getCurrentDate()%>">
      <input type="hidden" name="state" value="신청" >
      <div class="clearfix">
         <button type="button" class="cancelBtn" onclick="history.go(-1)">Cancel</button>
         <button type="submit" class="applyBtn">Apply</button>
         <input type="hidden" name="action" value="missionApply2">
      </div>
   </div>
</form>
<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>