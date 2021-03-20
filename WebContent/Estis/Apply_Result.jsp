<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/missionList.css" />
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/apply.css" />
<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/gallary.css" />

</head>
<body>
<!--메뉴-->
<jsp:include page="Top.jsp" flush="true" />

<!--party설명모달-->
	<div id="partyinfo" class="w3-modal">
		<div class="w3-modal-content">
			<div class="activityModalHeader">
				<span
					onclick="document.getElementById('partyinfo').style.display='none'"
					class="activityModalClose">&times;</span>
					 <H3>동행 신청이란?</H3>
			</div>
			<div class="activityModalBody">
				<p>동행신청은 1:1만 가능합니다.</p>
          		<p>요청 승인을 하면 신청내역은 사라집니다.</p>
            	<p>상대가 내 신청을 승인하면 내게 온 요청은 사라집니다.</p>
           	</div>
		</div>
	</div>
	
<!--party취소모달-->
<div id="partyCancel" class="w3-modal">
	<div class="w3-modal-content">
		<div class="w3-container">
			<span onclick="document.getElementById('partyCancel').style.display='none'"
			class="w3-button w3-display-topright">&times;</span>
			<H2>동행 요청 취소</H2>
			<hr>
			<p>정말 요청을 취소하시겠습니까?
			<div class="clearfix">
	      		<button type="submit" class="signupbtn">Apply</button>
    	  		<button type="button" class="cancelbtn" onclick="document.getElementById('partyCancel').style.display='none'">Cancel</button>
    		</div>
		</div>
	</div>
</div>


<!--party승인모달-->
<div id="partyAccept" class="w3-modal">
	<div class="w3-modal-content">
		<div class="w3-container">
			<span onclick="document.getElementById('partyAccept').style.display='none'"
			class="w3-button w3-display-topright">&times;</span>
			<H3>동행 요청 승인</H3>
			<hr>
			 <p>정말 요청을 받아들이시겠습니까?</p>
          			<p>이 요청을 승인하면 내가 요청한 내역은 취소되며,</p>
            		<p>승인 후엔 동행을 바꿀 수 없습니다.</p>
			<div class="clearfix">
	      		<button type="submit" class="signupbtn">Apply</button>
    	  		<button type="button" class="cancelbtn" onclick="document.getElementById('partyAccept').style.display='none'">Cancel</button>
    		</div>
		</div>
	</div>
</div>

	
<H2 class="maintext">'합격'입니다.</H2>

<p class="subtext">동행 신청하기<button
			onclick="document.getElementById('partyinfo').style.display='block'"
			class="prtyInfoBtn">
			<img src="Img/question.png">
		</button>
<table id="myTable">
      <tr class="header">
         <th style="width: 70%;"><input type="text" placeholder="동행자 ID" name="name" required> </th>
         <th style="width: 30%;"><button type="submit" class="applybtn">Apply</button></th>
      </tr>
</table>
<hr>
<H4 class="subtext">내 동행 요청</H4>
<table id="myTable">
      <tr class="header">
         <th style="width: 50%;">ID </th>
         <th style="width: 50%;">상태</th>
      </tr>
      <tr>
		<td>King</td>
		<td><button
				onclick="document.getElementById('partyCancel').style.display='block'"
				class="w3-button w3-black">취소하기</button></td>
	  </tr>
</table>
<hr>
<H4 class="subtext">동행 요청받음</H4>
<table id="myTable">
      <tr class="header">
         <th style="width: 50%;">ID </th>
         <th style="width: 50%;"></th>
      </tr>
      <tr>
		<td>kskhh07</td>
		<td><button
				onclick="document.getElementById('partyAccept').style.display='block'"
				class="w3-button w3-black">승인하기</button></td>
	  </tr>
</table>

      
<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>