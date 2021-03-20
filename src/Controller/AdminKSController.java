package Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;
import java.sql.*;
/* cos 컴포넌트 사용을 위한 import 선언 */
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import Beans.BuddyBean;
import Beans.FSBean;
import Beans.KSBean;
import DAO.FSDAO;
import DAO.KSDAO;
import DAO.KSDAO;
/*엑셀 라이브러리인 jxl 컴포넌트를 import한다. */
import jxl.*;
import jxl.read.biff.BiffException;
import test.*;
import org.apache.poi.hssf.usermodel.*;

/**
 * Servlet implementation class AdminKSController
 */
@WebServlet("/AdminKSController")
public class AdminKSController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminKSController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter(); // 선언
		String address = null;
		ServletContext sc = getServletContext();
		RequestDispatcher dispatcher;
		

		String action = request.getParameter("action");
		String detail = request.getParameter("detail");
		String withdraw= request.getParameter("withdraw");
		KSDAO dao=KSDAO.getInstance();
		if(detail!=null){
			String ksid=detail;
			
			KSBean ks=dao.getKS(ksid);
			sc.setAttribute("ksdetail", ks);
			
			address = "Estis/Admin_KS_detail.jsp";
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		}
		else if(withdraw!=null) {//action.equals(ksid)일때
			String ksid=withdraw;
			
			dao.deleteKS(ksid);
			
			String str = "";
			str = "<script language='javascript'>";
			str += "alert('강제 탈퇴되었습니다.');"; // 팝업창
			str += "location.href = 'Estis/Admin_KS.jsp';";
			str += "</script>";
			out.print(str);
			out.flush();
			out.close();
		}else if (action.equals("init")) {

			String[] checkedKsid = request.getParameterValues("check");

			
			dao.connect();
			dao.setAutoCommit(false); // 트랜잭션
			
			for (int i = 0; i < checkedKsid.length; i++) {// sCheck[i]
				
				dao.initPwKS(checkedKsid[i]);
				

			}
			dao.commit();
			dao.setAutoCommit(true);
			dao.disconnect();

			
			String str = "";
			str = "<script language='javascript'>";
			str += "alert('변경되었습니다.');"; // 팝업창
			str += "location.href = 'Estis/Admin_KS.jsp';";
			str += "</script>";
			out.print(str);
			out.flush();
			out.close();
			

		}else if(action.equals("sms")){
			String[] checkedKsid = request.getParameterValues("check");
			ArrayList<String> phoneList=new ArrayList<>();
			
			
			for (int i = 0; i < checkedKsid.length; i++) {//체크한 아이디의 핸드폰 넘버를 받아서 phoneList에 넣음
				KSBean ks=dao.getKS(checkedKsid[i]);
				phoneList.add(ks.getPhone());
			}
			sc.setAttribute("phoneList", phoneList);

			address = "Estis/Admin_SMS.jsp";
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);

		}

	
	}
}
