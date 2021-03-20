package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import Beans.MissionBean;
import Beans.MissionResultBean;
import Beans.NoticeBean;
import DAO.MissionDAO;
import DAO.MissionResultDAO;
import DAO.NoticeDAO;

/**
 * Servlet implementation class ImageController
 */
@WebServlet("/ImageController")
public class ImageController extends HttpServlet {
   private static final long serialVersionUID = 1L;

   /**
    * @see HttpServlet#HttpServlet()
    */
   public ImageController() {
      super();
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
      String realFolder = "";
      String image = "";
      int maxSize = 1024 * 1024 * 5;
      String encType = "UTF-8";
      String savefile = "Estis\\Img";
      ServletContext scontext = getServletContext();
      realFolder = scontext.getRealPath(savefile);
      MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType,
            new DefaultFileRenamePolicy());
      
      String address = null;
      request.setCharacterEncoding("utf-8");
      response.setCharacterEncoding("UTF-8");
      response.setContentType("text/html; charset=UTF-8");

      HttpSession session = request.getSession();
      RequestDispatcher dispatcher;
      String action = multi.getParameter("action");   
        String attri = multi.getParameter("attri");
        System.out.println("         "+multi.getParameter("attri"));
        PrintWriter out = response.getWriter();
        
      NoticeBean notice = new NoticeBean();
      NoticeDAO noDAO = NoticeDAO.getInstance();
      ArrayList<NoticeBean> noticeAll = new ArrayList<NoticeBean>();
      
      MissionBean mission = new MissionBean();
      MissionDAO mDAO = MissionDAO.getInstance();
        ArrayList<MissionBean> mAll = new ArrayList<MissionBean>();       
      
        MissionResultBean mr = new MissionResultBean();
        MissionResultDAO mrDAO = MissionResultDAO.getInstance();
        ArrayList<MissionResultBean> mrAll = new ArrayList<MissionResultBean>();      
        
      if(action.equals("noticeAdd")){
         Enumeration<?> files = multi.getFileNames();
         String file1 = (String) files.nextElement();
         image = multi.getFilesystemName(file1);
         image = "/ESTIS/Estis/Img/" + image;
         
         notice.setWriterid(multi.getParameter("writerid"));
         notice.setTitle(multi.getParameter("title"));
         notice.setDate(multi.getParameter("date"));
         notice.setImage(image);
         notice.setContent(multi.getParameter("content"));
         notice.setHeader(multi.getParameter("header"));
         notice.setHit(Integer.parseInt(multi.getParameter("hit")));
         noDAO.addNotice(notice); // DAO로 전달하여 DB에 값 저장

         noticeAll = noDAO.getNoticeAll();
         session.setAttribute("noticeAll", noticeAll);
         address = "/Estis/Notice.jsp";
         dispatcher = request.getRequestDispatcher(address);
         dispatcher.forward(request, response);
      }else if(action.equals("galleryAdd")){
           Enumeration<?> files = multi.getFileNames();
         String file1 = (String) files.nextElement();
         image = multi.getFilesystemName(file1);
         image = "/ESTIS/Estis/Img/" + image;
         
           int missionid = mDAO.getMissionId(multi.getParameter("missionTitle"));
           System.out.println(missionid);
           mr.setMissionid(missionid);
           mr.setWriterid(multi.getParameter("writerid"));
           mr.setTitle(multi.getParameter("title"));
           mr.setDate(multi.getParameter("date"));
           mr.setContent(multi.getParameter("content"));
           mr.setHit(Integer.parseInt(multi.getParameter("hit")));
           mr.setImage(image);
           mrDAO.addMissionResult(mr); //미션결과저장
           
           mrAll = mrDAO.getMissionResultAll();
           session.setAttribute("missionReAll", mrAll);
           address="/Estis/Gallery.jsp";
           dispatcher = request.getRequestDispatcher(address);
            dispatcher.forward(request, response);
        }else if(action.equals("missionAdd")){
         Enumeration<?> files = multi.getFileNames();
         String file1 = (String) files.nextElement();
         image = multi.getFilesystemName(file1);
         image = "/ESTIS/Estis/Img/" + image;
         
         mission.setTitle(multi.getParameter("title"));
           mission.setMax(Integer.parseInt(multi.getParameter("max")));
           mission.setMin(Integer.parseInt(multi.getParameter("min")));
           mission.setContent(multi.getParameter("content"));
           mission.setApplystart(multi.getParameter("applystart"));
           mission.setApplyend(multi.getParameter("applyend"));
           mission.setImage(image);
           mission.setResultdate(multi.getParameter("resultdate"));
           mission.setPerformstart(multi.getParameter("performstart"));
           mission.setPerformend(multi.getParameter("performend"));
           mDAO.addMission(mission); //DAO로 전달하여 DB에 값 저장
            request.setAttribute("missionadd", mission);
            
            mAll = mDAO.getMissionListAll();
          request.setAttribute("missionall", mAll);
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
          }
          else{
                 address="/Estis/MissionList.jsp";
                 dispatcher = request.getRequestDispatcher(address);
                 dispatcher.forward(request, response);
            }
      }
   }
}