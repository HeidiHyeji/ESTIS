<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="Beans.BuddyBean"%>
<jsp:useBean id="userinfo" class="Beans.WriterBean" scope="session" />
<jsp:useBean id="BuddyRoom" class="java.util.ArrayList" scope="request"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/admin_buddyroom.css" />
<title>Insert title here</title>
</head>
<body>
<!-- 관리자 메뉴  -->
<jsp:include page="Admin_Top.jsp" flush="true" />
<jsp:include page="Bottom.jsp" flush="true" />
<div class="content">
	<%
	for(int i=0; i<BuddyRoom.size(); i++ ){
		BuddyBean buddy = (BuddyBean) BuddyRoom.get(i);
	%>
	<div class="responsive">
		<h2><%=buddy.getName() %></h2>
 		<div class="gallery">
    	<a href="BuddyController?action=member&buddyid=<%=buddy.getBuddyid()%>">
      	<img src="/ESTIS/Estis/Img/Buddyroom.png" alt="Trolltunga Norway" width="300" height="200">
    	</a>
    		<div class="desc"><%=buddy.getBuddyid() %></div>
  		</div>
	</div>

	<%
	}
	%>
</div>
</body>
</html>