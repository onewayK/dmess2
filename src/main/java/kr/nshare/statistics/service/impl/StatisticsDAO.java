package kr.nshare.statistics.service.impl;

import java.util.HashMap;
import java.util.List;

import kr.nshare.statistics.service.StatisticsVO;
import kr.nshare.training.service.TrainingRegisterVO;
import kr.nshare.training.service.TrainingVO;

public interface StatisticsDAO {
	
	public List<StatisticsVO> selectTrainingListByInstatutionCode(String Instatitution_code)  throws Exception;
	
	public List<StatisticsVO> selectTrainingLogListGrupByUser(String training_code) throws Exception;
	public List<HashMap> selectTrainingLogListGrupByUserExcel(String training_code) throws Exception;
	
	public List<StatisticsVO> selectTrainingLogListGrupByDepartment(String training_code) throws Exception;
	public List<HashMap> selectTrainingLogListGrupByDepartmentExcel(String training_code) throws Exception;
	
	
	public StatisticsVO selectTrainingLogChart(List<StatisticsVO> list) throws Exception;
	public StatisticsVO selectTrainingLogListGrupByUserSum(String training_code) throws Exception;
	//각 훈련에 대한 통계 
	public StatisticsVO selectTrainingLogChartReport(String code) throws Exception;
	//각 훈련에 대한 통계 엑셀
	public HashMap selectTrainingLogChartReportExcel(String code) throws Exception;
	//모든 훈련에 대한 종합 통계 
    public StatisticsVO selectTrainingLogChartReportTotal(List<String> list) throws Exception;
    public HashMap selectTrainingLogChartReportTotalEXcel(List<String> list) throws Exception;
    
	public List<TrainingRegisterVO> selectTrainingRegisterList(TrainingRegisterVO vo)  throws Exception;
	public int selectTrainingRegisterListCnt(TrainingRegisterVO vo) throws Exception;
	public int selectTrainingRegisterListCntExceptReduplication(TrainingRegisterVO vo) throws Exception;
	
	//중복 및 매칭 실패 항목 제거 후 신고리스트 출력
	public List<TrainingRegisterVO> selectTrainingRegisterExceptReduplication(TrainingRegisterVO vo)  throws Exception;
		
	//그룹리스트 출력
	public List<TrainingVO> selectGroupList(TrainingVO vo) throws Exception;
	
	//그룹리스트에 속한 훈련 검색
	public List<TrainingVO> selectTrainingListByGroupCode(TrainingVO vo)  throws Exception;
	
	public List<StatisticsVO> selectTrainingLogChart2(String ig_code) throws Exception;
	
	public List<StatisticsVO> selectTrainingLogListGrupByUser2(List<TrainingVO> list) throws Exception;
	public List<StatisticsVO> selectTrainingLogListGrupByDepartment2(List<TrainingVO> list) throws Exception;
	public List<StatisticsVO> selectTrainingGroupList(List<TrainingVO> list) throws Exception;
	

	/**그룹별 훈련통계**/
	public List<StatisticsVO> selectGroupStatisticalByGroup_code(List<StatisticsVO> list) throws Exception;
	
	public List<StatisticsVO> selectPhishingList(StatisticsVO vo) throws Exception;
	
	//매칭 유무 확인
	public TrainingVO selectMatchedTraininguser(TrainingVO vo) throws Exception;
	
	//템플릿 엑셀 리포트용
	public List<HashMap> selectTemplateExcelRoport(String training_code) throws Exception;
	
	//신고리스트 엑셀
	public List<HashMap> selectTrainingRegisterListExcel(String training_code) throws Exception;
	public List<HashMap> selectTrainingRegisterExceptReduplicationExcel(String training_code) throws Exception;
	
	//paging 추가한 리포트 검색
	public List<StatisticsVO> selectTrainingLogListByTriningCode(StatisticsVO vo) throws Exception;
	//한 훈련에 대한 전체 count
	public int selectTrainingLogListByTriningCodeCnt(String code) throws Exception;
	
}

