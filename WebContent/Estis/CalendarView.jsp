<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="Date.MakeCalendar" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/calendar.css" />
<title>Insert title here</title>
</head>
<body>
<%
      Calendar calendar = Calendar.getInstance();
      int year = calendar.get(Calendar.YEAR);
      int month = calendar.get(Calendar.MONTH) + 1;

      try {
         year = Integer.parseInt(request.getParameter("year"));
         month = Integer.parseInt(request.getParameter("month"));
      } catch (Exception e) {
      }
      if (month == 0) {
         year--;
         month = 12;
      } else if (month == 13) {
         year++;
         month = 1;
      }
   %>
<div class="C_months">      
  <div class="mul">
     <div class="mli"><input type="button" class="prev" value=&#10094;
               onclick="location.href='/ESTIS/AdminHomeController?year=<%=year%>&month=<%=month - 1%>'"></div>
    <div class="mli"><input type="button"  class="next" value=&#10095;
               onclick="location.href='/ESTIS/AdminHomeController?year=<%=year%>&month=<%=month + 1%>'"></div>
    <div class="mli" style="text-align:center ; background: #1abc9c">
      <%=month%>월<br>
      <span style="font-size:18px ; background: #1abc9c"><%=year%></span>
    </div>
  </div>
</div>

<ul class="weekdays">
  <li>Mo</li>
  <li>Tu</li>
  <li>We</li>
  <li>Th</li>
  <li>Fr</li>
  <li>Sa</li>
  <li>Su</li>
</ul>
<%
               //오늘 날짜 저장.
               Calendar todayCal = Calendar.getInstance();
               SimpleDateFormat sdf = new SimpleDateFormat("yyyMMdd");
               int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));
               System.out.println("intToday= " + intToday);
               int start = MakeCalendar.weekDay(year, month, 1);
               int count;
               out.println("<ul class='days'>" );   
               if (month == 1) {
                  count = MakeCalendar.lastDay(year - 1, 12) - start + 1;
               } else {
                  count = MakeCalendar.lastDay(year, month - 1) - start + 1;
               }
               for (int i = 1; i <= start; i++) {
                  out.println("<li><div class='befor'>"+ (month == 1 ? 12 : month - 1) + "/" + count++ + "</div></li>");
               }

               int week = 0;
               
               for (int i = 1; i <= MakeCalendar.lastDay(year, month); i++) {
                  week = MakeCalendar.weekDay(year, month, i);
                  String buff = null;
                  String buff2 = null;

                  if (1 <= month && month <= 9){
                     buff = Integer.toString(year) + "0"+Integer.toString(month);
                     buff2 = Integer.toString(year) + "/0" + Integer.toString(month);
                  }
                  else{
                     buff = Integer.toString(year)+Integer.toString(month);
                     buff2 = Integer.toString(year) + "/" + Integer.toString(month);
                  }
                     

                  if (1 <= i && i <= 9){
                     buff=buff+"0" + Integer.toString(i);
                     buff2 = buff2 + "/0" + Integer.toString(i);
                  }
                  else{
                     buff=buff+Integer.toString(i);
                     buff2 = buff2 + "/" + Integer.toString(i);
                  }

                  if (intToday == Integer.parseInt(buff)) {
                     
                     out.println("<li><span class='active'>"+i+"</span></li>" );
                  }
                  else {
                     out.println("<li>"+i+"</li>");
                  }
                  
               }
               
               count = 1;
               for (int j = week + 1; j < 7; j++) {
                  out.println("<li><div class='after'>"+ (month == 12 ? 1 : month + 1) + "/" + count++ +"</div></li>");
               }
               out.println("</ul>" );   
            %>
</body>
</html>