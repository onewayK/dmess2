package kr.nshare.request.service.impl;

import java.util.List;

import kr.nshare.request.service.RequestVO;
import kr.nshare.training.service.TrainingVO;

public interface RequestDAO {
	public void insertTraining(TrainingVO vo) throws Exception;
	public void insertTrainingUser(List<TrainingVO> list) throws Exception;
	
	public void updateTraining(TrainingVO vo) throws Exception;
	public TrainingVO selectTrainingByCode(String code) throws Exception;
	public void deleteTrainingUserByCode(String training_code)  throws Exception;
	
	public List<TrainingVO> selectTrainingList(TrainingVO vo) throws Exception;
	public int selectTrainingListCnt(TrainingVO vo) throws Exception;
	public List<TrainingVO> selectMemberInstitutionList(TrainingVO vo) throws Exception;
	public List<TrainingVO> selectTrainingUserByCode(String training_code)  throws Exception;
	public void insertTrainingLogPhishing(RequestVO vo) throws Exception;
	
	//취향분석 훈련 훈련대상 자 및 훈련내용 및 옵션 정보 추출
	public TrainingVO selectTraining2UserTrainingInfo(TrainingVO vo) throws Exception;
	
}
