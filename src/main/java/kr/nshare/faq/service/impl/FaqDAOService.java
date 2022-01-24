package kr.nshare.faq.service.impl;

import java.util.List;

import kr.nshare.common.AbstractDAO;
import kr.nshare.faq.service.FaqVO;
import kr.nshare.faq.service.mapper.FaqMapper;

import org.springframework.stereotype.Service;

@Service("faqDAOService")
public class FaqDAOService extends AbstractDAO implements FaqDAO 
{

	@Override
	public void insertFaq(FaqVO vo) throws Exception {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		mapper.insertFaq(vo);
		
	}

	@Override
	public void updateFaq(FaqVO vo) throws Exception {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		mapper.updateFaq(vo);
		
	}

	@Override
	public FaqVO selectFaqByCode(String code) throws Exception {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return  mapper.selectFaqByCode(code);
	}

	@Override
	public List<FaqVO> selectFaqList(FaqVO vo) throws Exception {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.selectFaqList(vo);
	}

	@Override
	public int selectFaqListCnt(FaqVO vo) throws Exception {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.selectFaqListCnt(vo);
	}

	@Override
	public int deleteFaqByCode(String code) throws Exception {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.deleteFaqByCode(code);
	}
	
	@Override
	public int deleteFaqByInstitutionCode(String code) throws Exception {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.deleteFaqByInstitutionCode(code);
	}
}
