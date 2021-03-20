package SystemMonitoring;

public class MemoryVo {
	private double total;
	private double used;
	private double free;
	public MemoryVo() {
		// TODO Auto-generated constructor stub
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public double getUsed() {
		return used;
	}
	public void setUsed(double used) {
		this.used = used;
	}
	public double getFree() {
		return free;
	}
	public void setFree(double free) {
		this.free = free;
	}
	public int getPercent(){
		return (int) Math.round(used/total*100);
	}

}
