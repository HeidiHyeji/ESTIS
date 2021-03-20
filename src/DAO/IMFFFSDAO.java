package DAO;

import java.sql.ResultSet;
import java.util.ArrayList;

import Beans.FSBean;
import Beans.IMFFFSBean;
import Beans.KSBean;
import Beans.IMFFFSBean;

public class IMFFFSDAO extends DriverLoad {
	private static IMFFFSDAO instance = new IMFFFSDAO();

	// 조회 method
	public static IMFFFSDAO getInstance() {
		return instance;
	}

	public IMFFFSDAO() {
		// TODO Auto-generated constructor stub
		super();
	}

	public void addIMFFFS(IMFFFSBean imfffs) {
		String sql = "insert into IMFFFS(fsid,party,missionid) values (?,?,?)";
		try {
			// connect();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, imfffs.getFsid());
			pstmt.setString(2, imfffs.getParty());
			pstmt.setInt(3, imfffs.getMissionid());
			// disconnect();
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.err.println("IMFFFSDAO error:addIMFFFS");
		}
	}

	public int getCount(String missionid) {
		int cnt = 0;
		String sql = "select count(*) from imfffs where missionid=?";

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

	public ArrayList<IMFFFSBean> getIMFFFS(String missionid) { // missionid를 신청한
																// imffks들의 객체들을
																// 리턴한다.
		// TODO Auto-generated method stub
		String sql = "select imfffsid,fsid,party,missionid from imfffs where missionid=?";
		ArrayList<IMFFFSBean> list = new ArrayList<IMFFFSBean>();

		try {
			connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, missionid);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				IMFFFSBean imfffs = new IMFFFSBean();

				imfffs.setImfffsid(rs.getInt("imfffsid"));
				imfffs.setFsid(rs.getString("fsid"));
				imfffs.setParty(rs.getString("party"));
				imfffs.setMissionid(rs.getInt("missionid"));
				list.add(imfffs);
			}
			rs.close();
			disconnect();
		} catch (Exception e) {
			System.err.println("IMFFFSDAO error:getIMFFFS");
		}
		return list;
	}

	public Boolean checkIMFFFS(IMFFFSBean imfffs) {
		String sql = "select * from imfffs where missionid=? and fsid=?";
		Boolean check=false;
		try {
			connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, imfffs.getMissionid());
			pstmt.setString(2, imfffs.getFsid());
			ResultSet rs = pstmt.executeQuery();

			check=rs.next();
			
			rs.close();
			disconnect();
		} catch (Exception e) {
		}
		return check;
	}
}
