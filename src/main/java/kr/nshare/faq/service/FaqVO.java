package kr.nshare.faq.service;

import kr.nshare.common.ComDefaultVO;

public class FaqVO extends ComDefaultVO {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String code = "";
	private String faq_q = "";
	private String faq_a = "";
	private String sdate = "";
	private String type = "";
	private String institution_code = "";
	private String institution_name = "";
	private String pageType = "";
	private String useyn = "";
	private String userid = "";
	private String lev = "";
	private String yn = "";

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getFaq_q() {
		return faq_q;
	}

	public void setFaq_q(String faq_q) {
		this.faq_q = faq_q;
	}

	public String getFaq_a() {
		return faq_a;
	}

	public void setFaq_a(String faq_a) {
		this.faq_a = faq_a;
	}

	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getInstitution_code() {
		return institution_code;
	}

	public void setInstitution_code(String institution_code) {
		this.institution_code = institution_code;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getPageType() {
		return pageType;
	}

	public void setPageType(String pageType) {
		this.pageType = pageType;
	}

	public String getUseyn() {
		return useyn;
	}

	public void setUseyn(String useyn) {
		this.useyn = useyn;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getInstitution_name() {
		return institution_name;
	}

	public void setInstitution_name(String institution_name) {
		this.institution_name = institution_name;
	}

	public String getLev() {
		return lev;
	}

	public void setLev(String lev) {
		this.lev = lev;
	}

	public String getYn() {
		return yn;
	}

	public void setYn(String yn) {
		this.yn = yn;
	}

}
