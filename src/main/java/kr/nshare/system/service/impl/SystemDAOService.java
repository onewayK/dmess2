package kr.nshare.system.service.impl;

import java.util.List;

import kr.nshare.common.AbstractDAO;
import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.TemplateVO;
import kr.nshare.system.service.mapper.SystemMapper;

import org.springframework.stereotype.Service;

@Service("systemDAOService")
public class SystemDAOService extends AbstractDAO implements SystemDAO 
{
	
	
	/****************************************************
	 *  사용자 등록 / 수정 / 삭제
	 * 
	 *****************************************************/
	
	/**
	 * 사용자 등록
	 */
	public void insertMember(SystemVO vo)  throws Exception {
		
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.insertMember(vo);
	}

	/**
	 * 사용자 업데이트
	 */
	@Override
	public void updateMember(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updateMember(vo);
	}
	
	/**
	 * 사용자 삭제로 인한 템플릿 생성자 변경
	 */
	@Override
	public void updateTemplateUcByCode(SystemVO vo) throws Exception{
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updateTemplateUcByCode(vo);
	} 
	
	/**
	 * 사용자 삭제로 인한 파일 생성자 변경
	 */
	@Override
	public void updateFileUcByCode(SystemVO vo) throws Exception{
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updateFileUcByCode(vo);
	} 
	
	/**
	 * 사용자 삭제로 인한 훈련 생성자 변경
	 */
	@Override
	public void updateTrainingUcAndIdByCode(SystemVO vo) throws Exception{
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updateTrainingUcAndIdByCode(vo);
	} 
	
	/**
	 * 사용자 삭제로 인한 훈련 생성자 변경
	 */
	@Override
	public void updateTrainingGroupIdAndIdByCode(SystemVO vo) throws Exception{
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updateTrainingGroupIdAndIdByCode(vo);
	} 
	
	/**
	 * 사용자 검색 by userid
	 */
	@Override
	public SystemVO selectMemberById(String userid) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectMemberById(userid);
	}

	/**
	 * 훈련 서비스 설정이 포함된 사용자 검색 by userid 
	 */
	@Override
	public SystemVO selectMemberByIdWithServiceSetting(String userid) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectMemberByIdWithServiceSetting(userid);
	}
	
	/**
	 * 사용자 리스트 검색
	 */
	@Override
	public List<SystemVO> selectMemberList(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectMemberList(vo);
	}
	
	/**
	 * 사용자 리스트 검색(count)
	 */
	public int selectMemberListCnt(SystemVO vo) throws Exception{
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectMemberListCnt(vo);
	}

	/**
	 * 사용자 상세보기 by code
	 */
	@Override
	public SystemVO selectMemberByCode(String code) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectMemberByCode(code);
	}

	/**
	 * 사용자 삭제
	 */
	@Override
	public void deleteMemberByCode(String code) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.deleteMemberByCode(code);
	}
	
	/**
	 * 기관 등록
	 */
	@Override
	public void insertInstitution(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.insertInstitution(vo);
		
	}
	
	/**
	 * 기관 수정
	 */
	@Override
	public void updateInstitution(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updateInstitution(vo);
		
	}

	/**
	 * 기관 삭제
	 */
	@Override
	public void deleteInstitutionByCode(String code) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.deleteInstitutionByCode(code);
	}
	
	/**
	 * 기관 검색(상세내역 검색)
	 */
	@Override
	public SystemVO selectInstitutionByCode(String code) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectInstitutionByCode(code);
	}

	/**
	 * 기관 리스트 정보
	 */
	@Override
	public List<SystemVO> selectInstitutionList(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectInstitutionList(vo);
	}

	/**
	 * 기관 갯수
	 */
	@Override
	public int selectInstitutionListCnt(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectInstitutionListCnt(vo);
	}

	/**
	 * 맵핑정보 검색
	 */
	@Override
	public List<SystemVO> selectAuthMappingListByMemberCode(String member_code)  throws Exception{
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectAuthMappingListByMemberCode(member_code);
	}

	/**
	 * 맵핑정보 입력
	 */
	@Override
	public void insertAuthMapping(SystemVO vo)  throws Exception{
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.insertAuthMapping(vo);
		
	}

	/**
	 * 맵핑정보 수정
	 */
	@Override
	public void updateAuthMapping(SystemVO vo)  throws Exception{
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updateAuthMapping(vo);
	}

	/**
	 * 맵핑정보삭제 기준 member_code 기준
	 */
	@Override
	public void deleteAuthMappingByMemberCode(String member_code) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.deleteAuthMappingByMemberCode(member_code);
	}

	/**
	 * 사용중인기관 전체 리스트
	 */
	@Override
	public List<SystemVO> selectAllInstitutionList(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectAllInstitutionList(vo);
	}

	/**
	 * 과금 등록
	 */
	@Override
	public void insertPayment(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.insertPayment(vo);
	}

	@Override
	public void updatePayCntMember(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updatePayCntMember(vo);
		
	}

	@Override
	public List<SystemVO> selectPayMentList(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectPayMentList(vo);
	}

	@Override
	public int selectPayMentListCnt(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectPayMentListCnt(vo);
	}

	@Override
	public int selectEmailSendLogListCnt(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectEmailSendLogListCnt(vo);
	}

	@Override
	public List<SystemVO> selectEmailSendLogList(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectEmailSendLogList(vo);
	}

	@Override
	public void updateMemberFirstPasswd(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updateMemberFirstPasswd(vo);
	}

	@Override
	public List<TemplateVO> selectTemplateList(TemplateVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectTemplateList(vo);
	}

	@Override
	public int selectTemplateListCnt(TemplateVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectTemplateListCnt(vo);
	}

	@Override
	public void insertTemplate(TemplateVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.insertTemplate(vo);		
	}

	@Override
	public void updateTemplate(TemplateVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updateTemplate(vo);
	}

	@Override
	public List<TemplateVO> selectTemplateCateList(TemplateVO vo)throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectTemplateCateList(vo);
	}

	@Override
	public TemplateVO selectTemplateByCode(String code) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectTemplateByCode(code);
	}

	@Override
	public List<TemplateVO> selectTemplateAllList(TemplateVO vo)throws Exception {
		
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectTemplateAllList(vo);
	}

	@Override
	public void insertTemplateCateWord(List<TemplateVO> list) throws Exception {
		// TODO Auto-generated method stub
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.insertTemplateCateWord(list);
	}

	@Override
	public void deleteTemplateCateWord(String code) throws Exception {
		// TODO Auto-generated method stub
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.deleteTemplateCateWord(code);
	}
	
	/**
	 * 템플릿 삭제
	 */
	@Override
	public void updateDisabledTemplateByCode(String code) throws Exception{
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updateDisabledTemplateByCode(code);
	} 
	
	/**
	 * 템플릿 삭제
	 */
	@Override
	public void updateDisabledTemplatesByCateCode(String code) throws Exception{
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updateDisabledTemplatesByCateCode(code);
	} 
	
	@Override
	public void updateTemplateCateWord(TemplateVO vo) throws Exception {
		// TODO Auto-generated method stub
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updateTemplateCateWord(vo);
	}
	
	@Override
	public void updateDisabledCategoryByCode(String code) throws Exception{
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updateDisabledCategoryByCode(code);
	} 
	@Override
	public List<TemplateVO> selectTemplateCateWordByCateCode(String cate_code) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectTemplateCateWordByCateCode(cate_code);
	}

	@Override
	public TemplateVO selectTemplateCateDetailByCode(String code) throws Exception {

		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectTemplateCateDetailByCode(code);
	}

	@Override
	public List<TemplateVO> selectTemplateCateWordAllList(String userid) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectTemplateCateWordAllList(userid);
	}

	@Override
	public List<TemplateVO> selectTemplateRandomAllList() throws Exception {
		// TODO Auto-generated method stub
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectTemplateRandomAllList();
	
	}
	
	/**
	 * 카테고리 등록
	 */
	@Override
	public void insertCategory(TemplateVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.insertCategory(vo);
	}
	
	/**
	 * 카테고리 수정
	 */
	@Override
	public void updateCategory(TemplateVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updateCategory(vo);
	}
	
	@Override
	public void deleteTemplateByInstitutionCode(String code) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.deleteTemplateByInstitutionCode(code);
	}
	
	/**
	 * 훈련 서비스 설정 등록
	 */
	@Override
	public void insertServiceSetting(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.insertServiceSetting(vo);
		
	}
	
	/**
	 * 훈련 서비스 설정 로그  등록
	 */
	@Override
	public void insertServiceSettingLog(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.insertServiceSettingLog(vo);
		
	}
	
	/**
	 * 훈련 서비스 불러오기
	 */
	@Override
	public SystemVO selectServiceByCode(String code) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectServiceByCode(code);
	}
	
	/**
	 * 계정에 포함된 모든  서비스 설정 불러오기
	 */
	@Override
	public List<SystemVO> selectServiceByUserCode(String uc) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectServiceByUserCode(uc);
	}
	
	/**
	 * 훈련 서비스 설정 수정
	 */
	@Override
	public void updateServiceSetting(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updateServiceSetting(vo);
	}
	
	/**
	 * 훈련 서비스 설정 상태 수정
	 */
	@Override
	public void updateServicStatusByUc(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		mapper.updateServicStatusByUc(vo);
	}
	
	/**
	 * 훈련 서비스 설정 로그 카운터
	 */
	@Override
	public int selectServiceLogListCnt(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectServiceLogListCnt(vo);
	}
	
	/**
	 * 훈련 서비스 설정 로그 출력
	 */
	@Override
	public List<SystemVO> selectServiceLogList(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectServiceLogList(vo);
	}
	
	/**
	 * 훈련 서비스 설정 정보 출력
	 */
	@Override
	public SystemVO selectServiceSettingInfoByUserID(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectServiceSettingInfoByUserID(vo);
	}
	
	/**
	 * 접속한 User ID의 service setting code을 이용하여 현재까지 실행된 훈련 인원 조회(중복제거)
	 */
	@Override
	public List<SystemVO>  selectTrainingUserCntByServiceSettingCode(SystemVO vo) throws Exception {
		SystemMapper mapper = sqlSession.getMapper(SystemMapper.class);
		return mapper.selectTrainingUserCntByServiceSettingCode(vo);
	}
}
