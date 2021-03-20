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

import Beans.BuddyBean;
import Beans.BuddyRoomPostingBean;
import Beans.FSBean;
import Beans.InputResult;
import Beans.WriterBean;
import DAO.BuddyDAO;
import DAO.BuddyRoomPostingDAO;
import DAO.FSDAO;

/**
 * Servlet implementation class BuddyController
 */
@WebServlet("/BuddyController")
public class BuddyController extends HttpServlet {
   private static final long serialVersionUID = 1L;

   /**
    * @see HttpServlet#HttpServlet()
    */
   public BuddyController() {
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
      
      String address = null;
      request.setCharacterEncoding("utf-8");
      HttpSession session=request.getSession();
      String action = request.getParameter("action");
      WriterBean user= (WriterBean)session.getAttribute("userinfo");
      String userid = (String)user.getWriterid();//현재 접속중인 사람 id
      BuddyRoomPostingDAO brpdao = new BuddyRoomPostingDAO();
      ArrayList<BuddyRoomPostingBean> sns = new ArrayList<BuddyRoomPostingBean>();
      
      session.setAttribute("userinfo", user);   
      System.out.println("버디룸: "+userid);
      //현재 접속중인 사람 유형 검사
      if(user.getAttri().equals("administrator")){
         System.out.println("관리자가 Buddyroom 클릭"+action);
         BuddyDAO buddydao = new BuddyDAO();
         if(action.equals("list")){
            ArrayList<BuddyBean> buddyRoomList = buddydao.getAllBuddy(); //모든 버디
            //session.setAttribute("userinfo", user);
            request.setAttribute("BuddyRoom", buddyRoomList);
            //request.setAttribute("memberlist", buddyRoomList);
            address="/Estis/Admin_BuddyRoomList.jsp";
         }
         if(action.equals("member")){
            System.out.println("member 들어옴");
            BuddyBean mybuddy = new BuddyBean();
            String buddyid = request.getParameter("buddyid");
            mybuddy = buddydao.getBuddyName(buddyid); //헤당 버디룸의 버디 이름
            ArrayList<FSBean> memberList = buddydao.getBuddyMember(buddyid); //해당 버디의 member
            //sns
            sns = brpdao.getBuddyRoomPosting(buddyid,memberList);
            session.setAttribute("sns", sns);
            session.setAttribute("userinfo", user);
            session.setAttribute("buddy", mybuddy);
            session.setAttribute("memberlist", memberList);
            address="/Estis/Admin_BuddyRoom.jsp";
         }
      }
      else if(user.getAttri().equals("fs")){
         FSDAO fsdao = new FSDAO();
         BuddyDAO dao = new BuddyDAO();
         BuddyBean mybuddy = new BuddyBean();
         //sns
         
//         for(int i=0; i<sns.size(); i++){
//            System.out.println(sns.get(i).getTitle());         
//         }
         if(action.equals("member")){
            String Buddyid=fsdao.getMyBuddy(userid); //내 버디
            System.out.println("버디 아이디 : "+Buddyid);
            mybuddy = dao.getBuddyName(Buddyid); //내 버디 이름
            System.out.println("버디 이름 : "+mybuddy.getName());
            ArrayList<FSBean> memberList = dao.getBuddyMember(Buddyid); //나와 같은 버디를 가진 fs
            //sns
            sns = brpdao.getBuddyRoomPosting(Buddyid,memberList);
            session.setAttribute("sns", sns);
            session.setAttribute("buddy", mybuddy);
            session.setAttribute("memberlist", memberList);
            address="/Estis/BuddyRoom.jsp";
         }
      }else if(user.getAttri().equals("buddy")){
         System.out.println("I'm Buddy");
         BuddyDAO dao = new BuddyDAO();
         FSDAO fsdao = new FSDAO();
         FSBean fs = new FSBean();
         ArrayList<FSBean> memberList = dao.getBuddyMember(userid);//내 멤버
         System.out.println(memberList);
         BuddyBean buddy = dao.getBuddyName(userid);//내 이름
         InputResult alert = new InputResult();
         //sns
         sns = brpdao.getBuddyRoomPosting(userid,memberList);
         session.setAttribute("sns", sns);
         for(int i=0; i<sns.size(); i++){
            System.out.println(sns.get(i).getTitle());         
         }
         if(action.equals("member")){
            System.out.println("member list 생성");
            session.setAttribute("memberlist", memberList);
            session.setAttribute("buddy", buddy);
            address="/Estis/BuddyRoom.jsp";
         }
         //멤버 추가
         else if(action.equals("addMember")){
            System.out.println("멤버등록 들어옴!!!!!!!!!!!!!: "+request.getParameter("addfsid"));
            int state=fsdao.checkExist(request.getParameter("addfsid"));
            if(state==0){
               fs.setBuddyid(userid);
               fs.setFsid(request.getParameter("addfsid"));
               fsdao.setBuddy(fs);
               memberList = dao.getBuddyMember(userid);
               session.setAttribute("memberlist", memberList);
            }
            else if(state==1){//id가존재하지 않음
               alert.setState("Error");
               alert.setAlert("ID가 존재하지 않습니다.");
               request.setAttribute("alerter", alert);
            }
            else{
               alert.setState("Error");
               alert.setAlert("이미 Buddy가 존재하는 학생입니다.");
               request.setAttribute("alerter", alert);
            }
            address="/Estis/ManageMember.jsp";
         }
         //멤버 삭제
         else if(action.equals("deleteMember")){
            System.out.println("멤버삭제 들어옴!!!!!!!!!!!!!"+request.getParameter("fsid"));
            fsdao.deleteBuddy(request.getParameter("fsid"));
            memberList = dao.getBuddyMember(userid);
            session.setAttribute("memberlist", memberList);
            address="/Estis/ManageMember.jsp";
         }
      }else{ //관리자

      }
      //버디가 멤버 등록 할 때
//      if(action.equals("member")){
//         FSBean fs = new FSBean();
//         fs.setBuddyid(userid);
//         fs.setFsid(request.getParameter("fsid"));
//         //중복체크해야함
//         fs.setPw(request.getParameter("psw"));
//         //dao.setFsBuddy(fs);
//         request.setAttribute("member", fs);
//         address="/Estis/BuddyRoom.jsp";
//         //         session.setAttribute("subjectlist", list);   
//         //         session.setAttribute("AllHomework", hwlist);
//
//      }
      RequestDispatcher dispatcher = request.getRequestDispatcher(address);
      dispatcher.forward(request, response);
   }
}