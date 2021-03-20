<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/signup.css" />
</head>
<body background="/ESTIS/Estis/Img/back.png">
<!--회원가입-->   
<h2>Sign up</h2>
<div class="content">
<form action="/ESTIS/SignupController" method="post" "border:1px solid #ccc">
   <div class="container">
      <label><b>Name</b></label> 
      <input type="text" placeholder="Enter Name" name="name" required> 
      
      <label><b>E-mail</b></label>
      <input type="text" placeholder="Enter E-mail" name="email" required>
      
      <label><b>Student Id</b></label> 
      <input type="text" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'  placeholder="Enter Student Id" name="sid" required> 

      
      <label><b>Phone Number</b></label> 
      <input type="text" placeholder="Enter Phone number" name="phone" required> 
      
      <label><b>Language</b></label>
      <select name="language">
         <option selected>Language</option> 
         <option>English</option>
         <option>Chinese</option>
      </select>
      
      <label><b>Id</b></label> 
      <input type="text" placeholder="Enter Id" name="id" required> 
      
      <label><b>Password</b></label>
      <input type="password" placeholder="Enter Password" id="psw" name="psw" required> 
      
      <label><b>Repeat Password</b> </label> 
      <input type="password" placeholder="Repeat Password" id="psw-repeat" name="psw-repeat" required>
    
       <div class="clearfix">
            <button type="button" class="cancelbtn" onclick="history.go(-1)">Cancel</button>
            <input type="hidden" name="action" value="signup">
            <button type="submit" class="signupbtn" onclick="javascript:pwdCheck();">Sign Up</button>
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
         alert("Check password again.");
         focus.passowrd;
         return false;
      }
      }
/*   function save() {

//       alert($("#password_hint").val());

//       alert($("#member_HP").val());

      var str3 = document.getElementById('join');

      str3.submit();

      alert("가입이 완료되었습니다.")

   }
*/
</script>


</body>
</html>