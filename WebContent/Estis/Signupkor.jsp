<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="alerter" class="Beans.InputResult" scope="request" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/signup.css" />
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/AlertMessages.css" />

</head>
<body background="/ESTIS/Estis/Img/back.png">
<div id="Error"><%=alerter.getAlert() %></div>
<!--회원가입-->   
<h2>회원가입</h2>
<div class="content">
<form action="/ESTIS/SignupController" method="post" style="border:1px solid #ccc">
   <div class="container">
      <label><b>이름</b></label> 
      <input type="text" placeholder="이름을 입력해주세요." name="name" required> 
      
      <label><b>전공</b></label>
      <input type="text" placeholder="전공을 입력해주세요." name="major" required>
      
      <label><b>학번</b></label> 
      <input type="text" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' placeholder="학번을 입력해주세요." name="sid" required> 
      
      <label><b>핸드폰 번호</b></label> 
      <input type="text" placeholder="핸드폰 번호를 입력해주세요." name="phone" required> 
      
      <label><b>언어</b></label>
      <select name ="language">
         <option selected>언어 없음</option> 
         <option>영어</option>
         <option>중국어</option>
      </select>
      
      <label><b>아이디</b></label> 
      <input type="text" placeholder="아이디를 입력해주세요." name="id" required>
      
      <label><b>비밀번호</b></label>
      <input type="password" placeholder="비밀번호를 입력해주세요." id="psw"  name="psw" required> 
      
      <label><b>비밀번호 확인</b> </label> 
      <input type="password" placeholder="비밀번호를 한번 더 입력해주세요." id="psw-repeat" name="psw-repeat" required>
    
       <div class="clearfix">
            <button type="button" class="cancelbtn" onclick="location.href='/ESTIS/Estis/Login.jsp'">취소</button>
             <input type="hidden" name="action" value="signup">
            <button type="submit" class="signupbtn" onclick="javascript:pwdCheck();">가입완료</button>
       </div>
   </div>
</form>
</div>
<script>
      function onlyNumber(event){
         event = event || window.event;
         var keyID = (event.which) ? event.which : event.keyCode;
         if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
            return;
         else
            return false;
      }
      function removeChar(event) {
         event = event || window.event;
         var keyID = (event.which) ? event.which : event.keyCode;
         if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
            return;
         else
            event.target.value = event.target.value.replace(/[^0-9]/g, "");
      }
      /*비밀번호와 비밀번호확인란 같은지 확인*/
      function pwdCheck(event){
    	  var password = document.getElementById('psw');
    	  var password_check = document.getElementById('psw-repeat');
		if (password.value != password_check.value){
			ErrorAlert();
			history.back();
			focus.passowrd;
			return false;
		}
      }
      function ErrorAlert() {
    	    var x = document.getElementById("Error")
    	    x.className = "show";
    	    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
    	    setTimeout(function(){ history.back(-1);}, 3000);
    	    
    	}
</script>
<% if(alerter.getAlert()!=null){
	out.println("<script>ErrorAlert();</script>");
	alerter.setAlert(null);
	alerter.setState(null);
}
 %>
</body>
</html>