package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Beans.IMFFBean;
import Beans.IMFFFSBean;
import Beans.IMFFKSBean;
import DAO.IMFFDAO;
import DAO.IMFFFSDAO;
import DAO.IMFFKSDAO;

/**
 * Servlet implementation class AdminIMFFMatchingController
 */
@WebServlet("/AdminIMFFMatchingController")
public class AdminIMFFMatchingController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminIMFFMatchingController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter(); // 선언
		String address = null;
		ServletContext sc = getServletContext();
		RequestDispatcher dispatcher;

		String matching = request.getParameter("matching");
		String missionid = request.getParameter("missionid");
		String teamnum;
		ArrayList<String[]> teamtablefsid = new ArrayList<String[]>();
		IMFFDAO imffdao = IMFFDAO.getInstance();
		String ksid[] = new String[2];

		if (matching.equals("imfffs")) {
			teamnum = request.getParameter("teamnum");
			sc.setAttribute("teamnum", teamnum);
			/* 외친소 해당 미션 신청한 fs학생 */
			IMFFFSDAO imfffsdao = IMFFFSDAO.getInstance();
			ArrayList<IMFFFSBean> imfffslist = imfffsdao.getIMFFFS(missionid);
			int imfffssize = imfffslist.size();
			IMFFFSBean[] imfffs = new IMFFFSBean[imfffssize];

			for (int i = 0; i < imfffssize; i++) {

				imfffs[i] = imfffslist.get(i);
				sc.setAttribute("imfffs[" + i + "]", imfffs[i]);

			}
			sc.setAttribute("imfffssize", imfffssize);

			/* 페이지 이동 */
			address = "Estis/Admin_matching.jsp?missionid=" + missionid;
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		} else if (matching.equals("imfffsend")) {

			imffdao.deleteIMFF(missionid);// fs 배정이 중복될 경우를 방지하기 위해, 해당 미션의 팀배정은
											// 한번으로 제한한다.
			imffdao.connect();
			imffdao.setAutoCommit(false);
			teamnum = (String) sc.getAttribute("teamnum");

			for (int i = 0; i < Integer.parseInt(teamnum); i++) {// teamtable에서
																	// 배정된 fs명단을
																	// 뽑아낸다
				String[] teamtablefscell = request.getParameterValues(i + "");// [0]:fsid1,[1]:fsid2
				IMFFBean imff = new IMFFBean();
				imff.setMissionid(Integer.parseInt(missionid));
				if (teamtablefscell != null) {
					if (teamtablefscell.length >= 1)
						imff.setFsid1(teamtablefscell[0]);
					if (teamtablefscell.length == 2) {
						imff.setFsid2(teamtablefscell[1]);
					}
					imffdao.addIMFF(imff);
				}
			}
			imffdao.commit();
			imffdao.setAutoCommit(true);
			imffdao.disconnect();

			String str = "";
			str = "<script language='javascript'>";
			str += "alert('교환학생 팀배정이 완료되었습니다.한국인학생 팀배정을 해주세요.');";
			str += "location.href = 'AdminIMFFMatchingController?missionid=";
			str += missionid;
			str += "&matching=imffks';";
			str += "</script>";
			out.print(str);
			out.flush();
			out.close();

		} else if (matching.equals("imffks")) {
			/* 해당 미션의 imff를 부른다 */
			ArrayList<IMFFBean> imfflist = imffdao.getIMFF(missionid);
			int imffsize = imfflist.size();
			IMFFBean[] imff = new IMFFBean[imffsize];

			for (int i = 0; i < imffsize; i++) {

				imff[i] = imfflist.get(i);
				sc.setAttribute("imff[" + i + "]", imff[i]);

			}
			sc.setAttribute("imffsize", imffsize);

			/* 외친소 해당 미션 신청한 ks학생 */
			IMFFKSDAO imffksdao = IMFFKSDAO.getInstance();

			ArrayList<IMFFKSBean> imffkslist = imffksdao.getIMFFKS(missionid);
			int imffkssize = imffkslist.size();

			IMFFKSBean[] imffks = new IMFFKSBean[imffkssize];

			for (int i = 0; i < imffkssize; i++) {

				imffks[i] = imffkslist.get(i);
				sc.setAttribute("imffks[" + i + "]", imffks[i]);

			}
			sc.setAttribute("imffkssize", imffkssize);

			/* 페이지 이동 */
			address = "Estis/Admin_matching_next.jsp?missionid=" + missionid;
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		} else if (matching.equals("imffksend")) {

			imffdao.connect();
			imffdao.setAutoCommit(false);
			int imffsize = (Integer) sc.getAttribute("imffsize");

			for (int i = 0; i < imffsize; i++) {// teamtable에서 배정된 fs명단을 뽑아낸다
				String[] teamtablefscell = request.getParameterValues(i + "");// [0]:fsid1,[1]:fsid2
				IMFFBean imff = new IMFFBean();
				imff.setMissionid(Integer.parseInt(missionid));

				if (teamtablefscell != null) {
					if (teamtablefscell.length >= 1)
						imff.setFsid1(teamtablefscell[0]);
					if (teamtablefscell.length >= 2) {
						imff.setFsid2(teamtablefscell[1]);
					}
					if (teamtablefscell.length >= 3) {
						imff.setKsid1(teamtablefscell[2]);
					}
					if (teamtablefscell.length >= 4) {
						imff.setKsid2(teamtablefscell[3]);
					}
					if (imff.getFsid2().equals("null"))
						imffdao.updateIMFFNULL(imff);
					else
						imffdao.updateIMFF(imff);
				}
			}
			imffdao.commit();
			imffdao.setAutoCommit(true);
			imffdao.disconnect();

			String str = "";
			str = "<script language='javascript'>";
			str += "alert('외친소 팀배정이 완료되었습니다.');";
			str += "location.href = 'AdminIMFFMatchingController?missionid=";
			str += missionid;
			str += "&matching=complete';";
			str += "</script>";
			out.print(str);
			out.flush();
			out.close();

		} else if (matching.equals("complete")) {
			ArrayList<IMFFBean> imfflist = imffdao.getIMFF(missionid);
			sc.setAttribute("imff", imfflist);
			
			/*IMFF테이블을 보고 IMFFKS테이블 state를 업데이트 시키기*/
			IMFFKSDAO imffksdao = IMFFKSDAO.getInstance();
			imffksdao.connect();
			imffksdao.setAutoCommit(false); // 트랜잭션
			// imfflist에서 IMFFBean을 얻음
			for (int i = 0; i < imfflist.size(); i++) {
				IMFFBean imff = imfflist.get(i);
				ksid[0] = imff.getKsid1();// 합격한 ksid 추출;
				ksid[1] = imff.getKsid2();

				//하나의 IMFFBean에는 합격한 ksid가 두개 있으니깐 반복문을 통해 update
				for (int j = 0; j < ksid.length; j++) {
					IMFFKSBean imffks = new IMFFKSBean();
					imffks.setKsid(ksid[j]);
					imffks.setMissionid(Integer.parseInt(missionid));
					imffks.setState("합격");

					imffksdao.updateIMFFKSState(imffks);
				}
			}
			imffksdao.commit();
			imffksdao.setAutoCommit(true);
			imffksdao.disconnect();

			/* 페이지 이동 */
			address = "Estis/Admin_matchig_complete.jsp?missionid=" + missionid;
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		}
	}

}
