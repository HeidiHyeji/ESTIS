package SystemMonitoring;

import org.hyperic.sigar.Sigar;

import java.text.DecimalFormat;

import org.hyperic.sigar.CpuPerc;
import org.hyperic.sigar.Mem;

public class SystemMonitoring {

	public SystemMonitoring() {
		// TODO Auto-generated constructor stub
	}

	public CPUVo getCPU()

	{

		//System.out.println("================== CPU DATA ====================");
		Sigar sigar = new Sigar();
		CpuPerc cpu = null;
		CpuPerc[] cpus = null;
		CPUVo vo=new CPUVo();
		try
		{
			cpu = sigar.getCpuPerc();
			cpus = sigar.getCpuPercList();
			//System.out.println(cpu.getUser()+"\n");
			vo.setUserTime(Math.round(cpu.getUser()*10000)/100.0);
			vo.setTotalSysTime(Math.round(cpu.getSys()*10000)/100.0);
			vo.setTotalIdle(cpu.getIdle()*100);
			/*System.out.println(String.format("Total User Time : %s / Total Sys Time : %s / Total Idle  : %s ",
					vo.getUserTime(),
					vo.getTotalSysTime(),
					vo.getTotalIdle()));*/
			/*UserTime CPU DATA 출력*/
		/*	for (int i = 0; i < cpus.length; i++)
			{
				System.out.println(String.format("[" + (i + 1) + "] User Time : %s / Sys Time : %s / Idle  : %s ",
						CpuPerc.format(cpus[i].getUser()),
						CpuPerc.format(cpus[i].getSys()),
						CpuPerc.format(cpus[i].getIdle())));
			}*/
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return vo;
	}

	public MemoryVo getMemory()
	{
		//System.out.println("================== Memory DATA ====================");
		Sigar sigar = new Sigar();
		Mem mem = null;
		String pattern = "####.##";
		MemoryVo vo=new MemoryVo();
		try
		{
			mem = sigar.getMem();
			/* KB > GB 변환 */
			Double total = (double) mem.getTotal() / 1000000000;
			Double used = (double) mem.getUsed() / 1000000000;
			Double free = (double) mem.getFree() / 1000000000;
			DecimalFormat df = new DecimalFormat(pattern);
			total=Math.round(total*100)/100.0;
			used=Math.round(used*100)/100.0;
			free=Math.round(free*100)/100.0;
			vo.setTotal(total);
			vo.setUsed(used);
			vo.setFree(free);
//			vo.setTotal(String.valueOf(df.format(totalCPU) + " GB"));
//			vo.setUsed(String.valueOf(df.format(usedCPU) + " GB"));
//			vo.setFree(String.valueOf(df.format(freeCPU) + " GB"));
			/*System.out.println(String.format("Total : %s / Used : %s / Free : %s ",
					vo.getTotal(),
					vo.getUsed(),
					vo.getFree()));*/
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return vo;
	}
}
