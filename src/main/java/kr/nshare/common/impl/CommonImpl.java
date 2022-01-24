package kr.nshare.common.impl;

import java.util.ArrayList;
import java.util.List;

import kr.nshare.common.CommonVO;
import kr.nshare.common.MenuVO;
import kr.nshare.common.util.EgovFileScrty;
import kr.nshare.main.mapper.TestTblDAO;
import kr.nshare.system.service.SystemVO;
import kr.nshare.training.service.TrainingVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("commonImpl")
public class CommonImpl implements CommonService{
	@Autowired
	private CommonDAO commonDAOService;

	@Override
	public List<MenuVO> selectMenuByLev(String lev) throws Exception {
		
		return commonDAOService.selectMenuByLev(lev);
		
	}

	@Override
	public List<String> selectMenuForUrl(String url) throws Exception {
		
		return commonDAOService.selectMenuForUrl(url);
		
	}
	/**
	 * 공통 코드 리스트 추출
	 */
	@Override
	public List<CommonVO> selectCommonList(CommonVO vo) throws Exception {
		return commonDAOService.selectCommonList(vo);
	}

	@Override
	public String insertImage(CommonVO vo) throws Exception {
		return commonDAOService.insertImage(vo);
		
	}

	@Override
	public CommonVO selectImage(String code) throws Exception {
		return commonDAOService.selectImage(code);
	}

	
	
	

}
