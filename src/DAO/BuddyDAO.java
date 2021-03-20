package DAO;

import java.sql.ResultSet;
import java.util.ArrayList;

import Beans.BuddyBean;
import Beans.FSBean;
import Beans.MissionBean;

public class BuddyDAO extends DriverLoad {

   private static BuddyDAO instance = new BuddyDAO();

   public BuddyDAO() {
      super();
   }

   public static synchronized BuddyDAO getInstance() {
      return instance;
   }

   public void addBuddy(BuddyBean buddy) {
      //String sql = "Insert into Buddy values(?,?,?,?,?,?,?)";
      String sql = "update Buddy set pw=?, name=?, email=?, semester=?, language=? where buddyid=?";
      try {
         // connect();버디는 일괄처리 하기 때문에 트랜잭션 사용한다. 따라서 connect와 disconnect는
         // dao객체에서 호출한다.
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, buddy.getPw());
         pstmt.setString(2, buddy.getName());
         pstmt.setString(3, buddy.getEmail());
         pstmt.setInt(4, buddy.getSemester());
         pstmt.setString(5, buddy.getLanguage());
         pstmt.setString(6, buddy.getBuddyid());
         pstmt.executeUpdate();

         // disconnect();
      } catch (Exception e) {
         System.err.println("BuddyDAO error:addBuddy");
      }
   }

   public BuddyBean getBuddy(String buddyid) {
      BuddyBean buddy = new BuddyBean();
      String sql = "select * from buddy where buddyid = \"" + buddyid + "\"";
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(sql);
         while (rs.next()) {
            buddy.setBuddyid(rs.getString(1));
            buddy.setPw(rs.getString(2));
            buddy.setName(rs.getString(3));
            buddy.setEmail(rs.getString(4));
            buddy.setSemester(rs.getInt(5));
            buddy.setLanguage(rs.getString(6));
         }
         rs.close();
         disconnect();
      } catch (Exception e) {
         System.err.println("BuddyDAO error:getBuddy");
      }
      return buddy;
   }

   public ArrayList<BuddyBean> getAllBuddy() {
      String sql = "select buddyid,pw,name,email,semester,language from buddy";
      ArrayList<BuddyBean> list = new ArrayList<BuddyBean>();
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         ResultSet rs = pstmt.executeQuery();

         while (rs.next()) {
            BuddyBean buddy = new BuddyBean();
            buddy.setBuddyid(rs.getString("buddyid"));
            buddy.setPw(rs.getString("pw"));
            buddy.setName(rs.getString("name"));
            buddy.setEmail(rs.getString("email"));
            buddy.setSemester(rs.getInt("semester"));
            buddy.setLanguage(rs.getString("language"));
            list.add(buddy);
         }
         rs.close();
         disconnect();
      } catch (Exception e) {
         System.err.println("BuddyDAO error:getAllBuddy");
      }
      return list;
   }

   public void initBuddy(String buddyid) {
      String sql = "update Buddy set pw=?, name=?, email=null, semester=null, language=null where buddyid=?";
      try {
         // connect();버디는 일괄처리 하기 때문에 트랜잭션 사용한다. 따라서 connect와 disconnect는
         // dao객체에서 호출한다.
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, "kgu");
         pstmt.setString(2, "kgu");
         pstmt.setString(3, buddyid);
         pstmt.executeUpdate();

         // disconnect();
      } catch (Exception e) {
         System.err.println("BuddyDAO error:initBuddy");
      }
   }

   public void initPwBuddy(String buddyid) {
      String sql = "update Buddy set pw=? where buddyid=?";
      try {
         // connect();버디는 일괄처리 하기 때문에 트랜잭션 사용한다. 따라서 connect와 disconnect는
         // dao객체에서 호출한다.
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, "kgu");
         pstmt.setString(2, buddyid);
         pstmt.executeUpdate();

         // disconnect();
      } catch (Exception e) {
         System.err.println("BuddyDAO error:initPwBuddy");
      }
   }
   // 버디 아이디에 따른 멤버
   public ArrayList<FSBean> getBuddyMember(String buddy) {
      String sql = "select  fsid, name from fs where buddyid=?";
      ArrayList<FSBean> fsList = new ArrayList<FSBean>();

      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, buddy);
         ResultSet rs = pstmt.executeQuery();

         while (rs.next()) {
            FSBean fs = new FSBean();
            fs.setFsid(rs.getString(1));
            fs.setName(rs.getString(2));
            fsList.add(fs);
         }
         rs.close();
         disconnect();
      } catch (Exception e) {
         System.err.println("BuddyDAO error:getBuddyMember");
      }

      return fsList;
   }

   public BuddyBean getBuddyName(String buddyid) {
      System.out.println("버디 아아디" + buddyid);
      String sql = "select name from buddy where buddyid=?";
      BuddyBean buddy = new BuddyBean();
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, buddyid);
         ResultSet rs = pstmt.executeQuery();
         rs.next();
         buddy.setBuddyid(buddyid);
         buddy.setName(rs.getString(1));

         rs.close();
         disconnect();
      } catch (Exception e) {
         System.err.println("BuddyDAO error:getBuddyName");
      }
      return buddy;

   }
   public void initPwBuddy(String buddyid,int newPw) {
	      String sql = "update Buddy set pw=? where buddyid=?";
	      try {
	         connect();
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, newPw+"");
	         pstmt.setString(2, buddyid);
	         pstmt.executeUpdate();

	         disconnect();
	      } catch (Exception e) {
	         System.err.println("BuddyDAO error:initPwBuddy");
	      }
	   }
}