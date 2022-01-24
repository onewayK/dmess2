/**
 * @author +impro
 *
 */
package kr.nshare.system.service.mapper;

import java.util.List;

import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.TemplateVO;

public interface SystemMapper{
	/**
	 * 사용자
	 */
	void insertMember(SystemVO vo)  throws Exception;
	void updateMember(SystemVO vo) throws Exception;
	SystemVO selectMemberById(String userid)  throws Exception;
	//훈련 서비스 설정이 포함된 사용자 정보 리턴
	public SystemVO selectMemberByIdWithServiceSetting(String userid)  throws Exception;
	SystemVO selectMemberByCode(String code) throws Exception;
	List<SystemVO> selectMemberList(SystemVO vo) throws Exception;
	int selectMemberListCnt(SystemVO vo) throws Exception;
	public void updateMemberFirstPasswd(SystemVO vo) throws Exception;
	public void deleteMemberByCode(String code) throws Exception;
	
	//사용자 삭제로 인한 템플릿 생성자 변경
	public void updateTemplateUcByCode(SystemVO vo) throws Exception;
	//사용자 삭제로 인한 파일 생성자 변경
	public void updateFileUcByCode(SystemVO vo) throws Exception;
	//사용자 삭제로 인한 훈련 생성자 변경
	public void updateTrainingUcAndIdByCode(SystemVO vo) throws Exception;
	//사용자 삭제로 인한 훈련 생성자 변경
	public void updateTrainingGroupIdAndIdByCode(SystemVO vo) throws Exception;
	//기관 코드로 템플릿 삭제
	public void deleteTemplateByInstitutionCode(String code) throws Exception;
	
	//기관  삭제
	public void deleteInstitutionByCode(String code) throws Exception;
	
	/**
	 * 기관 관리
	 */
	void insertInstitution(SystemVO vo) throws Exception;
	void updateInstitution(SystemVO vo) throws Exception;
	SystemVO selectInstitutionByCode(String code)  throws Exception;
	List<SystemVO> selectInstitutionList(SystemVO vo)  throws Exception;
	int selectInstitutionListCnt(SystemVO vo)  throws Exception;
	List<SystemVO> selectAllInstitutionList(SystemVO vo)  throws Exception;
	
	/**
	 * 사용자 와 기관의 맵핑 정보
	 */
	public List<SystemVO> selectAuthMappingListByMemberCode(String member_code)  throws Exception;
	public void insertAuthMapping(SystemVO vo)  throws Exception;
	public void updateAuthMapping(SystemVO vo)  throws Exception;
	public void deleteAuthMappingByMemberCode(String member_code) throws Exception;
	
	/**
	 * 과금리스트 및 추가
	 */
	public void insertPayment(SystemVO vo)  throws Exception;
	public void updatePayCntMember(SystemVO vo) throws Exception;
	public List<SystemVO> selectPayMentList(SystemVO vo)  throws Exception;
	public int selectPayMentListCnt(SystemVO vo)  throws Exception;
	
	/**
	 * 발송로그 리스트
	 */
	public int selectEmailSendLogListCnt(SystemVO vo)  throws Exception;;
	public List<SystemVO> selectEmailSendLogList(SystemVO vo)  throws Exception;;
	
	/**
	 * 템플릿 리스트
	 */
	public List<TemplateVO> selectTemplateList(TemplateVO vo) throws Exception;
	public int selectTemplateListCnt(TemplateVO vo) throws Exception;
	
	//템플릿 보기
	public TemplateVO selectTemplateByCode(String code) throws Exception;
	
	//템플릿 등록
	public void insertTemplate(TemplateVO vo) throws Exception;
	public void updateTemplate(TemplateVO vo) throws Exception;
	public List<TemplateVO> selectTemplateCateList(TemplateVO vo) throws Exception;
	public List<TemplateVO> selectTemplateAllList(TemplateVO vo) throws Exception;
	public void updateDisabledTemplateByCode(String code) throws Exception;
	public void updateDisabledTemplatesByCateCode(String code) throws Exception;
		
	//	카테고리 등록
	public void insertCategory(TemplateVO vo) throws Exception;
	
	//	카테고리 수정
	public void updateCategory(TemplateVO vo) throws Exception;
	
	//카테고리 비활성화
	public void updateDisabledCategoryByCode(String code) throws Exception;
	
	//등록단어 등록
	public void insertTemplateCateWord(List<TemplateVO> list) throws Exception;
	
	//등록단어 삭제
	public void deleteTemplateCateWord(String code) throws Exception;
	
	//등록단어 수정
	public void updateTemplateCateWord(TemplateVO vo) throws Exception;
	
	//등록단어 검색
	public List<TemplateVO> selectTemplateCateWordByCateCode(String cate_code) throws Exception;

	//카테고리 상세정보
	public TemplateVO selectTemplateCateDetailByCode(String code) throws Exception;

	//카테고리 등록 단어 리스트
	public List<TemplateVO> selectTemplateCateWordAllList(String userid) throws Exception;
	
	//템플릿 존재 카테고리중 random으로 조회 
	public List<TemplateVO> selectTemplateRandomAllList() throws Exception;
	
	/**
	 * 훈련 서비스 설정
	 */
	//훈련 서비스 설정 등록
	public void insertServiceSetting(SystemVO vo) throws Exception;
	//훈련 서비스 설정 로그 등록
	public void insertServiceSettingLog(SystemVO vo) throws Exception;
	//코드로 서비스 불러오기
	public SystemVO selectServiceByCode(String code)  throws Exception;
	//계정에 포함된 모든  서비스 설정 불러오기
	public List<SystemVO> selectServiceByUserCode(String uc) throws Exception;
	//훈련 서비스 설정 수정
	public void updateServiceSetting(SystemVO vo) throws Exception;
	//훈련 서비스 설정 상태 수정
	public void updateServicStatusByUc(SystemVO vo) throws Exception;
	//접속한 User ID을 이용하여 서비스 설정 정보 조회
	public SystemVO selectServiceSettingInfoByUserID(SystemVO vo)  throws Exception;
	//접속한 User ID을 이용하여 현재까지 실행된 훈련 인원 조회(중복제거)
	public List<SystemVO>  selectTrainingUserCntByServiceSettingCode(SystemVO vo)  throws Exception;
		
	/**
	 * 훈련 서비스 로그 설정
	 */
	public int selectServiceLogListCnt(SystemVO vo)  throws Exception;
	public List<SystemVO> selectServiceLogList(SystemVO vo)  throws Exception;
	
	
	
}