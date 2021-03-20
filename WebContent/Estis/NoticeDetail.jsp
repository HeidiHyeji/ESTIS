<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Beans.MissionBean, Date.DateCalc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="noticeOne" class="Beans.NoticeBean" scope="session" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/detail.css" />
</head>
<body>
<jsp:include page="Top.jsp" flush="true" />
<!--공지사항 상세 페이지-->
<% 
DateCalc d = new DateCalc();
%>
<div class="container">
   <h2><%=noticeOne.getTitle() %></h2>
   <div class="gallery">
      <%=noticeOne.getHeader() %> 
       <%=noticeOne.getWriterid() %>
       <%=d.getDate(noticeOne.getDate()) %>    
       <label class="galleryHit">hit <%=noticeOne.getHit() %></label>
       <hr> 
   </div>   
   <label class="list">
   <%if(!noticeOne.getImage().equals("/ESTIS/Estis/Img/null")&&noticeOne.getImage()!=null){%>
      <img src="<%=noticeOne.getImage() %>" width="100%"/>
   <%}else{
      out.print("등록된 사진이 없습니다.");
     }
   %>
   </label>
   <label class="list"> <%=noticeOne.getContent() %></label>
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