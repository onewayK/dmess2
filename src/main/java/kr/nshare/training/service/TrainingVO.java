package kr.nshare.training.service;

import java.util.List;

import kr.nshare.common.ComDefaultVO;

import org.springframework.web.multipart.MultipartFile;

public class TrainingVO extends ComDefaultVO {

	private static final long serialVersionUID = 1L;
	/**
	 * 훈련관리
	 */	
	private List<TrainingVO> listvo;
	
	private String json_userlist = "";
	
	private String id = "";
	
	private String type = "";
	private String pageType = "";
	private String name = "";
	private String department_name = "";
	private String email = "";
	private String unikey = "";
	private String training_code = "";
	private String code = "";
	private String uc = "";
	private String tname = "";
	private String title = "";
	private String send_name = "";
	private String send_email = "";
	private String send_content = "";
	private String training_type1 = "";
	private String training_type2 = "";
	private String training_type2_content = "";
	private String Training_type2_linkname="";
	private String training_type3 = "";
	private String training_type3_file_type = "";
	private String training_type3_file_name = "";
	private String training_type3_file_redirect = "";
	private String training_type3_content = "";
	private String start_date = "";
	private String end_date = "";
	private String sdate = "";
	private String udate = "";
	private String request_url = "";
	private String institution_code = "";
	private String status = "";
	private String institution_name = "";
	private String userid = "";
	private String progress = "";
	private String lev = "";
	private String del_type = "";
	private String register_type = "";
	private String register_url = "";
	private String register_url_param = "";
	private String del_flag = "";
	private String user_cnt = "";
	private String validation = "";
	private String type2_json = "";
	// 그룹
	private String group_name = "";
	private String group_code = "";
	private String allocation_yn = "";
	private String group_user_cnt = "";
	private String cate = "";
	private String create_user = "";

	private String training_cnt = "";
	private String training_list = "";
	private String ig_code = "";
	private String group_cnt = "";
	private String row_number = "";
	private String dummy = "";
	private String total = "";
	
	private String create_id = "";
	// 파일 업로드
	private MultipartFile uploadfile;

	private String gp_send_name = "";
	private String gp_send_email = "";
	private String gp_title = "";
	
	private String tc_code="";
	private String tg_code="";
	private String cate_code="";
	private String cate_name="";
	private String template_name="";
	private String training_user_code = "";
	
	private String maxcode = "";
	
	private String template_code = "";
	
	private String random_insert_use = "";
	
	//exe 첨부파일관련
	private String training_type3_file_exe_type="";
	private String training_type3_exe_content = "";
	
	//스팸 우회 관련
	private String spam_type = "";
	private String spam_time = "";
	private String spam_number = "";
	
	//발송설정 관련
	private String all_send_type = "";
	private String send_number = "";
	private String send_percent = "";
	
	//관리자 승인 관련
	private String approval_type = "";
	private String approval_id = "";
	
	private String content = "";
	
	//예약관련
	private String reservation_date = "";
	private String reservation_type = "";
		
	//신고시간 준수 관련
	private String register_time_type = "";
	private String register_time = "";
	//신고리스트 중복제거
	private String reduplication = "";
		
	//sort 관련 
	private String sortcolumn = "";
	private String orderBy = "";
	
	
	//훈련 서비스 설정 관련 
	private String service_type = "";
	private String del_date = "";
	//훈련 서비스 설정 코드 
	private String service_setting_code = "";
	
	//훈련 삭제 팝업 관련
	private String create_name = "";
	private String create_phone = "";
	
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getUc() {
		return uc;
	}

	public void setUc(String uc) {
		this.uc = uc;
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

	public String getSend_content() {
		return send_content;
	}

	public void setSend_content(String send_content) {
		this.send_content = send_content;
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

	public String getRequest_url() {
		return request_url;
	}

	public void setRequest_url(String request_url) {
		this.request_url = request_url;
	}

	public String getInstitution_code() {
		return institution_code;
	}

	public void setInstitution_code(String institution_code) {
		this.institution_code = institution_code;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public MultipartFile getUploadfile() {
		return uploadfile;
	}

	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
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

	public List<TrainingVO> getListvo() {
		return listvo;
	}

	public void setListvo(List<TrainingVO> listvo) {
		this.listvo = listvo;
	}

	public String getTraining_code() {
		return training_code;
	}

	public void setTraining_code(String training_code) {
		this.training_code = training_code;
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

	public String getTraining_type2_content() {
		return training_type2_content;
	}

	public void setTraining_type2_content(String training_type2_content) {
		this.training_type2_content = training_type2_content;
	}

	public String getTraining_type3() {
		return training_type3;
	}

	public void setTraining_type3(String training_type3) {
		this.training_type3 = training_type3;
	}

	public String getTraining_type3_file_type() {
		return training_type3_file_type;
	}

	public void setTraining_type3_file_type(String training_type3_file_type) {
		this.training_type3_file_type = training_type3_file_type;
	}

	public String getTraining_type3_content() {
		return training_type3_content;
	}

	public void setTraining_type3_content(String training_type3_content) {
		this.training_type3_content = training_type3_content;
	}

	public String getTraining_type3_file_name() {
		return training_type3_file_name;
	}

	public void setTraining_type3_file_name(String training_type3_file_name) {
		this.training_type3_file_name = training_type3_file_name;
	}

	public String getPageType() {
		return pageType;
	}

	public void setPageType(String pageType) {
		this.pageType = pageType;
	}

	public String getTraining_type3_file_redirect() {
		return training_type3_file_redirect;
	}

	public void setTraining_type3_file_redirect(
			String training_type3_file_redirect) {
		this.training_type3_file_redirect = training_type3_file_redirect;
	}

	public String getProgress() {
		return progress;
	}

	public void setProgress(String progress) {
		this.progress = progress;
	}

	public String getLev() {
		return lev;
	}

	public void setLev(String lev) {
		this.lev = lev;
	}

	public String getDel_type() {
		return del_type;
	}

	public void setDel_type(String del_type) {
		this.del_type = del_type;
	}

	public String getRegister_type() {
		return register_type;
	}

	public void setRegister_type(String register_type) {
		this.register_type = register_type;
	}

	public String getDel_flag() {
		return del_flag;
	}

	public void setDel_flag(String del_flag) {
		this.del_flag = del_flag;
	}

	public String getUser_cnt() {
		return user_cnt;
	}

	public void setUser_cnt(String user_cnt) {
		this.user_cnt = user_cnt;
	}

	public String getValidation() {
		return validation;
	}

	public void setValidation(String validation) {
		this.validation = validation;
	}

	public String getRegister_url() {
		return register_url;
	}

	public void setRegister_url(String register_url) {
		this.register_url = register_url;
	}

	public String getRegister_url_param() {
		return register_url_param;
	}

	public void setRegister_url_param(String register_url_param) {
		this.register_url_param = register_url_param;
	}

	public String getGroup_name() {
		return group_name;
	}

	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}

	public String getGroup_code() {
		return group_code;
	}

	public void setGroup_code(String group_code) {
		this.group_code = group_code;
	}

	public String getAllocation_yn() {
		return allocation_yn;
	}

	public void setAllocation_yn(String allocation_yn) {
		this.allocation_yn = allocation_yn;
	}

	public String getGroup_user_cnt() {
		return group_user_cnt;
	}

	public void setGroup_user_cnt(String group_user_cnt) {
		this.group_user_cnt = group_user_cnt;
	}

	public String getCate() {
		return cate;
	}

	public void setCate(String cate) {
		this.cate = cate;
	}

	public String getCreate_user() {
		return create_user;
	}

	public void setCreate_user(String create_user) {
		this.create_user = create_user;
	}

	public String getTraining_cnt() {
		return training_cnt;
	}

	public void setTraining_cnt(String training_cnt) {
		this.training_cnt = training_cnt;
	}

	public String getTraining_list() {
		return training_list;
	}

	public void setTraining_list(String training_list) {
		this.training_list = training_list;
	}

	public String getIg_code() {
		return ig_code;
	}

	public void setIg_code(String ig_code) {
		this.ig_code = ig_code;
	}

	public String getGroup_cnt() {
		return group_cnt;
	}

	public void setGroup_cnt(String group_cnt) {
		this.group_cnt = group_cnt;
	}

	public String getRow_number() {
		return row_number;
	}

	public void setRow_number(String row_number) {
		this.row_number = row_number;
	}

	public String getDummy() {
		return dummy;
	}

	public void setDummy(String dummy) {
		this.dummy = dummy;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getCreate_id() {
		return create_id;
	}

	public void setCreate_id(String create_id) {
		this.create_id = create_id;
	}

	public String getType2_json() {
		return type2_json;
	}

	public void setType2_json(String type2_json) {
		this.type2_json = type2_json;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getGp_send_name() {
		return gp_send_name;
	}

	public void setGp_send_name(String gp_send_name) {
		this.gp_send_name = gp_send_name;
	}

	public String getGp_send_email() {
		return gp_send_email;
	}

	public void setGp_send_email(String gp_send_email) {
		this.gp_send_email = gp_send_email;
	}

	public String getTg_code() {
		return tg_code;
	}

	public void setTg_code(String tg_code) {
		this.tg_code = tg_code;
	}

	public String getTc_code() {
		return tc_code;
	}

	public void setTc_code(String tc_code) {
		this.tc_code = tc_code;
	}

	public String getCate_code() {
		return cate_code;
	}

	public void setCate_code(String cate_code) {
		this.cate_code = cate_code;
	}

	public String getTraining_type2_linkname() {
		return Training_type2_linkname;
	}

	public void setTraining_type2_linkname(String training_type2_linkname) {
		Training_type2_linkname = training_type2_linkname;
	}

	public String getCate_name() {
		return cate_name;
	}

	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}

	public String getTemplate_name() {
		return template_name;
	}

	public void setTemplate_name(String template_name) {
		this.template_name = template_name;
	}

	public String getGp_title() {
		return gp_title;
	}

	public void setGp_title(String gp_title) {
		this.gp_title = gp_title;
	}

	public String getTraining_user_code() {
		return training_user_code;
	}

	public void setTraining_user_code(String training_user_code) {
		this.training_user_code = training_user_code;
	}

	public String getMaxcode() {
		return maxcode;
	}

	public void setMaxcode(String maxcode) {
		this.maxcode = maxcode;
	}

	public String getTraining_type3_file_exe_type() {
		return training_type3_file_exe_type;
	}

	public void setTraining_type3_file_exe_type(
			String training_type3_file_exe_type) {
		this.training_type3_file_exe_type = training_type3_file_exe_type;
	}

	public String getTraining_type3_exe_content() {
		return training_type3_exe_content;
	}

	public void setTraining_type3_exe_content(String training_type3_exe_content) {
		this.training_type3_exe_content = training_type3_exe_content;
	}

	public String getTemplate_code() {
		return template_code;
	}

	public void setTemplate_code(String template_code) {
		this.template_code = template_code;
	}

	public String getRandom_insert_use() {
		return random_insert_use;
	}

	public void setRandom_insert_use(String random_insert_use) {
		this.random_insert_use = random_insert_use;
	}

	public String getSpam_type() {
		return spam_type;
	}

	public void setSpam_type(String spam_type) {
		this.spam_type = spam_type;
	}

	public String getSpam_time() {
		return spam_time;
	}

	public void setSpam_time(String spam_time) {
		this.spam_time = spam_time;
	}

	public String getSpam_number() {
		return spam_number;
	}

	public void setSpam_number(String spam_number) {
		this.spam_number = spam_number;
	}

	public String getAll_send_type() {
		return all_send_type;
	}

	public void setAll_send_type(String all_send_type) {
		this.all_send_type = all_send_type;
	}

	public String getSend_number() {
		return send_number;
	}

	public void setSend_number(String send_number) {
		this.send_number = send_number;
	}

	public String getApproval_type() {
		return approval_type;
	}

	public void setApproval_type(String approval_type) {
		this.approval_type = approval_type;
	}

	public String getApproval_id() {
		return approval_id;
	}

	public void setApproval_id(String approval_id) {
		this.approval_id = approval_id;
	}

	public String getSend_percent() {
		return send_percent;
	}

	public void setSend_percent(String send_percent) {
		this.send_percent = send_percent;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReservation_date() {
		return reservation_date;
	}

	public void setReservation_date(String reservation_date) {
		this.reservation_date = reservation_date;
	}

	public String getReservation_type() {
		return reservation_type;
	}

	public void setReservation_type(String reservation_type) {
		this.reservation_type = reservation_type;
	}

	public String getRegister_time_type() {
		return register_time_type;
	}

	public void setRegister_time_type(String register_time_type) {
		this.register_time_type = register_time_type;
	}

	public String getRegister_time() {
		return register_time;
	}

	public void setRegister_time(String register_time) {
		this.register_time = register_time;
	}

	public String getReduplication() {
		return reduplication;
	}

	public void setReduplication(String reduplication) {
		this.reduplication = reduplication;
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

	public String getService_type() {
		return service_type;
	}

	public void setService_type(String service_type) {
		this.service_type = service_type;
	}

	public String getService_setting_code() {
		return service_setting_code;
	}

	public void setService_setting_code(String service_setting_code) {
		this.service_setting_code = service_setting_code;
	}

	public String getDel_date() {
		return del_date;
	}

	public void setDel_date(String del_date) {
		this.del_date = del_date;
	}

	public String getCreate_name() {
		return create_name;
	}

	public void setCreate_name(String create_name) {
		this.create_name = create_name;
	}

	public String getCreate_phone() {
		return create_phone;
	}

	public void setCreate_phone(String create_phone) {
		this.create_phone = create_phone;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getJson_userlist() {
		return json_userlist;
	}

	public void setJson_userlist(String json_userlist) {
		this.json_userlist = json_userlist;
	}

}
