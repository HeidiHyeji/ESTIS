<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="Beans.MissionResultBean, Beans.IMFFKSBean"%>
<jsp:useBean id="userinfo" class="Beans.WriterBean" scope="session" />
<jsp:useBean id="ks" class="Beans.KSBean" scope="session" />
<jsp:useBean id="fs" class="Beans.FSBean" scope="session" />
<jsp:useBean id="buddy" class="Beans.BuddyBean" scope="session" />
<jsp:useBean id="mr" class="java.util.ArrayList" scope="session" />
<jsp:useBean id="imffks" class="java.util.ArrayList" scope="session" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/myPage.css">
<title>ESTIS 마이페이지</title>
</head>
<body>
<jsp:include page="Top.jsp" flush="true" />

<h3>♥MyPage♥</h3>

<div class="myPage">
   <label style="font-size: 27px;">
   <%
   if(userinfo.getAttri().equals("ks")){%>
   <%=ks.getName() %>
   <%}else if(userinfo.getAttri().equals("fs")){ %>
   <%=fs.getName() %>
   <%}else if(userinfo.getAttri().equals("buddy")){ %>
   <%=buddy.getName() %>
   <%} %>
   
   </label>
   <label style="font-size: 12px;">
   <%
   if(userinfo.getAttri().equals("ks")){%>
   한국학생입니다.
   <%}else if(userinfo.getAttri().equals("fs")){ %>
   I'm exchange student.
   <%}else if(userinfo.getAttri().equals("buddy")){ %>
   버디입니다.
   <%} %>
   </label>
   <hr>
   <table class="myPageTable">
      <tr>
         <td class="type">id</td>
         <td class="cont">
         <%=userinfo.getWriterid() %>
         </td>
      </tr>
      <tr>
         <%
         if(userinfo.getAttri().equals("ks")){%>
         <td class="type">major</td>
         <td class="cont">         
         <%=ks.getMajor() %>
         </td>
         <%}else if(userinfo.getAttri().equals("fs")){ %>
         <td class="type">major</td>
         <td class="cont">
         <%=fs.getMajor() %>
         </td>
         <%}%>
      </tr>
      <tr>
         <%
         if(userinfo.getAttri().equals("ks")){%>
         <td class="type">studentId</td>
         <td class="cont">         
         <%=ks.getSid() %>
         </td>
         <%}else if(userinfo.getAttri().equals("fs")){ %>
         <td class="type">studentId</td>
         <td class="cont">
         <%=fs.getSid() %>
         </td>
         <%}%>
      </tr>
      <tr>
         <%
         if(userinfo.getAttri().equals("ks")){%>
         <td class="type">phone</td>
         <td class="cont">         
         <%=ks.getPhone() %>
         </td>
         <%}else if(userinfo.getAttri().equals("fs")){ %>
         <td class="type">phone</td>
         <td class="cont">
         <%=fs.getPhone() %>
         </td>
         <%}%>
      </tr>
      <tr>
         <td class="type">language</td>
         <td class="cont">
         <%
         if(userinfo.getAttri().equals("ks")){%>
         <%=ks.getLanguage() %>
         <%}else if(userinfo.getAttri().equals("fs")){ %>
         <%=fs.getLanguage() %>
         <%}else if(userinfo.getAttri().equals("buddy")){ %>
         <%=buddy.getLanguage() %>
         <%} %>
         </td>
      </tr>
      <%if(userinfo.getAttri().equals("buddy")){ %>
      <tr>
         <td class="type">기수</td>
         <td class="cont"><%=buddy.getSemester() %>
      </tr>
      <%} %>
   </table>
   <hr>
   
<button class="accordion">내가 쓴 갤러리 게시물</button>
<div class="panel">
   <table class="myAct">
      <tr>
         <th>Title</th>
         <th>Score</th>
         <th>Hit</th>
      </tr>
   <%
      for(int i=0; i<mr.size(); i++){
         MissionResultBean mrOne = (MissionResultBean)mr.get(i);
   %>
      <tr style="cursor: pointer;"
         onclick="location.href='MissionResultController?action=missionReOne&resultid=<%=mrOne.getResultid()%>'">
         <td><%=mrOne.getTitle() %></td>
         <td><%=mrOne.getScore() %></td>
         <td><%=mrOne.getHit() %></td>
      </tr>
   <%
      }
   %>
   </table>
</div>
<%
   if(userinfo.getAttri().equals("ks") ){
%>
<button class="accordion">외친소 신청 내역</button>
<div class="panel">
   <table class="myAct">
      <%
      for(int i=0; i<imffks.size(); i++){
         IMFFKSBean imffksOne = (IMFFKSBean)imffks.get(i);
   %>
      <tr>
         <td><%=imffksOne.getImffksid() %></td>
         <td><%=imffksOne.getParty() %></td>
         <td><%=imffksOne.getMissionid() %></td>
         <td><%=imffksOne.getState() %></td>
      </tr>
   <%
      }
   %>
   </table>
</div>
<%
   }if(userinfo.getAttri().equals("fs") || userinfo.getAttri().equals("buddy") ){
%>

<button class="accordion">내가 쓴 버디방 게시물</button>
<div class="panel">
   <table class="myAct">
      <tr>
         <td>이름</td>
         <td>최진원</td>
      </tr>
   </table>
</div>
<%
   }
%>   
   <div>
      <button type="submit" class="pwchangebtn">비밀번호변경</button>
      <button type="submit" class="confirmbtn" onclick="history.go(-1)">확인</button>
   </div>
</div>


<script>
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
   acc[i].onclick = function() {
      this.classList.toggle("active");
      var panel = this.nextElementSibling;
      if (panel.style.maxHeight) {
         panel.style.maxHeight = null;
      } else {
         panel.style.maxHeight = panel.scrollHeight + "px";
      }
   }
}

document.getElementById("defaultOpen").click();
</script>
   
<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>