package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Beans.InputResult;
import Beans.KSBean;
import Beans.WriterBean;
import DAO.KSDAO;
import DAO.WriterDAO;
import Date.DateCalc;

/**
 * Servlet implementation class SignupController
 */
@WebServlet("/SignupController")
public class SignupController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SignupController() {
		super();
		// TODO Auto-generated constructor stub
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		KSDAO dao = KSDAO.getInstance();
		WriterDAO Wdao = new WriterDAO();
		String address = null;
		request.setCharacterEncoding("utf-8");

		String action = request.getParameter("action");

		//회원가입 입력값 DAO  
		if(action.equals("signup")){
			KSBean ks = new KSBean();
			InputResult alert = new InputResult();
			WriterBean login = Wdao.getPw(request.getParameter("id"));
			if(login.getWriterid()!=null){//이미 존재하는 아이디
				System.err.println("이미 존재하는 아이디.");
				alert.setState("Error");
				alert.setAlert("이미 존재하는 ID 입니다.");
				request.setAttribute("alerter", alert);
				address="/Estis/Signupkor.jsp";//회원가입 정보 로그인 페이지로 바로 넘겨주기
			}
			else if(!(request.getParameter("psw").equals(request.getParameter("psw-repeat")))){
				System.err.println("비밀번호와 비밀번호 확인란이 다릅니다.");
				alert.setAlert("비밀번호와 비밀번호 확인란이 다릅니다.");
				alert.setState("Error");
				request.setAttribute("alerter", alert);
				address="/Estis/Signupkor.jsp";//회원가입 정보 로그인 페이지로 바로 넘겨주기
			}
			else{
				ks.setName(request.getParameter("name"));
				//ks.setEmail(request.getParameter("email"));
				ks.setSid(Integer.parseInt(request.getParameter("sid")));
				ks.setPhone(request.getParameter("phone"));
				ks.setLanguage(request.getParameter("language"));
				ks.setKsid(request.getParameter("id"));
				ks.setPw(request.getParameter("psw"));
				ks.setMajor(request.getParameter("major"));
				ks.setDate(new DateCalc().getCurrentDate());
				dao.addKS(ks); //DAO로 전달하여 DB에 값 저장
				alert.setState("Success");
				alert.setAlert("회원가입에 성공하였습니다! Welcome!");
				request.setAttribute("alerter", alert);
				request.setAttribute("signup_ks", ks);
				address="/Estis/Login.jsp";//회원가입 정보 로그인 페이지로 바로 넘겨주기
			}
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(address);
		dispatcher.forward(request, response);


	}

}