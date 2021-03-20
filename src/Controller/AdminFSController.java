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

import Beans.FSBean;
import Beans.FSBean;
import Beans.FSBean;
import DAO.FSDAO;
import Date.DateCalc;
import DAO.FSDAO;
/*엑셀 라이브러리인 jxl 컴포넌트를 import한다. */
import jxl.*;
import jxl.read.biff.BiffException;
import test.*;
import org.apache.poi.hssf.usermodel.*;

/**
 * Servlet implementation class AdminFSController
 */
@WebServlet("/AdminFSController")
public class AdminFSController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminFSController() {
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
	
		/*dispatcher 페이지 이동 및 attri전송*/
		String address = null;
		RequestDispatcher dispatcher;
		ServletContext sc = getServletContext();

		String detail = request.getParameter("detail");
		String action = request.getParameter("action");
		String withdraw =request.getParameter("withdraw");
		PrintWriter out = response.getWriter(); // 선언


		
		/*엑셀 작업시 필요한 변수들*/
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
		FSExcelReader excelReader;
		List<FSBean> xlsList = null;
		// BuddyVo vo;
		FSBean[] vo = null;
		
		if(detail!=null){
			String fsid=detail;
			FSDAO dao=FSDAO.getInstance();
			FSBean fs=dao.getFS(fsid);
			sc.setAttribute("fsdetail", fs);
			
			address = "Estis/Admin_FS_detail.jsp";
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		}
		else if(withdraw !=null) {//action.equals(ksid)일때
			String fsid=withdraw;
			FSDAO dao=FSDAO.getInstance();
			dao.deleteFS(fsid);
			
			String str = "";
			str = "<script language='javascript'>";
			str += "alert('강제 탈퇴되었습니다.');"; // 팝업창
			str += "location.href = 'Estis/Admin_FS.jsp';";
			str += "</script>";
			out.print(str);
			out.flush();
			out.close();
		}
		
		else if (action.equals("start")) {
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

			excelReader = new FSExcelReader();
			xlsList = excelReader.xlsToFSVoList(savePath + "\\" + fileName);
			size = xlsList.size();
			vo = new FSBean[size];

			for (int i = 0; i < size; i++) {
				

				vo[i] = xlsList.get(i);
				sc.setAttribute("fsvo" + i, vo[i]);
				
			}
			sc.setAttribute("fsvosize", xlsList.size());

			address = "Estis/Admin_FS_excel_detail.jsp";
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);

		} else if (action.equals("upload")) {
			/* FS 데이터베이스에 vo들을 넣어줌 */
			FSDAO dao = FSDAO.getInstance();
			dao.connect();
			dao.setAutoCommit(false); // 트랜잭션

			size = (int) sc.getAttribute("fsvosize");
			vo = new FSBean[size];
			FSBean fs = new FSBean();
			for (int i = 0; i < size; i++) {
				// vo[i]=new BuddyVo();
				vo[i] = (FSBean) sc.getAttribute("fsvo" + i);
				fs.setFsid(vo[i].getFsid());
				fs.setPw(vo[i].getPw());
				fs.setName(vo[i].getName());
				fs.setEmail(vo[i].getEmail());
				fs.setLanguage(vo[i].getLanguage());
				fs.setSid(vo[i].getSid());
				fs.setPhone(vo[i].getPhone());
				fs.setMajor(vo[i].getMajor());
				fs.setBuddyid(vo[i].getBuddyid());
				fs.setSemester(vo[i].getSemester());
				
				DateCalc d=new DateCalc();
				fs.setDate(d.getCurrentDate());
				
				dao.addFS(fs);

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

		}else if (action.equals("init")) {

			String[] checkedKsid = request.getParameterValues("check");

			FSDAO dao = FSDAO.getInstance();
			dao.connect();
			dao.setAutoCommit(false); // 트랜잭션
			
			for (int i = 0; i < checkedKsid.length; i++) {// sCheck[i]
				
				dao.initPwFS(checkedKsid[i]);
				

			}
			dao.commit();
			dao.setAutoCommit(true);
			dao.disconnect();

			
			String str = "";
			str = "<script language='javascript'>";
			str += "alert('변경되었습니다.');"; // 팝업창
			str += "location.href = 'Estis/Admin_FS.jsp';";
			str += "</script>";
			out.print(str);
			out.flush();
			out.close();
			

		}else if(action.equals("sms")){
			String[] checkedKsid = request.getParameterValues("check");
			ArrayList<String> phoneList=new ArrayList<>();
			
			FSDAO dao = FSDAO.getInstance();
			for (int i = 0; i < checkedKsid.length; i++) {//체크한 아이디의 핸드폰 넘버를 받아서 phoneList에 넣음
				FSBean fs=dao.getFS(checkedKsid[i]);
				phoneList.add(fs.getPhone());
			}
			sc.setAttribute("phoneList", phoneList);

			address = "Estis/Admin_SMS.jsp";
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);

			
			
		}
		
	}
}
