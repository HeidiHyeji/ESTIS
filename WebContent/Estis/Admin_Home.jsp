<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="test.*"%>
<%@ page import="Date.*"%>
<%@ page import="DAO.*" %>
<%@ page import="java.util.*"%>
<%@ page import="Beans.*" %>
<%@ page import="SystemMonitoring.*"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css"
   href="/ESTIS/Estis/Css/adminhome.css" />
   <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> <!-- 배지 -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script><!-- 배지 -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script><!-- 배지-->
<!-- 구글 API그래프 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
   
   <title>Insert title here</title>
   <%
      /*가입자 수 출력*/
      WriterDAO writerdao=WriterDAO.getInstance();
      DateCalc d= new DateCalc();
      
      int today=writerdao.getCount(d.getOtherInitDate(0,0,0,0),d.getOtherInitDate(0,23,59,59)); //오늘 멤버수
      int before1=writerdao.getCount(d.getOtherInitDate(-1,0,0,0),d.getOtherInitDate(-1,23,59,59));//어제 멤버수
      int before2=writerdao.getCount(d.getOtherInitDate(-2,0,0,0),d.getOtherInitDate(-2,23,59,59));//글피 멤버수
      int before3=writerdao.getCount(d.getOtherInitDate(-3,0,0,0),d.getOtherInitDate(-3,23,59,59));//사흘 멤버수
      String t=d.getOtherDay(0);
      String b1=d.getOtherDay(-1);
      String b2=d.getOtherDay(-2);
      String b3=d.getOtherDay(-3);
      
      /*멤버수 출력*/
      KSDAO ksdao=KSDAO.getInstance();
      FSDAO fsdao=FSDAO.getInstance();
      
   %>
<script type="text/javascript">
   /*구글그래프*/
   google.charts.load('current', {
      'packages' : [ 'corechart' ]
   });
   google.charts.setOnLoadCallback(drawChart);

   function drawChart() {
      var data = google.visualization.arrayToDataTable([
            [ 'Days', '가입자 수' ],
            [ <%=b3%>,<%=before3%> ],
            [ <%=b2%>,<%=before2%> ],
            [ <%=b1%>,<%=before1%> ], 
            [ <%=t%>,<%=today%> ]
             ]);

      var options = {
         title : 'Number of subscribers',
         curveType : 'function',
         legend : {
            position : 'bottom'
         },
         series: {
               0: { color: '#d1a827' }
               //,1: { color: '#687672' }
             },
             hAxis: {
                  viewWindow: {
                      min: <%=b3%>,
                      max: <%=t%>
                  },
                  ticks: [<%=b3%>, <%=b2%>, <%=b1%>, <%=t%>] // display labels every 25
              }
      
      };

      var chart = new google.visualization.LineChart(document
            .getElementById('curve_chart'));

      chart.draw(data, options);
   }

    google.charts.load("current", {packages:["corechart"]});
    google.charts.setOnLoadCallback(drawChart2);
    function drawChart2() {
      var data = google.visualization.arrayToDataTable([
        ['Composition', 'Member per Total'],
        ['ES',     <%=fsdao.getCount()%>],
        ['KS',     <%=ksdao.getCount()%>],
        ['Buddy',  16],
        ['Admin', 1]
      ]);

      var options = {
        title: 'Member Composition ratio',
        pieHole: 0.3,
        pieSliceTextStyle: {
            color: 'black',
          },
      colors: ['#a1bbd0','#d1a827','#d5ed96','#3f4234']

      };

      var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
      chart.draw(data, options);
    }

 
    
   /*날짜함수*/
   function printDate() {
      var sdate = document.getElementById("date"); 
        var date = new Date();
        var day  = date.getDate();
        var month = date.getMonth() + 1;
        var year = date.getYear();
        year = (year < 1000) ? year + 1900 : year;

        var s=year + "년 "+ month + "월 " + day + "일 ";
        sdate.innerHTML=s;
 }
window.onload=function(){
   printDate();
}


</script>

</head>
<jsp:include page="Admin_Top.jsp" flush="true" />
<body style="background-color:#f2f5f5;">
      
      <!--좌측메뉴-->
   <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" align='center'>
    <tr>
        <td width="80%" align="center">
      <br>
      <div class="admindiv">
      To do&nbsp&nbsp<span id="date" class="datestyle"></span>
      </div>
      <br>
   <!-- 오늘의 할일(테이블) -->
      <%
      ArrayList<MissionBean> missionlist
         =(ArrayList<MissionBean>)application.getAttribute("missionlist");
      

      %>
   <div class="adminhometop">
      <span class="counter"><%=d.getRecruitCount(missionlist) %></span>
      <h6>모집중</h6>
   </div>
      <div class="adminhometop">
      <span class="counter"><%=d.getSelectCount(missionlist) %></span>
      <h6>선별중</h6>
   </div>
      <div class="adminhometop">
      <span class="counter"><%=d.getCompleteCount(missionlist) %></span>
      <h6>모집완료</h6>
   </div>
      <div class="adminhometop">
      <span class="counter"><%=d.getActiveCount(missionlist) %></span>
      <h6>활동중</h6>
   </div>
      <div class="adminhometop">
      <span class="counter"><%=d.getFinishCount(missionlist) %></span>
      <h6>종료</h6>
   </div>

   
      
      
             <!-- 요약 그래프 -->
        <div id="curve_chart" class="adminlinegraph"></div>
      <div id="donutchart" class="adminlinegraph2"></div>
      
      
      <!-- 탭부분 -->
   <%
   ArrayList<ArrayList<String>> imffksTot
         =(ArrayList<ArrayList<String>>)application.getAttribute("imffksTot");

   %>
      <div style="margin:20px;">
      <ult class="tab" id="tab">
   <lit class="tabOverClass fir" overcss="tabOverClass" outcss="tabOutClass fir">외친소신청</lit>
   <lit class="tabOutClass" overcss="tabOverClass" outcss="tabOutClass">미션 상태</lit>
</ult>
<div class="image_list" id="image_list">
   <div class="images content_frame" style="display:block; width:90%; padding:10px 0;"><!--탭1:외친소신청contents-->
      <div id="media" class="news">
      <div class="fa-ul" style="text-align: left !important; width: 100% !important;">
      
         <%for(int i=0;i<imffksTot.size();i++){
            ArrayList<String> imffks_data=imffksTot.get(i);
            out.println("<span><i class='fa fa-bullhorn' aria-hidden='true'></i>&nbsp");   
            out.println(imffks_data.get(0)); 
            out.println("</span><r>"+imffks_data.get(1)+"</r>");
            out.println("<br>");
         }
         %>
      </div>
      
      </div>
      
   </div>
   <div class="images content_frame" style="width:90%;  padding:10px 0;">
      <div class="fa-ul" style="text-align: left !important; width: 100% !important;">
    <%
       for(int i=0;i<6;i++){ 
          if(i>=missionlist.size()) break; //최대 6개 까지 출력하고자 하는데 리스트 사이즈가 6개이하이면 break 
          MissionBean mission=missionlist.get(i);
          String result=d.dateCalc(mission.getApplystart(),mission.getApplyend(),
              mission.getPerformstart(), mission.getPerformend(),mission.getResultdate());
          String str="'"+mission.getTitle()+"' 미션이 현재 '"+result+"' 상태에 있습니다.";
          out.println("<span><i class='fa fa-bullhorn' aria-hidden='true'></i>&nbsp");   
         out.println(str); 
         out.println("</span>");
         out.println("<br>");
       }
    %>
       </div>
   </div>
</div>
      
      </div><!-- 탭부분 끝 -->
   
   
      </td>
      
      <% 
         Boolean imffupdate=(Boolean)request.getAttribute("Admin_Imff.jsp");
         Boolean brupdate=(Boolean)request.getAttribute("Admin_BuddyRoom.jsp");         
      %>
        <td width="20%" align="center">
      
      <div id='right_banner'>
         <br><br>
         <header><jsp:include page="CalendarView.jsp" flush="false" /></header>
<ul>
  <li><a href="/ESTIS/Estis/Admin_Imff.jsp">외친소<% if(imffupdate==true){%>
     <span class="badge" style="font-size:6px;background-color:#FA8072;">N</span> 
     <%}else{}%></a>
     </li>
  <li><a href="/ESTIS/BuddyController?action=list">버디룸<% if(brupdate==true){%>
     <span class="badge" style="font-size:6px; background-color:#FA8072;">N</span>
     <%}else{}%></a></li>
</ul>
      <br><br></div>
      </td><!-- http://javastudy.tistory.com/82 서버pc메모리 출력 -->

    </tr>
</table>
      
      
   
   <jsp:include page="Bottom.jsp" flush="true" />
   <script type="text/javascript">
   new tabView({menu:"tab", menuTag:"LIT", callEvent:"click", imageArea:"image_list", imageTag:"DIV"});
   //new tabView({menu:"tab2", menuTag:"IMG", callEvent:"mouseover", imageArea:"image_list_2", imageTag:"DIV"});

   function tabView(json){
      /*
      if(json.callEvent == "mouseover"){
         e(json.menu).onmouseover = function(event){
            var tabs = tn(e(json.menu), json.menuTag);
            var evt = event || window.event;
            var t = evt.target || evt.srcElement;
            
            for(n in tabs){
               if(tabs[n] == t){
                  viewContent(n);
                  rollOver(t);
                  break;
               }
            }
         }
      }else */if(json.callEvent == "click"){
         e(json.menu).onclick = function(event){
            var tabs = tn(e(json.menu), json.menuTag);
            var evt = event || window.event;
            var t = evt.target || evt.srcElement;
            
            for(n in tabs){
               if(tabs[n] == t){
                  viewContent(n);
                  //rollOver(event.srcElement);
                  rollOver(t);
                  break;
               }
            }
         }
      };
      

      //내용 보이기
      function viewContent(nIdx){
         var els = tn(e(json.imageArea), json.imageTag);
         if(els.length == 0) return;
         var arr = new Array();
         
         for(n=0; n<els.length; n++){
            if(els[n].getAttribute('class').indexOf('content_frame') > 0 ){
               arr.push(els[n]);
            }
         }

         for(n=0; n<arr.length; n++){
            if(typeof arr[n]=="object"){
               if(n==nIdx){
                  arr[n].style.display = "block";   
               }else{
                  arr[n].style.display = "none";
               }
            }
         }
      }

      //라벨 onmouseover 시 클래스 적용
      function rollOver(obj){
         //if(c.label == null) return;
         //var els = c.label.getElementsByTagName(c.labelType);
         var els = tn(e(json.menu), json.menuTag);
         if(els.length==0) return;
         /*
         if(json.menuTag == "IMG"){
            for(n in els){
               if(typeof els[n] == "object"){
                  if(els[n] == obj){
                     els[n].src = els[n].getAttribute("oversrc");
                  }else{
                     els[n].src = els[n].getAttribute("outsrc");
                  }
               }
            }
         }else */if(json.menuTag=="LIT"){
            for(n in els){
               if(typeof els[n] == "object"){
                  if(els[n] == obj){
                     var ocss = els[n].className;
                     els[n].className = ocss+" "+els[n].getAttribute("overcss");
                  }else{
                     els[n].className = els[n].getAttribute("outcss");
                  }
               }
            }
         }
      }// e function rollOver(obj){
   }


   //객체 반환
   function e(id){
      return document.getElementById(id);
   }

   //pa에 속한 태그들 반환
   function tn(pa, tagName){
      return pa.getElementsByTagName(tagName);
   }
   </script>
</body>
</html>