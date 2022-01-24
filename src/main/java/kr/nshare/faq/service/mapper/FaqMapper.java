/**
 * @author +impro
 *
 */
package kr.nshare.faq.service.mapper;

import java.util.List;

import kr.nshare.faq.service.FaqVO;

public interface FaqMapper{
	public void insertFaq(FaqVO vo) throws Exception;
	public void updateFaq(FaqVO vo) throws Exception;
	public FaqVO selectFaqByCode(String code) throws Exception;
	public List<FaqVO> selectFaqList(FaqVO vo) throws Exception;
	public int selectFaqListCnt(FaqVO vo) throws Exception;
	
	//faq 삭제
	public int deleteFaqByCode(String code) throws Exception;
	public int deleteFaqByInstitutionCode(String code) throws Exception;
	
	
}