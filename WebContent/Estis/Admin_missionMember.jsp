<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="DAO.IMFFFSDAO"%>
<%@ page import="Beans.IMFFFSBean"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css"
	href="/ESTIS/Estis/Css/adminmission.css" />
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<title>Insert title here</title>
<%String missionid=(String)request.getParameter("missionid"); %>
</head>
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

</script>
<body>
	<!--메뉴-->
	<jsp:include page="Admin_Top.jsp" flush="true" />
	<!--내용-->
	<div class="missiontitle">
		<b>외친소 Mission Member Management</b>
		<hr class="titleline">
	</div>
	<br>
	<div class="title">
		<br> <i class="fa fa-chevron-circle-right fa-lg"
			aria-hidden="true" style="color: #687672 !important;"></i>
		<n>Exchange Student 미션 신청 관리</n>
	</div>
	<div class="detail_mLpeople">
		<i class="fa fa-smile-o" aria-hidden="true" style="background-color: yellow !important;"></i>
		<ml>신청현황</ml>
		&nbsp&nbsp
		<a href="/ESTIS/AdminIMFFMatchingController?missionid=<%=missionid%>&matching=complete" class="teamcurrentbtn">팀 현황 보기</a>
	</div>
	<div class="detail_ks2">
		한국인 학생:&nbsp<%=request.getParameter("imffkscnt")%>&nbsp명
		<div class="detail_fs2">외국인 학생:&nbsp<%=request.getParameter("imfffscnt")%>&nbsp명</div>
	</div>
<form name="frm1" method="post" action="/ESTIS/AdminIMFFMemberController?action=start" enctype="multipart/form-data">
		<TABLE class="excelupload">
			<TR><TD colspan="2"><B>**주의사항**</B><TD><TR>
			<TR><TD colspan="2">*엑셀파일만 업로드 가능합니다.</TD></TR>
			<TR><TD colspan="2">*첫번째 시트에 데이터가 있어야 합니다.[시트명:Sheet1]</TD></TR>
			<TR><TD colspan="2">*엑셀 작성 시 중간에 빈줄이 없어야 합니다.</TD></TR>
			<TR><TD colspan="2">*엑셀 작성 시 수식이 없어야 합니다.</TD></TR>
			<tr>
				<td colspan="2">
				<a href="Template/ExcelTemplate3.xls" class="formdownloadbtn">양식 다운로드</a>
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
	
<form name="frm2" method="post" >
	<table id="myTable">
		<tr class="header">
			<th style="width: 3%;">no</th>
			<th style="width: 15%;">imfffsid</th>
			<th style="width: 15%;">fsid</th>
			<th style="width: 15%;">party</th>
			<th style="width: 15%;">missionid</th>
		</tr>
		<%
			
			int no=1;
			int pagenum=1;//페이지 번호
			IMFFFSDAO dao=IMFFFSDAO.getInstance();
			
			//페이징 하기
			
			if(request.getParameter("memberPage")!=null){
				pagenum = Integer.parseInt(request.getParameter("memberPage"));
			}
			int size=15;
			int tot;
			int cnt=dao.getCount(missionid);
			tot=cnt/size;
			if(cnt%size != 0){
				tot++;
			}
			
			int start=(pagenum-1)*size;
			int end=pagenum*size-1;
		
			//리스트 띄우기
			ArrayList<IMFFFSBean> imfffslist=dao.getIMFFFS(missionid);
			
			if(imfffslist.size()>0){
				for(int i=0; i<imfffslist.size(); i++){
					IMFFFSBean imfffs=(IMFFFSBean)imfffslist.get(i);
		%>
		<tr>
			<td style="color: #687672"><%=no++ %></td>
			<td><%=imfffs.getImfffsid()%></td>
			<td><%=imfffs.getFsid() %></td>
			<td><%=imfffs.getParty() %></td>
			<td class="ellipsis"><%= imfffs.getMissionid()%></td>
			
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
	    	<a <%if(pagenum-1>=1) out.println("href='Admin_missionMember.jsp?memberPage="+(pagenum-1)+"'"); 
		    %>>&laquo;</a>
	    	<%for(int i = 1; i<=tot; i++){ 
	    		if(pagenum==i){
	    	%>
	  				<a class="active"><%=i%></a>
	 		<%	}else{%>
	    			<a href="Admin_missionMember.jsp?memberPage=<%=i%>"><%=i%></a>
	    	<% 	} 
	    	}%>
		    <a <%if(pagenum+1<=tot) out.println("href='Admin_missionMember.jsp?memberPage="+(pagenum+1)+"'"); 
		    %>>&raquo;</a>
		</div>
	</div>

	<br>
	<div class="over">
	<a href="/ESTIS/AdminIMFFMatchingController?missionid=<%=missionid%>&matching=imfffs">팀배정 시작하기</a> </div>
	
</form>


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>