package kr.nshare.scheduler.service.impl;

import java.util.List;

import kr.nshare.common.AbstractDAO;
import kr.nshare.scheduler.service.SchedulerVO;
import kr.nshare.scheduler.service.mapper.SchedulerMapper;
import kr.nshare.system.service.SystemVO;
import kr.nshare.training.service.TrainingVO;

import org.springframework.stereotype.Service;

@Service("schedulerDAOService")
public class SchedulerDAOService extends AbstractDAO implements SchedulerDAO 
{

	
	@Override
	public List<SchedulerVO> selectTrainingDeleteList(SchedulerVO vo) throws Exception {
		SchedulerMapper mapper = sqlSession.getMapper(SchedulerMapper.class);
		return mapper.selectTrainingDeleteList(vo);
	}

	@Override
	public void deleteTrainingUser(SchedulerVO vo) throws Exception {
		SchedulerMapper mapper = sqlSession.getMapper(SchedulerMapper.class);
		mapper.deleteTrainingUser(vo);
		
	}

	@Override
	public void updateTrainingDelFlag(SchedulerVO vo) throws Exception {
		SchedulerMapper mapper = sqlSession.getMapper(SchedulerMapper.class);
		mapper.updateTrainingDelFlag(vo);
	}

	@Override
	public void deleteTrainingRegister(SchedulerVO vo) throws Exception {
		SchedulerMapper mapper = sqlSession.getMapper(SchedulerMapper.class);
		mapper.deleteTrainingRegister(vo);		
	}
	
	
	/*
 	 *  훈련 서비스 기간이 끝난 설정 조회
 	 */
	@Override
	public void updateServiceUseStatus() throws Exception {
		SchedulerMapper mapper = sqlSession.getMapper(SchedulerMapper.class);
		mapper.updateServiceUseStatus();		
	}
	
	/*
 	 *  훈련 서비스 기간이 끝난 설정 조회
 	 */
	@Override
	public List<SystemVO> selectServiceListNotinDate() throws Exception {
		SchedulerMapper mapper = sqlSession.getMapper(SchedulerMapper.class);
		return mapper.selectServiceListNotinDate();
	}
	
	/*
 	 * 훈련 서비스 설정에 의한 삭제 리스트 조회(서비스 설정인 안된 훈련은 제외)
 	 */
	@Override
	public List<TrainingVO> selectDeleteTrainingListByService(SchedulerVO vo) throws Exception {
		SchedulerMapper mapper = sqlSession.getMapper(SchedulerMapper.class);
		return mapper.selectDeleteTrainingListByService(vo);
	}
}
