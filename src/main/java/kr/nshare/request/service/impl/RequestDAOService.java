package kr.nshare.request.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.nshare.common.AbstractDAO;
import kr.nshare.common.util.EgovFileScrty;
import kr.nshare.main.mapper.TestTbl;
import kr.nshare.member.service.mapper.MemberMapper;
import kr.nshare.request.service.RequestVO;
import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.mapper.SystemMapper;
import kr.nshare.training.service.TrainingVO;
import kr.nshare.training.service.mapper.TrainingMapper;

import org.apache.ibatis.annotations.Insert;
import org.springframework.stereotype.Service;

@Service("requestDAOService")
public class RequestDAOService extends AbstractDAO implements RequestDAO {

	/**
	 * 훈련 등록
	 */
	@Override
	public void insertTraining(TrainingVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.insertTraining(vo);
	}

	/**
	 * 훈련 업데이트
	 */
	@Override
	public void updateTraining(TrainingVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.updateTraining(vo);

	}

	/**
	 * 상세
	 */
	@Override
	public TrainingVO selectTrainingByCode(String code) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTrainingByCode(code);

	}

	/**
	 * 리스트
	 */
	@Override
	public List<TrainingVO> selectTrainingList(TrainingVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTrainingList(vo);
	}

	/**
	 * 총갯수
	 */
	@Override
	public int selectTrainingListCnt(TrainingVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTrainingListCnt(vo);
	}

	/**
	 * 사용자별 기관 리스트
	 */
	@Override
	public List<TrainingVO> selectMemberInstitutionList(TrainingVO vo)
			throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectMemberInstitutionList(vo);
	}

	/**
	 * 훈련 사용자 등록
	 */
	@Override
	public void insertTrainingUser(List<TrainingVO> list) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		Map<String, Object> map = null;
		mapper.insertTrainingUser(list);

	}

	/**
	 * 훈련사용자 검색 by training_code
	 */
	@Override
	public List<TrainingVO> selectTrainingUserByCode(String training_code)
			throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTrainingUserByCode(training_code);
	}

	/**
	 * 훈련사용자 삭제 루틴
	 */
	@Override
	public void deleteTrainingUserByCode(String training_code) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.deleteTrainingUserByCode(training_code);

	}

	/**
	 * 피싱 정보 입력 루틴
	 */
	@Override
	public void insertTrainingLogPhishing(RequestVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.insertTrainingLogPhishing(vo);
	}

	/**
	 * 취향 분석 훈련 훈련내용 및 훈련 대상자 정보 추출
	 */
	@Override
	public TrainingVO selectTraining2UserTrainingInfo(TrainingVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTraining2UserTrainingInfo(vo);
	}

}
