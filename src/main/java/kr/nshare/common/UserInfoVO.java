package kr.nshare.common;

public class UserInfoVO extends ComDefaultVO {
	private static final long serialVersionUID = 1L;

	private String sessionId = "";
	private String code = "";
	private String userid = "";
	private String name = "";
	private String fax = "";
	private String phone = "";
	private String comp_name = "";
	private String zcode = "";
	private String comp_addr1 = "";
	private String comp_addr2 = "";
	private String lev = "";
	private String paycnt = "";

	//훈련 서비스 설정 관련 
	private String service_setting_code = "";
	private String title = "";
	private String start_date = "";
	private String end_date = "";
	private String test_send_number = "";
	private String real_send_number = "";
	private String test_sended_number = "";
	private String real_sended_number = "";
	private String service_use = "";		
	
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
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

	public String getPaycnt() {
		return paycnt;
	}

	public void setPaycnt(String paycnt) {
		this.paycnt = paycnt;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public String getService_setting_code() {
		return service_setting_code;
	}

	public void setService_setting_code(String service_setting_code) {
		this.service_setting_code = service_setting_code;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getService_use() {
		return service_use;
	}

	public void setService_use(String service_use) {
		this.service_use = service_use;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getTest_send_number() {
		return test_send_number;
	}

	public void setTest_send_number(String test_send_number) {
		this.test_send_number = test_send_number;
	}

	public String getReal_send_number() {
		return real_send_number;
	}

	public void setReal_send_number(String real_send_number) {
		this.real_send_number = real_send_number;
	}

	public String getTest_sended_number() {
		return test_sended_number;
	}

	public void setTest_sended_number(String test_sended_number) {
		this.test_sended_number = test_sended_number;
	}

	public String getReal_sended_number() {
		return real_sended_number;
	}

	public void setReal_sended_number(String real_sended_number) {
		this.real_sended_number = real_sended_number;
	}

}
