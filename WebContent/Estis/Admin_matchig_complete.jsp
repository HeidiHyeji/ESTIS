<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Beans.IMFFBean"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css"
	href="/ESTIS/Estis/Css/adminmatchingcomplete.css" />
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<title>Insert title here</title>
</head>
<body>
	<!--메뉴-->
	<jsp:include page="Admin_Top.jsp" flush="true" />
	<!--내용-->
	<div class="missiontitle">
		<b>외친소 Mission Team</b>
		<hr class="titleline">
	</div>
	<br>
	<div class="title" align="center">
		<br> <i class="fa fa-chevron-circle-right fa-lg"
			aria-hidden="true" style="color: #687672 !important;"></i>
		<n>외친소 팀 현황</n>
		<br>
		<br>
		<div style="margin-left: 10px">
			외친소 팀 배정이 모두 완료되었습니다.<br>
		</div>
	</div>


	<br>
	
		<div class="container" align="center">
			<table id="myTable"> 
				<tr class="header">
					<th style="width: 3%;">no</th>
					<th style="width: 3%;">teamid</th>
					<th style="width: 15%;">fsid1</th>
					<th style="width: 15%;">fsid2</th>
					<th style="width: 15%;">ksid1</th>
					<th style="width: 15%;">ksid2</th>
				</tr>
				<%
					int no = 1;
					int pagenum = 1;//페이지 번호
					ArrayList<IMFFBean> imfflist = (ArrayList<IMFFBean>) application.getAttribute("imff");

					//페이징 하기
					//String missionid=(String)request.getParameter("missionid");
					if (request.getParameter("memberPage") != null) {
						pagenum = Integer.parseInt(request.getParameter("memberPage"));
					}
					int size = 15;
					int tot;
					int cnt = imfflist.size();
					tot = cnt / size;
					if (cnt % size != 0) {
						tot++;
					}

					int start = (pagenum - 1) * size;
					int end = pagenum * size - 1;

					//리스트 띄우기

					if (imfflist.size() > 0) {
						for (int i = 0; i < imfflist.size(); i++) {
							IMFFBean imff = (IMFFBean) imfflist.get(i);
				%>
				<tr>
					<td style="color: #687672"><%=no++%></td>
					<td><%=imff.getTeamid()%></td>
					<td><%=imff.getFsid1()%></td>
					<td><%=imff.getFsid2()%></td>
					<td><%=imff.getKsid1()%></td>
					<td><%=imff.getKsid2()%></td>
				</tr>
				<%
					}
					}
				%>

			</table>
		</div>
		<div align="center">
	<a href="/ESTIS/Estis/Admin_Imff.jsp" class="backbtn" >미션 페이지로 돌아가기</a>
</div>

	<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>