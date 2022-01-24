package kr.nshare.statistics.service;

import java.util.ArrayList;

import kr.nshare.common.ComDefaultVO;

/**
 * 
 * 
 * @author air82
 * 
 */
public class StatisticsVO extends ComDefaultVO {

	private static final long serialVersionUID = 1L;
	private String code = "";
	private String training_code = "";
	private String type = "";
	private String training_user_code = "";
	private String institution_code = "";
	private String institution_name = "";
	private String group_name = "";
	private String selected = "";
	private String type1_use_yn = "";
	private String type1_use = "";
	private String type1_date = "";
	private String type1_info = "";
	private String type1_referer = "";
	private String type1_ip = "";
	private String type1_use_percent = "";
	private String phishing_use = "";
	private String phishing_cnt = "";
	private String t_userId = "";
	private String t_passwd = "";

	private String type2_use_yn = "";
	private String type2_use = "";
	private String type2_date = "";
	private String type2_info = "";
	private String type2_referer = "";
	private String type2_ip = "";
	private String type2_use_percent = "";

	private String type3_use_yn = "";
	private String type3_use = "";
	private String type3_date = "";
	private String type3_info = "";
	private String type3_referer = "";
	private String type3_ip = "";
	private String sdate = "";
	private String status = "";
	private String type3_use_percent = "";
	
	// training
	private String training_type1 = "";
	private String training_type2 = "";
	private String training_type3 = "";
	private String send_name = "";
	private String send_email = "";

	// 수신자 리스트용
	private String name = "";
	private String department_name = "";
	private String email = "";
	private String unikey = "";
	private String start_date = "";
	private String end_date = "";

	private String training_type1_percent = "";
	private String training_type2_percent = "";
	private String training_type3_percent = "";

	private String training_type1_cnt = "";
	private String training_type2_cnt = "";
	private String training_type3_cnt = "";

	// 그래프용
	// 전체
	private String total = "";
	private String all_total = "";
	// 읽은것 카운터
	private String read_cnt = "";
	// 링크실행 카운터
	private String link_cnt = "";
	// 파일 실행 카운터
	private String excute_cnt = "";
	// 신고 카운터
	private String register_cnt = "";
	private String register_cnt_percent = "";
	private String title = "";
	private String tname = "";

	private String type1_use_sum = "";
	private String type2_use_sum = "";
	private String type3_use_sum = "";
	private String group_code = "";
	private ArrayList<String> multiselect_training_code = new ArrayList<String>();
	private String ig_code = "";
	
	private String training_type1_cal = "";
	private String training_type2_cal = "";
	private String training_type3_cal = "";
	
	private String training_type1_2 = "";	
	private String training_type1_3 = "";
	private String training_type2_3 = "";
	private String training_type1_2_3 = "";
	
	private String training_type1_2_cal = "";
	private String training_type1_3_cal = "";
	private String training_type2_3_cal = "";
	private String training_type1_2_3_cal = "";
	
	private String type1_2_use = "";
	private String type1_3_use = "";
	private String type2_3_use = "";
	private String type1_2_3_use = "";
	
	private String type1_2_use_percent = "";
	private String type1_3_use_percent = "";
	private String type2_3_use_percent = "";
	private String type1_2_3_use_percent = "";
	
	//열람,링크, 첨부파일에 따른 신고율
	private String register_type = "";
	
	private String type1_register = "";
	private String type1_registertime = "";
	private String type1_register_cnt_percent = "";
	private String type1_register_cnt = "";
	private String type2_register = "";
	private String type2_registertime = "";
	private String type2_register_cnt_percent = "";
	private String type2_register_cnt = "";
	private String type3_register = "";
	private String type3_registertime = "";
	private String type3_register_cnt_percent = "";
	private String type3_register_cnt = "";
	
	//열람,링크, 첨부파일에 따른 신고준수율
	private String type1_registertime_cnt_percent = "";
	private String type1_registertime_cnt = "";
	private String type2_registertime_cnt_percent = "";
	private String type2_registertime_cnt = "";
	private String type3_registertime_cnt_percent = "";
	private String type3_registertime_cnt = "";
	
	//메일이 실제 발송된 시간
	private String send_date = "";
	
	//신고 관련
	private String register_excess_time = "";
	private String registertime_use = "";
	private String register_time_type = "";
	private String register_time = "";
	private String register_use  = "";
	private String register_sdate  = "";
	
	//sort 관련 
	private String sortcolumn = "";
	private String orderBy = "";
	
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTraining_user_code() {
		return training_user_code;
	}

	public void setTraining_user_code(String training_user_code) {
		this.training_user_code = training_user_code;
	}

	public String getInstitution_code() {
		return institution_code;
	}

	public void setInstitution_code(String institution_code) {
		this.institution_code = institution_code;
	}

	public String getType1_use_yn() {
		return type1_use_yn;
	}

	public void setType1_use_yn(String type1_use_yn) {
		this.type1_use_yn = type1_use_yn;
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

	public String getType1_info() {
		return type1_info;
	}

	public void setType1_info(String type1_info) {
		this.type1_info = type1_info;
	}

	public String getType1_referer() {
		return type1_referer;
	}

	public void setType1_referer(String type1_referer) {
		this.type1_referer = type1_referer;
	}

	public String getType1_ip() {
		return type1_ip;
	}

	public void setType1_ip(String type1_ip) {
		this.type1_ip = type1_ip;
	}

	public String getType2_use_yn() {
		return type2_use_yn;
	}

	public void setType2_use_yn(String type2_use_yn) {
		this.type2_use_yn = type2_use_yn;
	}

	public String getType2_use() {
		return type2_use;
	}

	public void setType2_use(String type2_use) {
		this.type2_use = type2_use;
	}

	public String getType2_date() {
		return type2_date;
	}

	public void setType2_date(String type2_date) {
		this.type2_date = type2_date;
	}

	public String getType2_info() {
		return type2_info;
	}

	public void setType2_info(String type2_info) {
		this.type2_info = type2_info;
	}

	public String getType2_referer() {
		return type2_referer;
	}

	public void setType2_referer(String type2_referer) {
		this.type2_referer = type2_referer;
	}

	public String getType2_ip() {
		return type2_ip;
	}

	public void setType2_ip(String type2_ip) {
		this.type2_ip = type2_ip;
	}

	public String getType3_use_yn() {
		return type3_use_yn;
	}

	public void setType3_use_yn(String type3_use_yn) {
		this.type3_use_yn = type3_use_yn;
	}

	public String getType3_use() {
		return type3_use;
	}

	public void setType3_use(String type3_use) {
		this.type3_use = type3_use;
	}

	public String getType3_date() {
		return type3_date;
	}

	public void setType3_date(String type3_date) {
		this.type3_date = type3_date;
	}

	public String getType3_info() {
		return type3_info;
	}

	public void setType3_info(String type3_info) {
		this.type3_info = type3_info;
	}

	public String getType3_referer() {
		return type3_referer;
	}

	public void setType3_referer(String type3_referer) {
		this.type3_referer = type3_referer;
	}

	public String getType3_ip() {
		return type3_ip;
	}

	public void setType3_ip(String type3_ip) {
		this.type3_ip = type3_ip;
	}

	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDepartment_name() {
		return department_name;
	}

	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUnikey() {
		return unikey;
	}

	public void setUnikey(String unikey) {
		this.unikey = unikey;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getRead_cnt() {
		return read_cnt;
	}

	public void setRead_cnt(String read_cnt) {
		this.read_cnt = read_cnt;
	}

	public String getLink_cnt() {
		return link_cnt;
	}

	public void setLink_cnt(String link_cnt) {
		this.link_cnt = link_cnt;
	}

	public String getExcute_cnt() {
		return excute_cnt;
	}

	public void setExcute_cnt(String excute_cnt) {
		this.excute_cnt = excute_cnt;
	}

	public String getRegister_cnt() {
		return register_cnt;
	}

	public void setRegister_cnt(String register_cnt) {
		this.register_cnt = register_cnt;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getInstitution_name() {
		return institution_name;
	}

	public void setInstitution_name(String institution_name) {
		this.institution_name = institution_name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	public String getTraining_type1() {
		return training_type1;
	}

	public void setTraining_type1(String training_type1) {
		this.training_type1 = training_type1;
	}

	public String getTraining_type2() {
		return training_type2;
	}

	public void setTraining_type2(String training_type2) {
		this.training_type2 = training_type2;
	}

	public String getTraining_type3() {
		return training_type3;
	}

	public void setTraining_type3(String training_type3) {
		this.training_type3 = training_type3;
	}

	public String getSend_name() {
		return send_name;
	}

	public void setSend_name(String send_name) {
		this.send_name = send_name;
	}

	public String getSend_email() {
		return send_email;
	}

	public void setSend_email(String send_email) {
		this.send_email = send_email;
	}

	public String getType1_use_percent() {
		return type1_use_percent;
	}

	public void setType1_use_percent(String type1_use_percent) {
		this.type1_use_percent = type1_use_percent;
	}

	public String getType2_use_percent() {
		return type2_use_percent;
	}

	public void setType2_use_percent(String type2_use_percent) {
		this.type2_use_percent = type2_use_percent;
	}

	public String getType3_use_percent() {
		return type3_use_percent;
	}

	public void setType3_use_percent(String type3_use_percent) {
		this.type3_use_percent = type3_use_percent;
	}

	public String getType1_use_sum() {
		return type1_use_sum;
	}

	public void setType1_use_sum(String type1_use_sum) {
		this.type1_use_sum = type1_use_sum;
	}

	public String getType2_use_sum() {
		return type2_use_sum;
	}

	public void setType2_use_sum(String type2_use_sum) {
		this.type2_use_sum = type2_use_sum;
	}

	public String getType3_use_sum() {
		return type3_use_sum;
	}

	public void setType3_use_sum(String type3_use_sum) {
		this.type3_use_sum = type3_use_sum;
	}

	public String getRegister_cnt_percent() {
		return register_cnt_percent;
	}

	public void setRegister_cnt_percent(String register_cnt_percent) {
		this.register_cnt_percent = register_cnt_percent;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getGroup_code() {
		return group_code;
	}

	public void setGroup_code(String group_code) {
		this.group_code = group_code;
	}

	public ArrayList<String> getMultiselect_training_code() {
		return multiselect_training_code;
	}

	public void setMultiselect_training_code(
			ArrayList<String> multiselect_training_code) {
		this.multiselect_training_code = multiselect_training_code;
	}

	public String getIg_code() {
		return ig_code;
	}

	public void setIg_code(String ig_code) {
		this.ig_code = ig_code;
	}

	public String getSelected() {
		return selected;
	}

	public void setSelected(String selected) {
		this.selected = selected;
	}

	public String getGroup_name() {
		return group_name;
	}

	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}

	public String getPhishing_use() {
		return phishing_use;
	}

	public void setPhishing_use(String phishing_use) {
		this.phishing_use = phishing_use;
	}

	public String getPhishing_cnt() {
		return phishing_cnt;
	}

	public void setPhishing_cnt(String phishing_cnt) {
		this.phishing_cnt = phishing_cnt;
	}

	public String getT_userId() {
		return t_userId;
	}

	public void setT_userId(String t_userId) {
		this.t_userId = t_userId;
	}

	public String getT_passwd() {
		return t_passwd;
	}

	public void setT_passwd(String t_passwd) {
		this.t_passwd = t_passwd;
	}

	public String getTraining_type1_percent() {
		return training_type1_percent;
	}

	public void setTraining_type1_percent(String training_type1_percent) {
		this.training_type1_percent = training_type1_percent;
	}

	public String getTraining_type2_percent() {
		return training_type2_percent;
	}

	public void setTraining_type2_percent(String training_type2_percent) {
		this.training_type2_percent = training_type2_percent;
	}

	public String getTraining_type3_percent() {
		return training_type3_percent;
	}

	public void setTraining_type3_percent(String training_type3_percent) {
		this.training_type3_percent = training_type3_percent;
	}

	public String getTraining_type1_cnt() {
		return training_type1_cnt;
	}

	public void setTraining_type1_cnt(String training_type1_cnt) {
		this.training_type1_cnt = training_type1_cnt;
	}

	public String getTraining_type2_cnt() {
		return training_type2_cnt;
	}

	public void setTraining_type2_cnt(String training_type2_cnt) {
		this.training_type2_cnt = training_type2_cnt;
	}

	public String getTraining_type3_cnt() {
		return training_type3_cnt;
	}

	public void setTraining_type3_cnt(String training_type3_cnt) {
		this.training_type3_cnt = training_type3_cnt;
	}

	public String getTraining_type1_2() {
		return training_type1_2;
	}

	public void setTraining_type1_2(String training_type1_2) {
		this.training_type1_2 = training_type1_2;
	}

	public String getTraining_type1_3() {
		return training_type1_3;
	}

	public void setTraining_type1_3(String training_type1_3) {
		this.training_type1_3 = training_type1_3;
	}

	public String getTraining_type2_3() {
		return training_type2_3;
	}

	public void setTraining_type2_3(String training_type2_3) {
		this.training_type2_3 = training_type2_3;
	}

	public String getTraining_type1_2_3() {
		return training_type1_2_3;
	}

	public void setTraining_type1_2_3(String training_type1_2_3) {
		this.training_type1_2_3 = training_type1_2_3;
	}

	public String getTraining_type1_cal() {
		return training_type1_cal;
	}

	public void setTraining_type1_cal(String training_type1_cal) {
		this.training_type1_cal = training_type1_cal;
	}

	public String getTraining_type2_cal() {
		return training_type2_cal;
	}

	public void setTraining_type2_cal(String training_type2_cal) {
		this.training_type2_cal = training_type2_cal;
	}

	public String getTraining_type3_cal() {
		return training_type3_cal;
	}

	public void setTraining_type3_cal(String training_type3_cal) {
		this.training_type3_cal = training_type3_cal;
	}

	public String getTraining_type1_2_cal() {
		return training_type1_2_cal;
	}

	public void setTraining_type1_2_cal(String training_type1_2_cal) {
		this.training_type1_2_cal = training_type1_2_cal;
	}

	public String getTraining_type1_3_cal() {
		return training_type1_3_cal;
	}

	public void setTraining_type1_3_cal(String training_type1_3_cal) {
		this.training_type1_3_cal = training_type1_3_cal;
	}

	public String getTraining_type2_3_cal() {
		return training_type2_3_cal;
	}

	public void setTraining_type2_3_cal(String training_type2_3_cal) {
		this.training_type2_3_cal = training_type2_3_cal;
	}

	public String getTraining_type1_2_3_cal() {
		return training_type1_2_3_cal;
	}

	public void setTraining_type1_2_3_cal(String training_type1_2_3_cal) {
		this.training_type1_2_3_cal = training_type1_2_3_cal;
	}

	public String getType1_2_use() {
		return type1_2_use;
	}

	public void setType1_2_use(String type1_2_use) {
		this.type1_2_use = type1_2_use;
	}

	public String getType1_3_use() {
		return type1_3_use;
	}

	public void setType1_3_use(String type1_3_use) {
		this.type1_3_use = type1_3_use;
	}

	public String getType2_3_use() {
		return type2_3_use;
	}

	public void setType2_3_use(String type2_3_use) {
		this.type2_3_use = type2_3_use;
	}

	public String getType1_2_3_use() {
		return type1_2_3_use;
	}

	public void setType1_2_3_use(String type1_2_3_use) {
		this.type1_2_3_use = type1_2_3_use;
	}

	public String getType1_2_use_percent() {
		return type1_2_use_percent;
	}

	public void setType1_2_use_percent(String type1_2_use_percent) {
		this.type1_2_use_percent = type1_2_use_percent;
	}

	public String getType1_3_use_percent() {
		return type1_3_use_percent;
	}

	public void setType1_3_use_percent(String type1_3_use_percent) {
		this.type1_3_use_percent = type1_3_use_percent;
	}

	public String getType2_3_use_percent() {
		return type2_3_use_percent;
	}

	public void setType2_3_use_percent(String type2_3_use_percent) {
		this.type2_3_use_percent = type2_3_use_percent;
	}

	public String getType1_2_3_use_percent() {
		return type1_2_3_use_percent;
	}

	public void setType1_2_3_use_percent(String type1_2_3_use_percent) {
		this.type1_2_3_use_percent = type1_2_3_use_percent;
	}

	public String getType1_register_cnt_percent() {
		return type1_register_cnt_percent;
	}

	public void setType1_register_cnt_percent(String type1_register_cnt_percent) {
		this.type1_register_cnt_percent = type1_register_cnt_percent;
	}

	public String getType1_register_cnt() {
		return type1_register_cnt;
	}

	public void setType1_register_cnt(String type1_register_cnt) {
		this.type1_register_cnt = type1_register_cnt;
	}

	public String getRegister_type() {
		return register_type;
	}

	public void setRegister_type(String register_type) {
		this.register_type = register_type;
	}

	public String getSend_date() {
		return send_date;
	}

	public void setSend_date(String send_date) {
		this.send_date = send_date;
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

	public String getRegister_use() {
		return register_use;
	}

	public void setRegister_use(String register_use) {
		this.register_use = register_use;
	}

	public String getRegister_sdate() {
		return register_sdate;
	}

	public void setRegister_sdate(String register_sdate) {
		this.register_sdate = register_sdate;
	}

	public String getRegister_time_type() {
		return register_time_type;
	}

	public void setRegister_time_type(String register_time_type) {
		this.register_time_type = register_time_type;
	}

	public String getType2_register_cnt_percent() {
		return type2_register_cnt_percent;
	}

	public void setType2_register_cnt_percent(String type2_register_cnt_percent) {
		this.type2_register_cnt_percent = type2_register_cnt_percent;
	}

	public String getType2_register_cnt() {
		return type2_register_cnt;
	}

	public void setType2_register_cnt(String type2_register_cnt) {
		this.type2_register_cnt = type2_register_cnt;
	}

	public String getType3_register_cnt_percent() {
		return type3_register_cnt_percent;
	}

	public void setType3_register_cnt_percent(String type3_register_cnt_percent) {
		this.type3_register_cnt_percent = type3_register_cnt_percent;
	}

	public String getType3_register_cnt() {
		return type3_register_cnt;
	}

	public void setType3_register_cnt(String type3_register_cnt) {
		this.type3_register_cnt = type3_register_cnt;
	}

	public String getType1_registertime_cnt_percent() {
		return type1_registertime_cnt_percent;
	}

	public void setType1_registertime_cnt_percent(
			String type1_registertime_cnt_percent) {
		this.type1_registertime_cnt_percent = type1_registertime_cnt_percent;
	}

	public String getType1_registertime_cnt() {
		return type1_registertime_cnt;
	}

	public void setType1_registertime_cnt(String type1_registertime_cnt) {
		this.type1_registertime_cnt = type1_registertime_cnt;
	}

	public String getType2_registertime_cnt_percent() {
		return type2_registertime_cnt_percent;
	}

	public void setType2_registertime_cnt_percent(
			String type2_registertime_cnt_percent) {
		this.type2_registertime_cnt_percent = type2_registertime_cnt_percent;
	}

	public String getType2_registertime_cnt() {
		return type2_registertime_cnt;
	}

	public void setType2_registertime_cnt(String type2_registertime_cnt) {
		this.type2_registertime_cnt = type2_registertime_cnt;
	}

	public String getType3_registertime_cnt_percent() {
		return type3_registertime_cnt_percent;
	}

	public void setType3_registertime_cnt_percent(
			String type3_registertime_cnt_percent) {
		this.type3_registertime_cnt_percent = type3_registertime_cnt_percent;
	}

	public String getType3_registertime_cnt() {
		return type3_registertime_cnt;
	}

	public void setType3_registertime_cnt(String type3_registertime_cnt) {
		this.type3_registertime_cnt = type3_registertime_cnt;
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

	public String getAll_total() {
		return all_total;
	}

	public void setAll_total(String all_total) {
		this.all_total = all_total;
	}

	public String getType1_register() {
		return type1_register;
	}

	public void setType1_register(String type1_register) {
		this.type1_register = type1_register;
	}

	public String getType1_registertime() {
		return type1_registertime;
	}

	public void setType1_registertime(String type1_registertime) {
		this.type1_registertime = type1_registertime;
	}

	public String getType2_register() {
		return type2_register;
	}

	public void setType2_register(String type2_register) {
		this.type2_register = type2_register;
	}

	public String getType2_registertime() {
		return type2_registertime;
	}

	public void setType2_registertime(String type2_registertime) {
		this.type2_registertime = type2_registertime;
	}

	public String getType3_register() {
		return type3_register;
	}

	public void setType3_register(String type3_register) {
		this.type3_register = type3_register;
	}

	public String getType3_registertime() {
		return type3_registertime;
	}

	public void setType3_registertime(String type3_registertime) {
		this.type3_registertime = type3_registertime;
	}

}
