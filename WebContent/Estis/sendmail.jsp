<%@page import="DAO.BuddyDAO"%>
<%@page import="DAO.WriterDAO"%>
<%@page import="DAO.KSDAO"%>
<%@page import="DAO.FSDAO"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="Mail.SMTPAuthenticator"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String email = request.getParameter("user_email");
	String writerid = request.getParameter("id");
	String attri=null;
	// 입력값 받음

	Properties p = new Properties(); // 정보를 담을 객체

	p.put("mail.smtp.host", "smtp.naver.com"); // 네이버 SMTP

	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	// SMTP 서버에 접속하기 위한 정보들

	try {
		Authenticator auth = new SMTPAuthenticator();
		Session ses = Session.getInstance(p, auth);

		ses.setDebug(true);

		MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
		msg.setSubject("ESTIS 비밀번호찾기 내역입니다."); // 제목

		Address fromAddr = new InternetAddress("cjw4767@naver.com");
		msg.setFrom(fromAddr); // 보내는 사람

		Address toAddr = new InternetAddress(email);
		msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람

		WriterDAO writerdao = WriterDAO.getInstance();
		Boolean exist = writerdao.checkWriter(writerid, email);
		System.out.println(writerid);
		System.out.println(email);
		System.out.println(exist);
		if (exist.equals(false)) {//경고창!!!-----------------------------------------------------------------------
			
			out.println("<script>alert('등록되지 않은 이메일입니다.');history.back();</script>");
		}else if (exist.equals(true)) {
			
			int newPw = 0;
			newPw=(int)(Math.random()*100000+1);//비밀번호를 랜덤수로 초기화
			attri=writerdao.getAttri(writerid);
			if(attri.equals("fs")){
				FSDAO fsdao=FSDAO.getInstance();
				fsdao.initPwFS(writerid, newPw);
			}
			else if(attri.equals("ks")){
				KSDAO ksdao=KSDAO.getInstance();
				ksdao.initPwKS(writerid, newPw);
			}
			else if(attri.equals("buddy")){
				BuddyDAO buddydao=BuddyDAO.getInstance();
				buddydao.initPwBuddy(writerid, newPw);
			}
			
			if (newPw != 0) {
				String content = "고객님의  현재 임시 비밀번호는 " + newPw + " 입니다. 비밀번호를 변경하여 주시길 바랍니다.";
				msg.setContent(content, "text/html;charset=UTF-8"); // 내용과 인코딩
				Transport.send(msg); // 전송

			}
		}
	} catch (Exception e) {
		e.printStackTrace();
		out.println("<script>alert('이메일 전송에 실패하였습니다.');history.back();</script>");
		// 오류 발생시 뒤로 돌아가도록
		return;
	}

	out.println("<script>alert('임시비밀번호가 발급되었습니다. 이메일을 확인해주십시오.');location.href='/ESTIS/Estis/Login.jsp';</script>");
	
	// 성공 시
%>