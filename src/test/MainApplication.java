package test;

import java.util.List;

import javax.servlet.ServletContext;

import Date.DateCalc;
import SystemMonitoring.SystemMonitoring;
import test.BuddyExcelReader;
import test.BuddyVo;

public class MainApplication {

	public static void main(String[] args) {

		/*BuddyExcelReader excelReader = new BuddyExcelReader();

		System.out.println("*****xls*****");
		List<BuddyVo> xlsList = excelReader.xlsToBuddyVoList("C:\\Users\\gogo6\\Documents\\캡스톤설계\\소스코드\\buddyupdate.xls");
		printList(xlsList);
*/
		
		/*System.out.println("*****xlsx*****");
		List<CustomerVo> xlsxList = excelReader.xlsxToCustomerVoList("C:\\Users\\cjw47\\Desktop\\buddyTest.xlsx");
		printList(xlsxList);*/
		/*SystemMonitoring test=new SystemMonitoring();
		test.getCPU();
		test.getMemory();*/
		//System.out.println(System.getProperty("java.library.path"));
		DateCalc d=new DateCalc();
		System.out.println(d.getOtherDay(0));
		System.out.println(d.getOtherDay(-1));
		System.out.println(d.getOtherInitDate(0,0, 0, 0));
		System.out.println(d.getOtherInitDate(0,23, 59, 59));
		
		
	}

	public static void printList(List<BuddyVo> list) {
		BuddyVo vo;

		for (int i = 0; i < list.size(); i++) {
			vo = list.get(i);
			System.out.println(vo.toString());
		}
	}
}