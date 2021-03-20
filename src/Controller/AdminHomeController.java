package Controller;

import java.io.IOException;
import java.util.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.IMFFKSDAO;
import DAO.MissionDAO;

import Beans.IMFFKSBean;
import Beans.MissionBean;
import SystemMonitoring.CPUVo;
import SystemMonitoring.MemoryVo;
import SystemMonitoring.SystemMonitoring;

/**
 * Servlet implementation class AdminHomeController
 */
@WebServlet("/AdminHomeController")
public class AdminHomeController extends HttpServlet {
   private static final long serialVersionUID = 1L;

   /**
    * @see HttpServlet#HttpServlet()
    */
   public AdminHomeController() {
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
      RequestDispatcher dispatcher;
      ServletContext sc = getServletContext();

      String address = null;
      String action = request.getParameter("action");

      //if (action.equals("home")) {
      
         
         /*오른쪽 버튼 메뉴 외친소,버디룸 페이지 'new'띄우기*/
         //외친소 페이지 마지막 수정날짜 구하기
         String imffPath = sc.getRealPath("/Estis/Admin_Imff.jsp");
         java.io.File imffFile = new java.io.File(imffPath);
         java.util.Date lastModified = new java.util.Date(imffFile.lastModified());
         java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
         String imff=fmt.format(lastModified);
         //request.setAttribute("Admin_Imff.jsp", imff);
         //버디룸 페이지 마지막 수정날짜 구하기
         String brPath = sc.getRealPath("/Estis/Admin_BuddyRoom.jsp");
         java.io.File brFile = new java.io.File(brPath);
         java.util.Date lastModified2 = new java.util.Date(imffFile.lastModified());
         String br=fmt.format(lastModified2);
         //request.setAttribute("Admin_BuddyRoom.jsp",br );
         
         //오늘 날짜 구하기
         Calendar calendar = Calendar.getInstance();
            java.util.Date todaydate = calendar.getTime();
            String today = fmt.format(todaydate);
         if(Double.parseDouble(imff)>=Double.parseDouble(today)-1000000)//어제 업데이트까지는 NEW로 표기한다:NEW라면
            request.setAttribute(imffFile.getName(),true);
         else request.setAttribute(imffFile.getName(),false);
         if(Double.parseDouble(br)>=Double.parseDouble(today)-1000000)//어제 업데이트까지는 NEW로 표기한다:NEW라면
            request.setAttribute(brFile.getName(),true);
         else request.setAttribute(brFile.getName(),false);
         

         
         
         /*date: ksid님이 missionid 미션을 language 전형으로 신청하였습니다 . 탭1부분*/
         IMFFKSDAO imffksdao=IMFFKSDAO.getInstance();
         ArrayList<IMFFKSBean> imffks_list=imffksdao.getAllIMFFKS(0, 5);
         
         ArrayList<ArrayList<String>> imffksTot = new ArrayList<>();
         MissionDAO missiondao=MissionDAO.getInstance();
         
         if(imffks_list.size()>0){
            for(int i=0; i<imffks_list.size(); i++){
               ArrayList<String> imffks_data=new ArrayList<>();
               IMFFKSBean imffks=(IMFFKSBean)imffks_list.get(i);
               String missiontitle=missiondao.getMissionTitle(imffks.getMissionid()); //미션아이디를 통해 미션타이틀을 얻는다
               String str=imffks.getKsid()+"님이 "+missiontitle+" 미션을"
                     +imffks.getLanguage()+" 전형으로 신청하였습니다.";
               imffks_data.add(str);//index 0에는 리스트에 띄울 스트링 add
               imffks_data.add(imffks.getDate());//index 1에는 리스트에 띄울 날짜 data add
               imffksTot.add(imffks_data);
            }
         }
         sc.setAttribute("imffksTot", imffksTot);
         
         /*오늘의 할일 테이블*/
         ArrayList<MissionBean> missionlist=(ArrayList<MissionBean>)missiondao.getMissionListAll();
         sc.setAttribute("missionlist", missionlist);
         
         
         
         
         
         address = "Estis/Admin_Home.jsp";
         dispatcher = request.getRequestDispatcher(address);
         dispatcher.forward(request, response);
         
         
         
         
         
      //}
      }
}