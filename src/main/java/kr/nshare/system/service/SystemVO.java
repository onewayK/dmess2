package kr.nshare.system.service;

import kr.nshare.common.ComDefaultVO;
public class SystemVO extends ComDefaultVO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 사용자 관리
	 */
	private String code="";
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
	private String init = "";
	private String paycnt = "";
	private String isChgPaswd =  "";
	private String chgPasswd = "";
	private String training_name = "";
	private String send_content = "";
	 
	/**
	 * 훈련 서비스 설정 관리 
	 */	
	private String uc = "";
	private String start_date = "";
	private String end_date = "";
	private String test_send_number = "";
	private String real_send_number = "";
	private String auto_del_type = "";
	private String auto_test_del_date = "";
	private String auto_real_del_date = "";
	private String passive_del_type = "";
	private String passive_test_del_date = "";
	private String passive_real_del_date = "";
	private String service_use = "";
	private String service_setting_code="";
	private String create_user = "";
	private String service_code = "";	
	private String service_status_cnt = "";
	private String update_list = "";
	
	private String test_sended_number = "";
	private String real_sended_number = "";
	private String sended_user_cnt="";
	
	//훈련 서비스 설정 관련 
	private String service_type = "";
		
	/**
	 * 사용자 기관 관리
	 */
	private String institution_name = "";
	private String institution_owner_name = "";
	private String institution_owner_email = "";
	private String institution_owner_phone = "";
	private String institution_owner_location = "";
	private String create_userid = "";
	private String member_code = "";
	private String create_id = "";
	
	/**
	 * PAYMENT관련
	 */
	private String type = "";
	private String now_count = "";
	private String comment = "";
	private String training_code = "";
	
	
	/**
	 * 
	 * @return
	 */
	
	/**
	 *  발송로그 
	 * @return
	 */
	private String send_email = "";
	private String send_name = "";
	private String tname = "";
	private String title = "";
	private String email = "";
	private String department_name = "";
	private String unikey = "";
	private String status = "";
	private String log = "";
	
	private String action = "";
	private String im_code = "";
	private String refer = "";
	private String ip = "";
	
	private String send_date = "";
	
	public String getMember_code() {
		return member_code;
	}
	public void setMember_code(String member_code) {
		this.member_code = member_code;
	}
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
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
	public String getPageType() {
		return pageType;
	}
	public void setPageType(String pageType) {
		this.pageType = pageType;
	}
	public String getInstitution_name() {
		return institution_name;
	}
	public void setInstitution_name(String institution_name) {
		this.institution_name = institution_name;
	}
	public String getInstitution_owner_name() {
		return institution_owner_name;
	}
	public void setInstitution_owner_name(String institution_owner_name) {
		this.institution_owner_name = institution_owner_name;
	}
	public String getInstitution_owner_email() {
		return institution_owner_email;
	}
	public void setInstitution_owner_email(String institution_owner_email) {
		this.institution_owner_email = institution_owner_email;
	}
	public String getInstitution_owner_phone() {
		return institution_owner_phone;
	}
	public void setInstitution_owner_phone(String institution_owner_phone) {
		this.institution_owner_phone = institution_owner_phone;
	}
	public String getInstitution_owner_location() {
		return institution_owner_location;
	}
	public void setInstitution_owner_location(String institution_owner_location) {
		this.institution_owner_location = institution_owner_location;
	}
	public String getCreate_userid() {
		return create_userid;
	}
	public void setCreate_userid(String create_userid) {
		this.create_userid = create_userid;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getIsChgPaswd() {
		return isChgPaswd;
	}
	public void setIsChgPaswd(String isChgPaswd) {
		this.isChgPaswd = isChgPaswd;
	}
	public String getPaycnt() {
		return paycnt;
	}
	public void setPaycnt(String paycnt) {
		this.paycnt = paycnt;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getNow_count() {
		return now_count;
	}
	public void setNow_count(String now_count) {
		this.now_count = now_count;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getTraining_code() {
		return training_code;
	}
	public void setTraining_code(String training_code) {
		this.training_code = training_code;
	}
	public String getSend_email() {
		return send_email;
	}
	public void setSend_email(String send_email) {
		this.send_email = send_email;
	}
	public String getSend_name() {
		return send_name;
	}
	public void setSend_name(String send_name) {
		this.send_name = send_name;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDepartment_name() {
		return department_name;
	}
	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}
	public String getUnikey() {
		return unikey;
	}
	public void setUnikey(String unikey) {
		this.unikey = unikey;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getInit() {
		return init;
	}
	public void setInit(String init) {
		this.init = init;
	}
	public String getChgPasswd() {
		return chgPasswd;
	}
	public void setChgPasswd(String chgPasswd) {
		this.chgPasswd = chgPasswd;
	}
	public String getLog() {
		return log;
	}
	public void setLog(String log) {
		this.log = log;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getIm_code() {
		return im_code;
	}
	public void setIm_code(String im_code) {
		this.im_code = im_code;
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
	public String getTraining_name() {
		return training_name;
	}
	public void setTraining_name(String training_name) {
		this.training_name = training_name;
	}
	public String getSend_content() {
		return send_content;
	}
	public void setSend_content(String send_content) {
		this.send_content = send_content;
	}
	public String getSend_date() {
		return send_date;
	}
	public void setSend_date(String send_date) {
		this.send_date = send_date;
	}
	public String getCreate_id() {
		return create_id;
	}
	public void setCreate_id(String create_id) {
		this.create_id = create_id;
	}
	public String getUc() {
		return uc;
	}
	public void setUc(String uc) {
		this.uc = uc;
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
	public String getReal_send_number() {
		return real_send_number;
	}
	public void setReal_send_number(String real_send_number) {
		this.real_send_number = real_send_number;
	}
	public String getTest_send_number() {
		return test_send_number;
	}
	public void setTest_send_number(String test_send_number) {
		this.test_send_number = test_send_number;
	}
	public String getAuto_del_type() {
		return auto_del_type;
	}
	public void setAuto_del_type(String auto_del_type) {
		this.auto_del_type = auto_del_type;
	}
	
	public String getPassive_del_type() {
		return passive_del_type;
	}
	public void setPassive_del_type(String passive_del_type) {
		this.passive_del_type = passive_del_type;
	}
	public String getService_use() {
		return service_use;
	}
	public void setService_use(String service_use) {
		this.service_use = service_use;
	}
	public String getCreate_user() {
		return create_user;
	}
	public void setCreate_user(String create_user) {
		this.create_user = create_user;
	}
	public String getService_code() {
		return service_code;
	}
	public void setService_code(String service_code) {
		this.service_code = service_code;
	}
	public String getAuto_test_del_date() {
		return auto_test_del_date;
	}
	public void setAuto_test_del_date(String auto_test_del_date) {
		this.auto_test_del_date = auto_test_del_date;
	}
	public String getAuto_real_del_date() {
		return auto_real_del_date;
	}
	public void setAuto_real_del_date(String auto_real_del_date) {
		this.auto_real_del_date = auto_real_del_date;
	}
	public String getService_status_cnt() {
		return service_status_cnt;
	}
	public void setService_status_cnt(String service_status_cnt) {
		this.service_status_cnt = service_status_cnt;
	}
	public String getUpdate_list() {
		return update_list;
	}
	public void setUpdate_list(String update_list) {
		this.update_list = update_list;
	}
	public String getPassive_test_del_date() {
		return passive_test_del_date;
	}
	public void setPassive_test_del_date(String passive_test_del_date) {
		this.passive_test_del_date = passive_test_del_date;
	}
	public String getPassive_real_del_date() {
		return passive_real_del_date;
	}
	public void setPassive_real_del_date(String passive_real_del_date) {
		this.passive_real_del_date = passive_real_del_date;
	}
	public String getService_setting_code() {
		return service_setting_code;
	}
	public void setService_setting_code(String service_setting_code) {
		this.service_setting_code = service_setting_code;
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
	public String getSended_user_cnt() {
		return sended_user_cnt;
	}
	public void setSended_user_cnt(String sended_user_cnt) {
		this.sended_user_cnt = sended_user_cnt;
	}
	public String getService_type() {
		return service_type;
	}
	public void setService_type(String service_type) {
		this.service_type = service_type;
	}
	
}
