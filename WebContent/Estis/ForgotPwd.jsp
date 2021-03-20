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
<h2>Forgot Password</h2>


<div class="content">
<form  action="/ESTIS/Estis/sendmail.jsp" method="post" >
  <div class="container">
    <label><b>비밀번호를 잊으셨나요?</b></label><br>
    <label>Enter your ID and E-mail address below to reset your password.</label><br><br>
    
    <label><b>Id</b></label>
    <input type="text" placeholder="Enter Id" name="id" required>
    
     <label><b>E-mail</b></label>
    <input type="text" name="user_email" placeholder="Enter Email" autocomplete="off" required>
     <input type="hidden" name="action" value="login">    
    <button class="loginbtn" type="submit">submit</button>
  </div>

  <div class="container" style="background-color:#f1f1f1">
    <button type="button" class="signbtn1" onclick="location.href='/ESTIS/Estis/Signupkor.jsp'">Cancel</button>    
  </div>
 
</form>
</div>

</body>
</html>