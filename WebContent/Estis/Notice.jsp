<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Beans.NoticeBean, Date.DateCalc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="userinfo" class="Beans.WriterBean" scope="session" />
<jsp:useBean id="noticeAll" class="java.util.ArrayList" scope="session" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/list.css" />
</head>
<body>
<jsp:include page="Top.jsp" flush="true" />

<table class="listTitle">
      <tr>
        <td>
           &nbsp;<b>Notice</b>
            <br>&nbsp;공지사항 방입니다^O^
         </td>
         <%if(userinfo.getAttri().equals("administrator")){ %>
         <td>
          <!-- 공지사항 추가 버튼 -- // **관리자만 이용**-->
            <form class="listAddBtn" action="/ESTIS/NoticeController" method="post">
            <button class="listAddBtn" type="submit">
            <img src="/ESTIS/Estis/Img/add.png"></button>
            <input type="hidden" name="action" value="add">
            </form>
         </td>
         <%} %>
      </tr>
</table>
<input type="text" id="myInput" onkeyup="myFunction()" 
placeholder="Search for title" title="Type in a name">
   
<table id="myTable">
   <tr class="header">
      <th style="width: 5%;">#</th>
      <th style="width: 15%;">Part</th>
      <th style="width: 60%;">Title</th>
      <th style="width: 20%;">Date</th>
   </tr>
   <!-- 디비 받아서 for문으로 추가! -->
   <%
      for(int i=0; i<noticeAll.size(); i++){
         NoticeBean notice = (NoticeBean)noticeAll.get(i);
      
   %>
   <tr style="cursor: pointer;"
         onclick="location.href='NoticeController?action=detail&noticeid=<%=notice.getNoticeid()%>'">
      <td><%=notice.getNoticeid() %></td>
      <td><%=notice.getHeader() %></td>
      <td><%=notice.getTitle() %></td>
      <% DateCalc d = new DateCalc(); %>
      <td><%=d.getDate(notice.getDate()) %></td>
   </tr>
   <%
      }
   %>
</table>

<script>
function myFunction() {
   var input, filter, table, tr, td, i;
   input = document.getElementById("myInput");
   filter = input.value.toUpperCase();
   table = document.getElementById("myTable");
   tr = table.getElementsByTagName("tr");
   for (i = 0; i < tr.length; i++) {
      td = tr[i].getElementsByTagName("td")[2];
      if (td) {
         if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
            tr[i].style.display = "";
         } else {
            tr[i].style.display = "none";
         }
      }
   }
}
</script>
<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>