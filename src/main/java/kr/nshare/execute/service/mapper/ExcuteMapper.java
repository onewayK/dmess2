/**
 * @author +impro
 *
 */
package kr.nshare.execute.service.mapper;

import java.util.List;

import kr.nshare.training.service.TrainingVO;

public interface ExcuteMapper{
	
	//훈련log생성
	public void insertTrainingUserLogExcute(TrainingVO vo) throws Exception;
	
	//훈련log생성(기존 등록되어있는 로그를 제외한 훈련자만 등록)
	public void insertTrainingUserLogExcuteEXcetp(TrainingVO vo) throws Exception;	
	
	public void updateTrainingStatus(TrainingVO vo) throws Exception;
	
	//실행 리스트 출력
	public int selectExcuteListCnt(TrainingVO vo) throws Exception;
	public List<TrainingVO> selectExcuteList(TrainingVO vo) throws Exception;
	public List<TrainingVO> selectExcuteGroupSummary(TrainingVO vo) throws Exception;
	
	//훈련 실행에 필요한 승인 관련
	public void insertTrainingApproval(TrainingVO vo) throws Exception;	
	public void updateTrainingApproval(TrainingVO vo) throws Exception;
	public int deleteTrainingApproval(String code) throws Exception;
}