<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="test.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/exceldetail.css" />
<script>

function getTimeStamp() {
  var clock = document.getElementById("clock");            // 출력할 장소 선택
  var d = new Date();

  var s =
    leadingZeros(d.getFullYear(), 4) + '-' +
    leadingZeros(d.getMonth() + 1, 2) + '-' +
    leadingZeros(d.getDate(), 2) + ' ' +

    leadingZeros(d.getHours(), 2) + ':' +
    leadingZeros(d.getMinutes(), 2) + ':' +
    leadingZeros(d.getSeconds(), 2);
  clock.innerHTML = s;//현재 시간을 출력
  setTimeout("getTimeStamp()",1000);
}
window.onload=function(){
	getTimeStamp();
}
function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}


</script>

</head>
<body>
<!--jsp:include page="Top.jsp" flush="true" /-->
  
<div class="title">
<br>
<b>버디 일괄처리 상세화면</b>
<hr class="titleline">
</div>
<form action="/ESTIS/AdminBuddyController" method="post" >
<ul><li><strong>업로드 정보</strong></li></ul>
<table class="bluetop">
<tr><th>업로드 일시</th><td><span id="clock"></span></td></tr>
<tr><th>업로드 위치</th><td>Buddy</td></tr>
<tr><th>처리 운영자</th><td><%= request.getRemoteAddr() %></td></tr>
<tr><th>처리 건수 요약</th><td>엑셀: <%= application.getAttribute("buddyvosize") %>건</td></tr>
</table>
<ul><li><strong>업로드 상세 정보</strong></li></ul> 
<table class="bluetop">
<tr><th>번호</th><th>buddyid</th><th>pw</th><th>name</th><th>email</th><th>semester</th><th>language</th></tr>
<%
int size=(Integer)application.getAttribute("buddyvosize");
for(int i=0;i<size;i++) {
	BuddyVo vo=(BuddyVo)application.getAttribute("buddyvo"+i);
%>
<tr><td><%=i+1 %></td><td><%=vo.getBuddyId() %></td><td><%=vo.getBuddyPw() %></td>
	<td><%=vo.getBuddyName() %></td><td><%=vo.getBuddyEmail() %></td><td><%=String.valueOf(vo.getBuddySemester())%></td><td><%=vo.getBuddyLanguage() %></td></tr>
<%} %>

</table>
<div class="helpbox"><img src="/ESTIS/Estis/Img/questionmark.png" height="20" border="0" align="bottom">
<helptitle>일괄 처리 상세 도움말</helptitle><br>
<helpcontents>- '일괄처리' 버튼을 클릭하면, 버디정보의 일괄 처리가 진행됩니다.</helpcontents><br>
<helpcontents>- 일괄처리가 완료된 이후에는 처리 결과에 따른 내역을 정렬해서 볼 수 있습니다.</helpcontents><br>
<helpcontents>- 맞지 않은 양식을 업로드 할 경우, 정상적으로 일괄 처리가 진행되지 않습니다.</helpcontents>

</div>
<div class=accessdiv>
<input type="hidden" name="action" value="upload">
<button type="submit" class="bluebtn">일괄처리</button>
<!--<a class="bluebtn" href="www.naver.com">일괄처리</a>-->
<a class="graybtn" href=javascript:window.close();>닫기</a>
</div>
</form>
<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>