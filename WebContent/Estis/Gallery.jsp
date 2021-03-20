<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="Beans.MissionResultBean, Date.DateCalc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="missionReAll" class="java.util.ArrayList" scope="session" />
<jsp:useBean id="missionall" class="java.util.ArrayList" scope="session" />
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/missionMenu.css" />
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/list.css" />
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
         
      <td>
      <form action="/ESTIS/MissionController"  method="post" > 
      <button class="missionTdBtn" type="submit">Mission list</button>
      <input type="hidden" name="action" value="list">
      </form>
      </td>    
           
      <td style="background-color: gray;">
      <form action="/ESTIS/MissionResultController"  method="post" > 
      <button style="color: white;" class="missionTdBtn" type="submit">Gallery</button>
      <input type="hidden" name="action" value="missionRe">
      </form>
      </td>
   </tr>
</table>

<table class="listTitle">
      <tr>
        <td>&nbsp;<b>Gallery</b>
            <br>&nbsp;외친소 활동 사진올리는 방입니다^O^
         </td>
         <td>
          <!-- 갤러리 추가 버튼 -- // **모든 학생 이용**-->
            <form class="listAddBtn" action="/ESTIS/MissionResultController" method="post">
            <button class="listAddBtn" type="submit">
            <img src="/ESTIS/Estis/Img/add.png"></button>
            <input type="hidden" name="action" value="write">
            </form>
         </td>
      </tr>
</table>

<input type="text" id="myInput" onkeyup="myFunction()" 
placeholder="Search for title" title="Type in a name">

<table id="myTable">
   <tr class="header">
      <th>#</th>
      <th style="width: 50%;">Title</th>
      <th>Writer</th>
      <th>Date</th>
   </tr>
      <%
      DateCalc d = new DateCalc();
      for(int i=0; i<missionReAll.size(); i++){
      MissionResultBean missionRe = (MissionResultBean)missionReAll.get(i); %>
   <tr style="cursor: pointer;"
         onclick="location.href='MissionResultController?action=missionReOne&resultid=<%=missionRe.getResultid()%>'">
      <td>
         <%=missionRe.getResultid()%>
      </td>
      <td>
         <%=missionRe.getTitle()%>
      </td>    
      <td>
         <%=missionRe.getWriterid()%> 
      </td>
      <td>
         <%=d.getDate(missionRe.getDate())%> 
      </td>
   </tr>
      <%} %>
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