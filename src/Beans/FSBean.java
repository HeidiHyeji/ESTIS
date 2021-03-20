package Beans;

public class FSBean {
   private String fsid;
   private String pw;
   private String name;
   private String email;
   private String language;
   private int sid;
   private String phone;
   private String major;
   private String buddyid;
   private int semester;
   private String date;
   
   public String getDate() {
	return date;
}

public void setDate(String date) {
	this.date = date;
}

public FSBean() {

   }

   public String getFsid() {
      return fsid;
   }

   public void setFsid(String fsid) {
      this.fsid = fsid;
   }

   public String getPw() {
      return pw;
   }

   public void setPw(String pw) {
      this.pw = pw;
   }

   public String getName() {
      return name;
   }

   public void setName(String name) {
      this.name = name;
   }

   public String getEmail() {
      return email;
   }

   public void setEmail(String email) {
      this.email = email;
   }

   public String getLanguage() {
      return language;
   }

   public void setLanguage(String language) {
      this.language = language;
   }

   public int getSid() {
      return sid;
   }

   public void setSid(int sid) {
      this.sid = sid;
   }

   public String getPhone() {
      return phone;
   }

   public void setPhone(String phone) {
      this.phone = phone;
   }

   public String getMajor() {
      return major;
   }

   public void setMajor(String major) {
      this.major = major;
   }

   public String getBuddyid() {
      return buddyid;
   }

   public void setBuddyid(String buddyid) {
      this.buddyid = buddyid;
   }

   public int getSemester() {
      return semester;
   }

   public void setSemester(int semester) {
      this.semester = semester;
   }

}