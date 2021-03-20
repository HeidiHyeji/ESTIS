<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Beans.BuddyRoomPostingBean"%>
<jsp:useBean id="sns" class="java.util.ArrayList" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/brposting.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>

</head>
<body>

<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
<div class="snsallcontent">
<div style="background-color:black;color:white;padding:3px">
<label></label> 
<div class="clearfix">
      <textarea id="content" name="content" placeholder="내용 입력" style="height: 100px"></textarea>
            <button type="button" class="cancelBtn" onclick="history.go(-1)">Cancel</button>
            <button type="submit" class="addBtn">Add</button>
            <input type="hidden" name="action" value="missionadd">
       </div>
      </div>
<div class="SNS" style="padding:30px 30px auto">
	
 	<%
 	int c =0;
    for(int i=0; i<sns.size(); i++){
        BuddyRoomPostingBean p=(BuddyRoomPostingBean) sns.get(i);%>  
    <br>   
	<div class="snscontent">
	<table>
	<tr>
		<td rowspan="2"><img src="/ESTIS/Estis/Img/buddy.png" alt="Person" width="50" height="50"></td>
		<td><%=p.getWriterid()%></td>
		<td rowspan="2"><%=p.getTitle()%></td>
	</tr>
	<tr><td><%=p.getDate() %></td></tr>
	<tr><td colspan="3"><%=p.getContent() %></td></tr>
	<tr><td colspan="3">댓글 수</td></tr>
	</table>

	
	</div>
	
	<%c++;}//out.println("<script> $(window).bind('scroll',ss("+c+"));</script>");%>
	
	 <br>   
</div>
</div>
<script>
// When the user scrolls down 20px from the top of the document, show the button
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
        document.getElementById("myBtn").style.display = "block";
    } else {
        document.getElementById("myBtn").style.display = "none";
    }
}

// When the user clicks on the button, scroll to the top of the document
function topFunction() {
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 0;
}
</script>
<!-- script>
$(function(){
    //$(window).scroll(function() { });
    
    //문서가 로드되면 10 row 생성 그리고 생성이 완료되면 scroll 이벤트 바인딩

        $(window).bind("scroll",ss);// bind 이벤트 묶기, 스크롤이 발생했을때 ss function 실행

    function ss(count) {
		var count= count;
        //현재문서의 높이를 구함.
        var documentHeight  = $(document).height();
        //console.log("documentHeight : " + documentHeight);
        
        //scrollTop() 메서드는 선택된 요소의 세로 스크롤 위치를 설정하거나 반환    
        //스크롤바가 맨 위쪽에 있을때 , 위치는 0
        //console.log("window의 scrollTop() : " + $(window).scrollTop()); 
        //height() 메서드는 브라우저 창의 높이를 설정하거나 반환
        //console.log("window의 height() : " + $(window).height());
        
        //세로 스크롤위치 max값과 창의 높이를 더하면 현재문서의 높이를 구할수있음.
        //세로 스크롤위치 값이 max이면 문서의 끝에 도달했다는 의미x`
        var scrollHeight = $(window).scrollTop()+$(window).height();         
        //console.log("scrollHeight : " + scrollHeight);

            
        if(scrollHeight == documentHeight) { //문서의 맨끝에 도달했을때 내용 추가 
            	 $("<h1>"+count+test+"</h1>").appendTo("body");				
        }
    }//function infinityScrollFunction()
});

</script-->
</body>
</html>