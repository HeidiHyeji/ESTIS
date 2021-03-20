package DAO;

import java.util.ArrayList;
import Beans.MissionResultBean;

public class MissionResultDAO extends DriverLoad{
   
   private static MissionResultDAO instance = new MissionResultDAO();

   public MissionResultDAO() {
      super();
   }
   
   public static MissionResultDAO getInstance () {
      return instance;
   }

   public void addMissionResult(MissionResultBean mr) {
      String sql = "insert into missionresult(missionid,writerid,title,date,content,hit,image) "
            + "values (?,?,?,?,?,?,?)";
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, mr.getMissionid());
         pstmt.setString(2, mr.getWriterid());
         pstmt.setString(3, mr.getTitle());
         pstmt.setString(4, mr.getDate());
         pstmt.setString(5, mr.getContent());
         pstmt.setInt(6, mr.getHit());
         pstmt.setString(7, mr.getImage());

         pstmt.executeUpdate();
         disconnect();
      } catch (Exception e) {
         System.err.println("MissionResultDAO error:addMissionResult");
      }
   }
   
   //미션 결과 모두 불러오기
   public ArrayList<MissionResultBean> getMissionResultAll(){
      String sql = "select resultid,title,writerid,date,hit from missionresult order by resultid DESC";
      ArrayList<MissionResultBean> all = new ArrayList<MissionResultBean>();
      try{
         connect();
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(sql);
         while(rs.next()){
            MissionResultBean in = new MissionResultBean();
            in.setResultid(rs.getInt(1));
            in.setTitle(rs.getString(2));
            in.setWriterid(rs.getString(3));
            in.setDate(rs.getString(4));
            in.setHit(rs.getInt(5));
            
            all.add(in);
         }
         rs.close();
         disconnect();
      } catch(Exception e){
         System.err.println("MissionResultDAO error:getMissionResultAll");
      }
      return all;
   }
   
   //미션결과 세부사항 
   public MissionResultBean getMissionRe(String num){
      String sql = "select * from missionresult where resultid = "+num;
      MissionResultBean one = new MissionResultBean();
      try{
         connect();
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(sql);
         while(rs.next()){
            one.setResultid(rs.getInt(1));
            one.setMissionid(rs.getInt(2));
            one.setWriterid(rs.getString(3));
            one.setTitle(rs.getString(4));
            one.setDate(rs.getString(5));
            one.setContent(rs.getString(6));
            one.setImage(rs.getString(7));   
            one.setScore(rs.getInt(8));
            one.setHit(rs.getInt(9));
         }
         rs.close();
         disconnect();
      } catch(Exception e){
         System.err.println("MissionResultDAO error:getMissionRe");
      }
      return one;
   }
   public void updateHit(String resultid){
      String sql = "update missionresult set hit = hit + 1 where resultid="+resultid;
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.executeUpdate();
         disconnect();
      } catch (Exception e) {
         System.err.println("MissionResultDAO error:updateHit");
      }
   }
   
   public ArrayList<MissionResultBean> getMissionReForWriter(String writerid){
      String sql = "select * from missionresult where writerid = \'"+writerid +"\'";
      ArrayList<MissionResultBean> result = new ArrayList<MissionResultBean>();
      try{
         connect();
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(sql);
         
         while(rs.next()){
            MissionResultBean one = new MissionResultBean();
            one.setResultid(rs.getInt(1));
            one.setMissionid(rs.getInt(2));
            one.setWriterid(rs.getString(3));
            one.setTitle(rs.getString(4));
            one.setDate(rs.getString(5));
            one.setContent(rs.getString(6));
            one.setImage(rs.getString(7));   
            one.setScore(rs.getInt(8));
            one.setHit(rs.getInt(9));
            
            result.add(one);
         }
         rs.close();
         disconnect();
      } catch(Exception e){
         System.err.println("MissionResultDAO error : getMissionReForWriter");
      }
      return result;
   }
   
}