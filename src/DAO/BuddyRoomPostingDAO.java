package DAO;

import java.sql.ResultSet;
import java.util.ArrayList;

import Beans.BuddyRoomPostingBean;
import Beans.FSBean;
import Beans.KSBean;

public class BuddyRoomPostingDAO extends DriverLoad{

   public BuddyRoomPostingDAO() {
      // TODO Auto-generated constructor stub
   }
   public void addBuddyRoomPosting(BuddyRoomPostingBean brp){
      String sql = "insert into BuddyRoomPosting values ('"
            +brp.getPostingid()+"','"
            +brp.getWriterid()+"','"
            +brp.getTitle()+"','"
            +brp.getDate()+"','"
            +brp.getContent()+"','"
            +brp.getImage()+"')";
      try{
         connect();
         stmt.executeUpdate(sql);
         disconnect();
      }catch(Exception e){
      }
   }
   //꾸에에에ㅔ에에에에에ㅔ에엑
   public ArrayList<BuddyRoomPostingBean> getBuddyRoomPosting(String buddyid, ArrayList<FSBean> memberList){
      String sql = "select * from BuddyRoomPosting where writerid='"+buddyid+"'";
      for(int i=0; i<memberList.size(); i++){
         sql=sql+"or writerid='"+memberList.get(i).getFsid()+"'"; 
         }
      sql=sql+" order by 1 desc";
//      System.out.println(sql);
      ArrayList<BuddyRoomPostingBean> list = new ArrayList<BuddyRoomPostingBean>();      
      try{
         connect();
         pstmt = conn.prepareStatement(sql);
         ResultSet rs = pstmt.executeQuery();
         
         while (rs.next()) {         
            BuddyRoomPostingBean bp = new BuddyRoomPostingBean();
            bp.setPostingid(rs.getInt(1));
            bp.setWriterid(rs.getString(2));
            bp.setTitle(rs.getString(3));
            bp.setDate(rs.getString(4));
            bp.setContent(rs.getString(5));
            bp.setImage(rs.getBlob(6));
            list.add(bp);
         }
         rs.close();
         disconnect();
      } catch (Exception e) {
         System.err.println("BuddyRoomPosting error:getBuddyRoomPosting");
      }
      return list;
   }
   public void addContent(BuddyRoomPostingBean sns){
      String sql = "insert into BuddyRoomPosting values(null,?,?,null,?,?)";
       try{
            connect();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, sns.getWriterid());
            pstmt.setString(2, sns.getTitle());
            pstmt.setString(3, sns.getContent());
            pstmt.setBlob(4, sns.getImage());
            pstmt.executeUpdate();
            disconnect();
         }catch(Exception e){
            System.err.println("BuddyRoomPostingDAO error : addContent");
         }
      
   }
}