package kr.nshare.common.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.nshare.common.AbstractDAO;
import kr.nshare.common.CommonVO;
import kr.nshare.common.MenuVO;
import kr.nshare.common.mapper.CommonMapper;
import kr.nshare.common.util.EgovFileScrty;
import kr.nshare.main.mapper.TestTbl;
import kr.nshare.member.service.mapper.MemberMapper;
import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.mapper.SystemMapper;
import kr.nshare.training.service.TrainingVO;
import kr.nshare.training.service.mapper.TrainingMapper;

import org.apache.ibatis.annotations.Insert;
import org.springframework.stereotype.Service;

@Service("commonDAOService")
public class CommonDAOService extends AbstractDAO implements CommonDAO 
{
	

	@Override
	public List<MenuVO> selectMenuByLev(String lev) throws Exception {
		CommonMapper mapper = sqlSession.getMapper(CommonMapper.class);
		return mapper.selectMenuByLev(lev);
	}
	
	@Override
	public List<String> selectMenuForUrl(String url) throws Exception {
		CommonMapper mapper = sqlSession.getMapper(CommonMapper.class);
		return mapper.selectMenuForUrl(url);
	}
	
	@Override
	public List<CommonVO> selectCommonList(CommonVO vo) throws Exception {
		CommonMapper mapper = sqlSession.getMapper(CommonMapper.class);
		return mapper.selectCommonList(vo);
	}

	/**
	 * 파일 업로드 
	 */
	@Override
	public String insertImage(CommonVO vo) throws Exception {
		CommonMapper mapper = sqlSession.getMapper(CommonMapper.class);
		mapper.insertImage(vo);
		return vo.getCode();
		
	}

	@Override
	public CommonVO selectImage(String code) throws Exception {
		CommonMapper mapper = sqlSession.getMapper(CommonMapper.class);
		return mapper.selectImage(code);
	}
	
	
}
