package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Beans.BuddyBean;
import Beans.FSBean;
import Beans.IMFFKSBean;
import Beans.KSBean;
import Beans.MissionResultBean;
import DAO.BuddyDAO;
import DAO.FSDAO;
import DAO.IMFFKSDAO;
import DAO.KSDAO;
import DAO.MissionResultDAO;

/**
 * Servlet implementation class MyPageController
 */
@WebServlet("/MyPageController")
public class MyPageController extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyPageController() {
        super();
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
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String address = null;
        request.setCharacterEncoding("utf-8");
      String action = request.getParameter("action");
      KSBean ks = new KSBean();
      FSBean fs = new FSBean();
      BuddyBean buddy = new BuddyBean();
      ArrayList<MissionResultBean> mr = new ArrayList<MissionResultBean>();
      ArrayList<IMFFKSBean> imffks = new ArrayList<IMFFKSBean>();
      
      KSDAO ksdao = KSDAO.getInstance();
      FSDAO fsdao = FSDAO.getInstance();
      BuddyDAO buddydao =BuddyDAO.getInstance();
      MissionResultDAO mrdao = MissionResultDAO.getInstance();
      IMFFKSDAO imffdao = IMFFKSDAO.getInstance();
      
      HttpSession session=request.getSession();
      RequestDispatcher dispatcher;      
      
      
      if(action.equals("mypage")){
         String attri = request.getParameter("attri");
         String writerid = request.getParameter("writerid");
         System.out.println("마이페이지 열기 성공 "+attri+" "+writerid);
         if(attri.equals("ks")){ //한국학생이면 ks테이블에서 정보 불러오기
            ks = ksdao.getKS(writerid);
            session.setAttribute("ks", ks);
         }else if(attri.equals("fs")){ //외국인학생이면 fs테이블에서 정보 불러오기
            fs = fsdao.getFS(writerid);
            session.setAttribute("fs", fs);
         }else if(attri.equals("buddy")){ //버디이면 buddy테이블에서 정보 불러오기
            buddy = buddydao.getBuddy(writerid);
            session.setAttribute("buddy", buddy);
         }
         mr = mrdao.getMissionReForWriter(writerid);
         session.setAttribute("mr", mr);
         
         imffks = imffdao.getApplyForKS(writerid);
         session.setAttribute("imffks", imffks);
         
         address="/Estis/MyPage.jsp";
         dispatcher = request.getRequestDispatcher(address);
           dispatcher.forward(request, response);  
      }  
   }

}