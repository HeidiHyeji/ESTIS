<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="DAO.MissionDAO"%>
<%@ page import="Beans.MissionBean"%>
<%@ page import="Date.DateCalc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="/ESTIS/Estis/Css/adminimff.css" />
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<title>Insert title here</title>
<script type="text/javascript">
	function missionAdd() {

		var cw = screen.availWidth; //화면 넓이
		var ch = screen.availHeight; //화면 높이
		var sw = 520; //띄울 창의 넓이
		var sh = 630; //띄울 창의 높이

		var ml = (cw - sw) / 2;
		var mt = (ch - sh) / 2;

		var gsWin = window.open("/ESTIS/Estis/Admin_MissionAdd.jsp", "winName",
				'scrollbars=yes,resizable=yes,width=' + sw + ',height=' + sh
						+ ',top=' + mt + ',left=' + ml + '');
	}
</script>
</head>
<body>
	<!--메뉴-->
	<jsp:include page="Admin_Top.jsp" flush="true" />

	<!-- 페이지제목 -->
	<div class="missiontitle">
		<b>외친소 Management</b>
		<hr class="titleline">
	</div>



	<!-- 미션등록 안내부분 -->
	<div class="title">
		<br> <i class="fa fa-chevron-circle-right fa-lg"
			aria-hidden="true" style="color: #687672 !important;"></i>
		<n>Mission 등록</n>
	</div>

	<table>
		<tr>
			<td>
				<ul>
					<li>미션 등록 버튼 클릭시, 미션등록 페이지 창이 뜹니다.</li>
					<li>관리자는 관리자 페이지와 사용자 페이지, 모두에서 미션 등록이 가능합니다.</li>
				</ul>
			</td>
			<td style="padding-left: 20px"><a
				href="javascript:missionAdd();" class="gobtn">미션 등록하기</a></td>
		</tr>
	</table>
	<br>
	<br>
	<!--How to부분-->
	<div class="title">
		<br> <i class="fa fa-chevron-circle-right fa-lg"
			aria-hidden="true" style="color: #687672 !important;"></i>
		<n>How to</n>
	</div>
	<p>
		<img src="/ESTIS/Estis/Img/missionlist.png" width="100" height="auto">
		<span>1.관리하고자 하는 미션 리스트를 선택합니다.</span>
	</p>
	<p>
		<img src="/ESTIS/Estis/Img/detail.png" width="100" height="auto">
		2. 해당 미션의 세부정보와 신청자명단을 확인 및 관리합니다.
	</p>
	<p>
		<img src="/ESTIS/Estis/Img/matching.png" width="100" height="auto">
		3. 신청자들을 Matching하여 해당 미션을 수행할 팀을 구성합니다.
	</p>
	<br>
	<br>
	<!-- 미션 리스트 부분 -->
	<div class="title">
		<br> <i class="fa fa-chevron-circle-right fa-lg"
			aria-hidden="true" style="color: #687672 !important;"></i>
		<n>Mission List</n>
	</div>

	<form name="frm1" method="post" action="/ESTIS/AdminIMFFController">
		<table id="myTable">
			<tr class="header">
				<th style="width: 3%;">no</th>
				<th style="width: 12%;">title</th>
				<th style="width: 3%;">Max</th>
				<th style="width: 3%;">Min</th>
				<th style="width: 10%;">applystart</th>
				<th style="width: 10%;">applyend</th>
				<th style="width: 10%;">resultdate</th>
				<th style="width: 10%;">performstart</th>
				<th style="width: 10%;">performend</th>
				<th style="width: 5%;">State</th>
				<th style="width: 5%;">missionid</th>


			</tr>
			<%
				int no = 1;
				int pagenum = 1;//페이지 번호
				MissionDAO dao = MissionDAO.getInstance();

				if (request.getParameter("memberPage") != null) {
					pagenum = Integer.parseInt(request.getParameter("memberPage"));
				}
				int size = 15;
				int tot;
				int cnt = dao.getCount();
				tot = cnt / size;
				if (cnt % size != 0) {
					tot++;
				}
				int start = (pagenum - 1) * size;
				int end = pagenum * size - 1;
				DateCalc d = new DateCalc();
				ArrayList<MissionBean> missionlist = dao.getMissionList();
				if (missionlist.size() > 0) {
					for (int i = 0; i < missionlist.size(); i++) {
						MissionBean mission = (MissionBean) missionlist.get(i);
			%>

			<tr style="cursor: pointer;"
				onclick="location.href='/ESTIS/AdminIMFFController?missionid=<%=mission.getMissionid()%>'">
				<td style="color: #687672"><%=no++%></td>
				<td class="ellipsis"><%=mission.getTitle()%></td>
				<td><%=mission.getMax()%></td>
				<td><%=mission.getMin()%></td>
				<td><%=mission.getApplystart()%></td>
				<td><%=mission.getApplyend()%></td>
				<td><%=mission.getPerformstart()%></td>
				<td><%=mission.getPerformend()%></td>
				<td><%=mission.getResultdate()%></td>
				<td><%=d.dateCalc(mission.getApplystart(), mission.getApplyend(), mission.getPerformstart(),
							mission.getPerformend(), mission.getResultdate())%></td>
				<td><%=mission.getMissionid()%></td>
			</tr>
			<%
				}
				}
			%>
		</table>

		<br>
		<!-- 페이징(게시글 페이지 번호 넘기기) -->
		<div class="center">
			<div class="pagination">
				<a
					<%if (pagenum - 1 >= 1)
				out.println("href='Admin_Imff.jsp?memberPage=" + (pagenum - 1) + "'");%>>&laquo;</a>
				<%
					for (int i = 1; i <= tot; i++) {
						if (pagenum == i) {
				%>
				<a class="active"><%=i%></a>
				<%
					} else {
				%>
				<a href="Admin_Imff.jsp?memberPage=<%=i%>"><%=i%></a>
				<%
						}
					}
				%>
				<a
					<%if (pagenum + 1 <= tot)
				out.println("href='Admin_Imff.jsp?memberPage=" + (pagenum + 1) + "'");%>>&raquo;</a>
			</div>
		</div>

		<br>


	</form>
	<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>