<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="DAO.FSDAO"  %>
<%@ page import="Beans.FSBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/adminfs.css" />




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
function showDetail(fsid){

	var f= document.frm2;

	 var cw=screen.availWidth;     //화면 넓이
	 var ch=screen.availHeight;    //화면 높이
	 var sw=520;    //띄울 창의 넓이
	 var sh=630;    //띄울 창의 높이

	 var ml=(cw-sw)/2;        
	 var mt=(ch-sh)/2;         

	var gsWin = window.open("about:blank", "winName",'scrollbars=yes,resizable=yes,width='+sw+',height='+sh+',top='+mt+',left='+ml+'');
    //var fr = document.frm1;
    f.action = "/ESTIS/AdminFSController?detail="+fsid;
    frm2.target = "winName";
    frm2.submit();
	
}
function showSMS(sms){

	var chk=document.getElementsByName("check");
	var checkRow;
	for(var i=0; i<chk.length; i++){
		if(chk[i].checked == true) checkRow=true;
	}
	if(checkRow == true){
		
		   var f= document.frm2;

		    var cw=screen.availWidth;     //화면 넓이
		    var ch=screen.availHeight;    //화면 높이
		    var sw=520;    //띄울 창의 넓이
		    var sh=630;    //띄울 창의 높이

		    var ml=(cw-sw)/2;        
		    var mt=(ch-sh)/2;         

		   var gsWin = window.open("about:blank", "winName",'scrollbars=yes,resizable=yes,width='+sw+',height='+sh+',top='+mt+',left='+ml+'');
		    //var fr = document.frm1;
		    f.action = "/ESTIS/AdminFSController?action="+sms;
		    frm2.target = "winName";
		    frm2.submit();
	 }
	else{
	    alert('변경할 행을 선택하십시오.');
	    return;
	   }
	

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
		function func(command)
		{
			var chk=document.getElementsByName("check");
			var checkRow;
			for(var i=0; i<chk.length; i++){
				if(chk[i].checked == true) checkRow=true;
			}
			if(checkRow == true){
				document.frm2.action="/ESTIS/AdminFSController?action="+command;
			    frm2.submit();
			 }
			else{
			    alert('변경할 행을 선택하십시오.');
			    return;
			   }
		}
		function withdraw(id)
		{
			
				document.frm2.action="/ESTIS/AdminFSController?withdraw="+id;
			    frm2.submit();
		}
</script>
</head>
<body>
	<!--메뉴-->
	<jsp:include page="Admin_Top.jsp" flush="true" />
	<!--내용-->
	<div class="missiontitle">
   <b>Exchange Student Management</b> 
</div>
<form name="frm1" method="post" action="/ESTIS/AdminFSController?action=start" enctype="multipart/form-data">
		<TABLE class="excelupload">
			<TR><TD colspan="2"><B>**주의사항**</B><TD><TR>
			<TR><TD colspan="2">*엑셀파일만 업로드 가능합니다.</TD></TR>
			<TR><TD colspan="2">*첫번째 시트에 데이터가 있어야 합니다.[시트명:Sheet1]</TD></TR>
			<TR><TD colspan="2">*엑셀 작성 시 중간에 빈줄이 없어야 합니다.</TD></TR>
			<TR><TD colspan="2">*엑셀 작성 시 수식이 없어야 합니다.</TD></TR>
			<tr>
				<td colspan="2">
				<a href="Template/ExcelTemplate2.xls" class="formdownloadbtn">양식 다운로드</a>
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
	
<form name="frm2" method="post" action="/ESTIS/AdminFSController" >
	<table id="myTable">
		<tr class="header">
			<th style="width: 3%;">no</th>
			<th style="width: 5%;" scope="col"><input type="checkbox" name="checkall" onclick="javascript:CheckAll()">
			<th style="width: 15%;">fsid</th>
			<th style="width: 15%;">pw</th>
			<th style="width: 5%;">name</th>
			<th style="width: 5%;">email</th>
			<th style="width: 5%;">language</th>
			<th style="width: 10%;">sid</th>
			<th style="width: 10%;">buddyid</th>
			<th style="width: 27%;text-align : right;">detail</th>
		</tr>
		<%
			int no=1;
			int pagenum=1;//페이지 번호
			FSDAO dao=FSDAO.getInstance();
			
			if(request.getParameter("memberPage")!=null){
				pagenum = Integer.parseInt(request.getParameter("memberPage"));
			}
			int size=15;
			int tot;
			int cnt=dao.getCount();
			tot=cnt/size;
			if(cnt%size != 0){
				tot++;
			}
			int start=(pagenum-1)*size;
			int end=pagenum*size-1;
			
			ArrayList<FSBean> FSlist=dao.getAllFS(start,end);
			if(FSlist.size()>0){
				for(int i=0; i<FSlist.size(); i++){
					FSBean fs=(FSBean)FSlist.get(i);
			
		%>
		<tr>
			<td style="color: #687672"><%=no++ %></td>
			<td><input type="checkbox" id="check" name="check" value="<%=fs.getFsid()%>"></td>
			<td><%=fs.getFsid()%></td>
			<td class="ellipsis"><%=fs.getPw() %></td>
			<td><%=fs.getName() %></td>
			<td class="ellipsis"><%=fs.getEmail() %></td>
			<td><%=fs.getLanguage() %></td>
			<td><%=fs.getSid() %></td>
			<td><%=fs.getBuddyid() %></td>
			<td style="text-align : right;"><a href="javascript:showDetail('<%=fs.getFsid()%>');" class="detailbtn">detail</a>
				<a href="javascript:withdraw('<%=fs.getFsid()%>');" class="withdrawbtn">withdraw</a><!-- 강퇴 -->
			</td>
			
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
	    	<a <%if(pagenum-1>=1) out.println("href='Admin_FS.jsp?memberPage="+(pagenum-1)+"'"); 
		    %>>&laquo;</a>
	    	<%for(int i = 1; i<=tot; i++){ 
	    		if(pagenum==i){
	    	%>
	  				<a class="active"><%=i%></a>
	 		<%	}else{%>
	    			<a href="Admin_FS.jsp?memberPage=<%=i%>"><%=i%></a>
	    	<% 	} 
	    	}%>
		    <a <%if(pagenum+1<=tot) out.println("href='Admin_FS.jsp?memberPage="+(pagenum+1)+"'"); 
		    %>>&raquo;</a>
		</div>
	</div>
	
	<br>
	<!-- 맨 밑 버튼 -->
	<div  class="clearfix">
		<button type="button" class="smsbtn" onclick="javascript:showSMS('sms')">sms 전송</button><!-- 미구현 -->
		<button type="button" class="initbtn" onclick="javascript:func('init')">pw 초기화</button>
    </div>
	
	
</form>
	<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>