<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Beans.KSBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/admindetail.css" />
<%
	KSBean ks=(KSBean)application.getAttribute("ksdetail");
%>
</head>
<body>
<!--jsp:include page="Top.jsp" flush="true" /-->
  
<div class="title">
<br>
<b>Korean Student Detailed Info</b>
<hr class="titleline">
</div>

<table class="bluetop">
<tr><th>ksid</th><td><%=ks.getKsid() %></td></tr>
<tr><th>pw</th><td><%=ks.getPw() %></td></tr>
<tr><th>name</th><td><%=ks.getName() %></td></tr>
<tr><th>email</th><td><%=ks.getEmail() %></td></tr>
<tr><th>language</th><td><%=ks.getLanguage() %></td></tr>
<tr><th>sid</th><td><%=String.valueOf(ks.getSid())%></td></tr>
<tr><th>phone</th><td><%=ks.getPhone()%></td></tr>
<tr><th>major</th><td><%=ks.getMajor() %></td></tr>
<tr><th>history</th><td><%=ks.getHistory() %></td></tr>

</table>

<div class=accessdiv>
<a class="graybtn" href=javascript:window.close();>닫기</a>
</div>

<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>