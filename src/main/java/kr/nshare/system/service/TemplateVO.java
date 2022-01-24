package kr.nshare.system.service;

import java.util.List;

import kr.nshare.training.service.TrainingVO;

public class TemplateVO extends TrainingVO {
	
	private List<TemplateVO> wlistvo;
	
	private String template_name = "";
	private String cate_code = "";
	private String cate_name = "";
	private String template_code = "";
	private String lev = "";
	private String institution_cnt = "";
	private String not_institution_cnt = "";
	private String cnt = "";
	private String word_cnt = "";
	private String tc_code = "";
	private String word = "";
	private String val = "";
	private String ord = "";
	private String useyn = "";
	private String type = "";
	private String code = "";
	private String tcw_code = "";
	private String cate_type = "";

	private String lev_use = "";
	

	public String getTemplate_name() {
		return template_name;
	}

	public void setTemplate_name(String template_name) {
		this.template_name = template_name;
	}

	public String getCate_name() {
		return cate_name;
	}

	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}

	public String getCate_code() {
		return cate_code;
	}

	public void setCate_code(String cate_code) {
		this.cate_code = cate_code;
	}

	public String getTemplate_code() {
		return template_code;
	}

	public void setTemplate_code(String template_code) {
		this.template_code = template_code;
	}

	public String getLev() {
		return lev;
	}

	public void setLev(String lev) {
		this.lev = lev;
	}

	public String getInstitution_cnt() {
		return institution_cnt;
	}

	public void setInstitution_cnt(String institution_cnt) {
		this.institution_cnt = institution_cnt;
	}

	public String getNot_institution_cnt() {
		return not_institution_cnt;
	}

	public void setNot_institution_cnt(String not_institution_cnt) {
		this.not_institution_cnt = not_institution_cnt;
	}

	public String getCnt() {
		return cnt;
	}

	public void setCnt(String cnt) {
		this.cnt = cnt;
	}

	public String getWord_cnt() {
		return word_cnt;
	}

	public void setWord_cnt(String word_cnt) {
		this.word_cnt = word_cnt;
	}

	public String getTc_code() {
		return tc_code;
	}

	public void setTc_code(String tc_code) {
		this.tc_code = tc_code;

	}

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}

	public String getVal() {
		return val;
	}

	public void setVal(String val) {
		this.val = val;
	}

	public String getOrd() {
		return ord;
	}

	public void setOrd(String ord) {
		this.ord = ord;
	}

	public String getUseyn() {
		return useyn;
	}

	public void setUseyn(String useyn) {
		this.useyn = useyn;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;

	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getTcw_code() {
		return tcw_code;
	}

	public void setTcw_code(String tcw_code) {
		this.tcw_code = tcw_code;
	}

	public String getCate_type() {
		return cate_type;
	}

	public void setCate_type(String cate_type) {
		this.cate_type = cate_type;
	}

	public String getLev_use() {
		return lev_use;
	}

	public void setLev_use(String lev_use) {
		this.lev_use = lev_use;
	}

	public List<TemplateVO> getWlistvo() {
		return wlistvo;
	}

	public void setWlistvo(List<TemplateVO> wlistvo) {
		this.wlistvo = wlistvo;
	}

}