package DAO;

import java.sql.ResultSet;
import java.util.ArrayList;

import Beans.KSBean;

public class KSDAO extends DriverLoad {
   private static KSDAO instance = new KSDAO();

   public KSDAO() {
      super();
   }

   public static KSDAO getInstance() {
      return instance;
   }

   public void addKS(KSBean ks) {
      String sql = "insert into KS(ksid,pw,name,language,sid,phone,major) values (?,?,?,?,?,?,?)";
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, ks.getKsid());
         pstmt.setString(2, ks.getPw());
         pstmt.setString(3, ks.getName());
         pstmt.setString(4, ks.getLanguage());
         pstmt.setInt(5, ks.getSid());
         pstmt.setString(6, ks.getPhone());
         pstmt.setString(7, ks.getMajor());

         pstmt.executeUpdate();

      } catch (Exception e) {
         System.out.println("한국학생 회원가입 에러");
      }
   }

   // 모든 한국학생 불러오기
   public ArrayList<KSBean> getAllKS() {// ksid,pw,name,email,language,sid
      String sql = "select ksid,pw,name,email,language,sid from ks";
      ArrayList<KSBean> list = new ArrayList<KSBean>();
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         ResultSet rs = pstmt.executeQuery();

         while (rs.next()) {
            KSBean ks = new KSBean();
            ks.setKsid(rs.getString("ksid"));
            ks.setPw(rs.getString("pw"));
            ks.setName(rs.getString("name"));
            ks.setEmail(rs.getString("email"));
            ks.setLanguage(rs.getString("language"));
            ks.setSid(rs.getInt("sid"));
            list.add(ks);
         }
         rs.close();
         disconnect();
      } catch (Exception e) {
         System.err.println("KSDAO error:getAllKS");
      }
      return list;
   }

   public ArrayList<KSBean> getAllKS(int start, int end) {// ksid,pw,name,email,language,sid
      String sql = "select ksid,pw,name,email,language,sid from ks order by ksid asc limit ?,?";
      ArrayList<KSBean> list = new ArrayList<KSBean>();
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, start);
         pstmt.setInt(2, end);
         ResultSet rs = pstmt.executeQuery();

         while (rs.next()) {
            KSBean ks = new KSBean();
            ks.setKsid(rs.getString("ksid"));
            ks.setPw(rs.getString("pw"));
            ks.setName(rs.getString("name"));
            ks.setEmail(rs.getString("email"));
            ks.setLanguage(rs.getString("language"));
            ks.setSid(rs.getInt("sid"));
            list.add(ks);
         }
         rs.close();
         disconnect();
      } catch (Exception e) {
         System.err.println("KSDAO error:getAllKS");
      }
      return list;
   }

   // 한국 학생 한명 정보 불러오기
   public KSBean getKS(String ksid) {
      String sql = "select ksid,pw,name,email,language,sid,phone,major,history from ks where ksid=?";
      KSBean ks = new KSBean();
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, ksid);
         ResultSet rs = pstmt.executeQuery();

         while (rs.next()) {
            ks.setKsid(rs.getString("ksid"));
            ks.setPw(rs.getString("pw"));
            ks.setName(rs.getString("name"));
            ks.setEmail(rs.getString("email"));
            ks.setLanguage(rs.getString("language"));
            ks.setSid(rs.getInt("sid"));
            ks.setPhone(rs.getString("phone"));
            ks.setMajor(rs.getString("major"));
            ks.setHistory(rs.getString("history"));
         }
         rs.close();
         disconnect();
      } catch (Exception e) {
      }
      return ks;
   }

   public void initPwKS(String ksid) {
      String sql = "update ks set pw=? where ksid=?";
      try {
         // connect();일괄처리 하기 때문에 트랜잭션 사용한다. 따라서 connect와 disconnect는 dao객체에서
         // 호출한다.
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, "kgu");
         pstmt.setString(2, ksid);
         pstmt.executeUpdate();

         // disconnect();
      } catch (Exception e) {
         System.err.println("KSDAO error:initPwKS");
      }
   }

   public void deleteKS(String ksid) {
      String sql = "delete from ks where ksid=?";
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, ksid);
         pstmt.executeUpdate();
         disconnect();
      } catch (Exception e) {
         System.out.println("KSDAO error:deleteKS");
      }
   }

   public int getCount() {
      int cnt = 0;
      String sql = "select count(*) from ks";

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
   public void initPwKS(String ksid,int newPw) {
	      String sql = "update ks set pw=? where ksid=?";
	      try {
	         // connect();일괄처리 하기 때문에 트랜잭션 사용한다. 따라서 connect와 disconnect는 dao객체에서
	         // 호출한다.
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, newPw+"");
	         pstmt.setString(2, ksid);
	         pstmt.executeUpdate();

	         // disconnect();
	      } catch (Exception e) {
	         System.err.println("KSDAO error:initPwKS");
	      }
	   }
}