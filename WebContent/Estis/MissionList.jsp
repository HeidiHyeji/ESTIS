<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="Beans.MissionBean, java.util.ArrayList, Date.DateCalc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="missionall" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="missionone" class="Beans.MissionBean" scope="request" />
<jsp:useBean id="userinfo" class="Beans.WriterBean" scope="session" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/list.css" />
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/missionMenu.css" />
</head>
<body>
<jsp:include page="Top.jsp" flush="true" />
<table class="menu">
   <tr>
      <td>
      <form action="/ESTIS/MissionController"  method="post" >      
      <button class="missionTdBtn" type="submit">Intro</button>
      <input type="hidden" name="action" value="intro">
      </form>
      </td>   
         
      <td style="background-color: gray;">
      <form action="/ESTIS/MissionController"  method="post" > 
      <button style="color: white;" class="missionTdBtn" type="submit">Mission list</button>
      <input type="hidden" name="action" value="list">
      </form>
      </td>    
           
      <td>
      <form action="/ESTIS/MissionResultController" method="post" > 
      <button class="missionTdBtn" type="submit">Gallery</button>
      <input type="hidden" name="action" value="missionRe">
      </form>
      </td>
   </tr>
</table>

<table class="listTitle">
      <tr>
        <td>&nbsp;<b>Let's Go Mission!!</b>
            <br>&nbsp;외친소를 신청하세요!!!^@^
         </td>
         <%if(userinfo.getAttri().equals("administrator")){ %>
         <td>
          <!-- 공지사항 추가 버튼 -- // **관리자만 이용**-->
            <form class="listAddBtn" action="/ESTIS/MissionController" method="post">
            <button class="listAddBtn" type="submit">
            <img src="/ESTIS/Estis/Img/add.png"></button>
            <input type="hidden" name="action" value="missionListAdd">
            </form>
         </td>
         <%} %>
      </tr>
</table>

<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search for title" title="Type in a name">

<table id="myTable">
   <tr class="header">
      <th style="width: 5%;">#</th>
      <th style="width: 50%;">Title</th>
      <th style="width: 25%;">State</th>
      <th style="width: 20%;"></th>
   </tr>
   <%
      for(int i=0; i<missionall.size(); i++){
         MissionBean mission = (MissionBean)missionall.get(i); 
   %>
   <tr>
      <td>
      <%=mission.getMissionid() %>
      </td>
      <td style="cursor: pointer;" 
         onclick="location.href='MissionController?action=missionOne&missionid=<%=mission.getMissionid()%>'">
      <%=mission.getTitle()%>
      </td>
      <td>
      <% 
         DateCalc d = new DateCalc(); 
         String result = d.dateCalc(mission.getApplystart(),mission.getApplyend(),
            mission.getPerformstart(), mission.getPerformend(),mission.getResultdate());%>
      <%=result%>
      </td>
      <td>
      <%if(result.equals("모집중")){ %>
      <button onclick="location.href='MissionController?action=missionApply&missionid=<%=mission.getMissionid()%>'" 
         type="submit" class="w3-button w3-black">신청하기</button>
      <%}else if(result.equals("모집완료")){ %>
      <button onclick="location.href='MissionController?action=missionApplyResult&missionid=<%=mission.getMissionid()%>'" 
         type="submit" class="w3-button w3-black">결과보기</button>
      <% } %>      
      </td>
   </tr>
   <% } %>
</table>

<script>
function myFunction() {
   var input, filter, table, tr, td, i;
   input = document.getElementById("myInput");
   filter = input.value.toUpperCase();
   table = document.getElementById("myTable");
   tr = table.getElementsByTagName("tr");
   for (i = 0; i < tr.length; i++) {
      td = tr[i].getElementsByTagName("td")[1];
      if (td) {
         if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
            tr[i].style.display = "";
         } else {
            tr[i].style.display = "none";
         }
      }
   }
}
</script>
<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>