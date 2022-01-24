package kr.nshare.scheduler.service.impl;

import java.util.List;

import kr.nshare.scheduler.service.SchedulerVO;
import kr.nshare.system.service.SystemVO;
import kr.nshare.training.service.TrainingVO;

public interface SchedulerService {

	
	
	public List<SchedulerVO> selectTrainingDeleteList(SchedulerVO vo) throws Exception;
 	public void deleteTrainingUser(SchedulerVO vo) throws Exception;
 	public void updateTrainingDelFlag(SchedulerVO vo) throws Exception;
 	public void deleteTrainingRegister(SchedulerVO vo)throws Exception;
 	
 	/*
 	 *  훈련 서비스 설정 관련 
 	 */
 	//훈련 서비스 기간이 지난 서비스 설정 N으로 초기화
 	public void updateServiceUseStatus() throws Exception;
 	//훈련 서비스 기간이 끝난 설정 조회
 	public List<SystemVO> selectServiceListNotinDate() throws Exception; 
 	//훈련 서비스 설정에 의한 삭제 리스트 조회(서비스 설정인 안된 훈련은 제외)
 	public List<TrainingVO> selectDeleteTrainingListByService(SchedulerVO vo) throws Exception; 
}
