package DAO;


import java.sql.ResultSet;
import java.util.ArrayList;

import Beans.IMFFBean;
import Beans.IMFFFSBean;
import Beans.IMFFKSBean;
import Beans.KSBean;
import Beans.IMFFBean;
import Beans.IMFFBean;


public class IMFFDAO extends DriverLoad{
	private static IMFFDAO instance = new IMFFDAO();


	public static IMFFDAO getInstance() {
		return instance;
	}
	public IMFFDAO() {
		// TODO Auto-generated constructor stub
		super();
	}
	public void addIMFF(IMFFBean imff){
		String sql = "insert into IMFF(missionid,fsid1,fsid2,ksid1,ksid2) values (?,?,?,?,?)";
		try{
			//connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, imff.getMissionid());
			pstmt.setString(2, imff.getFsid1());
			pstmt.setString(3, imff.getFsid2());
			pstmt.setString(4, imff.getKsid1());
			pstmt.setString(5, imff.getKsid2());
			// disconnect();
			pstmt.executeUpdate();
		}catch(Exception e){
			System.err.println("IMFFDAO error:addIMFF");
		}
	}
	public void deleteIMFF(String missionid) {
		String sql = "delete from imff where missionid=?";
		try {
			connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, missionid);
			pstmt.executeUpdate();
			disconnect();
		} catch (Exception e) {
			System.out.println("IMFFDAO error:deleteIMFF");
		}
	}
	public ArrayList<IMFFBean> getIMFF(String missionid) { //missionid를 신청한 imff들의 객체들을 리턴한다.
		// TODO Auto-generated method stub
		String sql = "select fsid1,fsid2,ksid1,ksid2 from imff where missionid=?";
		ArrayList<IMFFBean> list = new ArrayList<IMFFBean>();

		try {
			connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, missionid);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				IMFFBean imff = new IMFFBean();		
				imff.setFsid1(rs.getString("fsid1"));
				imff.setFsid2(rs.getString("fsid2"));
				imff.setKsid1(rs.getString("ksid1"));
				imff.setKsid2(rs.getString("ksid2"));
				list.add(imff);
			}
			rs.close();
			disconnect();
		} catch (Exception e) {
			System.err.println("IMFFDAO error:getIMFF");
		}
		return list;
	}
	public void updateIMFF(IMFFBean imff){
		String sql = "update IMFF set ksid1=?, ksid2=? where missionid=? and fsid1=? and fsid2=?";
		try{
			//connect();버디는 일괄처리 하기 때문에 트랜잭션 사용한다. 따라서 connect와 disconnect는 dao객체에서 호출한다.				
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, imff.getKsid1());
			pstmt.setString(2, imff.getKsid2());
			pstmt.setInt(3, imff.getMissionid());
			pstmt.setString(4, imff.getFsid1());
			pstmt.setString(5, imff.getFsid2());


			pstmt.executeUpdate();

			//disconnect();
		}catch(Exception e){
			System.err.println("IMFFDAO error:updateIMFF");
		}
	}
	public void updateIMFFNULL(IMFFBean imff){
		String sql = "update IMFF set ksid1=?, ksid2=? where missionid=? and fsid1=? and fsid2 IS NULL";
		try{
			//connect();버디는 일괄처리 하기 때문에 트랜잭션 사용한다. 따라서 connect와 disconnect는 dao객체에서 호출한다.				
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, imff.getKsid1());
			pstmt.setString(2, imff.getKsid2());
			pstmt.setInt(3, imff.getMissionid());
			pstmt.setString(4, imff.getFsid1());


			pstmt.executeUpdate();

			//disconnect();
		}catch(Exception e){
			System.err.println("IMFFDAO error:updateIMFFNULL");
		}
	}
	//미션아이디로 imff뽑아내기
	public ArrayList<IMFFBean> getIMFFForMission(String mId){
		String sql = "select * from imff where missionid=?";
		ArrayList<IMFFBean> list = new ArrayList<IMFFBean>();
		try {
			connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mId);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				IMFFBean imff = new IMFFBean();
				imff.setTeamid(rs.getInt(1));
				imff.setMissionid(rs.getInt(2));
				imff.setFsid1(rs.getString(3));
				imff.setFsid2(rs.getString(4));
				imff.setKsid1(rs.getString(5));
				imff.setKsid2(rs.getString(6));
				list.add(imff);                                        
			}
			rs.close();
			disconnect();
		} catch (Exception e) {
			System.err.println("IMFFDAO error : getIMFFForMission");
		}
		return list;
	}
	
	  public IMFFBean getMissionIMFF(IMFFKSBean imffks) {//IMFFKSBean을 외국인 일때도 동일 하게 사용(사용자 id와 미션아이디를 표현하기 위함)
	      String sql = "select * from IMFF where (ksid1=? OR ksid2=? OR fsid1=? OR fsid2=?) AND missionid=? ";
	      IMFFBean imff = new IMFFBean();
	      try {
	         connect();
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, imffks.getKsid());//사용자 아이디가 속하는 팀 검색
	         pstmt.setString(2, imffks.getKsid());
	         pstmt.setString(3, imffks.getKsid());
	         pstmt.setString(4, imffks.getKsid());
	         pstmt.setInt(5, imffks.getMissionid());
	         ResultSet rs = pstmt.executeQuery();

	         while (rs.next()) {
					imff.setTeamid(rs.getInt(1));
					imff.setMissionid(rs.getInt(2));
					imff.setFsid1(rs.getString(3));
					imff.setFsid2(rs.getString(4));
					imff.setKsid1(rs.getString(5));
					imff.setKsid2(rs.getString(6));
	         }
	         rs.close();
	         disconnect();
	      } catch (Exception e) {
	      }
	      return imff;
	   }

	  public IMFFBean getMissionIMFF(IMFFFSBean imfffs) {//오버로딩
	      String sql = "select * from IMFF where (ksid1=? OR ksid2=? OR fsid1=? OR fsid2=?) AND missionid=? ";
	      IMFFBean imff = new IMFFBean();
	      try {
	         connect();
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, imfffs.getFsid());//사용자 아이디가 속하는 팀 검색
	         pstmt.setString(2, imfffs.getFsid());
	         pstmt.setString(3, imfffs.getFsid());
	         pstmt.setString(4, imfffs.getFsid());
	         pstmt.setInt(5, imfffs.getMissionid());
	         ResultSet rs = pstmt.executeQuery();

	         while (rs.next()) {
					imff.setTeamid(rs.getInt(1));
					imff.setMissionid(rs.getInt(2));
					imff.setFsid1(rs.getString(3));
					imff.setFsid2(rs.getString(4));
					imff.setKsid1(rs.getString(5));
					imff.setKsid2(rs.getString(6));
	         }
	         rs.close();
	         disconnect();
	      } catch (Exception e) {
	      }
	      return imff;
	   }

}
