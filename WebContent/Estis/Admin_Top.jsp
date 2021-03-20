<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userinfo" class="Beans.WriterBean" scope="session" />
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
         '<%=userinfo.getWriterid()%>'(관리자)님 안녕하세요!
         </p>
         <!-- 마이페이지 로그아웃  -->
         <button class="menuloginbtn"
         onclick="location.href='/ESTIS/Estis/Home.jsp'">User Mode</button>
         <form action="/ESTIS/LoginController"  method="post" >
         <button type="submit" class="menuloginbtn">Logout</button>
         <input type="hidden" name="action" value="logout">
         </form>
      </div>
   
   <div class="overlay-content" >
       <a class="mainmenu">Member Management</a>
          <a class="submenu" href="/ESTIS/Estis/Admin_buddy.jsp">Buddy</a>
          <a class="submenu" href="/ESTIS/Estis/Admin_KS.jsp">Korean Student</a>
          <a class="submenu" href="/ESTIS/Estis/Admin_FS.jsp">Exchange Student</a>
       <a class="mainmenu" href="/ESTIS/Estis/Admin_Imff.jsp">외친소 Management</a>
       <a class="mainmenu" href="/ESTIS/BuddyController?action=list">Buddy room Management</a>
       <form action="/ESTIS/NoticeController"  method="post" >   
       <button class="mainmenu2">Notice Management</button>
       <input type="hidden" name="action" value="notice">
       </form>
       <a class="mainmenu" href="/ESTIS/Estis/Admin_SystemMonitoring.jsp">System Monitoring</a>
         <br>
  <br>
  <br>
  
  </div>

</div>

<!--상단바-->
<div class="mainbar">
   <a href="/ESTIS/AdminHomeController" class="w3-bar-item w3-button">ESTIS</a>
   <a class="w3-bar-item w3-button w3-#687672 w3-right" onclick="openNav()">&#9776;</a>
</div>

</body>
</html>