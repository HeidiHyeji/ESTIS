package Beans;

public class MissionBean {
   private int missionid;
   private String title;
   private int Max;
   private int Min;
   private String content;
   private String image;
   private String applystart;
   private String applyend;
   private String performstart;
   private String performend;
   private String resultdate;
   
   public MissionBean() {

   }

   public int getMissionid() {
      return missionid;
   }

   public void setMissionid(int missionid) {
      this.missionid = missionid;
   }

   public String getTitle() {
      return title;
   }

   public void setTitle(String title) {
      this.title = title;
   }

   public int getMax() {
      return Max;
   }

   public void setMax(int max) {
      Max = max;
   }

   public int getMin() {
      return Min;
   }

   public void setMin(int min) {
      Min = min;
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

   public String getApplystart() {
      return applystart;
   }

   public void setApplystart(String applystart) {
      this.applystart = applystart;
   }

   public String getApplyend() {
      return applyend;
   }

   public void setApplyend(String applyend) {
      this.applyend = applyend;
   }

   public String getResultdate() {
      return resultdate;
   }

   public void setResultdate(String resultdate) {
      this.resultdate = resultdate;
   }

   public String getPerformstart() {
      return performstart;
   }

   public void setPerformstart(String performstart) {
      this.performstart = performstart;
   }

   public String getPerformend() {
      return performend;
   }

   public void setPerformend(String performend) {
      this.performend = performend;
   }

}