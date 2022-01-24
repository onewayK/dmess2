package kr.nshare.request.service;

import kr.nshare.common.ComDefaultVO;

import org.springframework.web.multipart.MultipartFile;



public class RequestVO extends ComDefaultVO{
	
	private static final long serialVersionUID = 1L;
	
	private String type = "";
	private String t = "";
	private String u = "";
	
	private String name = "";
	private String email = "";
	private String content="";
	private String training_code = "";
	private String matching_flag = "";
	private String sdate = "";
	private String sdate_use = "";
	
	private String title = "";
	private String register_user = "";
	private String msg = "";
	private String training_user_code = "";
		
	
	private String t_userId = "";
	private String t_passwd = "";
	private String t_01= "";
	private String t_02= "";
	private String t_03= "";
	private String t_04= "";
	
	
	private MultipartFile uploadfile;	
	
	public String getRegister_user() {
		return register_user;
	}
	public void setRegister_user(String register_user) {
		this.register_user = register_user;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getT() {
		return t;
	}
	public void setT(String t) {
		this.t = t;
	}
	public String getU() {
		return u;
	}
	public void setU(String u) {
		this.u = u;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTraining_code() {
		return training_code;
	}
	public void setTraining_code(String training_code) {
		this.training_code = training_code;
	}
	public String getMatching_flag() {
		return matching_flag;
	}
	public void setMatching_flag(String matching_flag) {
		this.matching_flag = matching_flag;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
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
	public String getT_01() {
		return t_01;
	}
	public void setT_01(String t_01) {
		this.t_01 = t_01;
	}
	public String getT_02() {
		return t_02;
	}
	public void setT_02(String t_02) {
		this.t_02 = t_02;
	}
	public String getT_03() {
		return t_03;
	}
	public void setT_03(String t_03) {
		this.t_03 = t_03;
	}
	public String getT_04() {
		return t_04;
	}
	public void setT_04(String t_04) {
		this.t_04 = t_04;
	}
	public String getTraining_user_code() {
		return training_user_code;
	}
	public void setTraining_user_code(String training_user_code) {
		this.training_user_code = training_user_code;
	}
	public MultipartFile getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}
	public String getSdate_use() {
		return sdate_use;
	}
	public void setSdate_use(String sdate_use) {
		this.sdate_use = sdate_use;
	}
	
	
	
	
}
