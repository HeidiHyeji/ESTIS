<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alerter" class="Beans.InputResult" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/login.css" />
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/AlertMessages.css" />
</head>
<body>
<body background="/ESTIS/Estis/Img/back.png">
<h2>Login</h2>

<!--로그인오류알림-->
<div id="Error"><%=alerter.getAlert() %></div>
<div id="Success"><%=alerter.getAlert() %></div>
<script>
function Alert_S() {
    var x = document.getElementById("Success")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}
function Alert_E() {
    var x = document.getElementById("Error")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}
</script>
<% if(alerter.getAlert()!=null){
	if(alerter.getState().equals("Error")){
		out.println("<script>Alert_E();</script>");
	}
	else if(alerter.getState().equals("Success")){
		out.println("<script>Alert_S();</script>");
	}
	alerter.setAlert(null);
	alerter.setState(null);
}
 %>

<div class="content">
<form action="/ESTIS/LoginController"  method="post" >
  <div class="container">
    <label><b>Id</b></label>
    <input type="text" placeholder="Enter Id" name="id" required>

    <label><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="psw" required>
     <input type="hidden" name="action" value="login">    
    <button class="loginbtn" type="submit">Login</button>
  </div>

  <div class="container" style="background-color:#f1f1f1">
    <button type="button" class="signbtn1" onclick="location.href='/ESTIS/Estis/Signupkor.jsp'">Sign up</button>    
    <span class="psw">Forgot <a href="/ESTIS/Estis/ForgotPwd.jsp">password?</a></span>
  </div>
 
</form>
</div>
</body>
</html>