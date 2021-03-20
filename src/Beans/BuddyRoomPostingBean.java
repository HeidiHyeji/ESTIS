package Beans;

import java.sql.Blob;

public class BuddyRoomPostingBean {
	private int postingid;
	private String writerid;
	private String title;
	private String date;
	private String content;
	private Blob image;
	public BuddyRoomPostingBean() {

	}
	public int getPostingid() {
		return postingid;
	}
	public void setPostingid(int postingid) {
		this.postingid = postingid;
	}
	public String getWriterid() {
		return writerid;
	}
	public void setWriterid(String writerid) {
		this.writerid = writerid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Blob getImage() {
		return image;
	}
	public void setImage(Blob image) {
		this.image = image;
	}
	
}
