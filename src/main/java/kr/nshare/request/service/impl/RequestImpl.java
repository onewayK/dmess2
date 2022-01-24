package kr.nshare.request.service.impl;

import java.util.ArrayList;
import java.util.List;

import kr.nshare.common.UserInfoVO;
import kr.nshare.common.util.EgovFileScrty;
import kr.nshare.common.util.SessionUtil;
import kr.nshare.main.mapper.TestTblDAO;
import kr.nshare.request.service.RequestVO;
import kr.nshare.system.service.SystemVO;
import kr.nshare.training.service.TrainingVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("requestImpl")
public class RequestImpl implements RequestService{
	@Autowired
	private RequestDAO trainingDAOService;

	/**
	 * 사용자 등록
	 */
	@Override
	public void insertTraining(TrainingVO vo) throws Exception {
		
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setUc(userInfo.getCode());
		
		//상태 지정
		if(vo.getStatus().equals(""))
		{
			vo.setStatus("ready");
		}
		
		//과금처리
		
		trainingDAOService.insertTraining(vo);
		
		if(null!=vo.getListvo() && vo.getListvo().size()>0)
		{
			List<TrainingVO> list = new ArrayList<TrainingVO>();
			
			for(TrainingVO tempvo : vo.getListvo())
			{
				TrainingVO vo2 = new TrainingVO();
				vo2.setTraining_code(String.valueOf(vo.getCode()));
				vo2.setName(tempvo.getName());
				vo2.setEmail(tempvo.getEmail());
				vo2.setDepartment_name(tempvo.getDepartment_name());
				vo2.setUnikey(tempvo.getUnikey());
				list.add(vo2);
			}
			
			trainingDAOService.insertTrainingUser(list);
		}
		
	}

	@Override
	public void updateTraining(TrainingVO vo) throws Exception {
		trainingDAOService.updateTraining(vo);
		
		if(null!=vo.getListvo() && vo.getListvo().size()>0)
		{
			//기존 사용자 등록분 삭제
			trainingDAOService.deleteTrainingUserByCode(vo.getCode());
			
			List<TrainingVO> list = new ArrayList<TrainingVO>();
			for(TrainingVO tempvo : vo.getListvo())
			{
				TrainingVO vo2 = new TrainingVO();
				vo2.setTraining_code(String.valueOf(vo.getCode()));
				vo2.setName(tempvo.getName());
				vo2.setEmail(tempvo.getEmail());
				vo2.setDepartment_name(tempvo.getDepartment_name());
				vo2.setUnikey(tempvo.getUnikey());
				list.add(vo2);
			}
			
			trainingDAOService.insertTrainingUser(list);
		}
		
	}

	@Override
	public TrainingVO selectTrainingByCode(String code) throws Exception {
		return trainingDAOService.selectTrainingByCode(code);
	}

	@Override
	public List<TrainingVO> selectTrainingList(TrainingVO vo) throws Exception {
		return trainingDAOService.selectTrainingList(vo);
	}

	@Override
	public int selectTrainingListCnt(TrainingVO vo) throws Exception {
		return trainingDAOService.selectTrainingListCnt(vo);
	}

	/**
	 * 사용자별 기관 리스트
	 */
	@Override
	public List<TrainingVO> selectMemberInstitutionList(TrainingVO vo) throws Exception {
		return trainingDAOService.selectMemberInstitutionList(vo);
	}

	@Override
	public List<TrainingVO> selectTrainingUserByCode(String training_code) throws Exception {
		return trainingDAOService.selectTrainingUserByCode(training_code);
	}

	/**
	 * 훈련 사용자 삭제
	 */
	@Override
	public void deleteTrainingUserByCode(String training_code) throws Exception {
		trainingDAOService.deleteTrainingUserByCode(training_code);
	}

	@Override
	public void insertTrainingLogPhishing(RequestVO vo) throws Exception {
		trainingDAOService.insertTrainingLogPhishing(vo);
		
	}

	@Override
	public TrainingVO selectTraining2UserTrainingInfo(TrainingVO vo)throws Exception {
		return trainingDAOService.selectTraining2UserTrainingInfo(vo);
	}
	
	

}
