<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="Css/myActivity.css">
</head>
<body>
<jsp:include page="Top.jsp" flush="true" />

<table class="mpbar">
	<tr>
		<td onclick="location.href='/ESTIS/Estis/MyPage.jsp'">MyPage</td>
		<td bgcolor="gray">활동내역</td>
	</tr>
</table>
<button class="accordion">전체</button>
<div class="panel">
	<table class="myPage">
		<tr>
			<td>이름</td>
			<td>최진원</td>
		</tr>
		<tr>
			<td>아이디</td>
			<td>blahBlah</td>
		</tr>
		<tr>
			<td>학과</td>
			<td>컴퓨터과학과</td>
		</tr>
		<tr>
			<td>학번</td>
			<td>201411783</td>
		</tr>
		<tr>
			<td>폰번호</td>
			<td>010-1234-5678</td>
		</tr>
		<tr>
			<td>언어권</td>
			<td>영어</td>
		</tr>
		</table>
</div>

<button class="accordion">외친소활동</button>
<div class="panel">
	<table class="myPage">
		<tr>
			<td>이름</td>
			<td>최진원</td>
		</tr>
		<tr>
			<td>아이디</td>
			<td>blahBlah</td>
		</tr>
		<tr>
			<td>학과</td>
			<td>컴퓨터과학과</td>
		</tr>
		<tr>
			<td>학번</td>
			<td>201411783</td>
		</tr>
		<tr>
			<td>폰번호</td>
			<td>010-1234-5678</td>
		</tr>
		<tr>
			<td>언어권</td>
			<td>영어</td>
		</tr>
	</table>
</div>

<button class="accordion">내가 쓴 글</button>
<div class="panel">
	<table class="myPage">
		<tr>
			<td>이름</td>
			<td>최진원</td>
		</tr>
		<tr>
			<td>아이디</td>
			<td>blahBlah</td>
		</tr>
		<tr>
			<td>학과</td>
			<td>컴퓨터과학과</td>
		</tr>
		<tr>
			<td>학번</td>
			<td>201411783</td>
		</tr>
		<tr>
			<td>폰번호</td>
			<td>010-1234-5678</td>
		</tr>
		<tr>
			<td>언어권</td>
			<td>영어</td>
		</tr>
	</table>
</div>

<button class="accordion">내가 쓴 댓글</button>
<div class="panel">
	<table class="myPage">
		<tr>
			<td>이름</td>
			<td>최진원</td>
		</tr>
		<tr>
			<td>아이디</td>
			<td>blahBlah</td>
		</tr>
		<tr>
			<td>학과</td>
			<td>컴퓨터과학과</td>
		</tr>
		<tr>
			<td>학번</td>
			<td>201411783</td>
		</tr>
		<tr>
			<td>폰번호</td>
			<td>010-1234-5678</td>
		</tr>
		<tr>
			<td>언어권</td>
			<td>영어</td>
		</tr>
	</table>
</div>


<script>
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
	acc[i].onclick = function() {
		this.classList.toggle("active");
		var panel = this.nextElementSibling;
		if (panel.style.maxHeight) {
			panel.style.maxHeight = null;
		} else {
			panel.style.maxHeight = panel.scrollHeight + "px";
		}
	}
}

document.getElementById("defaultOpen").click();
</script>
<jsp:include page="Bottom.jsp" flush="true" />
</body>
</html>