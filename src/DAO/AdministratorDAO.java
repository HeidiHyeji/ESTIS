package DAO;

import java.sql.ResultSet;

import Beans.AdministratorBean;
import Beans.FSBean;

public class AdministratorDAO extends DriverLoad{

	public AdministratorDAO() {
		// TODO Auto-generated constructor stub
	}
	public void addAdministrator(AdministratorBean admin){
		String sql = "insert into Administrator values ('"
				+admin.getId()+"','"
				+admin.getPw()+"')";
		try{
			connect();
			stmt.executeUpdate(sql);
			disconnect();
		}catch(Exception e){
		}
	}
	
}
