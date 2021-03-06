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

import Beans.KSBean;
import Beans.MissionBean;
import Beans.WriterBean;
import Beans.IMFFBean;
import Beans.IMFFFSBean;
import Beans.IMFFKSBean;
import DAO.FSDAO;
import DAO.IMFFDAO;
import DAO.IMFFFSDAO;
import DAO.IMFFKSDAO;
import DAO.KSDAO;
import DAO.MissionDAO;
import DAO.WriterDAO;

/**
 * Servlet implementation class MissionController
 */
@WebServlet("/MissionController")
public class MissionController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MissionController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {    
		String address = null;
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String action = request.getParameter("action");
		String attri = request.getParameter("attri");
		PrintWriter out = response.getWriter();

		MissionDAO dao = MissionDAO.getInstance();
		IMFFKSDAO imffksDao = IMFFKSDAO.getInstance();
		KSDAO ksDao = KSDAO.getInstance();
		FSDAO fsDao = FSDAO.getInstance();
		IMFFDAO imffDao = IMFFDAO.getInstance();
		MissionBean mission = new MissionBean();
		KSBean ks = new KSBean();
		IMFFKSBean imffks = new IMFFKSBean();

		/*???????????? ????????? ????????????*/
		HttpSession session=request.getSession();
	    WriterBean user= (WriterBean)session.getAttribute("userinfo");
	    String userid = (String)user.getWriterid();//?????? ???????????? ?????? id
		
		ArrayList<IMFFBean> imffAllList = new ArrayList<IMFFBean>();
		ArrayList<MissionBean> missionall = new ArrayList<MissionBean>();
		RequestDispatcher dispatcher;

		//???????????? ??????????????? ?????????????????? ?????????  
		if(action.equals("missionadd")){
			mission.setTitle(request.getParameter("title"));
			mission.setMax(Integer.parseInt(request.getParameter("max")));
			mission.setMin(Integer.parseInt(request.getParameter("min")));
			mission.setContent(request.getParameter("content"));
			mission.setApplystart(request.getParameter("applystart"));
			mission.setApplyend(request.getParameter("applyend"));
			mission.setResultdate(request.getParameter("resultdate"));
			mission.setPerformstart(request.getParameter("performstart"));
			mission.setPerformend(request.getParameter("performend"));
			dao.addMission(mission); //DAO??? ???????????? DB??? ??? ??????
			request.setAttribute("missionadd", mission);
			missionall = dao.getMissionListAll();
			request.setAttribute("missionall", missionall);
			if(attri!=null){
				if(attri.equals("admin")){
					String str = "";
					str = "<script language='javascript'>";
					str += "opener.window.location.reload();"; // ????????? ????????????
					str += "self.close();"; // ???????????? ???????????? ????????? ?????????
					str += "</script>";
					out.print(str);
					out.flush();
					return;
				}
			}else{
				address="/Estis/MissionList.jsp";
				dispatcher = request.getRequestDispatcher(address);
				dispatcher.forward(request, response);
			}
		}else if(action.equals("missionListAdd")){
			address="/Estis/MissionAdd.jsp";
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		}else if(action.equals("missionall") || action.equals("list")){
			missionall = dao.getMissionListAll();
			request.setAttribute("missionall", missionall);
			address="/Estis/MissionList.jsp";
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		}else if(action.equals("intro")){
			address="/Estis/Intro.jsp";
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		}else if(action.equals("gallery")){
			address="/Estis/Gallery.jsp";
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		}else if(action.equals("missionOne")){
			mission = dao.getMissionOne(request.getParameter("missionid"));
			System.out.println(request.getParameter("missionid"));
			request.setAttribute("missionone", mission);
			address="/Estis/MissionDetail.jsp";
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		}else if(action.equals("missionApplyResult")){
			String missionid=request.getParameter("missionid");
			request.setAttribute("missionTitle"
					,dao.getMissionTitle(Integer.parseInt(missionid)));
			
			String state=null;
			IMFFBean imff=new IMFFBean();
			/*?????? ???????????? ???????????? ?????? ?????? ???????????? ?????? ??? ??????:?????????(null,??????,?????????), ?????????(null,??????)*/
			if(user.getAttri().equals("ks")){
				
				imffks=new IMFFKSBean();
				imffks.setMissionid(Integer.parseInt(missionid));
				imffks.setKsid(userid);
				state=imffksDao.getIMFFKSState(imffks);
				imff=imffDao.getMissionIMFF(imffks);//????????? ??? ????????? ??????
				
			}else if(user.getAttri().equals("fs")){
				IMFFFSBean imfffs=new IMFFFSBean();
				imfffs.setMissionid(Integer.parseInt(missionid));
				imfffs.setFsid(userid);
				IMFFFSDAO imfffsDao=IMFFFSDAO.getInstance();
				Boolean existimfffs=imfffsDao.checkIMFFFS(imfffs);
				if(existimfffs)state="??????";//fs??? ??????????????? state=null
				imff=imffDao.getMissionIMFF(imfffs);//????????? ??? ????????? ??????
			}
			
				if(state==null){//?????? ?????? ?????? ??????
					request.setAttribute("state", "?????????");
				}
				else if(state.equals("??????")){//??????????????? null(?????????)??????
					request.setAttribute("state", "??????");
					
					String ksid1=imff.getKsid1();
					String ksid2=imff.getKsid2();
					String fsid1=imff.getFsid1();
					String fsid2=imff.getFsid2();
				
					//?????? ????????? ??????
					if(ksid1!=null){
					request.setAttribute("ks1", ksDao.getKS(ksid1));
					}
					if(ksid2!=null){
						request.setAttribute("ks2", ksDao.getKS(ksid2));
					}
					if(fsid1!=null){
						request.setAttribute("fs1", fsDao.getFS(fsid1));
					}
					if(fsid2!=null){
						request.setAttribute("fs2", fsDao.getFS(fsid2));
					}
				
				}else{//???????????? ???
					request.setAttribute("state", state);
				}

			address = "/Estis/MissionApplyResult.jsp";
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
			
		}else if(action.equals("missionApply")){
			mission = dao.getMissionOne(request.getParameter("missionid"));
			//System.out.println(request.getParameter("missionid"));
			request.setAttribute("missionone", mission);
			address="/Estis/MissionApply.jsp";
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		}
		//????????? ????????? ?????? ????????? ????????? ??????????????? ??????
		else if(action.equals("missionApply2")){
			String ksid = request.getParameter("ksid");
			//?????? ?????? ??????
			System.out.println("????????? ?????? ????????? "+ksid);
			imffks = imffksDao.checkDoubleApply(ksid, request.getParameter("missionid"));
			if(ksid.equals(imffks.getKsid())){
				System.out.println("?????? ??????");
			}else{
				imffks.setKsid(request.getParameter("ksid"));
	            imffks.setLanguage(request.getParameter("language"));
	            imffks.setReason(request.getParameter("reason"));
	            imffks.setMissionid(Integer.parseInt(request.getParameter("missionid")));
	            imffks.setDate(request.getParameter("applydate"));
	            imffks.setState(request.getParameter("state"));
	            System.out.println("state "+request.getParameter("state"));
	            if (!request.getParameter("party").equals("")) {
	               imffks.setParty(request.getParameter("party"));
	               System.out.println("?????? ????????????");
	            }
	            imffksDao.addIMFFKS(imffks); // DAO??? ???????????? DB??? ??? ??????
	            request.setAttribute("imffksAdd", imffks);
	         }

			missionall = dao.getMissionListAll();
			request.setAttribute("missionall", missionall);
			address="/Estis/MissionList.jsp";
			dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		}
	}
}