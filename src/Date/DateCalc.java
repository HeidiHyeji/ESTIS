package Date;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import Beans.MissionBean;

public class DateCalc {
   SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
   Date currentTime = new Date();
   SimpleDateFormat form2 = new SimpleDateFormat("yy.MM.dd");

   public String dateCalc(String applystart, String applyend, String performstart, String performend,
         String resultdate) throws ParseException {
      if(applystart ==null || applyend==null || performstart ==null 
            || performend==null || resultdate==null) return " ";
      Date applyS = form.parse(applystart);
      Date applyE = form.parse(applyend);
      Date perS = form.parse(performstart);
      Date perE = form.parse(performend);
      Date res = form.parse(resultdate);

      if(applyS.compareTo(currentTime)>0){
          return "모집예정";
       }else if(applyS.compareTo(currentTime)<0 && applyE.compareTo(currentTime)>0){   
          //System.out.println("모집중");
          return "모집중";
       }else if((applyE.compareTo(currentTime)<0 && res.compareTo(currentTime)>0)){
          //System.out.println("선별중");
          return "선별중";
       }else if((res.compareTo(currentTime)<0 && perS.compareTo(currentTime)>0)){
          //System.out.println("모집완료");
          return "모집완료";
       }else if((perS.compareTo(currentTime)<0 && perE.compareTo(currentTime)>0)){
          //System.out.println("활동중");
          return "활동중";
       }else if((perE.compareTo(currentTime)<0)){
          //System.out.println("종료");
          return "종료";
       }else{
          //System.out.println(" ");
          return " ";
       }
   }

   public String getCurrentDate() {
      
      return form.format(currentTime);
   }
   public String getOtherDay(int n){
      SimpleDateFormat form2 = new SimpleDateFormat("dd");
      Calendar cal= Calendar.getInstance();
      cal.add(cal.DATE,n);
      String other=form2.format(cal.getTime());
      return other;
   }
   public String getOtherInitDate(int n,int hours,int minutes, int seconds){
      //SimpleDateFormat ymd = new SimpleDateFormat("yyyy-MM-dd");
      Calendar cal= Calendar.getInstance();
      cal.add(cal.DATE,n);
      Date tmp=cal.getTime();
      tmp.setHours(hours);
      tmp.setMinutes(minutes);
      tmp.setSeconds(seconds);
      
      String other=form.format(tmp);
      return other;
   }

   public int getRecruitCount(ArrayList<MissionBean> missionlist) {// 모집중
      int cnt = 0;
      try {
         for (int i = 0; i < missionlist.size(); i++) {
            MissionBean mission = missionlist.get(i);

            String result = dateCalc(mission.getApplystart(), mission.getApplyend(), mission.getPerformstart(),
                  mission.getPerformend(), mission.getResultdate());
            if (result != null)
               if (result.equals("모집중"))
                  cnt++;
         }
      } catch (ParseException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();

      }
      return cnt;
   }

   public int getSelectCount(ArrayList<MissionBean> missionlist) {// 선별중
      int cnt = 0;
      try {
         for (int i = 0; i < missionlist.size(); i++) {
            MissionBean mission = missionlist.get(i);

            String result = dateCalc(mission.getApplystart(), mission.getApplyend(), mission.getPerformstart(),
                  mission.getPerformend(), mission.getResultdate());
            if (result != null)
               if (result.equals("선별중"))
                  cnt++;
         }
      } catch (ParseException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();

      }
      return cnt;
   }

   public int getCompleteCount(ArrayList<MissionBean> missionlist) {// 모집완료
      int cnt = 0;
      try {
         for (int i = 0; i < missionlist.size(); i++) {
            MissionBean mission = missionlist.get(i);

            String result = dateCalc(mission.getApplystart(), mission.getApplyend(), mission.getPerformstart(),
                  mission.getPerformend(), mission.getResultdate());
            if (result != null)
               if (result.equals("모집완료"))
                  cnt++;
         }
      } catch (ParseException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();

      }
      return cnt;
   }

   public int getActiveCount(ArrayList<MissionBean> missionlist) {// 활동중
      int cnt = 0;
      try {
         for (int i = 0; i < missionlist.size(); i++) {
            MissionBean mission = missionlist.get(i);

            String result = dateCalc(mission.getApplystart(), mission.getApplyend(), mission.getPerformstart(),
                  mission.getPerformend(), mission.getResultdate());
            if (result != null)
               if (result.equals("활동중"))
                  cnt++;
         }
      } catch (ParseException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();

      }
      return cnt;
   }

   public int getFinishCount(ArrayList<MissionBean> missionlist) {// 종료
      int cnt = 0;
      try {
         for (int i = 0; i < missionlist.size(); i++) {
            MissionBean mission = missionlist.get(i);

            String result = dateCalc(mission.getApplystart(), mission.getApplyend(), mission.getPerformstart(),
                  mission.getPerformend(), mission.getResultdate());
            if (result != null)
               if (result.equals("종료"))
                  cnt++;
         }
      } catch (ParseException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();

      }
      return cnt;
   }
   public String getDate(String date) throws ParseException{
	      Date date2 = form.parse(date);
	      return form2.format(date2);
	   }

}