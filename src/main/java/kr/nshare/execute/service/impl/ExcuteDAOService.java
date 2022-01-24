package kr.nshare.execute.service.impl;

import java.util.List;

import kr.nshare.common.AbstractDAO;
import kr.nshare.execute.service.mapper.ExcuteMapper;
import kr.nshare.training.service.TrainingVO;

import org.springframework.stereotype.Service;

@Service("excuteDAOService")
public class ExcuteDAOService extends AbstractDAO implements ExcuteDAO 
{
	/**
	 * 훈련 대상자 생성
	 */
	public void insertTrainingUserLogExcute(TrainingVO vo) throws Exception {
		ExcuteMapper mapper = sqlSession.getMapper(ExcuteMapper.class);
		mapper.insertTrainingUserLogExcute(vo);
	}
	
	/**
	 * 훈련log생성(기존 등록되어있는 로그를 제외한 훈련자만 등록)
	 */
	public void insertTrainingUserLogExcuteEXcetp(TrainingVO vo) throws Exception {
		ExcuteMapper mapper = sqlSession.getMapper(ExcuteMapper.class);
		mapper.insertTrainingUserLogExcuteEXcetp(vo);
	}
	
	/**
	 * 훈련 상태 값 변경
	 */
	@Override
	public void updateTrainingStatus(TrainingVO vo) throws Exception {
		ExcuteMapper mapper = sqlSession.getMapper(ExcuteMapper.class);
		mapper.updateTrainingStatus(vo);
	}

	@Override
	public int selectExcuteListCnt(TrainingVO vo) throws Exception {
		ExcuteMapper mapper = sqlSession.getMapper(ExcuteMapper.class);
		return mapper.selectExcuteListCnt(vo);
	}
	
	@Override
	public List<TrainingVO> selectExcuteList(TrainingVO vo) throws Exception {
		ExcuteMapper mapper = sqlSession.getMapper(ExcuteMapper.class);
		return mapper.selectExcuteList(vo);
	}

	@Override
	public List<TrainingVO> selectExcuteGroupSummary(TrainingVO vo)
			throws Exception {
		ExcuteMapper mapper = sqlSession.getMapper(ExcuteMapper.class);
		return mapper.selectExcuteGroupSummary(vo);
	}

	
	/**
	 *  훈련 승인 생성 관련 
	 */
	@Override
	public void insertTrainingApproval(TrainingVO vo) throws Exception {
		ExcuteMapper mapper = sqlSession.getMapper(ExcuteMapper.class);
		mapper.insertTrainingApproval(vo);
	}
	
	/**
	 * 훈련 승인 수정
	 */
	@Override
	public void updateTrainingApproval(TrainingVO vo) throws Exception {
		ExcuteMapper mapper = sqlSession.getMapper(ExcuteMapper.class);
		mapper.updateTrainingApproval(vo);
	}
	
	/**
	 * 훈련 승인 삭제
	 */
	@Override
	public int deleteTrainingApproval(String code) throws Exception {
		ExcuteMapper mapper = sqlSession.getMapper(ExcuteMapper.class);
		return mapper.deleteTrainingApproval(code);
	}
	
}
