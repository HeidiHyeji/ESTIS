<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="notice" class="Beans.NoticeBean" scope="session" />
<jsp:useBean id="userinfo" class="Beans.WriterBean" scope="session" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/home.css" />
</head>
<body>
<jsp:include page="Top.jsp" flush="true" />

<!--메인-->   
<div class="slideshow-container">
   <div class="mySlides fade">
     <div class="numbertext">1 / 4</div>
     <img src="/ESTIS/Estis/Img/main11.jpg" style="width:100%">
   </div>

   <div class="mySlides fade">
     <div class="numbertext">2 / 4</div>
     <img src="/ESTIS/Estis/Img/main22.png" style="width:100%">
   </div>

   <div class="mySlides fade">
     <div class="numbertext">3 / 4</div>
     <img src="/ESTIS/Estis/Img/main33.jpg" style="width:100%">
   </div>
      
   <div class="mySlides fade">
     <div class="numbertext">4 / 4</div>
     <img src="/ESTIS/Estis/Img/main44.jpg" style="width:100%">
   </div>
   
   <div style="text-align:center; padding:6px;">
     <span class="dot"></span> 
     <span class="dot"></span> 
     <span class="dot"></span>
     <span class="dot"></span>  
   </div>
</div>

<div class="noticeContain" 
onclick="location.href='NoticeController?action=detail&noticeid=<%=notice.getNoticeid()%>'">
   <img src="/ESTIS/Estis/Img/bell.png" /><%=notice.getTitle() %>
</div>

<table class="buttonContain">
   <tr>
      <td style="border-right-style: solid; border-right-width: 1px;" 
      onclick="location.href='MissionController?action=intro&id=1'">
      <img src="/ESTIS/Estis/Img/friend.png" /><br/>외친소<br/></td>
	<%if(userinfo.getAttri().equals("ks")){%>
	  <td onclick="location.href='MyPageController?action=mypage&attri=<%=userinfo.getAttri()%>&writerid=<%=userinfo.getWriterid()%>'">
      <img src="/ESTIS/Estis/Img/home.png" /><br/>My Page<br/></td>
	<% }else if(userinfo.getAttri().equals("administrator") ){%>
	  <td onclick="location.href='/ESTIS/AdminHomeController'">
      <img src="/ESTIS/Estis/Img/home.png" /><br/>Admin Mode<br/></td>
	<%}else{ %>
      <td onclick="location.href='BuddyController?action=member'">
      <img src="/ESTIS/Estis/Img/home.png" /><br/>Buddy room<br/></td>
     <%} %>
   </tr>
   	
</table>
<script>
var slideIndex = 0;
showSlides();

function showSlides() {
    var i;
    var slides = document.getElementsByClassName("mySlides");
    var dots = document.getElementsByClassName("dot");
    for (i = 0; i < slides.length; i++) {
       slides[i].style.display = "none";  
    }
    slideIndex++;
    if (slideIndex> slides.length) {slideIndex = 1}    
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
    }
    slides[slideIndex-1].style.display = "block";  
    dots[slideIndex-1].className += " active";
    setTimeout(showSlides, 2000); // Change image every 2 seconds
}
</script>
<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>