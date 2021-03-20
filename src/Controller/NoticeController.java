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

import Beans.NoticeBean;
import DAO.NoticeDAO;

/**
 * Servlet implementation class NoticeController
 */
@WebServlet("/NoticeController")
public class NoticeController extends HttpServlet {
   private static final long serialVersionUID = 1L;

   /**
    * @see HttpServlet#HttpServlet()
    */
   public NoticeController() {
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
    * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
    *      response)
    */
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      String address = null;
      request.setCharacterEncoding("utf-8");
      response.setCharacterEncoding("UTF-8");
      response.setContentType("text/html; charset=UTF-8");
      String action = request.getParameter("action");
      
      HttpSession session = request.getSession();
      RequestDispatcher dispatcher;
      
      ArrayList<NoticeBean> noticeAll = new ArrayList<NoticeBean>();
      NoticeBean notice = new NoticeBean();
      NoticeDAO nodao = new NoticeDAO();
      
      if(action.equals("notice")) {
         noticeAll = nodao.getNoticeAll();
         session.setAttribute("noticeAll", noticeAll);
         address = "/Estis/Notice.jsp";
         dispatcher = request.getRequestDispatcher(address);
         dispatcher.forward(request, response);   
      }
      //공지사항페이지에서 
      else if(action.equals("add")){ 
         address = "/Estis/NoticeAdd.jsp";
         dispatcher = request.getRequestDispatcher(address);
         dispatcher.forward(request, response);
      }else if(action.equals("detail")){
         nodao.updateHit(request.getParameter("noticeid"));
         notice = nodao.getNotice(request.getParameter("noticeid"));
           System.out.println(request.getParameter("noticeid"));
           session.setAttribute("noticeOne", notice);
         address = "/Estis/NoticeDetail.jsp";
         dispatcher = request.getRequestDispatcher(address);
         dispatcher.forward(request, response);
      }
   }

}