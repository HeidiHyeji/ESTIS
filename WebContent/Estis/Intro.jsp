<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/intro.css">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/missionMenu.css" />
</head>
<body>
<jsp:include page="Top.jsp" flush="true" />
<table class="menu">
   <tr>
      <td style="background-color: gray;">
       <form action="/ESTIS/MissionController"  method="post" >      
       <button style="color: white;" class="missionTdBtn" type="submit">Intro</button>
       <input type="hidden" name="action" value="intro">
       </form>
       </td>   
         
       <td>
       <form action="/ESTIS/MissionController"  method="post" > 
       <button class="missionTdBtn" type="submit">Mission list</button>
       <input type="hidden" name="action" value="list">
       </form>
       </td>    
           
       <td>
       <form action="/ESTIS/MissionController"  method="post" > 
       <button class="missionTdBtn" type="submit">Gallery</button>
       <input type="hidden" name="action" value="gallery">
       </form>
       </td>
   </tr>
</table>
<br>
<div class="introTitle">
   <b>&nbsp;Let 외.친.소. Introduce</b><!-- &nbsp;&nbsp; -->
</div>
<br>
<div class="thumbnail-wrappper"> 
   <img src="/ESTIS/Estis/Img/IMFF.png"> 
</div>
<hr style="border: solid 0.5px Gray;">
<div class="introContents">
   <div class="subjectText">
      <ul><li>외친소가 무엇인가요?</li></ul>   
      <sub>경기대 일반 학부생과 교환학생들의 교류를 위해 랜덤형식으로 친구를 소개시켜주는 프로그램입니다.</sub>
      <ul><li>프로그램은 어떻게 진행되나요?</li></ul>
      <sub><a href = "https://youtu.be/NB0InEfoGLA">여기를 클릭 </a></sub>
      <ul><li>어떤 미션을 하게되나요?</li></ul>
      <sub><a href = "https://youtu.be/NB0InEfoGLA">여기를 클릭 </a></sub>
   </div>
</div>

<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>