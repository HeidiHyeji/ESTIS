<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/signupSection.css" />
</head>
<body>
<!--메뉴-->
<jsp:include page="Top.jsp" flush="true" />
<h2>Sign up</h2>
<div class="signupSection">
  <div class="container">
    <button class="section" onclick="location.href='Signup.jsp'">exchange student</button>   
    <button class="section" onclick="location.href='Signupkor.jsp'">경기대 학생</button>
  </div>
</div>
<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>