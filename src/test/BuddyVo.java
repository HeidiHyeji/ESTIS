package test;

public class BuddyVo {
	private String buddyId;
	private String buddyPw;
	private String buddyName;
	private String buddyEmail;
	private int buddySemester;
	private String buddyLanguage;

	
	public String getBuddyId() {
		return buddyId;
	}


	public void setBuddyId(String buddyId) {
		this.buddyId = buddyId;
	}


	public String getBuddyPw() {
		return buddyPw;
	}


	public void setBuddyPw(String buddyPw) {
		this.buddyPw = buddyPw;
	}


	public String getBuddyName() {
		return buddyName;
	}


	public void setBuddyName(String buddyName) {
		this.buddyName = buddyName;
	}


	public String getBuddyEmail() {
		return buddyEmail;
	}


	public void setBuddyEmail(String buddyEmail) {
		this.buddyEmail = buddyEmail;
	}


	public int getBuddySemester() {
		return buddySemester;
	}


	public void setBuddySemester(int buddySemester) {
		this.buddySemester = buddySemester;
	}


	public String getBuddyLanguage() {
		return buddyLanguage;
	}


	public void setBuddyLanguage(String buddyLanguage) {
		this.buddyLanguage = buddyLanguage;
	}


	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer();

		sb.append("ID : " + buddyId);
		sb.append(" ,  PW : " + buddyPw);
		sb.append(" ,  Name : " + buddyName);
		sb.append(" ,  EMAIL : " + buddyEmail);
		sb.append(" ,  Semester : " + buddySemester);
		sb.append(" ,  Language : " + buddyLanguage);

		return sb.toString();
	}
}
