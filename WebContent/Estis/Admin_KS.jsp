<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="DAO.KSDAO"  %>
<%@ page import="Beans.KSBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/adminks.css" />




<title>Insert title here</title>
<script type="text/javascript">
function showDetail(ksid){

	var f= document.frm1;

	 var cw=screen.availWidth;     //화면 넓이
	 var ch=screen.availHeight;    //화면 높이
	 var sw=520;    //띄울 창의 넓이
	 var sh=630;    //띄울 창의 높이

	 var ml=(cw-sw)/2;        
	 var mt=(ch-sh)/2;         

	var gsWin = window.open("about:blank", "winName",'scrollbars=yes,resizable=yes,width='+sw+',height='+sh+',top='+mt+',left='+ml+'');
    //var fr = document.frm1;
    f.action = "/ESTIS/AdminKSController?detail="+ksid;
    frm1.target = "winName";
    frm1.submit();
	
}
function showSMS(sms){

	var chk=document.getElementsByName("check");
	var checkRow;
	for(var i=0; i<chk.length; i++){
		if(chk[i].checked == true) checkRow=true;
	}
	if(checkRow == true){
		
		   var f= document.frm1;

		    var cw=screen.availWidth;     //화면 넓이
		    var ch=screen.availHeight;    //화면 높이
		    var sw=520;    //띄울 창의 넓이
		    var sh=630;    //띄울 창의 높이

		    var ml=(cw-sw)/2;        
		    var mt=(ch-sh)/2;         

		   var gsWin = window.open("about:blank", "winName",'scrollbars=yes,resizable=yes,width='+sw+',height='+sh+',top='+mt+',left='+ml+'');
		    //var fr = document.frm1;
		    f.action = "/ESTIS/AdminKSController?action="+sms;
		    frm1.target = "winName";
		    frm1.submit();
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
				document.frm1.action="/ESTIS/AdminKSController?action="+command;
			    frm1.submit();
			 }
			else{
			    alert('변경할 행을 선택하십시오.');
			    return;
			   }
		}
		function withdraw(id)
		{
			
				document.frm1.action="/ESTIS/AdminKSController?withdraw="+id;
			    frm1.submit();
		}
</script>
</head>
<body>
	<!--메뉴-->
	<jsp:include page="Admin_Top.jsp" flush="true" />
	<!--내용-->
	<div class="missiontitle">
   <b>Korean Student Management</b> 
</div>

<form name="frm1" method="post" action="/ESTIS/AdminKSController" >
	<table id="myTable">
		<tr class="header">
			<th style="width: 3%;">no</th>
			<th style="width: 5%;" scope="col"><input type="checkbox" name="checkall" onclick="javascript:CheckAll()">
			<th style="width: 15%;">ksid</th>
			<th style="width: 15%;">pw</th>
			<th style="width: 5%;">name</th>
			<th style="width: 5%;">email</th>
			<th style="width: 5%;">language</th>
			<th style="width: 10%;">sid</th>
			<th style="width: 37%;text-align : right;">detail</th>
		</tr>
		<%
			int no=1;
			int pagenum=1;//페이지 번호
			KSDAO dao=KSDAO.getInstance();
			
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
			
			ArrayList<KSBean> KSlist=dao.getAllKS(start,end);
			if(KSlist.size()>0){
				for(int i=0; i<KSlist.size(); i++){
					KSBean ks=(KSBean)KSlist.get(i);
			
		%>
		<tr>
			<td style="color: #687672"><%=no++ %></td>
			<td><input type="checkbox" id="check" name="check" value="<%=ks.getKsid()%>"></td>
			<td><%=ks.getKsid()%></td>
			<td class="ellipsis"><%=ks.getPw() %></td>
			<td><%=ks.getName() %></td>
			<td class="ellipsis"><%=ks.getEmail() %></td>
			<td><%=ks.getLanguage() %></td>
			<td><%=ks.getSid() %></td>
			<td style="text-align : right;"><a href="javascript:showDetail('<%=ks.getKsid()%>');" class="detailbtn">detail</a>
				<a href="javascript:withdraw('<%=ks.getKsid()%>');" class="withdrawbtn">withdraw</a><!-- 강퇴 -->
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
	    	<a <%if(pagenum-1>=1) out.println("href='Admin_KS.jsp?memberPage="+(pagenum-1)+"'"); 
		    %>>&laquo;</a>
	    	<%for(int i = 1; i<=tot; i++){ 
	    		if(pagenum==i){
	    	%>
	  				<a class="active"><%=i%></a>
	 		<%	}else{%>
	    			<a href="Admin_KS.jsp?memberPage=<%=i%>"><%=i%></a>
	    	<% 	} 
	    	}%>
		    <a <%if(pagenum+1<=tot) out.println("href='Admin_KS.jsp?memberPage="+(pagenum+1)+"'"); 
		    %>>&raquo;</a>
		</div>
	</div>
	
	<br>
	
	<div  class="clearfix">
		<button type="button" class="smsbtn" onclick="javascript:showSMS('sms')">sms 전송</button><!-- 미구현 -->
		<button type="button" class="initbtn" onclick="javascript:func('init')">pw 초기화</button>
    </div>
	
	
</form>
	<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>