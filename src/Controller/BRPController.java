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

import Beans.BuddyRoomPostingBean;
import Beans.WriterBean;
import DAO.BuddyRoomPostingDAO;

/**
 * Servlet implementation class BRPController
 */
@WebServlet("/BRPController")
public class BRPController extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BRPController() {
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
      String address = null;
      request.setCharacterEncoding("UTF-8");
      String action = request.getParameter("action");   
      HttpSession session=request.getSession();
      WriterBean user= (WriterBean)session.getAttribute("userinfo");
      BuddyRoomPostingDAO brpdao = new BuddyRoomPostingDAO();
      BuddyRoomPostingBean brp = new BuddyRoomPostingBean();
      
      if(action.equals("snsadd")){//sns입력일때
         brp.setWriterid(user.getWriterid());//id
         brp.setTitle(request.getParameter("Title"));//제목
         brp.setContent(request.getParameter("content"));//내용
         brp.setImage(null);//이미지 일단 null
         brpdao.addContent(brp);
         session.setAttribute("userinfo", user);
         address = "/BuddyController?action=member";
         
      }
//      BuddyRoomPostingDAO brpdao = new BuddyRoomPostingDAO();
//      ArrayList<BuddyRoomPostingBean> sns = new ArrayList<BuddyRoomPostingBean>();
//      
//      System.out.println("SNS IN");
//      sns = brpdao.getBuddyRoomPosting();
//      session.setAttribute("sns", sns);
//      for(int i=0; i<sns.size(); i++){
//         System.out.println(sns.get(i).getTitle());         
//      }
//      address="/Estis/SNS.jsp";
//      
      RequestDispatcher dispatcher = request.getRequestDispatcher(address);
      dispatcher.forward(request, response);
   }

}