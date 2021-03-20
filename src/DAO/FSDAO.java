package DAO;

import java.sql.ResultSet;
import java.util.ArrayList;

import Beans.FSBean;

public class FSDAO extends DriverLoad {
   // private static 로 선언.
   private static FSDAO instance = new FSDAO();

   // 생성자
   public FSDAO() {
      // TODO Auto-generated constructor stub
      super();
   }

   // 조회 method
   public static FSDAO getInstance() {
      return instance;
   }

   public void addFS(FSBean fs) {//
      String sql = "insert into FS(fsid,pw,name,email,language,sid,phone,major,buddyid,semester) values (?,?,?,?,?,?,?,?,?,?)";

      try {
         // connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, fs.getFsid());
         pstmt.setString(2, fs.getPw());
         pstmt.setString(3, fs.getName());
         pstmt.setString(4, fs.getEmail());
         pstmt.setString(5, fs.getLanguage());
         pstmt.setInt(6, fs.getSid());
         pstmt.setString(7, fs.getPhone());
         pstmt.setString(8, fs.getMajor());
         pstmt.setString(9, fs.getBuddyid());
         pstmt.setInt(10, fs.getSemester());

         // disconnect();
         pstmt.executeUpdate();

      } catch (Exception e) {
         System.err.println("FSDAO error:addFS");
      }
   }
   
   public String getMyBuddy(String fsid) {
      String sql = "select  buddyid from fs where fsid=?";
      String mybuddy = null;
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, fsid);
         ResultSet rs = pstmt.executeQuery();
         rs.next();
         mybuddy = rs.getString("buddyid");

         disconnect();
      } catch (Exception e) {
         System.err.println("FSDAO error:getMyBuddy");
      }
      return mybuddy;

   }

   public void setBuddy(FSBean fs) {
      String sql = "update fs set buddyid=? where fsid=?";
      System.out.println("buddyid=" + fs.getBuddyid());
      System.out.println("fsid=" + fs.getFsid());
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, fs.getBuddyid());
         pstmt.setString(2, fs.getFsid());
         pstmt.executeUpdate();
         disconnect();
      } catch (Exception e) {
         System.err.println("FSDAO error:setBuddy");
      }
   }

   public void deleteBuddy(String fsid) {
      String sql = "update fs set buddyid=NULL where fsid=?";
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, fsid);
         pstmt.executeUpdate();
         disconnect();
      } catch (Exception e) {
         System.err.println("FSDAO error:deletBuddy Error");
      }
   }

   public ArrayList<FSBean> getAllFS() {
      String sql = "select fsid,pw,name,email,language,sid,phone,major,buddyid,semester from fs";
      ArrayList<FSBean> list = new ArrayList<FSBean>();
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         ResultSet rs = pstmt.executeQuery();

         while (rs.next()) {
            FSBean fs = new FSBean();
            fs.setFsid(rs.getString("fsid"));
            fs.setPw(rs.getString("pw"));
            fs.setName(rs.getString("name"));
            fs.setEmail(rs.getString("email"));
            fs.setLanguage(rs.getString("language"));
            fs.setSid(rs.getInt("sid"));
            fs.setPhone(rs.getString("phone"));
            fs.setMajor(rs.getString("major"));
            fs.setBuddyid(rs.getString("buddyid"));
            fs.setSemester(rs.getInt("semester"));

            list.add(fs);
         }
         rs.close();
         disconnect();
      } catch (Exception e) {
         System.err.println("FSDAO error:getAllFS");
      }
      return list;
   }

   public int checkExist(String fsid) {
      String sql = "select buddyid from fs where fsid=?";
      int exist = 2;// id가 있고 buddy가 존재함 =2
      System.out.print("해당 fsid= " + fsid);
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, fsid);
         ResultSet rs = pstmt.executeQuery();
         if (rs.next() == false) {// id가 존재하지 않음 = 1
            exist = 1;
            System.out.println(" 존재하지 않음");
         } else if (rs.getString(1) == null) {// id 존재, buddyid가 존재하지 않음 =0
                                       // <<원하는 상태
            exist = 0;
         } else
            System.out.println(" 이미 버디 존재 : " + rs.getString(1));
         disconnect();
      } catch (Exception e) {
         System.err.println("FSDAO error:checkExistBuddy");
      }
      return exist;
   }

   public ArrayList<FSBean> getAllFS(int start, int end) {
      String sql = "select fsid,pw,name,email,language,sid,"
            + "phone,major,buddyid,semester from fs order by fsid asc limit ?,?";
      ArrayList<FSBean> list = new ArrayList<FSBean>();
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, start);
         pstmt.setInt(2, end);
         ResultSet rs = pstmt.executeQuery();

         while (rs.next()) {
            FSBean fs = new FSBean();
            fs.setFsid(rs.getString("fsid"));
            fs.setPw(rs.getString("pw"));
            fs.setName(rs.getString("name"));
            fs.setEmail(rs.getString("email"));
            fs.setLanguage(rs.getString("language"));
            fs.setSid(rs.getInt("sid"));
            fs.setPhone(rs.getString("phone"));
            fs.setMajor(rs.getString("major"));
            fs.setBuddyid(rs.getString("buddyid"));
            fs.setSemester(rs.getInt("semester"));

            list.add(fs);
         }
         rs.close();
         disconnect();
      } catch (Exception e) {
         System.err.println("FSDAO error:getAllFS");
      }
      return list;
   }

   public FSBean getFS(String fsid) {
      // TODO Auto-generated method stub
      String sql = "select fsid,pw,name,email,language,sid,phone,major,buddyid,semester from fs where fsid=?";
      FSBean fs = new FSBean();
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, fsid);
         ResultSet rs = pstmt.executeQuery();

         while (rs.next()) {
            fs.setFsid(rs.getString("fsid"));
            fs.setPw(rs.getString("pw"));
            fs.setName(rs.getString("name"));
            fs.setEmail(rs.getString("email"));
            fs.setLanguage(rs.getString("language"));
            fs.setSid(rs.getInt("sid"));
            fs.setPhone(rs.getString("phone"));
            fs.setMajor(rs.getString("major"));
            fs.setBuddyid(rs.getString("buddyid"));
            fs.setSemester(rs.getInt("semester"));

         }
         rs.close();
         disconnect();
      } catch (Exception e) {
      }
      return fs;
   }

   public void initPwFS(String fsid) {
      String sql = "update fs set pw=? where fsid=?";
      try {
         // connect();일괄처리 하기 때문에 트랜잭션 사용한다. 따라서 connect와 disconnect는 dao객체에서
         // 호출한다.
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, "kgu");
         pstmt.setString(2, fsid);
         pstmt.executeUpdate();

         // disconnect();
      } catch (Exception e) {
         System.err.println("FSDAO error:initPwFS");
      }
   }

   public void deleteFS(String fsid) {
      String sql = "delete from fs where fsid=?";
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, fsid);
         pstmt.executeUpdate();
         disconnect();
      } catch (Exception e) {
         System.out.println("FSDAO error:deleteFS");
      }
   }

   public int getCount() {
      int cnt = 0;
      String sql = "select count(*) from fs";

      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         ResultSet rs = pstmt.executeQuery();

         while (rs.next()) {
            cnt = rs.getInt("count(*)");
         }
         rs.close();
         disconnect();
      } catch (Exception e) {
      }
      return cnt;

   }
   public void initPwFS(String fsid,int newPw) {
	      String sql = "update fs set pw=? where fsid=?";
	      try {
	         // connect();일괄처리 하기 때문에 트랜잭션 사용한다. 따라서 connect와 disconnect는 dao객체에서
	         // 호출한다.
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, newPw+"");
	         pstmt.setString(2, fsid);
	         pstmt.executeUpdate();

	         // disconnect();
	      } catch (Exception e) {
	         System.err.println("FSDAO error:initPwFS");
	      }
	   }

}