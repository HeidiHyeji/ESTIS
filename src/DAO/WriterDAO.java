package DAO;

import java.sql.ResultSet;
import java.sql.SQLException;

import Beans.IMFFFSBean;
import Beans.WriterBean;

public class WriterDAO extends DriverLoad{
   
   private static WriterDAO instance = new WriterDAO();
   
   public WriterDAO() {
      // TODO Auto-generated constructor stub
   }
   
   public static WriterDAO getInstance () {
      return instance;
   }
   public Boolean checkWriter(String writerid,String email) {
		String sql = "select * from writer where writerid=? and email=?";
		Boolean check=false;
		try {
			connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writerid);
			pstmt.setString(2, email);
			ResultSet rs = pstmt.executeQuery();

			check=rs.next();
			
			rs.close();
			disconnect();
		} catch (Exception e) {
	    	  System.err.println("WriterDAO error : checkWriter");
		}
		return check;
	}
  /* public void setPw(String writerid,String email,double newPw){
      String sql = "update Writer set pw=? where writerid=? and email=?";

      try{
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setDouble(1, newPw);
         pstmt.setString(2, writerid);
         pstmt.setString(3, email);
         pstmt.executeUpdate();
         disconnect();
      }catch(Exception e){
    	  System.err.println("WriterDAO error : setPw");
      }
   }*/
   public WriterBean getPw(String userid){
      System.out.println(userid);
      String sql = "select * from writer where writerid=?";
      WriterBean writer = new WriterBean();

      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, userid);
         rs = pstmt.executeQuery();

         //생성한 bean에 값 짚어 넣기
         rs.next();
         writer.setWriterid(rs.getString(1));//아이디가 이미 존재해서 회원가입이 불가능
         writer.setPw(rs.getString(2));//아이디가 이미 존재해서 회원가입이 불가능
         writer.setAttri(rs.getString(4));//아이디가 이미 존재해서 회원가입이 불가능

      } catch (Exception e) {
    	  System.err.println("WriterDAO error : getPw");
      } finally { 
         disconnect();
        
      }     

      return writer;
   }
   public int getCount() {
      int cnt = 0;
      String sql = "select count(*) from writer";
      
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
   public int getCount(String start,String end) {
      int cnt = 0;
      String sql = "select count(*) from writer where date>=? AND date<=?";
      
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, start);
         pstmt.setString(2, end);
         rs = pstmt.executeQuery();
         

         while (rs.next()) {
            cnt = rs.getInt("count(*)");
         }
         rs.close();
         disconnect();
      } catch (Exception e) {
      }
      return cnt;

   }
   public String getAttri(String userid){
	      
	      String sql = "select attri from writer where writerid=?";   
	      String attri = null;
	      try {
	         connect();
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         rs = pstmt.executeQuery();

	         if(rs.next()){
	        	 attri=rs.getString("attri");
	         }
	      } catch (Exception e) {
	    	  System.err.println("WriterDAO error:getAttri");
	      } finally { 
	         disconnect();
	      }     

	      return attri;
	   }

}