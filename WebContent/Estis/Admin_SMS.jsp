<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="SMS.SMS" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <link rel="stylesheet" href="/ESTIS/Estis/Css/bootstrap.css">-->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> <!-- ���� -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script><!-- ���� -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script><!-- ����-->
<title>SMS ����</title>
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<div class="container">
		<form method="post" name="smsForm" action="/ESTIS/Estis/Admin_sendSMS.jsp">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="text-align: center;">���� ���� ���</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<textarea class="form-control" maxlength="45" name="msg" style="height: 220px;" placeholder="���� ����"></textarea>
						</td>
					</tr>
					<tr>
						<td>
							<!--<input class="form-control" type="text" name="rphone" value="" placeholder="�޴� ��ȣ">-->
						</td>
					</tr>
					<tr>
						<td>�޴� ��ȣ�� 010-1234-5678�� ���� ��ü ��ȣ�� �ۼ����ֽñ� �ٶ��ϴ�.</td>
					</tr>
					<tr>
						<td>
							���� ���� �ܿ��� : <%= new SMS().getCount() %>
						</td>
					</tr>
					<tr>
						<td>
							<input type="hidden" name="action" value="go">
							<input type="hidden" name="sphone1" value="010">
							<input type="hidden" name="sphone2" value="4767">
							<input type="hidden" name="sphone3" value="9350">
							<input class="btn btn-primary pull-right" type="submit" value="����">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>