package Beans;

public class NoticeBean {
   private int noticeid;
   private String writerid;
   private String title;
   private String date;
   private String content;
   private String image;
   private String header;
   private int hit;
   
   public NoticeBean() {

   }

   public int getNoticeid() {
      return noticeid;
   }

   public void setNoticeid(int noticeid) {
      this.noticeid = noticeid;
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

   public String getImage() {
      return image;
   }

   public void setImage(String image) {
      this.image = image;
   }
   
   public String getHeader() {
      return header;
   }

   public void setHeader(String header) {
      this.header = header;
   }
   
   public int getHit() {
      return hit;
   }
   
   public void setHit(int hit) {
      this.hit = hit;
   }
}