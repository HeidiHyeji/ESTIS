<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Date.DateCalc, DAO.MissionDAO"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="missionReOne" class="Beans.MissionResultBean" scope="session" />
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/detail.css" />
<title><%=missionReOne.getTitle() %> 활동사진</title>
</head>
<body>
<jsp:include page="Top.jsp" flush="true" />
<% 
DateCalc d = new DateCalc();
MissionDAO dao = MissionDAO.getInstance();
%>
<div class="container">
   <h2><%=missionReOne.getTitle() %></h2>
   <div class="gallery">
       <%=missionReOne.getWriterid() %>
       <%=d.getDate(missionReOne.getDate()) %> 
       <label class="galleryHit">hit <%=missionReOne.getHit() %></label>
       <hr> 
   </div>   
   미션<label class="list"><%=dao.getMissionTitle(missionReOne.getMissionid()) %></label>
      <label class="list">
   <%if(!missionReOne.getImage().equals("/ESTIS/Estis/Img/null")&&missionReOne.getImage()!=null){%>
      <img src="<%=missionReOne.getImage() %>" width="100%"/>
   <%}else{
      out.print("등록된 사진이 없습니다.");
     }
   %>
   </label>
   활동내용<label class="list"> <%=missionReOne.getContent() %></label>
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