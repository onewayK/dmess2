package kr.nshare.training.service.impl;

import java.util.List;

import kr.nshare.common.AbstractDAO;
import kr.nshare.system.service.TemplateVO;
import kr.nshare.training.service.TrainingLogVO;
import kr.nshare.training.service.TrainingRegisterVO;
import kr.nshare.training.service.TrainingVO;
import kr.nshare.training.service.mapper.TrainingMapper;

import org.springframework.stereotype.Service;

@Service("trainingDAOService")
public class TrainingDAOService extends AbstractDAO implements TrainingDAO {

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
	 * 훈련 기간인지 확인하는 상태값 포함한 훈련 검색
	 */
	@Override
	public TrainingVO selectTrainingWithValidByCode(String code) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTrainingWithValidByCode(code);

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
	 * 상태를 포함한 훈련사용자 검색 by training_code
	 */
	@Override
	public List<TrainingVO> selectTrainingUserStatusByCode(String training_code)
			throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTrainingUserStatusByCode(training_code);
	}
	
	/**
	 * 훈련사용자 삭제 루틴
	 */
	@Override
	public int deleteTrainingUserByCode(String training_code) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.deleteTrainingUserByCode(training_code);
	}

	/**
	 * 훈련 실행 상태 체크
	 */
	@Override
	public List<TrainingVO> selectAjaxExcuteTrainingStatusList(
			List<TrainingVO> vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectAjaxExcuteTrainingStatusList(vo);
	}

	/**
	 * 
	 */
	@Override
	public TrainingLogVO selectTrainingLog(TrainingLogVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTrainingLog(vo);
	}

	@Override
	public void updateTrainingLog(TrainingLogVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.updateTrainingLog(vo);
	}

	@Override
	public TrainingVO selectTrainingLogSummy(String training_code)
			throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTrainingLogSummy(training_code);
	}

	@Override
	public List<TrainingVO> selectTrainingUserByNameAndEmail(TrainingVO vo)
			throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTrainingUserByNameAndEmail(vo);
	}

	@Override
	public void insertTrainingRegister(TrainingRegisterVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.insertTrainingRegister(vo);
	}

	@Override
	public void insertTrainingRegister2(TrainingRegisterVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.insertTrainingRegister2(vo);
	}
	
	@Override
	public List<TrainingVO> selectTrainingGroupList(TrainingVO vo)
			throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTrainingGroupList(vo);

	}

	@Override
	public int selectTrainingGroupListCnt(TrainingVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTrainingGroupListCnt(vo);
	}

	@Override
	public void insertGroup(TrainingVO vo) throws Exception {

		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.insertGroup(vo);
	}

	@Override
	public void updateGroup(TrainingVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.updateGroup(vo);
	}

	@Override
	public TrainingVO selectGroupByCode(String code) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectGroupByCode(code);
	}

	@Override
	public List<TrainingVO> selectGroupByInstitutionCode(String code) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectGroupByInstitutionCode(code);
	}
	
	@Override
	public List<TrainingVO> selectGroupListByInstitutionCode(String code)
			throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectGroupListByInstitutionCode(code);

	}

	@Override
	public int insertCopyTrainingByCode(TrainingVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.insertCopyTrainingByCode(vo);
	}

	@Override
	public int deleteTrainingByCode(String code) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.deleteTrainingByCode(code);
	}

	@Override
	public int deleteTrainingLogByCode(String training_code) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.deleteTrainingLogByCode(training_code);
	}

	@Override
	public int deleteTrainingRegisterByCode(String training_code)
			throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.deleteTrainingRegisterByCode(training_code);
	}


	@Override
	public void insertTraining2step1(TrainingVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.insertTraining2step1(vo);
	}

	@Override
	public void updateTraining2(TrainingVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.updateTraining2(vo);
	}

	@Override
	public void updateTrainingDate(TrainingVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.updateTrainingDate(vo);
	}
	
	@Override
	public List<TrainingVO> selectTraining2List(TrainingVO vo) throws Exception {
		// TODO Auto-generated method stub
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTraining2List(vo);
	}

	@Override
	public int selectTraining2ListCnt(TrainingVO vo) throws Exception {
		// TODO Auto-generated method stub
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTraining2ListCnt(vo);
	}

	@Override
	public void deleteTrainingGrpByCdoe(TrainingVO vo) throws Exception {
		// TODO Auto-generated method stub
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.deleteTrainingGrpByCdoe(vo);
	}

	@Override
	public void insertTraining2grp(TrainingVO vo) throws Exception {
		// TODO Auto-generated method stub
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		 mapper.insertTraining2grp(vo);
		
	}

	@Override
	public void updateTraining2grp(TemplateVO vo) throws Exception {
		// TODO Auto-generated method stub
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.updateTraining2grp(vo);
	}

	@Override
	public void insertTraining2User(List<TrainingVO> list) throws Exception {
		// TODO Auto-generated method stub
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.insertTraining2User(list);
	}



	@Override
	public void deleteTraining2UserByCdoe(TrainingVO vo) throws Exception {
		// TODO Auto-generated method stub
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.deleteTraining2UserByCdoe(vo);
	}

	@Override
	public void updateTraining2UserbySelect(TrainingVO vo) throws Exception {
		// TODO Auto-generated method stub
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		mapper.updateTraining2UserbySelect(vo);
	}

	@Override
	public List<TrainingVO> selectTraining2UserListByCode(String code)
			throws Exception {
		// TODO Auto-generated method stub
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTraining2UserListByCode(code);	
	}
	
	@Override
	public List<TrainingVO> selectTraining2UserListWithStatusByCode(String code)
			throws Exception {
		// TODO Auto-generated method stub
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTraining2UserListWithStatusByCode(code);	
	}

	@Override
	public List<TrainingVO> selectTraining2GrpListByCode(String code)
			throws Exception {
		// TODO Auto-generated method stub
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTraining2GrpListByCode(code);	
		
	}

	@Override
	public List<TrainingVO> selectAllTemplistExceptGrp(TrainingVO vo)
			throws Exception {
		// TODO Auto-generated method stub
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectAllTemplistExceptGrp(vo);	
		
	}

	@Override
	public List<TrainingVO> selectTraining2GrpNoUser(String code)
			throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTraining2GrpNoUser(code);	
	}

	@Override
	public List<TrainingVO> selectTraining2DetailList(String code)
			throws Exception {
		
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTraining2DetailList(code);	
	}

	@Override
	public List<TrainingVO> selectTraining2GrpByCode(TrainingVO vo) 
			throws Exception {  		
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTraining2GrpByCode(vo);	
	}
	
	@Override
	public List<TrainingVO> selectTrainingByGroupCode(String code) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTrainingByGroupCode(code);
	}
	
	@Override
	public int deleteTrainingGroupByCode(String code) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.deleteTrainingGroupByCode(code);
	}
	
	
	/**
	 * 훈련 삭제 팝업 관련
	 */
	@Override
	public List<TrainingVO> selectDeleteExpectedTrainingList(TrainingVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectDeleteExpectedTrainingList(vo);
	}

	/**
	 * 훈련 삭제 팝업 관련 총갯수
	 */
	@Override
	public int selectDeleteExpectedTrainingListCnt(TrainingVO vo) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectDeleteExpectedTrainingListCnt(vo);
	}
	
	/**
	 * 한 훈련에 등록된 훈련 대상자 수 
	 */
	@Override
	public int selectTrainingUserCnt(String code) throws Exception {
		TrainingMapper mapper = sqlSession.getMapper(TrainingMapper.class);
		return mapper.selectTrainingUserCnt(code);
	}

}
