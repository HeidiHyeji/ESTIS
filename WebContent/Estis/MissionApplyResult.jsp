<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Beans.WriterBean"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/apply.css" />

</head>
<body>
<!--메뉴-->
<jsp:include page="Top.jsp" flush="true" />
   <% 
   		WriterBean user= (WriterBean)session.getAttribute("userinfo");
   		String userid = (String)user.getWriterid();//현재 접속중인 사람 id	 
	%>
<H3 class="maintext">'<%=userid%>'님의 '<%=request.getAttribute("missionTitle") %>'미션 결과는 
'<%=request.getAttribute("state") %>'입니다.</H3>



<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>

