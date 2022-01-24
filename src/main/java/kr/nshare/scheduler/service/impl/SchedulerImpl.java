package kr.nshare.scheduler.service.impl;

import java.util.List;

import kr.nshare.scheduler.service.SchedulerVO;
import kr.nshare.system.service.SystemVO;
import kr.nshare.training.service.TrainingVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("schedulerImpl")
public class SchedulerImpl implements SchedulerService{
	@Autowired
	private SchedulerDAO schedulerDAOService;

	@Override
	public List<SchedulerVO> selectTrainingDeleteList(SchedulerVO vo)throws Exception {
		return schedulerDAOService.selectTrainingDeleteList(vo);
	}




	@Override
	public void deleteTrainingUser(SchedulerVO vo) throws Exception {
		schedulerDAOService.deleteTrainingUser(vo);
		
	}

	@Override
	public void updateTrainingDelFlag(SchedulerVO vo) throws Exception {
		schedulerDAOService.updateTrainingDelFlag(vo);
	}

	@Override
	public void deleteTrainingRegister(SchedulerVO vo) throws Exception {
		schedulerDAOService.deleteTrainingRegister(vo);
		
	}
	
	/*
 	 *  훈련 서비스 기간이 지난 서비스 설정 N으로 초기화
 	 */
	@Override
	public void updateServiceUseStatus() throws Exception {
		schedulerDAOService.updateServiceUseStatus();		
	}
	/*
 	 *  훈련 서비스 기간이 끝난 설정 조회
 	 */
	@Override
	public List<SystemVO> selectServiceListNotinDate()throws Exception {
		return schedulerDAOService.selectServiceListNotinDate();
	}
	
	/*
 	 *  훈련 서비스 설정에 의한 삭제 리스트 조회(서비스 설정인 안된 훈련은 제외)
 	 */
	@Override
	public List<TrainingVO> selectDeleteTrainingListByService(SchedulerVO vo) throws Exception{
		return schedulerDAOService.selectDeleteTrainingListByService(vo);
	}
}
