<%@ page language="java" contentType="text/html; charset=UTF-8" 
   pageEncoding="UTF-8" import="Beans.MissionBean, Date.DateCalc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="missionone" class="Beans.MissionBean" scope="request" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/detail.css" />
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
    <%if(result.equals("모집중") || result.equals("모집예정")){%>
   신청기간<label class="list"> <%=d.getDate(missionOne.getApplystart()) %> ~ <%=d.getDate(missionOne.getApplyend()) %></label>
   <%}if(result.equals("모집중") || result.equals("선별중") || result.equals("활동중") || result.equals("모집완료") || result.equals("모집예정")){ %>
   활동기간<label class="list"> <%=d.getDate(missionOne.getPerformstart()) %> ~ <%=d.getDate(missionOne.getPerformend()) %></label>
   <%}if(result.equals("모집중") || result.equals("선별중") || result.equals("모집예정")){ %>
   결과발표<label class="list" style="color: red;"> <%=missionOne.getResultdate() %></label>
   <%}%>
   <label class="list">
   <%if(!missionOne.getImage().equals("/ESTIS/Estis/Img/null") && missionOne.getImage()!=null){%>
      <img src="<%=missionOne.getImage() %>" width="100%"/>
   <%}else{
      out.print("등록된 사진이 없습니다.");
     }
   %>
   </label>
   활동내용<label class="list"> <%=missionOne.getContent() %></label>
   
<div class="clearfix">   
   <!-- <form action="#"> -->
   <button type="submit" class="deleteBtn">Delete</button>
   <!-- <input type="hidden" name="action" value="missionDelete">
   </form>
   <form action="#"> -->
   <button type="submit" class="modifyBtn">Modify</button>
   <!-- <input type="hidden" name="action" value="missionModify">
   </form> -->
   <button type="button" class="cancelBtn" onclick="history.go(-1)">Cancel</button>
</div>
</div>

<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>