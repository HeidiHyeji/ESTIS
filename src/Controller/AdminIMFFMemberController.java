package Controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import Beans.IMFFFSBean;
import DAO.IMFFFSDAO;
import DAO.IMFFFSDAO;
import DAO.IMFFKSDAO;
import Date.DateCalc;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import test.IMFFFSExcelReader;

/**
 * Servlet implementation class AdminIMFFMemberController
 */
@WebServlet("/AdminIMFFMemberController")
public class AdminIMFFMemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminIMFFMemberController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String action = request.getParameter("action");
		PrintWriter out = response.getWriter(); // 선언
		String address = null;
		ServletContext sc = getServletContext();
		RequestDispatcher dispatcher;
		
		String missionid = request.getParameter("missionid");
		
		/*해당 미션을 신청한 imffks,imfffs 명 수 가져오기 */
		IMFFFSDAO imfffsdao=IMFFFSDAO.getInstance();
		IMFFKSDAO imffksdao=IMFFKSDAO.getInstance();
		request.setAttribute("imfffscnt",imfffsdao.getCount(missionid));
		request.setAttribute("imffkscnt",imffksdao.getCount(missionid));
		
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
		IMFFFSExcelReader excelReader;
		List<IMFFFSBean> xlsList = null;
		// BuddyVo vo;
		IMFFFSBean[] vo = null;
		
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

			excelReader = new IMFFFSExcelReader();
			xlsList = excelReader.xlsToFSVoList(savePath + "\\" + fileName);
			size = xlsList.size();
			vo = new IMFFFSBean[size];

			for (int i = 0; i < size; i++) {
				// vo[i]=new BuddyVo();

				vo[i] = xlsList.get(i);
				sc.setAttribute("imfffsvo" + i, vo[i]);
				// System.out.println(vo.toString());
			}
			sc.setAttribute("imfffsvosize", xlsList.size());

			address = "Estis/Admin_IMFFFS_excel_detail.jsp";
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);

		} else if (action.equals("upload")) {
			/* IMFFFS 데이터베이스에 vo들을 넣어줌 */
			
			imfffsdao.connect();
			imfffsdao.setAutoCommit(false); // 트랜잭션

			size = (int) sc.getAttribute("imfffsvosize");
			vo = new IMFFFSBean[size];
			IMFFFSBean imfffs = new IMFFFSBean();
			for (int i = 0; i < size; i++) {
				
				vo[i] = (IMFFFSBean) sc.getAttribute("imfffsvo" + i);
				imfffs.setImfffsid(vo[i].getImfffsid());
				imfffs.setFsid(vo[i].getFsid());
				imfffs.setParty(vo[i].getParty());
				imfffs.setMissionid(vo[i].getMissionid());
				
				imfffsdao.addIMFFFS(imfffs);

			}
			imfffsdao.commit();
			imfffsdao.setAutoCommit(true);
			imfffsdao.disconnect();


			String str = "";
			str = "<script language='javascript'>";
			str += "opener.window.location.reload();"; // 오프너 새로고침
			str += "self.close();"; // 일괄처리 세부사항 페이지 창닫기
			str += "</script>";
			out.print(str);
			out.flush();

		}
	}

}
