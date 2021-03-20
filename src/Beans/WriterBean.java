package Beans;

import java.sql.Blob;

public class WriterBean {
	private String writerid;
	private String pw;
	private String email;
	private String attri;
	public String getAttri() {
		return attri;
	}
	public void setAttri(String attri) {
		this.attri = attri;
	}
	public String getWriterid() {
		return writerid;
	}
	public void setWriterid(String writerid) {
		this.writerid = writerid;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
}
