<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DAO.BuddyDAO"  %>
<%@ page import="java.util.*" %>
<%@ page import="Beans.BuddyBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/missionList.css" />
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/apply.css" />
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/adminbuddy.css" />


<title>Insert title here</title>
<script type="text/javascript">
	function goInsert(){

		var f= document.frm1;
		
		if(f.file1.value==""){
			alert("파일을 선택해 주세요.");
			return;
		}
		
		var thumbext = f.file1.value; //파일을 추가한 input 박스의 값
		thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
		if(thumbext != "xls"){ //확장자를 확인합니다.
			alert('엑셀 파일(xls)만 등록 가능합니다.');
			return;
		}
		var gsWin = window.open("about:blank", "winName",'scrollbars=yes,resizable=yes, top=100px, left=100px, height=700px, width=950px');
        var fr = document.frm1;
        //fr.action = "/ESTIS/AdminBuddyController?action=start";
        frm1.target = "winName";
        frm1.submit();
		
	}
	//체크박스 동작

		function CheckAll() {
			var chkall = document.getElementsByName("checkall");
			var chk = document.getElementsByName("check");
			if (chkall[0].checked == true) {
				for (var i = 0; i < chk.length; i++) {
					chk[i].checked = true; //모두 체크
				}
			} else {
				for (var i = 0; i < chk.length; i++) {
					chk[i].checked = false; //모두 해제
				}
			}
		}
		function init(init)
		{
			var chk=document.getElementsByName("check");
			var checkRow;
			for(var i=0; i<chk.length; i++){
				if(chk[i].checked == true) checkRow=true;
			}
			if(checkRow == true){
				document.frm2.action="/ESTIS/AdminBuddyController?init="+init;
			    frm2.submit();
			 }
			else{
			    alert('변경할 행을 선택하십시오.');
			    return;
			   }
		}
</script>
</head>
<body>
	<!--메뉴-->
	<jsp:include page="Admin_Top.jsp" flush="true" />
	<!--내용-->
	<div class="missiontitle">
   <b>버디 관리</b> 
</div>
<form name="frm1" method="post" action="/ESTIS/AdminBuddyController?action=start" enctype="multipart/form-data">
		<TABLE class="excelupload">
			<TR><TD colspan="2"><B>**주의사항**</B><TD><TR>
			<TR><TD colspan="2">*엑셀파일만 업로드 가능합니다.</TD></TR>
			<TR><TD colspan="2">*첫번째 시트에 데이터가 있어야 합니다.[시트명:Sheet1]</TD></TR>
			<TR><TD colspan="2">*엑셀 작성 시 중간에 빈줄이 없어야 합니다.</TD></TR>
			<tr>
				<td colspan="2">
				<a href="Template/ExcelTemplate.xls" class="formdownloadbtn">양식 다운로드</a>
				</td>
			</tr>
			<tr height="5"><td></td></tr>
			<tr>
				<td><input type="file" name="file1" size="80"></td>
				<td colspan="2" align="center">
					<a href="javascript:goInsert();" class="excelstartbtn">일괄처리 시작</a>
				</td>
			</tr>
				
		</TABLE>
	</form>
	<hr>
<form name="frm2" method="post" action="/ESTIS/AdminBuddyController" >
	<input type="hidden" name="action" value="init">
	<table id="myTable">
		<tr class="header">
			<th style="width: 5%;" scope="col"><input type="checkbox" name="checkall" onclick="javascript:CheckAll()">
			<th style="width: 15%;">buddy</th>
			<th style="width: 15%;">pw</th>
			<th style="width: 15%;">name</th>
			<th style="width: 20%;">email</th>
			<th style="width: 5%;">semester</th>
			<th style="width: 5%;">language</th>
		</tr>
		<%
			BuddyDAO dao=BuddyDAO.getInstance();
			ArrayList<BuddyBean> buddylist=dao.getAllBuddy();
			if(buddylist.size()>0){
				for(int i=0; i<16; i++){
				//ProjectBean project = (ProjectBean)projectlist.get(i);
					BuddyBean buddy=(BuddyBean)buddylist.get(i);
			
		%>
		<tr>
			<td><input type="checkbox" id="check" name="check" value="<%=buddy.getBuddyid()%>"></td>
			<td><%=buddy.getBuddyid()%></span></td>
			<td><%=buddy.getPw() %></td>
			<td><%=buddy.getName() %></td>
			<td><%=buddy.getEmail() %></td>
			<td><%=buddy.getSemester() %></td>
			<td><%=buddy.getLanguage() %></td>
		</tr>
		<% 		}
			}
		%>
	
	</table>
	
	<div class="clearfix">
		<button type="button" class="signupbtn" onclick="javascript:init('all')">전체 데이터 초기화</button>
		<button type="button" class="cancelbtn" onclick="javascript:init('pw')">pw 초기화</button>
    </div>
	
	
</form>
	<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>