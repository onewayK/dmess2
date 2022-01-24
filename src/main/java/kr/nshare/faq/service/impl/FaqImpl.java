package kr.nshare.faq.service.impl;

import java.util.List;

import kr.nshare.faq.service.FaqVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("faqImpl")
public class FaqImpl implements FaqService{
	private static final Logger log = LoggerFactory.getLogger(FaqImpl.class);
	@Autowired
	private FaqDAO faqDAOService;
	@Override
	public void insertFaq(FaqVO vo) throws Exception {
		faqDAOService.insertFaq(vo);
	}
	@Override
	public void updateFaq(FaqVO vo) throws Exception {
		faqDAOService.updateFaq(vo);
	}
	@Override
	public FaqVO selectFaqByCode(String code) throws Exception {
		return faqDAOService.selectFaqByCode(code);
	}
	@Override
	public List<FaqVO> selectFaqList(FaqVO vo) throws Exception {
		
		System.out.println("==============>"+vo.getUseyn());
		
		return faqDAOService.selectFaqList(vo);
	}
	@Override
	public int selectFaqListCnt(FaqVO vo) throws Exception {
		return faqDAOService.selectFaqListCnt(vo);
	}
	
	@Override
	public int deleteFaqByCode(String code)	throws Exception {
		return faqDAOService.deleteFaqByCode(code);
	}
	
	@Override
	public int deleteFaqByInstitutionCode(String code)	throws Exception {
		return faqDAOService.deleteFaqByInstitutionCode(code);
	}
}
