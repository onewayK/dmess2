package kr.nshare.member.service;

import kr.nshare.common.ComDefaultVO;


public class MemberVO extends ComDefaultVO{
	private static final long serialVersionUID = 1L;
	private int code;
	private String j_username = "";
	private String j_password = "";
	private String pageType = "";
	private String userid  = "";
	private String userpw  = "";
	private String name  = "";
	private String fax  = "";
	private String phone  = "";
	private String comp_name  = "";
	private String zcode  = "";
	private String comp_addr1  = "";
	private String comp_addr2  = "";
	private String lev  = "";
	private String institution_code  = "";
	private String sdate  = "";
	private String udate  = "";
	private String useyn  = "";
	private String cuser  = "";
	private String isChgPaswd =  "";
	private String type = "";
	private String chgPasswd = "";
	private String training_code =""; 
			
	private String template_code =""; 		
	
	//로깅
	private String im_code = "";
	private String action =  "";
	private String refer = "";
	private String ip = "";
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getPageType() {
		return pageType;
	}
	public void setPageType(String pageType) {
		this.pageType = pageType;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpw() {
		return userpw;
	}
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getComp_name() {
		return comp_name;
	}
	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}
	public String getZcode() {
		return zcode;
	}
	public void setZcode(String zcode) {
		this.zcode = zcode;
	}
	public String getComp_addr1() {
		return comp_addr1;
	}
	public void setComp_addr1(String comp_addr1) {
		this.comp_addr1 = comp_addr1;
	}
	public String getComp_addr2() {
		return comp_addr2;
	}
	public void setComp_addr2(String comp_addr2) {
		this.comp_addr2 = comp_addr2;
	}
	public String getLev() {
		return lev;
	}
	public void setLev(String lev) {
		this.lev = lev;
	}
	public String getInstitution_code() {
		return institution_code;
	}
	public void setInstitution_code(String institution_code) {
		this.institution_code = institution_code;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getUdate() {
		return udate;
	}
	public void setUdate(String udate) {
		this.udate = udate;
	}
	public String getUseyn() {
		return useyn;
	}
	public void setUseyn(String useyn) {
		this.useyn = useyn;
	}
	public String getCuser() {
		return cuser;
	}
	public void setCuser(String cuser) {
		this.cuser = cuser;
	}
	public String getIsChgPaswd() {
		return isChgPaswd;
	}
	public void setIsChgPaswd(String isChgPaswd) {
		this.isChgPaswd = isChgPaswd;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public String getJ_username() {
		return j_username;
	}
	public void setJ_username(String j_username) {
		this.j_username = j_username;
	}
	public String getJ_password() {
		return j_password;
	}
	public void setJ_password(String j_password) {
		this.j_password = j_password;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getChgPasswd() {
		return chgPasswd;
	}
	public void setChgPasswd(String chgPasswd) {
		this.chgPasswd = chgPasswd;
	}
	public String getIm_code() {
		return im_code;
	}
	public void setIm_code(String im_code) {
		this.im_code = im_code;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getRefer() {
		return refer;
	}
	public void setRefer(String refer) {
		this.refer = refer;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getTraining_code() {
		return training_code;
	}
	public void setTraining_code(String training_code) {
		this.training_code = training_code;
	}
	public String getTemplate_code() {
		return template_code;
	}
	public void setTemplate_code(String template_code) {
		this.template_code = template_code;
	}
	
}
