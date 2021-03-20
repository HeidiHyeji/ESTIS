package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.*;
import Beans.*;
/**
 * Servlet implementation class LoginControl
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("null")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		WriterDAO dao = new WriterDAO();

		String address = null;
		request.setCharacterEncoding("UTF-8");
		System.out.println("LoginControl 들어옴");
		//로그인 화면에서
		String action = request.getParameter("action");
		HttpSession session=request.getSession();
		NoticeDAO nodao = new NoticeDAO();
	    NoticeBean nobean = new NoticeBean();   
		InputResult alert = new InputResult();
		if(action.equals("login")){//로그인일때
			System.out.println("login버튼을 누름");
			WriterBean login = dao.getPw(request.getParameter("id"));
			alert = new InputResult();
			if(login.getWriterid()==null){//id가 없으면
				System.out.println("없는 id");
				alert.setState("Error");
				alert.setAlert("없는 ID 입니다.");
				//session.setAttribute("result", login);
				request.setAttribute("alerter", alert);
				 address="/Estis/Login.jsp";
			}
			else if(login.getPw().equals(request.getParameter("psw"))){//아이디 비밀번호가 일치할경우
				System.out.println("로그인 성공");
				session.setAttribute("userinfo",login);
				if(login.getAttri().equals("administrator")){
					System.out.println("관리자 로그인");
					address = "/AdminHomeController";
				}
				else{
				 address="/Estis/Home.jsp";
				}
			}
			else{//아이디 비밀번호가 불일치 할경우
				System.out.println("로그인 실패");
				alert.setState("Error");
				alert.setAlert("ID와 PW가 일치하지 않습니다.");
				
				request.setAttribute("alerter", alert);
				//session.setAttribute("save", login);
				
				address="/Estis/Login.jsp";
			}
			RequestDispatcher dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
			alert.setAlert(null);
			
		} 
		else if(action.equals("home")){
	         nobean = nodao.getNoticeLatest();
	         session.setAttribute("notice",nobean);
	         address="/Estis/Home.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);

	      }
		 else if(action.equals("logout")){
	         System.out.println("로그아웃버튼을 누름");
	         session.invalidate();
	         response.sendRedirect("/ESTIS/Estis/Login.jsp");
		 }
		 else if(action.equals("signup")){
			 response.sendRedirect("/ESTIS/Estis/Signupkor.jsp");
		 }
	} 
}
