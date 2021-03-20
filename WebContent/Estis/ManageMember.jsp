<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Beans.FSBean"%>
<jsp:useBean id="member" class="Beans.FSBean" scope="session" />
<jsp:useBean id="memberlist" class="java.util.ArrayList" scope="session"/>
<jsp:useBean id="alerter" class="Beans.InputResult" scope="request" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/apply.css" />
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/missionList.css" />
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/login.css" />
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/AlertMessages.css" />
<title>Control BuddyRoom Member</title>
</head>
<body>
<!--메뉴-->
	<jsp:include page="Top.jsp" flush="true" />
	
<!--멤버추가오류알림-->
<div id="Error"><%=alerter.getAlert() %></div>
<div id="Success"><%=alerter.getAlert() %></div>
<script>
function Alert_S() {
    var x = document.getElementById("Success")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}
function Alert_E() {
    var x = document.getElementById("Error")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}
</script>
<% if(alerter.getAlert()!=null){
	if(alerter.getState().equals("Error")){
		out.println("<script>Alert_E();</script>");
	}
	else if(alerter.getState().equals("Success")){
		out.println("<script>Alert_S();</script>");
	}
	alerter.setAlert(null);
	alerter.setState(null);
}
 %>	
	
<!-- 내용 -->
<form action="/ESTIS/BuddyController"  method="post" >
				<table id="myTable">
				
					<tr class="header">
						
						<th style="width: 60%;">
						<input type="text" placeholder="Buddy ID" name="addfsid" required></th>	
						<th style="width: 40%;">
						<input type="hidden" name="action" value="addMember">    
						<button type="submit" class="applybtn"> 등록  </button></th>
					
					</tr>
					
				</table>
				</form>
				<H3>Member 목록</H3>
				
				<table id="myTable">
					<tr class="header">
						<th style="width: 50%;">Member</th>
						<th style="width: 50%;"></th>
					</tr>
					<%
						for (int i = 0; i < memberlist.size(); i++) {
							FSBean fs = (FSBean) memberlist.get(i);
					%>
					<tr>
						<td><%= fs.getName()%></td>
						<td>
						<form action="/ESTIS/BuddyController"  method="post" >
						 <input type="hidden" name="action" value="deleteMember">  
						 <input type="hidden" name="fsid" value=<%=fs.getFsid() %>>  
						 <button class="w3-button w3-black" type="submit">해제하기</button>  
				<!-- <button
								onclick="document.getElementById('request').style.display='block'"
								class="w3-button w3-black">해제하기</button>
						 <input type="hidden" name="action" value="login">    -->
						 </form>
						 </td>
					</tr>
					<%
						}
					%>		
				</table>	
		<div class="container">
            <button type="button" class="loginbtn" onclick="location.href='/ESTIS/Estis/BuddyRoom.jsp'">확인</button>
       </div>
	<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>