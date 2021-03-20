package SystemMonitoring;

public class CPUVo {
	private double userTime;
	private double totalSysTime;
	private double totalIdle;
	public CPUVo() {
		// TODO Auto-generated constructor stub
	}
	public double getUserTime() {
		return userTime;
	}
	public void setUserTime(double userTime) {
		this.userTime = userTime;
	}
	public double getTotalSysTime() {
		return totalSysTime;
	}
	public void setTotalSysTime(double totalSysTime) {
		this.totalSysTime = totalSysTime;
	}
	public double getTotalIdle() {
		return totalIdle;
	}
	public void setTotalIdle(double totalIdle) {
		this.totalIdle = totalIdle;
	}

}
