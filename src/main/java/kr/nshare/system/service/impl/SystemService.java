package kr.nshare.system.service.impl;

import java.util.List;

import kr.nshare.common.UserInfoVO;
import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.TemplateVO;
import kr.nshare.training.service.TrainingVO;

import org.springframework.beans.factory.annotation.Qualifier;
@Qualifier
public interface SystemService {
	
	/**
	 * 사용자 등록 및 수정
	 * @param vo
	 */
	public void insertMember(SystemVO vo) throws Exception;
	public void updateMember(SystemVO vo) throws Exception;
	public SystemVO selectMemberById(String userid) throws Exception;
	//훈련 서비스 설정이 포함된 사용자 정보 리턴
	public SystemVO selectMemberByIdWithServiceSetting(String userid)  throws Exception;
	public SystemVO selectMemberByCode(String code) throws Exception;
	public List<SystemVO> selectMemberList(SystemVO vo) throws Exception;
	public int selectMemberListCnt(SystemVO vo) throws Exception;
	public void deleteMemberByCode(SystemVO vo, UserInfoVO uvo) throws Exception;
	
	public void updateMemberFirstPasswd(SystemVO vo) throws Exception;
	
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
	 * 기관 등록 및 수정
	 */
	public void insertInstitution(SystemVO vo) throws Exception;
	public void updateInstitution(SystemVO vo) throws Exception;
	public SystemVO selectInstitutionByCode(String code) throws Exception;
	public List<SystemVO> selectInstitutionList(SystemVO vo) throws Exception;
	public int selectInstitutionListCnt(SystemVO vo) throws Exception;
	public List<SystemVO> selectAllInstitutionList(SystemVO vo) throws Exception;
	
	/**기관맵핑 **/ 
	public List<SystemVO> selectAuthMappingListByMemberCode(String member_code) throws Exception;
	public void insertAuthMapping(SystemVO vo) throws Exception;
	public void updateAuthMapping(SystemVO vo) throws Exception;
	public void deleteAuthMappingByMemberCode(String member_code) throws Exception;
	
	/**과금**/
	public void insertPayment(SystemVO vo) throws Exception;
	public void updatePayCntMember(SystemVO vo) throws Exception;
	public List<SystemVO> selectPayMentList(SystemVO vo)throws Exception ;
	public int selectPayMentListCnt(SystemVO vo)throws Exception ;
	
	/**
	 * 발송로그 리스트
	 */
	public int selectEmailSendLogListCnt(SystemVO vo)  throws Exception;;
	public List<SystemVO> selectEmailSendLogList(SystemVO vo)  throws Exception;
	
	/**
	 * 템플릿 리스트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<TemplateVO> selectTemplateList(TemplateVO vo) throws Exception;
	public int selectTemplateListCnt(TemplateVO vo) throws Exception;
	
	//템플릿 등록/수정/보기
	public void insertTemplate(TemplateVO vo) throws Exception;
	public void updateTemplate(TemplateVO vo) throws Exception;
	public List<TemplateVO> selectTemplateCateList(TemplateVO vo) throws Exception;
	public List<TemplateVO> selectTemplateAllList(TemplateVO vo) throws Exception;
	public void updateDisabledTemplateByCode(String code) throws Exception;
	public void updateDisabledTemplatesByCateCode(String code) throws Exception;
	
	//카테고리 관련
	public void insertCategory(TemplateVO vo) throws Exception;
	public void updateCategory(TemplateVO vo) throws Exception;
	

	//카테고리 비활성화
	public void updateDisabledCategoryByCode(String code) throws Exception;
				
	//템플릿 상세
	public TemplateVO selectTemplateByCode(String code)throws Exception;
	
	
	//등록단어 등록
	public void insertTemplateCateWord(List<TemplateVO> list) throws Exception;
	
	//등록단어 삭제
	public void deleteTemplateCateWord(String code) throws Exception;
	
	//등록단어 수정
	public void updateTemplateCateWord(TemplateVO vo) throws Exception;
	
	//등록단어 검색
	public List<TemplateVO> selectTemplateCateWordByCateCode(String cate_code) throws Exception;
	
	//카테고리 정보 
	public TemplateVO selectTemplateCateDetailByCode(String code) throws Exception;
	
	//템플릿 존재 카테고리중 random으로 조회 
	public List<TemplateVO> selectTemplateRandomAllList() throws Exception;
	
	//카테고리 등록 단어 리스트
	public List<TemplateVO> selectTemplateCateWordAllList(String userid) throws Exception;
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
	//접속한 User ID의 service setting code을 이용하여 현재까지 실행된 훈련 인원 조회(중복제거)
	public List<SystemVO>  selectTrainingUserCntByServiceSettingCode(SystemVO vo)  throws Exception;
				
	/**
	 * 훈련 서비스 로그 설정
	 */
	public int selectServiceLogListCnt(SystemVO vo)  throws Exception;
	public List<SystemVO> selectServiceLogList(SystemVO vo)  throws Exception;
	public void insertServiceSettingLogByExecute(TrainingVO vo, int diff_send_num) throws Exception;
}
