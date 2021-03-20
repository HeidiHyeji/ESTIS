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
import DAO.BuddyDAO;
import Date.DateCalc;
/*엑셀 라이브러리인 jxl 컴포넌트를 import한다. */
import jxl.*;
import jxl.read.biff.BiffException;
import test.*;
import org.apache.poi.hssf.usermodel.*;

/**
 * Servlet implementation class AdminBuddyController
 */
@WebServlet("/AdminBuddyController")
public class AdminBuddyController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminBuddyController() {
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

		String action = request.getParameter("action");

		/* 파일을 저장할 서버의 경로를 지정 */
		String savePath = request.getRealPath("/") + "Estis\\uploaddata\\temp";

		/* 파일이 첨부된 request에 사용될 변수를 선언 */
		int sizeLimit = 30 * 1024 * 1024;
		String formName = "";
		String fileName = "";
		long fileSize = 0;
		int size = 0;

		/* if문 내에 사용될 변수를 미리 선언 */
		MultipartRequest multi;
		Enumeration formNames;
		Workbook workbook;
		Sheet sheet;
		BuddyExcelReader excelReader;
		List<BuddyVo> xlsList = null;
		// BuddyVo vo;
		BuddyVo[] vo = null;
		RequestDispatcher dispatcher;
		ServletContext sc = getServletContext();

		if (action.equals("start")) {
			multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
			formNames = multi.getFileNames();

			while (formNames.hasMoreElements()) {
				formName = (String) formNames.nextElement();
				fileName = multi.getFilesystemName(formName);

				if (fileName != null) {
					fileSize = multi.getFile(formName).length();
				}

			}
			/* 서버에 업로드한 엑셀파일의 Sheet1 객체를 가져온다. */
			workbook = null;
			try {
				workbook = Workbook.getWorkbook(new File(savePath + "\\" + fileName));
			} catch (BiffException e) {
				PrintWriter writer = response.getWriter();
				writer.println("<script type='text/javascript'>");
				writer.println("alert('해당 파일이 존재하지 않습니다.');");
				writer.println("history.back();");
				writer.println("</script>");
				writer.flush();

				e.printStackTrace();
			}
			sheet = workbook.getSheet(0); // Sheet1

			excelReader = new BuddyExcelReader();
			xlsList = excelReader.xlsToBuddyVoList(savePath + "\\" + fileName);
			size = xlsList.size();
			vo = new BuddyVo[size];

			for (int i = 0; i < size; i++) {
				// vo[i]=new BuddyVo();

				vo[i] = xlsList.get(i);
				sc.setAttribute("buddyvo" + i, vo[i]);
				// System.out.println(vo.toString());
			}
			sc.setAttribute("buddyvosize", xlsList.size());

			address = "Estis/Admin_buddy_excel_detail.jsp";
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);

		} else if (action.equals("upload")) {
			/* Buddy 데이터베이스에 vo들을 넣어줌 */
			BuddyDAO dao = BuddyDAO.getInstance();
			dao.connect();
			dao.setAutoCommit(false); // 트랜잭션

			size = (int) sc.getAttribute("buddyvosize");
			vo = new BuddyVo[size];
			BuddyBean bb = new BuddyBean();
			for (int i = 0; i < size; i++) {
				// vo[i]=new BuddyVo();
				vo[i] = (BuddyVo) sc.getAttribute("buddyvo" + i);
				bb.setBuddyid(vo[i].getBuddyId());
				bb.setPw(vo[i].getBuddyPw());
				bb.setName(vo[i].getBuddyName());
				bb.setEmail(vo[i].getBuddyEmail());
				bb.setSemester(vo[i].getBuddySemester());
				bb.setLanguage(vo[i].getBuddyLanguage());
				bb.setDate(new DateCalc().getCurrentDate());
				dao.addBuddy(bb);

			}
			dao.commit();
			dao.setAutoCommit(true);
			dao.disconnect();


			String str = "";
			str = "<script language='javascript'>";
			str += "opener.window.location.reload();"; // 오프너 새로고침
			str += "self.close();"; // 일괄처리 세부사항 페이지 창닫기
			str += "</script>";
			out.print(str);
			out.flush();

		} else if (action.equals("init")) {
			String init = request.getParameter("init");
			String[] checkedBid = request.getParameterValues("check");
			/*if(checkedBid == null){
				out.println("<script language='javascript'>");
				out.println("alert('변경할 행을 선택해주십시오.');");
				out.println("history.go(-1);");
				out.println("</script>");
				out.close();
			}
			*/
			BuddyDAO dao = BuddyDAO.getInstance();
			dao.connect();
			dao.setAutoCommit(false); // 트랜잭션
			
			for (int i = 0; i < checkedBid.length; i++) {// sCheck[i]
				if (init.equals("all")) {
					dao.initBuddy(checkedBid[i]);
				} else if (init.equals("pw")) {
					dao.initPwBuddy(checkedBid[i]);
				}

			}
			dao.commit();
			dao.setAutoCommit(true);
			dao.disconnect();

			
			String str = "";
			str = "<script language='javascript'>";
			str += "alert('변경되었습니다.');"; // 팝업창
			str += "location.href = 'Estis/Admin_buddy.jsp';";
			str += "</script>";
			out.print(str);
			out.flush();
			out.close();
			/*
			 * address = "Estis/Admin_buddy.jsp"; // Admin_buddy_excel_preview에
			 * dispatcher = request.getRequestDispatcher(address);
			 * dispatcher.forward(request, response);
			 */

		}
	}
}
