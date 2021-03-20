<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userinfo" class="Beans.WriterBean" scope="session" />
<jsp:useBean id="notice" class="Beans.NoticeBean" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/menu.css" />
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/home.css" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" >
</head>
<body>
<!--메뉴-->
<div id="myNav" class="overlay" style="overflow-y:auto;">
   <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
      <div class="navbuttonContain">
         <p class="mainmenu">
         Hello! '<%=userinfo.getWriterid()%>' 
         </p>
         
         <%if(userinfo.getAttri().equals("administrator")){%>
        	  <button class="menuloginbtn"onclick="location.href='/ESTIS/AdminHomeController'">Admin Mode </button>
         <% }
         else{%>
         <button class="menuloginbtn"
         onclick="location.href='MyPageController?action=mypage&attri=<%=userinfo.getAttri()%>&writerid=<%=userinfo.getWriterid()%>'">
         My page</button>
         <% } %>
         <!-- 마이페이지 로그아웃  -->
         <form action="/ESTIS/LoginController"  method="post" >
         <button type="submit" class="menuloginbtn">Logout</button>
         <input type="hidden" name="action" value="logout">
         </form>
      </div>
      
      <div class="overlay-content">
             <label class="mainmenu">외.친.소.</label>
            <form action="/ESTIS/MissionController"  method="post" >
          <button type="submit" class="submenubtn">Introduction</button>
          <input type="hidden" name="action" value="intro">
          </form>
          <form action="/ESTIS/MissionController"  method="post" >
           <button type="submit" class="submenubtn">Mission List</button>
          <input type="hidden" name="action" value="missionall">
          </form>
          <form action="/ESTIS/MissionResultController"  method="post" >
          <button type="submit" class="submenubtn">Gallery</button>
          <input type="hidden" name="action" value="missionRe">
          </form>
       <form action="/ESTIS/NoticeController"  method="post" >   
       <button class="mainmenu2">Notice</button>
       <input type="hidden" name="action" value="notice">
       </form>
       <% if(userinfo.getAttri().equals("fs")||userinfo.getAttri().equals("buddy")){ %>
          <a class="mainmenu" href="BuddyController?action=member">Buddy room</a>
       <% } %>
  </div>
</div>

<!--상단바-->
<div class="mainbar">
   <a onclick="location.href='LoginController?action=home&noticeid=1'"
    class="w3-bar-item w3-button">ESTIS</a>
   <a class="w3-bar-item w3-button w3-#687672 w3-right" onclick="openNav()">&#9776;</a>
</div>


</body>
</html>