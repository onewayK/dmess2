package kr.nshare.training.service;

import kr.nshare.common.ComDefaultVO;

public class TrainingLogVO extends ComDefaultVO {

	/**
	 * 발송 로그 관련 내용
	 */
	private static final long serialVersionUID = 1L;
	private String type = "";
	private String code = "";
	private String training_code = "";
	private String training_user_code = "";
	private String institution_code = "";

	private String type1_use = "";
	private String type1_date = "";
	private String type1_info = "";
	private String type1_referer = "";
	private String type1_ip = "";
	private String type1_date_all = "";

	private String type2_use = "";
	private String type2_date = "";
	private String type2_info = "";
	private String type2_referer = "";
	private String type2_ip = "";
	private String type2_date_all = "";
	private String type2_json = "";

	private String type3_use = "";
	private String type3_date = "";
	private String type3_info = "";
	private String type3_referer = "";
	private String type3_ip = "";
	private String type3_date_all = "";
	private String log = "";
	private String sdate = "";
	private String status = "";

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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getLog() {
		return log;
	}

	public void setLog(String log) {
		this.log = log;
	}

	public String getType1_date_all() {
		return type1_date_all;
	}

	public void setType1_date_all(String type1_date_all) {
		this.type1_date_all = type1_date_all;
	}

	public String getType2_date_all() {
		return type2_date_all;
	}

	public void setType2_date_all(String type2_date_all) {
		this.type2_date_all = type2_date_all;
	}

	public String getType3_date_all() {
		return type3_date_all;
	}

	public void setType3_date_all(String type3_date_all) {
		this.type3_date_all = type3_date_all;
	}

	public String getType2_json() {
		return type2_json;
	}

	public void setType2_json(String type2_json) {
		this.type2_json = type2_json;
	}

}
