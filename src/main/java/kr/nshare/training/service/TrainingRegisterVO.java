package kr.nshare.training.service;

import kr.nshare.common.ComDefaultVO;

public class TrainingRegisterVO extends ComDefaultVO{
	
	private static final long serialVersionUID = 1L;
	
	private String code = "";
	private String training_code = "";
	private String email = "";
	private String name = "";
	private String title = "";
	private String content = "";
	private String sdate = "";
	private String matching_flag = "";
	
	//신고 확인 메일 관련 
	private String check_mail_status = "";
	
	//신고시간 준수 관련
	private String type1_use = "";
	private String type1_date = "";
	private String register_time = "";
	private String register_excess_time = "";
	private String registertime_use = "";
	
	//sort 관련 
	private String sortcolumn = "";
	private String orderBy = "";
	
	private String sdate_use = "";
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getTraining_code() {
		return training_code;
	}
	public void setTraining_code(String training_code) {
		this.training_code = training_code;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

	public String getMatching_flag() {
		return matching_flag;
	}

	public void setMatching_flag(String matching_flag) {
		this.matching_flag = matching_flag;
	}

	public String getType1_use() {
		return type1_use;
	}

	public void setType1_use(String type1_use) {
		this.type1_use = type1_use;
	}

	public String getType1_date() {
		return type1_date;
	}

	public void setType1_date(String type1_date) {
		this.type1_date = type1_date;
	}

	public String getRegister_excess_time() {
		return register_excess_time;
	}

	public void setRegister_excess_time(String register_excess_time) {
		this.register_excess_time = register_excess_time;
	}

	public String getRegistertime_use() {
		return registertime_use;
	}

	public void setRegistertime_use(String registertime_use) {
		this.registertime_use = registertime_use;
	}

	public String getRegister_time() {
		return register_time;
	}

	public void setRegister_time(String register_time) {
		this.register_time = register_time;
	}

	public String getSortcolumn() {
		return sortcolumn;
	}

	public void setSortcolumn(String sortcolumn) {
		this.sortcolumn = sortcolumn;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public String getCheck_mail_status() {
		return check_mail_status;
	}

	public void setCheck_mail_status(String check_mail_status) {
		this.check_mail_status = check_mail_status;
	}

	public String getSdate_use() {
		return sdate_use;
	}

	public void setSdate_use(String sdate_use) {
		this.sdate_use = sdate_use;
	}
}
