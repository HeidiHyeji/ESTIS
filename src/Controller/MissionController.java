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

		/*세션에서 아이디 받아오기*/
		HttpSession session=request.getSession();
	    WriterBean user= (WriterBean)session.getAttribute("userinfo");
	    String userid = (String)user.getWriterid();//현재 접속중인 사람 id
		
		ArrayList<IMFFBean> imffAllList = new ArrayList<IMFFBean>();
		ArrayList<MissionBean> missionall = new ArrayList<MissionBean>();
		RequestDispatcher dispatcher;

		//미션추가 페이지에서 미션추가버튼 클릭시  
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
			dao.addMission(mission); //DAO로 전달하여 DB에 값 저장
			request.setAttribute("missionadd", mission);
			missionall = dao.getMissionListAll();
			request.setAttribute("missionall", missionall);
			if(attri!=null){
				if(attri.equals("admin")){
					String str = "";
					str = "<script language='javascript'>";
					str += "opener.window.location.reload();"; // 오프너 새로고침
					str += "self.close();"; // 일괄처리 세부사항 페이지 창닫기
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
			/*현재 접속중인 아이디의 해당 미션 합격여부 반환 및 변경:한국인(null,합격,불합격), 외국인(null,합격)*/
			if(user.getAttri().equals("ks")){
				
				imffks=new IMFFKSBean();
				imffks.setMissionid(Integer.parseInt(missionid));
				imffks.setKsid(userid);
				state=imffksDao.getIMFFKSState(imffks);
				imff=imffDao.getMissionIMFF(imffks);//배정된 팀 객체를 반환
				
			}else if(user.getAttri().equals("fs")){
				IMFFFSBean imfffs=new IMFFFSBean();
				imfffs.setMissionid(Integer.parseInt(missionid));
				imfffs.setFsid(userid);
				IMFFFSDAO imfffsDao=IMFFFSDAO.getInstance();
				Boolean existimfffs=imfffsDao.checkIMFFFS(imfffs);
				if(existimfffs)state="합격";//fs가 미신청이면 state=null
				imff=imffDao.getMissionIMFF(imfffs);//배정된 팀 객체를 반환
			}
			
				if(state==null){//해당 미션 신청 안함
					request.setAttribute("state", "미신청");
				}
				else if(state.equals("합격")){//합격이거나 null(외국인)일때
					request.setAttribute("state", "합격");
					
					String ksid1=imff.getKsid1();
					String ksid2=imff.getKsid2();
					String fsid1=imff.getFsid1();
					String fsid2=imff.getFsid2();
				
					//이름 아이디 학과
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
				
				}else{//불합격일 때
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
		//신청서 양식에 모두 작성후 디비에 넣을때쓰는 액션
		else if(action.equals("missionApply2")){
			String ksid = request.getParameter("ksid");
			//중복 신청 방지
			System.out.println("신청한 사람 아이디 "+ksid);
			imffks = imffksDao.checkDoubleApply(ksid, request.getParameter("missionid"));
			if(ksid.equals(imffks.getKsid())){
				System.out.println("중복 신청");
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
	               System.out.println("파티 신청했다");
	            }
	            imffksDao.addIMFFKS(imffks); // DAO로 전달하여 DB에 값 저장
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