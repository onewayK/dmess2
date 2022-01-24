package kr.nshare.execute.service.impl;

import java.util.ArrayList;
import java.util.List;

import kr.nshare.common.UserInfoVO;
import kr.nshare.common.util.SessionUtil;
import kr.nshare.training.service.TrainingVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service("excuteImpl")
public class ExcuteImpl implements ExcuteService{
	@Autowired
	private ExcuteDAO excuteDAOService;

	/**
	 * 훈련대상자 로그 생성
	 */
	@Override
	public void insertTrainingUserLogExcute(TrainingVO vo) throws Exception {
		excuteDAOService.insertTrainingUserLogExcute(vo);
	}
	
	/**
	 * 훈련log생성(기존 등록되어있는 로그를 제외한 훈련자만 등록)
	 */
	@Override
	public void insertTrainingUserLogExcuteEXcetp(TrainingVO vo) throws Exception {
		excuteDAOService.insertTrainingUserLogExcuteEXcetp(vo);
	}
	
	@Override
	public void updateTrainingStatus(TrainingVO vo) throws Exception {
		excuteDAOService.updateTrainingStatus(vo); 
		
	}

	@Override
	public int selectExcuteListCnt(TrainingVO vo) throws Exception {
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setLev(userInfo.getLev());
		vo.setUserid(userInfo.getUserid());
		
		return excuteDAOService.selectExcuteListCnt(vo); 
	}

	/**
	 * 실시간 리스트 
	 */
	@Override
	public List<TrainingVO> selectExcuteList(TrainingVO vo) throws Exception {
		
		List<TrainingVO> temp_list = null;
		List<TrainingVO> list = new ArrayList<TrainingVO>();
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setLev(userInfo.getLev());
		vo.setUserid(userInfo.getUserid());
		
		temp_list = excuteDAOService.selectExcuteList(vo);
		
		String temp = "";
		int rnum = 1;
		
		for(TrainingVO vo2 : temp_list)
		{
			if(vo2.getGroup_code().equals(temp))
			{
				vo2.setRow_number(String.valueOf(rnum));
				temp = vo2.getGroup_code();
				rnum++;
			}
			else
			{
				rnum = 1;
				vo2.setRow_number(String.valueOf(rnum));
				temp = vo2.getGroup_code();
				rnum++;
			}
			
			
			
			list.add(vo2);
		}
		
		return list;
	}

	@Override
	public List<TrainingVO> selectExcuteGroupSummary(TrainingVO vo) throws Exception {
		return excuteDAOService.selectExcuteGroupSummary(vo);
	}

	
	//훈련 승인 생성
	@Override
	public void insertTrainingApproval(TrainingVO vo) throws Exception {
		excuteDAOService.insertTrainingApproval(vo);
	}
	/**
	 * 훈련 승인 삭제
	 */
	@Override
	public int deleteTrainingApproval(String code) throws Exception {
		return excuteDAOService.deleteTrainingApproval(code);
	}
	// 훈련 승인 
	@Override
	public void updateTrainingApproval(TrainingVO vo) throws Exception {
		excuteDAOService.updateTrainingApproval(vo); 
	}

}
