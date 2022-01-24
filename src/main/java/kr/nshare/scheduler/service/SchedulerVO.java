package kr.nshare.scheduler.service;

import kr.nshare.training.service.TrainingVO;

public class SchedulerVO extends TrainingVO{
	private static final long serialVersionUID = 1L;
	private String type = "";
	
	private String auto_end_date = "";
	private String manual_end_date = "";	
	
	public String getAuto_end_date() {
		return auto_end_date;
	}

	public void setAuto_end_date(String auto_end_date) {
		this.auto_end_date = auto_end_date;
	}

	public String getManual_end_date() {
		return manual_end_date;
	}

	public void setManual_end_date(String manual_end_date) {
		this.manual_end_date = manual_end_date;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
