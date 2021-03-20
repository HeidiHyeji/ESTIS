<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Beans.IMFFFSBean"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="/ESTIS/Estis/Css/adminmatching.css" />
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	var checkRow;
	var checkRow2;
	var teamtablerow;
	var fstablerow;
	var clicked_Teamtable_row;
	var clicked_Teamtable_row_cell1;
	var clicked_Teamtable_row_cell2;
	var clicked_Fstable_row;
	var clicked_Fstable_row_cell1;
	var clicked_Fstable_row_cell2;
	var clicked_Fstable_row_cell1_html;
	var clicked_Fstable_row_cell2_html;
	var rowcnt = 0;
	var checkmaking=false;
	
	
	function onlyNumber(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ((keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105)
				|| keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39)
			return;
		else
			return false;
		
	}
	function removeChar(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if (keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39)
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
	function make_team() {
		if(document.frm1.teamnum.value==""){
				alert("생성할 팀의 수를 입력하세요.");
				writeForm.elemets[i].focus();
				return;
			
		}
		document.frm1.action = "/ESTIS/AdminIMFFMatchingController?matching=imfffs";
		frm1.submit();

	}
	function match_team() {
	    if(checkmaking==false){
	          alert("배정할 팀을 추가하세요.");
	          return;
	       
	    }
		alert('해당 미션 중복 배정시,팀 배정에 대한 이전 정보는 사라집니다.');
		document.frm1.action = "/ESTIS/AdminIMFFMatchingController?matching=imfffsend";
		frm1.submit();
	}
	function HighlightRow(obj, clickedrownum) {
		rowcnt = clickedrownum;
		clicked_Teamtable_row = obj;
		var teamtable = document.getElementsByName("teamtable");

		teamtablerow = document.getElementsByName("teamtablerow");//팀테이블의 전체 행
		for (var i = 0; i < teamtablerow.length; i++) {
			teamtablerow[i].style.backgroundColor = "#ffffff";
		}
		obj.style.backgroundColor = "#FCE6E0";
		checkRow = true;
		clicked_Teamtable_row_cell1 = clicked_Teamtable_row.cells[1];
		clicked_Teamtable_row_cell2 = clicked_Teamtable_row.cells[2];

	}
	function HighlightRow2(obj) {
		clicked_Fstable_row = obj;
		var teamtablerow = document.getElementsByName("teamtablerow");//getElementsByTagName
		if (checkRow == true) {
			var teamtable = document.getElementsByName("fstable");
			fstablerow = document.getElementsByName("fstablerow");//getElementsByTagName		
			for (var i = 0; i < fstablerow.length; i++) {
				fstablerow[i].style.backgroundColor = "#ffffff";
			}
			obj.style.backgroundColor = "#FCE6E0";
			checkRow2 = true;
		} else {
			alert('변경할 행을 선택하십시오.');
			return;
		}
		clicked_Fstable_row_cell1 = clicked_Fstable_row.cells[1];
		clicked_Fstable_row_cell2 = clicked_Fstable_row.cells[2];
		clicked_Fstable_row_cell1_html = clicked_Fstable_row.cells[1].innerHTML;
		clicked_Fstable_row_cell2_html = clicked_Fstable_row.cells[2].innerHTML;

	}
	function add(obj) {

		if (checkRow == true && checkRow2 == true) {
			if (clicked_Teamtable_row_cell1.innerHTML != ''
					&& clicked_Teamtable_row_cell2.innerHTML != '') {//team 테이블의 fs1fs2열이 모두 찼을때
				alert('imfffsid1행과 imfffsid2행의 꽉 찼습니다. 다른 team행을 선택하십시오');
			} else if (clicked_Teamtable_row_cell1.innerHTML != ''
					&& clicked_Teamtable_row_cell2.innerHTML == '') {//team테이블의 fs1열만 찼을 때
				if (clicked_Fstable_row_cell1_html != 'null'
						&& clicked_Fstable_row_cell2_html != 'null')//fs1,fs2 두개 넣으려고 하면
					alert('배정하려는 fs 수가  많습니다. 다른 fs행을 선택하십시오.');
				else {//fs테이블 중 하나만 넣으려고 하면
					if (clicked_Fstable_row_cell1.style.backgroundColor != 'rgb(242, 150, 123)') {//fs테이블 fs1열이 선택된적없으면
						//clicked_Teamtable_row_cell2.innerHTML=clicked_Fstable_row_cell1_html;//team 테이블의 fs2에 fs1열 값 저장
						var str = "<input type=text class='tdinput' name="+rowcnt+" value="+clicked_Fstable_row_cell1_html+" readonly>";
						clicked_Teamtable_row_cell2.innerHTML = str;
						clicked_Fstable_row_cell1.style.backgroundColor = "#f2967b";

					} else
						//선택된적 있으면
						alert('이미 배정된 fs입니다. 다른행을 선택하십시오.');

				}

			} else {//team테이블 두열 모두 비었을 때
				if (clicked_Fstable_row_cell1.style.backgroundColor != 'rgb(242, 150, 123)') { //fs테이블 fs1열이 선택된적없으면
					//clicked_Teamtable_row_cell1.innerHTML=clicked_Fstable_row_cell1_html;//team 테이블의 fs1에 fs1열 값 저장
					var str = "<input type=text class='tdinput' name="+rowcnt+" value="+clicked_Fstable_row_cell1_html+" readonly>";
					clicked_Teamtable_row_cell1.innerHTML = str;
					clicked_Fstable_row_cell1.style.backgroundColor = "#f2967b";
					if (clicked_Fstable_row_cell2_html != 'null') {//fs테이블의 fs2열이 null이 아닐때만 team테이블 fs2에 넣기
						//clicked_Teamtable_row_cell2.innerHTML=clicked_Fstable_row_cell2_html;//값 저장
						var str = "<input type=text class='tdinput' name="+rowcnt+" value="+clicked_Fstable_row_cell2_html+" readonly>";
						clicked_Teamtable_row_cell2.innerHTML = str;
						clicked_Fstable_row_cell2.style.backgroundColor = "#f2967b";

					}
				} else
					//fs테이블 fs1열이 선택된적있으면
					alert('이미 배정된 fs입니다. 다른행을 선택하십시오.');
			}
		checkmaking=true;
		} else {
			alert('배정할 행을 선택하십시오.');
			return;
		}

	}
</script>
<body>
	<jsp:include page="Admin_Top.jsp" flush="true" />
	<%
		String missionid = request.getParameter("missionid");
	%>
	<div class="missiontitle">
		<b>Mission Team Matching</b>

		<hr class="titleline">
	</div>
	<br>
	<div class="title">
		<br> <i class="fa fa-chevron-circle-right fa-lg"
			aria-hidden="true" style="color: #687672 !important;"></i>
		<n>Exchange Student 팀 배정</n>
		<br> <br>
		<nsub>missionid: <%=missionid%> 미션의 팀 배정입니다.</nsub>
		<br>
		<nsub>* 배정 도중, '추가' 버튼을 누르면 초기화됩니다.</nsub>
		<br>
		<nsub>* 해당 미션에 대해 중복 배정 시, 기존 팀 배정은 사라집니다.</nsub>
		<br>
		<nsub>1. 생성할 팀 수를 입력하여 팀 테이블을 생성해주세요.</nsub>
		<br>
		<nsub>2. 배정할 팀을 클릭한 후, 해당 팀에 배정할 ExchangeStudent를 선택하세요.</nsub>
		<br>
		<nsub>3. 왼쪽방향 화살표를 클릭하여 팀 테이블에 학생들을 배정하세요.</nsub>
		<br>
		<nsub>4. 배정 완료 후, '배정' 버튼을 눌러, 저장해주세요.</nsub>
		<br>


	</div>

	<form name="frm1" method="post" class="make_team">
		<input type="hidden" id="missionid" name="missionid"
			value="<%=missionid%>"> <i class="fa fa-user-plus"
			aria-hidden="true" style="margin-left: 30px;"></i> 생성할 팀 수 : <input
			type=text id=teamnum onkeydown='return onlyNumber(event)'
			onkeyup='removeChar(event)' style="ime-mode: disabled;"
			placeholder="팀의 수" name="teamnum" required> <a
			href="javascript:make_team();" class="make_teambtn" name="add"
			value="추가">추가</a> <a href="javascript:match_team();"
			class="matchingbtn">배정</a> <br> <br>
		<div class="team">
			<table id="myTable" name="teamtable">
				<tr class="header">
					<th style="width: 12%">no</th>
					<th style="width: 22%">fsid1</th>
					<th style="width: 22%">fsid2</th>
					<th style="width: 22%">ksid1</th>
					<th style="width: 22%">ksid1</th>
				</tr>
				<%
					int teamnum = 0;
					if (application.getAttribute("teamnum") != null)
						teamnum = Integer.parseInt((String) application.getAttribute("teamnum"));
					for (int i = 0; i < teamnum; i++) {
				%>
				<tr onclick="javascript:HighlightRow(this,'<%=i%>');"
					name="teamtablerow">
					<td><%=i + 1%></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<%
					}
				%>
			</table>
			<!-- <td><input type="button" class="regiBtn" value="등록"></td>-->
		</div>

	</form>
	<div class="student">
		<table id="myTable" name="fstable">
			<tr class="header">
				<th style="width: 10%">no</th>
				<th style="width: 45%">fsid</th>
				<th style="width: 45%">party</th>
			</tr>
			<%
				int imfffssize = (int) application.getAttribute("imfffssize");
				for (int i = 0; i < imfffssize; i++) {
					IMFFFSBean imfffs = (IMFFFSBean) application.getAttribute("imfffs[" + i + "]");
			%>
			<tr onclick="javascript:HighlightRow2(this);" name="fstablerow">
				<td><%=i + 1%></td>
				<td><%=imfffs.getFsid()%></td>
				<td><%=imfffs.getParty()%></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
	<div style="float: left; margin-left: 80px;">
		<div class="left_arrow" onclick="javascript:add(this);">
			<span style="font-size: 10px;"></span>
		</div>
		<div class="left_arrowpoint"></div>
	</div>
	<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>