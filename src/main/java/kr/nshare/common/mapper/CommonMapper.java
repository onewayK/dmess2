/**
 * @author +impro
 *
 */
package kr.nshare.common.mapper;

import java.util.List;

import kr.nshare.common.CommonVO;
import kr.nshare.common.MenuVO;

public interface CommonMapper{
	public List<MenuVO> selectMenuByLev(String lev)  throws Exception;
	public List<String> selectMenuForUrl(String url)  throws Exception;
	
	
	/**
	 * 대중소 값을 입력하여 그에 해당 하는 리스트 추출 : 예를 들어 대분류에 SYSTEM 인것만 참고 싶다면 Sys
	 * @param l_grp
	 * @param m_grp
	 * @param s_grp
	 * @return
	 * @throws Exception
	 */
	public List<CommonVO> selectCommonList(CommonVO vo)throws Exception;
	
	/**
	 * 파일 업로드 
	 * @param vo
	 * @throws Exception
	 */
	public void insertImage(CommonVO vo) throws Exception;
	
	/**
	 * 이미지 호출
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public CommonVO selectImage(String code) throws Exception;
	
	
}