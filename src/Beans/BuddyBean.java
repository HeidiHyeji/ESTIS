package Beans;

public class BuddyBean {
   private String buddyid;
   private String pw;
   private String name;
   private String email;
   private int semester;
   private String language;
   private String date;
   
   public String getDate() {
	return date;
}

public void setDate(String date) {
	this.date = date;
}

public BuddyBean() {

   }

   public String getBuddyid() {
      return buddyid;
   }

   public void setBuddyid(String buddyid) {
      this.buddyid = buddyid;
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

   public int getSemester() {
      return semester;
   }

   public void setSemester(int semester) {
      this.semester = semester;
   }

   public String getLanguage() {
      return language;
   }

   public void setLanguage(String language) {
      this.language = language;
   }

   
}