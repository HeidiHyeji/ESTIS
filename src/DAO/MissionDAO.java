package DAO;

import java.sql.ResultSet;
import java.util.ArrayList;

import Beans.MissionBean;

public class MissionDAO extends DriverLoad{
   private static MissionDAO instance = new MissionDAO();

   public MissionDAO() {
      super();
   }
   
   public static MissionDAO getInstance () {
      return instance;
   }
   
   public void addMission(MissionBean mission){
      String sql = "insert into Mission(title,Max,Min,content,applystart,"
            + "applyend,resultdate,performstart,performend,image) values (?,?,?,?,?,?,?,?,?,?)";
      try{
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, mission.getTitle());
         pstmt.setInt(2, mission.getMax());
         pstmt.setInt(3, mission.getMin());
         pstmt.setString(4, mission.getContent());
         pstmt.setString(5, mission.getApplystart());
         pstmt.setString(6, mission.getApplyend());
         pstmt.setString(7, mission.getResultdate());
         pstmt.setString(8, mission.getPerformstart());
         pstmt.setString(9, mission.getPerformend());
         pstmt.setString(10, mission.getImage());
         
         pstmt.executeUpdate();
         disconnect();
      }catch(Exception e){
         System.err.println("MissionDAO error : addMission");
      }
   }
   
   //모든 미션 불러오기
 //모든 미션 불러오기
   public ArrayList<MissionBean> getMissionListAll(){
      String sql = "select * from mission order by missionid DESC";
      ArrayList<MissionBean> all = new ArrayList<MissionBean>();
      try{
         connect();
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(sql);
         while(rs.next()){
            MissionBean one = new MissionBean();

            one.setMissionid(rs.getInt(1));
            one.setTitle(rs.getString(2));
            one.setMax(rs.getInt(3));
            one.setMin(rs.getInt(4));
            one.setContent(rs.getString(5));
            one.setImage(rs.getString(6));
            one.setApplystart(rs.getString(7));
            one.setApplyend(rs.getString(8));
            one.setResultdate(rs.getString(9));
            one.setPerformstart(rs.getString(10));
            one.setPerformend(rs.getString(11));
            
            all.add(one);
         }
         rs.close();
         disconnect();
      } catch(Exception e){
         System.err.println("MissionDAO error : getMissionListAll");
      }
      return all;
   }
   
   public MissionBean getMissionOne(String num){
      String sql = "select * from mission where missionid = "+num;
      MissionBean one = new MissionBean();
      try{
         connect();
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(sql);
         while(rs.next()){
            one.setMissionid(rs.getInt(1));
            one.setTitle(rs.getString(2));
            one.setMax(rs.getInt(3));
            one.setMin(rs.getInt(4));
            one.setContent(rs.getString(5));
            one.setImage(rs.getString(6));
            
            one.setApplystart(rs.getString(7));
            one.setApplyend(rs.getString(8));
            one.setResultdate(rs.getString(9));
            one.setPerformstart(rs.getString(10));
            one.setPerformend(rs.getString(11));
         }
         rs.close();
         disconnect();
      } catch(Exception e){
         System.err.println("MissionDAO error : getMissionOne");
      }
      return one;
   }
   
   public ArrayList<MissionBean> getMissionList(){
       String sql = "select title,applystart,applyend,performstart,"
             + "performend,resultdate,missionid,max,min from mission order by missionid DESC";
       ArrayList<MissionBean> all = new ArrayList<MissionBean>();
       try{
          connect();
          pstmt = conn.prepareStatement(sql);
          rs = pstmt.executeQuery(sql);
          while(rs.next()){
             MissionBean in = new MissionBean();
             in.setTitle(rs.getString(1));
             in.setApplystart(rs.getString(2));
             in.setApplyend(rs.getString(3));
             in.setPerformstart(rs.getString(4));
             in.setPerformend(rs.getString(5));
             in.setResultdate(rs.getString(6));
             in.setMissionid(rs.getInt(7));
             in.setMax(rs.getInt(8));
             in.setMin(rs.getInt(9));
             
             all.add(in);
          }
          rs.close();
          disconnect();
       } catch(Exception e){
          System.out.println("미션 리스트 불러오기 에러");
       }
       return all;
    }

   public String getMissionTitle(int missionid) {
      String sql = "select title from mission where missionid=?";
      String title = null;
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, missionid);
         ResultSet rs = pstmt.executeQuery();

         while (rs.next()) {
            title = rs.getString("title");
         }
         rs.close();
         disconnect();
      } catch (Exception e) {
         System.err.println("MissionDAO error : getMissionTitle");
      }
      return title;
   }
   
   //미션 타이틀 넣으면 미션id리턴
   public int getMissionId(String missionTitle) {
      String sql = "select missionid from mission where title=?";
      int missionid = -1;
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, missionTitle);
         ResultSet rs = pstmt.executeQuery();

         while (rs.next()) {
            missionid = rs.getInt("missionid");
         }
         rs.close();
         disconnect();
      } catch (Exception e) {
         System.err.println("MissionDAO error : getMissionId");
      }
      return missionid;
   }
   public int getCount() {
	      int cnt = 0;
	      String sql = "select count(*) from mission";
	      
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

}