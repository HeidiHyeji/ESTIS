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

import Beans.MissionBean;
import Beans.MissionResultBean;
import Beans.WriterBean;
import DAO.MissionDAO;
import DAO.MissionResultDAO;

/**
 * Servlet implementation class MissionResultController
 */
@WebServlet("/MissionResultController")
public class MissionResultController extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MissionResultController() {
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
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();   
       
        MissionResultDAO mrdao = MissionResultDAO.getInstance();
        MissionResultBean mr = new MissionResultBean();
        ArrayList<MissionBean> missionall = new ArrayList<MissionBean>();
      ArrayList<MissionResultBean> missionReAll = new ArrayList<MissionResultBean>();
        MissionDAO dao = MissionDAO.getInstance();
        //WriterBean user= (WriterBean)session.getAttribute("userinfo");
        //session.setAttribute("userinfo", user);
        if(action.equals("write")){
           missionall = dao.getMissionListAll();
           session.setAttribute("missionall", missionall);
           address="/Estis/GalleryAdd.jsp";
        }else if(action.equals("missionRe")){
           missionReAll = mrdao.getMissionResultAll();
           session.setAttribute("missionReAll", missionReAll);
           address="/Estis/Gallery.jsp";
        }else if(action.equals("missionReOne")){ //디테일 페이지 들어감
           mrdao.updateHit(request.getParameter("resultid"));
           mr = mrdao.getMissionRe(request.getParameter("resultid"));
           session.setAttribute("missionReOne", mr);
           address="/Estis/GalleryDetail.jsp";
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher(address);
        dispatcher.forward(request, response);  
   }
}