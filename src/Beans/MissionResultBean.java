package Beans;

public class MissionResultBean {
   private int resultid;
   private int missionid;
   private String writerid;
   private String title;
   private String date;
   private String content;
   private String image;
   private int score;
   private int hit;
   
   public MissionResultBean() {

   }

   public int getResultid() {
      return resultid;
   }

   public void setResultid(int resultid) {
      this.resultid = resultid;
   }

   public int getMissionid() {
      return missionid;
   }

   public void setMissionid(int missionid) {
      this.missionid = missionid;
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

   public int getScore() {
      return score;
   }

   public void setScore(int score) {
      this.score = score;
   }
   
   public int getHit() {
      return hit;
   }

   public void setHit(int hit) {
      this.hit = hit;
   }
}