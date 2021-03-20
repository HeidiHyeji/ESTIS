package DAO;

import java.util.ArrayList;
import Beans.NoticeBean;

public class NoticeDAO extends DriverLoad{
   private static NoticeDAO instance = new NoticeDAO();

   public NoticeDAO() {
      super();
   }
   
   public static NoticeDAO getInstance () {
      return instance;
   }
   
   String sql;
   
   //공지 추가
   public void addNotice(NoticeBean notice){
      sql = "insert into notice(writerid,title,date,content,image,header,hit) values (?,?,?,?,?,?,?)";
      try{
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, notice.getWriterid());
         pstmt.setString(2, notice.getTitle());
         pstmt.setString(3, notice.getDate());
         pstmt.setString(4, notice.getContent());
         pstmt.setString(5, notice.getImage());
         pstmt.setString(6, notice.getHeader());
         pstmt.setInt(7, notice.getHit());
         
         pstmt.executeUpdate();
         disconnect();
      }catch(Exception e){
         System.err.println("NoticeDAO error : addNotice");
      }
   }
   
   // 모든 공지 불러오기
   public ArrayList<NoticeBean> getNoticeAll() {
      sql = "select * from Notice order by noticeid DESC";
      ArrayList<NoticeBean> all = new ArrayList<NoticeBean>();
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(sql);
         while (rs.next()) {
            NoticeBean in = new NoticeBean();
            in.setNoticeid(rs.getInt(1));
            in.setWriterid(rs.getString(2));
            in.setTitle(rs.getString(3));
            in.setDate(rs.getString(4));
            in.setContent(rs.getString(5));
            in.setImage(rs.getString(6));
            in.setHeader(rs.getString(7));
            in.setHit(rs.getInt(8));
            
            all.add(in);
         }
         rs.close();
         disconnect();
      } catch (Exception e) {
         System.err.println("NoticeDAO error : getNoticeAll");
      }
      return all;
   }
   
   // 공지 한 개 불러오기
   public NoticeBean getNotice(String num){
      sql = "select * from notice where noticeid = " + num;
      NoticeBean one = new NoticeBean();
      try{
         connect();
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(sql);
         while(rs.next()){
            one.setNoticeid(rs.getInt(1));
            one.setWriterid(rs.getString(2));
            one.setTitle(rs.getString(3));
            one.setDate(rs.getString(4));
            one.setContent(rs.getString(5));
            one.setImage(rs.getString(6));
            one.setHeader(rs.getString(7));
            one.setHit(rs.getInt(8));
         }
         rs.close();
         disconnect();
      } catch(Exception e){
         System.err.println("NoticeDAO error : getNotice");
      }
      return one;
   }
   
   //가장 최근 공지 하나 불러오기
   public NoticeBean getNoticeLatest(){
      sql = "select * from notice where noticeid = (select max(noticeid) from notice)";
      NoticeBean one = new NoticeBean();
      try{
         connect();
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(sql);
         while(rs.next()){
            one.setNoticeid(rs.getInt(1));
            one.setWriterid(rs.getString(2));
            one.setTitle(rs.getString(3));
            one.setDate(rs.getString(4));
            one.setContent(rs.getString(5));
            one.setImage(rs.getString(6));
            one.setHeader(rs.getString(7));
            one.setHit(rs.getInt(8));
         }
         rs.close();
         disconnect();
      } catch(Exception e){
         System.err.println("NoticeDAO error : getNoticeLatest");
      }
      return one;
   }
   
   //조회수 증가시키기
   public void updateHit(String noticeid){
      sql = "update notice set hit = hit + 1 where noticeid="+noticeid;
      try {
         connect();
         pstmt = conn.prepareStatement(sql);
         pstmt.executeUpdate();
         disconnect();
      } catch (Exception e) {
         System.err.println("NoticeDAO error:updateHit");
      }
   }
}