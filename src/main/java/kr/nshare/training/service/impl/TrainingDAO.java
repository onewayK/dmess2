package kr.nshare.training.service.impl;

import java.util.List;

import kr.nshare.system.service.TemplateVO;
import kr.nshare.training.service.TrainingLogVO;
import kr.nshare.training.service.TrainingRegisterVO;
import kr.nshare.training.service.TrainingVO;

public interface TrainingDAO {
	public void insertTraining(TrainingVO vo) throws Exception;
	public void insertTrainingUser(List<TrainingVO> list) throws Exception;
	
	public void updateTraining(TrainingVO vo) throws Exception;
	public TrainingVO selectTrainingByCode(String code) throws Exception;
	public int deleteTrainingUserByCode(String training_code)  throws Exception;
	
	public List<TrainingVO> selectTrainingList(TrainingVO vo) throws Exception;
	public int selectTrainingListCnt(TrainingVO vo) throws Exception;
	public List<TrainingVO> selectMemberInstitutionList(TrainingVO vo) throws Exception;
	public List<TrainingVO> selectTrainingUserByCode(String training_code)  throws Exception;
	//발송상태를 포함한 유저 리스트
	public List<TrainingVO> selectTrainingUserStatusByCode(String training_code) throws Exception;
	
	public List<TrainingVO> selectAjaxExcuteTrainingStatusList(List<TrainingVO> vo) throws Exception;
	public TrainingLogVO selectTrainingLog(TrainingLogVO vo) throws Exception;
	//훈려로그 업데이트
	public void updateTrainingLog(TrainingLogVO vo) throws Exception;
	// 훈련 기간 수정
	public void updateTrainingDate(TrainingVO vo) throws Exception;
	
	//메일 발송 진행 내용 summy
	public TrainingVO selectTrainingLogSummy(String training_code ) throws Exception;
	
	
	//신고검색(검색인자training_code + name + email)
	public List<TrainingVO> selectTrainingUserByNameAndEmail(TrainingVO vo)  throws Exception;
	
	//신고등록
	public void insertTrainingRegister(TrainingRegisterVO vo) throws Exception;
	//일괄 신고등록
	public void insertTrainingRegister2(TrainingRegisterVO vo) throws Exception;
		
	//훈련관리>훈련그룹관리
	public List<TrainingVO> selectTrainingGroupList(TrainingVO vo) throws Exception;
	public int selectTrainingGroupListCnt(TrainingVO vo) throws Exception;
	
	//훈련관리>훈련그룹등록 및 수정
	public void insertGroup(TrainingVO vo) throws Exception;
	public void updateGroup(TrainingVO vo) throws Exception;
	
	//그룹정보 추출
	public TrainingVO selectGroupByCode(String code) throws Exception;
	// 기관 코드로 그룹정보 추출
	public List<TrainingVO> selectGroupByInstitutionCode(String code) throws Exception;
		
	//기관 코드 베이스로 그룹 정보 추출
	public List<TrainingVO> selectGroupListByInstitutionCode(String code) throws Exception;
	
	//훈련 삭제
	public int insertCopyTrainingByCode(TrainingVO vo) throws Exception;
	
	
	//훈련 복사
	public int deleteTrainingByCode(String code) throws Exception;
	
	//훈련에 해당하는 log삭제
	public int deleteTrainingLogByCode(String training_code) throws Exception;
	
	//훈려에 해당하는 신고 삭제
	public int deleteTrainingRegisterByCode(String training_code) throws Exception;
	
	
	//취향분석 훈련 등록 step1
	public void insertTraining2step1(TrainingVO vo) throws Exception;
	
	//취향분석 훈련 내용 수정
	public void updateTraining2(TrainingVO vo) throws Exception;
	
	public List<TrainingVO> selectTraining2List(TrainingVO vo) throws Exception;
	public int selectTraining2ListCnt(TrainingVO vo) throws Exception;
	
//취향 분석 훈련 grp 등록
	public void insertTraining2grp(TrainingVO vo) throws Exception;
	//취향 분석 훈련 grp 삭제
	public void deleteTrainingGrpByCdoe(TrainingVO vo) throws  Exception;	
	//취향 분석 훈련 grp 수정
	public void updateTraining2grp(TemplateVO vo) throws Exception;
	
	//취향 분석 훈련 대상자 등록(개별)
	public void insertTraining2User(List<TrainingVO> list) throws Exception;

	//취향 분석 훈련 대상자 전체 or 개별 삭제
	public void deleteTraining2UserByCdoe(TrainingVO vo) throws Exception;
	
	//취향 분석 훈련 대상자 수정(개별)
	public void updateTraining2UserbySelect(TrainingVO vo) throws Exception;
	
	//취향 분석 훈련 트레이닝 코드로 user list select 함
	public List<TrainingVO> selectTraining2UserListByCode(String code) throws Exception;
	
	//취향 분석 훈련 트레이닝 코드로 user list select 함(발송상태 포함)
	public List<TrainingVO> selectTraining2UserListWithStatusByCode(String code) throws Exception;
		
	
	//취향 분석  훈련에 등록된 Grp를 select 함
	public List<TrainingVO> selectTraining2GrpListByCode(String code) throws Exception;
	
	//취향 분석  훈련에 등록된 Grp를 제외한 템블릿 전체 list select 함
	public List<TrainingVO> selectAllTemplistExceptGrp(TrainingVO vo) throws Exception;
	
	//취향 분석 훈련에 등록된 grp 중 user가 등록안된 grp 탐색
	public List<TrainingVO> selectTraining2GrpNoUser(String code) throws Exception;	
	
	//등록된 취향 분석 훈련의 상세 보기
	public List<TrainingVO> selectTraining2DetailList(String code) throws Exception;
	
	//취향분석시 템플릿 수정창 GRP 조회
	public List<TrainingVO> selectTraining2GrpByCode(TrainingVO vo) throws Exception;
	
	//훈련 기간인지 확인하는 상태값 포함한 훈련 검색
	public TrainingVO selectTrainingWithValidByCode(String code) throws Exception;
	
	//그룹 코드로 훈련 리스트 검색
	public List<TrainingVO> selectTrainingByGroupCode(String code) throws Exception;
	// 훈련그룹 삭제
	public int deleteTrainingGroupByCode(String code) throws Exception;
	
	//훈련 삭제 팝업 관련
	public List<TrainingVO> selectDeleteExpectedTrainingList(TrainingVO vo) throws Exception;
	public int selectDeleteExpectedTrainingListCnt(TrainingVO vo) throws Exception;
	
	//한 훈련에 등록된 훈련 대상자 총값
	public int selectTrainingUserCnt(String code) throws Exception;
	
}
