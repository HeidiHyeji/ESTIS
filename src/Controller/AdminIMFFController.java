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
import Beans.KSBean;
import Beans.MissionBean;
import DAO.IMFFFSDAO;
import DAO.IMFFKSDAO;
import DAO.KSDAO;
import DAO.MissionDAO;
import DAO.KSDAO;
/*엑셀 라이브러리인 jxl 컴포넌트를 import한다. */
import jxl.*;
import jxl.read.biff.BiffException;
import test.*;
import org.apache.poi.hssf.usermodel.*;

/**
 * Servlet implementation class AdminIMFFController
 */
@WebServlet("/AdminIMFFController")
public class AdminIMFFController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminIMFFController() {
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
		
		/*미션 객체 가져오기*/
		String missionid = request.getParameter("missionid");
		MissionDAO missiondao=MissionDAO.getInstance();
		MissionBean mission=missiondao.getMissionOne(missionid);
		
		request.setAttribute("mission", mission);//받은 missionid로 mission객체 db에서 가져오고 attribute로 전달
		/*해당 미션을 신청한 imffks,imfffs 명 수 가져오기 */
		IMFFFSDAO imfffs=IMFFFSDAO.getInstance();
		IMFFKSDAO imffks=IMFFKSDAO.getInstance();
		request.setAttribute("imfffscnt",imfffs.getCount(missionid));
		request.setAttribute("imffkscnt",imffks.getCount(missionid));
		
		address = "Estis/Admin_missionManage.jsp";
		dispatcher = request.getRequestDispatcher(address);
		dispatcher.forward(request, response);

	}
}
