<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/add.css" />
<title>미션 등록</title>
</head>
<body>
<jsp:include page="Top.jsp" flush="true" />   
<h3>♥미션 등록하기♥</h3>
<form action="/ESTIS/ImageController" enctype="multipart/form-data" method="post" style="border:1px solid #ccc">
   <div class="container">
      <label><b>제목</b></label> 
      <input type="text" placeholder="제목 입력" name="title" required> 
      
      <label><b>최대인원</b></label><br>
      <input class="num" type="text" placeholder="최대인원" name="max" required>
      <label><b>명</b></label><br>
      
      <label><b>최소인원</b></label><br> 
      <input class="num" type="text" placeholder="최소인원" name="min" required>
      <label><b>명</b></label><br>
           
      <label><b>신청 시작 날짜</b></label> 
      <input type="text" placeholder="YYYY-MM-DD HH:mm:ss" name="applystart" required>
      
      <label><b>신청 종료 날짜</b></label> 
      <input type="text" placeholder="YYYY-MM-DD HH:mm:ss" name="applyend" required>
      
      <label><b>활동 시작 날짜</b></label> 
      <input type="text" placeholder="YYYY-MM-DD HH:mm:ss" name="performstart" required>
      
      <label><b>활동 종료 날짜</b></label> 
      <input type="text" placeholder="YYYY-MM-DD HH:mm:ss" name="performend" required>
      
      <label><b>결과 발표 날짜</b></label> 
      <input type="text" placeholder="YYYY-MM-DD HH:mm:ss" name="resultdate" required>
      
      <label><b>사진</b></label>
      <input type="file" name="image">
   
      <label><b>내용</b></label> 
      <textarea id="content" name="content" placeholder="내용 입력" style="height: 200px"></textarea>
    
       <div class="clearfix">
            <button type="button" class="cancelBtn" onclick="history.go(-1)">Cancel</button>
            <button type="submit" class="addBtn">Add</button>
            <input type="hidden" name="action" value="missionAdd">
       </div>
   </div>
</form>

<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>