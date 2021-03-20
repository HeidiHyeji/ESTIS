<%@ page language="java" contentType="text/html; charset=UTF-8" 
   pageEncoding="UTF-8" import="Beans.MissionBean, Date.DateCalc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="missionone" class="Beans.MissionBean" scope="request" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/missionDetail.css" />
</head>
<body>
<jsp:include page="Top.jsp" flush="true" />
<%
   MissionBean missionOne = (MissionBean)missionone;
%>
<div class="container">
   <h2><%=missionOne.getTitle() %></h2>
   <% DateCalc d = new DateCalc(); 
       String result = d.dateCalc(missionOne.getApplystart(),missionOne.getApplyend(),
            missionOne.getPerformstart(), missionOne.getPerformend(),missionOne.getResultdate());%>
    <%=result %>인 미션입니다.<br><br>
    <%if(result.equals("모집중")){%>
   신청기간<label class="list"> <%=missionOne.getApplystart() %> ~ <%=missionOne.getApplyend() %></label>
   <%}if(result.equals("모집중") || result.equals("선별중") || result.equals("활동중") || result.equals("모집완료")){ %>
   활동기간<label class="list"> <%=missionOne.getPerformstart() %> ~ <%=missionOne.getPerformend() %></label>
   <%}if(result.equals("모집중") || result.equals("선별중")){ %>
   결과발표<label class="list" style="color: red;"> <%=missionOne.getResultdate() %></label>
   <%}%>
   활동내용<label class="list"> <%=missionOne.getContent() %></label>
</div>

<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>