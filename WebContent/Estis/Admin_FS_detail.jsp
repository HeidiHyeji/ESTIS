<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Beans.FSBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/admindetail.css" />
<%
	FSBean fs=(FSBean)application.getAttribute("fsdetail");
%>
</head>
<body>
<!--jsp:include page="Top.jsp" flush="true" /-->
  
<div class="title">
<br>
<b>Exchange Student Detailed Info</b>
<hr class="titleline">
</div>

<table class="bluetop">
<tr><th>fsid</th><td><%=fs.getFsid() %></td></tr>
<tr><th>pw</th><td><%=fs.getPw() %></td></tr>
<tr><th>name</th><td><%=fs.getName() %></td></tr>
<tr><th>email</th><td><%=fs.getEmail() %></td></tr>
<tr><th>language</th><td><%=fs.getLanguage() %></td></tr>
<tr><th>sid</th><td><%=String.valueOf(fs.getSid())%></td></tr>
<tr><th>phone</th><td><%=fs.getPhone()%></td></tr>
<tr><th>major</th><td><%=fs.getMajor() %></td></tr>
<tr><th>buddyid</th><td><%=fs.getBuddyid() %></td></tr>
<tr><th>semester</th><td><%=String.valueOf(fs.getSemester())%></td></tr>

</table>

<div class=accessdiv>
<a class="graybtn" href=javascript:window.close();>닫기</a>
</div>

<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>