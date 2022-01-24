package kr.nshare.common.impl;

import java.util.ArrayList;
import java.util.List;

import kr.nshare.common.CommonVO;
import kr.nshare.common.MenuVO;
import kr.nshare.main.mapper.TestTbl;
import kr.nshare.system.service.SystemVO;
import kr.nshare.training.service.TrainingVO;

public interface CommonDAO {
	public List<MenuVO> selectMenuByLev(String lev)  throws Exception;
	public List<String> selectMenuForUrl(String url)  throws Exception;
	public List<CommonVO> selectCommonList(CommonVO vo)throws Exception;
	
	public String insertImage(CommonVO vo) throws Exception;

	public CommonVO selectImage(String code) throws Exception;
}
