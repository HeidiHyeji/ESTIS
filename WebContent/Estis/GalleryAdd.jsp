<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Date.DateCalc, Beans.MissionBean"%>
<jsp:useBean id="userinfo" class="Beans.WriterBean" scope="session" />
<jsp:useBean id="missionall" class="java.util.ArrayList" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/add.css" />
<title>미션 결과 등록</title>
</head>
<body>
<jsp:include page="Top.jsp" flush="true" />   
<h3>♥미션 결과 등록하기♥</h3>

<form action="/ESTIS/ImageController" enctype="multipart/form-data" method="post" style="border:1px solid #ccc">   
<input type="hidden" name="writerid" value="<%=userinfo.getWriterid() %>" >
<%DateCalc current = new DateCalc(); %>
<input type="hidden" name="date" value="<%=current.getCurrentDate()%>">
<input type="hidden" name="hit" value="0">
<input type="hidden" name="action" value="galleryAdd">
<div class="container">
   <label><b>제목</b></label> 
   <input type="text" placeholder="제목 입력" name="title" required> 
     
   <label><b>미션</b></label>
   <select name="missionTitle">
      <option selected>미션을 선택해주세요.</option>   
      <%   
         DateCalc d = new DateCalc();
         for(int i=0; i<missionall.size(); i++){
            MissionBean mission = (MissionBean)missionall.get(i);
            String result = d.dateCalc(mission.getApplystart(),mission.getApplyend(),
                     mission.getPerformstart(), mission.getPerformend(),mission.getResultdate());
            if(result.equals("종료")){
            %>         
            <option><%=mission.getTitle() %></option>
      <%
            }
         }
      %>
   </select>
     
   <label><b>사진</b></label>
   <input type="file" name="image">
         
   <label><b>내용</b></label> 
   <textarea id="content" name="content" placeholder="내용 입력" style="height: 200px"></textarea>
   <div class="clearfix">
      <button type="button" class="cancelBtn" onclick="history.go(-1)">Cancel</button>
      <button type="submit" class="addBtn">Save</button>
   </div>
</div>   
</form> 

<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>