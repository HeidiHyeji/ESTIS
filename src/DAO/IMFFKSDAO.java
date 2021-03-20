package DAO;

import java.sql.ResultSet;
import java.util.ArrayList;


import Beans.IMFFKSBean;


public class IMFFKSDAO extends DriverLoad{
	private static IMFFKSDAO instance = new IMFFKSDAO();
	
	public static synchronized IMFFKSDAO getInstance(){
		return instance;
	}
	public IMFFKSDAO() {
		// TODO Auto-generated constructor stub
		super();
	}
	public void addIMFFKS(IMFFKSBean imffks){
			String sql;
	      if(imffks.getParty()==null)  sql = "insert into IMFFKS (ksid,reason,missionid,language,date,state) values (?,?,?,?,?,?)";
	      else sql = "insert into IMFFKS (ksid,reason,missionid,language,date,state,party) values (?,?,?,?,?,?,?)";
	      try{
	         connect();
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, imffks.getKsid());
	         pstmt.setString(2, imffks.getReason());
	         pstmt.setInt(3, imffks.getMissionid());
	         pstmt.setString(4, imffks.getLanguage());
	         pstmt.setString(5, imffks.getDate());
	         pstmt.setString(6, imffks.getState());
	         System.out.println(imffks.getDate());
	         System.out.println(imffks.getParty());
	         if(imffks.getParty()!=null){ 
	            pstmt.setString(7, imffks.getParty());
	            System.out.println(imffks.getParty());
	         }
	         pstmt.executeUpdate();
	         disconnect();
	      }catch(Exception e){
	         System.err.println("IMFFKSDAO error : addIMFFKS");
	      }
	   }
	public ArrayList<IMFFKSBean> getAllIMFFKS(int start, int end) {
		String sql = "select date,ksid,missionid,language from imffks order by date desc limit ?,?";

		ArrayList<IMFFKSBean> list = new ArrayList<IMFFKSBean>();
		try {
			connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				IMFFKSBean imffks = new IMFFKSBean();
				imffks.setDate(rs.getString("date"));
				imffks.setKsid(rs.getString("ksid"));
				imffks.setMissionid(rs.getInt("missionid"));
				imffks.setLanguage(rs.getString("language"));
				
				list.add(imffks);
			}
			rs.close();
			disconnect();
		} catch (Exception e) {
			System.err.println("IMFFKSDAO error:getAllIMFFKS");
		}
		return list;
	}
	public IMFFKSBean checkDoubleApply(String ksid, String missionid){
	      IMFFKSBean imffks = new IMFFKSBean();
	      String sql = "select DISTINCT ksid from IMFFKS where missionid = "+missionid+" and ksid=\""+ksid+"\"";
	      try{
	         connect();
	         pstmt = conn.prepareStatement(sql);
	         rs = pstmt.executeQuery(sql);
	         while(rs.next()){
	            imffks.setKsid(rs.getString(1));;
	         }
	         rs.close();
	         disconnect();
	      } catch(Exception e){
	         System.out.println("신청 중복 방지 에러");      
	      }
	      return imffks;
	   }
	public int getCount(String missionid) {
		int cnt = 0;
		String sql = "select count(*) from imffks where missionid=?";
		
		try {
			connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, missionid);
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
	public ArrayList<IMFFKSBean> getIMFFKS(String missionid) { //missionid를 신청한 imffks들의 객체들을 리턴한다.
		// TODO Auto-generated method stub
		String sql = "select imffksid,ksid,party,reason,missionid,language,date,state from imffks where missionid=?";
		ArrayList<IMFFKSBean> list = new ArrayList<IMFFKSBean>();
		
		try {
			connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, missionid);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				IMFFKSBean imffks = new IMFFKSBean();
				
				imffks.setImffksid(rs.getInt("imffksid"));
				imffks.setKsid(rs.getString("ksid"));
				imffks.setParty(rs.getString("party"));
				imffks.setReason(rs.getString("reason"));
				imffks.setMissionid(rs.getInt("missionid"));
				imffks.setLanguage(rs.getString("language"));
				imffks.setDate(rs.getString("date"));
				imffks.setState(rs.getString("state"));
			
				list.add(imffks);
			}
			rs.close();
			disconnect();
		} catch (Exception e) {
		}
		return list;
	}
	//ksid에 따른 신청 내역 보기
	   public ArrayList<IMFFKSBean> getApplyForKS(String ksid){
	      String sql = "select distinct * from imffks where ksid = "+ksid;
	      ArrayList<IMFFKSBean> all = new ArrayList<IMFFKSBean>();
	      try {
	         connect();
	         pstmt = conn.prepareStatement(sql);
	         rs = pstmt.executeQuery(sql);
	         while (rs.next()) {
	            IMFFKSBean in = new IMFFKSBean();
	            in.setImffksid(rs.getInt(1));
	            in.setKsid(rs.getString(2));
	            in.setParty(rs.getString(3));
	            in.setReason(rs.getString(4));
	            in.setMissionid(rs.getInt(5));
	            in.setLanguage(rs.getString(6));
	            in.setDate(rs.getString(7));
	            in.setState(rs.getString(8));
	            
	            all.add(in);
	         }
	         rs.close();
	         disconnect();
	      } catch (Exception e) {
	         System.err.println("IMFFKSDAO error : getApplyForKS");
	      }
	      return all;
	   }
	   public void updateIMFFKSState(IMFFKSBean imffks) {
		  
		      String sql = "update IMFFKS set state=? where ksid=? and missionid=?";
		      try {
		         // connect();여러명을 일괄처리 하기 때문에 트랜잭션 사용한다. 따라서 connect와 disconnect는
		         // dao객체에서 호출한다.
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setString(1, imffks.getState());
		         pstmt.setString(2, imffks.getKsid());
		         pstmt.setInt(3, imffks.getMissionid());

		         pstmt.executeUpdate();

		         // disconnect();
		      } catch (Exception e) {
		         System.err.println("IMFFKSDAO error:updateIMFFKSState");
		      }
		   }
	   public String getIMFFKSState(IMFFKSBean imffks) {
		      String sql = "select state from IMFFKS where missionid=? and ksid=?";
		      String state = null;
		      try {
		         connect();
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setInt(1, imffks.getMissionid());
		         pstmt.setString(2, imffks.getKsid());
		         ResultSet rs = pstmt.executeQuery();

		         while (rs.next()) {
		        	 state = rs.getString("state");
		         }
		         rs.close();
		         disconnect();
		      } catch (Exception e) {
		         System.err.println("IMFFKSDAO error : getIMFFKSState");
		      }
		      return state;
		   }
}
