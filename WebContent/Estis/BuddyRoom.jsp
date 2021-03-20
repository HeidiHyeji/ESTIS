<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Beans.FSBean"%>
<jsp:useBean id="userinfo" class="Beans.WriterBean" scope="session" />
<jsp:useBean id="buddy" class="Beans.BuddyBean" scope="session" />
<jsp:useBean id="member" class="Beans.FSBean" scope="request" />
<jsp:useBean id="memberlist" class="java.util.ArrayList" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/buddyRoom.css" />
</head>
<body>
	<!--메뉴-->
	<jsp:include page="Top.jsp" flush="true" />
	<jsp:include page="Bottom.jsp" flush="true" />
	<!--내용-->
	<br>
	<div style="overflow-x:auto;">
		<table class="membertable">
			<tr>
				<td class="membertd">Member</td>
				<% if(userinfo.getAttri().equals("buddy")){ %>
				<td><button class="memberadd"	onclick="location.href='/ESTIS/Estis/ManageMember.jsp'" >
					<img src="/ESTIS/Estis/Img/adduser.png"></button>
				</td>
				<%} %>

				<td class="membertd"><img src="/ESTIS/Estis/Img/buddy.png" alt="Person" width="30" height="30">
					<%= buddy.getName() %>
				</td>
				<% for (int i = 0; i < memberlist.size(); i++) {
					FSBean fs = (FSBean) memberlist.get(i);%>
				
				<td class="membertd"><img src="/ESTIS/Estis/Img/member.png" alt="Person" width="30" height="30">					
					<%= fs.getName() %>
				</td>
				<% }%>
			<tr>
		</table>
	</div>
	<br>
	<div>
<button class="tablink" onclick="openCity('London', this, '#FA8072')" id="defaultOpen">전체</button>
<button class="tablink" onclick="openCity('Paris', this, '#A1BBD0')">공지사항</button>
<button class="tablink" onclick="openCity('Tokyo', this, '#9ce08b')">일반</button>
<br>
<div id="London" class="tabcontent">
<br><br>
  <jsp:include page="SNS.jsp" flush="true" />
</div>

<div id="Paris" class="tabcontent">
<br>
  <jsp:include page="SNS.jsp" flush="true" />
</div>

<div id="Tokyo" class="tabcontent">
<br>
  <jsp:include page="SNS.jsp" flush="true" />
</div>



		
	</div>


<script>
function openCity(cityName,elmnt,color) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablink");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].style.backgroundColor = "";
    }
    document.getElementById(cityName).style.display = "block";
    elmnt.style.backgroundColor = color;

}
// Get the element with id="defaultOpen" and click on it
document.getElementById("defaultOpen").click();
</script>
	
</body>
</html>