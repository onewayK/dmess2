package kr.nshare.common;

import org.springframework.web.multipart.MultipartFile;

public class CommonVO {
	private String code = "";
	private String l_grp = "";
	private String m_grp = "";
	private String s_grp = "";
	private String name = "";
	private String value = "";
	private String comment =  "";
	private String sdate =  "";
	
	private String ori_name = "";
	private String path = "";
	private String file_name = "";
	private String uc = "";
	private String  type="";
	
	//license  관련
	private String  license_key="";
	private String  license_key_type=""; //라이선스 키 오류
	private String  license_file_type=""; //라이선스 파일 오류
	
	private String  host_use="";
	private String  hostname="";
	private String  host_type=""; //host 오류 유무
	
	private String  mac_use="";
	private String  mac="";
	private String  mac_type=""; //mac 주소 유무
	
	private String  date_use="";
	private String  startDt="";
	private String  endDt="";
	private String  date_type=""; //사용 기간 오류  유무

	private String  installPw ="";
	private String  installType ="";
	private String  diffDay= "";
	
	// 파일 업로드
	private MultipartFile uploadfile;
	
	public String getL_grp() {
		return l_grp;
	}
	public void setL_grp(String l_grp) {
		this.l_grp = l_grp;
	}
	public String getM_grp() {
		return m_grp;
	}
	public void setM_grp(String m_grp) {
		this.m_grp = m_grp;
	}
	public String getS_grp() {
		return s_grp;
	}
	public void setS_grp(String s_grp) {
		this.s_grp = s_grp;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getOri_name() {
		return ori_name;
	}
	public void setOri_name(String ori_name) {
		this.ori_name = ori_name;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getUc() {
		return uc;
	}
	public void setUc(String uc) {
		this.uc = uc;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	public String getLicense_key() {
		return license_key;
	}
	public void setLicense_key(String license_key) {
		this.license_key = license_key;
	}
	public MultipartFile getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}
	public String getHost_use() {
		return host_use;
	}
	public void setHost_use(String host_use) {
		this.host_use = host_use;
	}
	public String getHostname() {
		return hostname;
	}
	public void setHostname(String hostname) {
		this.hostname = hostname;
	}
	public String getMac_use() {
		return mac_use;
	}
	public void setMac_use(String mac_use) {
		this.mac_use = mac_use;
	}
	public String getMac() {
		return mac;
	}
	public void setMac(String mac) {
		this.mac = mac;
	}
	public String getDate_use() {
		return date_use;
	}
	public void setDate_use(String date_use) {
		this.date_use = date_use;
	}

	public String getInstallPw() {
		return installPw;
	}
	public void setInstallPw(String installPw) {
		this.installPw = installPw;
	}
	public String getInstallType() {
		return installType;
	}
	public void setInstallType(String installType) {
		this.installType = installType;
	}
	public String getHost_type() {
		return host_type;
	}
	public void setHost_type(String host_type) {
		this.host_type = host_type;
	}
	public String getMac_type() {
		return mac_type;
	}
	public void setMac_type(String mac_type) {
		this.mac_type = mac_type;
	}
	
	public String getLicense_key_type() {
		return license_key_type;
	}
	public void setLicense_key_type(String license_key_type) {
		this.license_key_type = license_key_type;
	}
	
	public String getDate_type() {
		return date_type;
	}
	public void setDate_type(String date_type) {
		this.date_type = date_type;
	}
	public String getLicense_file_type() {
		return license_file_type;
	}
	public void setLicense_file_type(String license_file_type) {
		this.license_file_type = license_file_type;
	}
	public String getDiffDay() {
		return diffDay;
	}
	public void setDiffDay(String diffDay) {
		this.diffDay = diffDay;
	}
	
	
	
}
