package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DriverLoad {
	protected String jdbcDriver = "org.mariadb.jdbc.Driver";
	protected String jdbcUrl = "jdbc:mariadb://localhost:3306/estis";
	protected Connection conn;
	protected PreparedStatement pstmt = null;
	protected Statement stmt;
	protected ResultSet rs = null;
	
	
	public DriverLoad() {
		// TODO Auto-generated constructor stub
	}
	public void connect(){
		try{
			Class.forName(jdbcDriver);
			conn = DriverManager.getConnection(jdbcUrl,"root","se");
		}catch(Exception e){
		}
	}
	public void disconnect(){
		try{
			stmt.close();
			conn.close();
		}catch(Exception e){
		}
		
	}
	public void setAutoCommit(boolean autoCommit){
		try {
			conn.setAutoCommit(autoCommit);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void commit(){
		try {
			conn.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void rollback(){
		try {
			conn.rollback();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
	


