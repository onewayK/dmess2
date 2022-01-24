package kr.nshare.statistics.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import kr.nshare.statistics.service.StatisticsVO;
import kr.nshare.training.service.TrainingRegisterVO;
import kr.nshare.training.service.TrainingVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("statisticsImpl")
public class StatisticsImpl implements StatisticsService{
	@Autowired
	private StatisticsDAO statisticsDAOService;

	@Override
	public List<StatisticsVO> selectTrainingListByInstatutionCode(String Instatitution_code) throws Exception {
		return statisticsDAOService.selectTrainingListByInstatutionCode(Instatitution_code);
	}

	@Override
	public List<StatisticsVO> selectTrainingLogListGrupByUser(
			String training_code) throws Exception {
		return statisticsDAOService.selectTrainingLogListGrupByUser(training_code);
	}





	@Override
	public List<StatisticsVO> selectTrainingLogListGrupByDepartment(
			String training_code) throws Exception {
		// TODO Auto-generated method stub
		return statisticsDAOService.selectTrainingLogListGrupByDepartment(training_code);
	}





	@Override
	public StatisticsVO selectTrainingLogChart(List<StatisticsVO> list)
			throws Exception {
		// TODO Auto-generated method stub
		return statisticsDAOService.selectTrainingLogChart(list);
	}
	
	@Override
	public List<StatisticsVO> selectTrainingLogChartReport(List<StatisticsVO> list) throws Exception {
		// TODO Auto-generated method stub
		List<StatisticsVO> training_result_list = new ArrayList<StatisticsVO>();

		for (int i = 0; i < list.size(); i++) {
			
			StatisticsVO sv = statisticsDAOService.selectTrainingLogChartReport(list.get(i).getCode());
			
			training_result_list.add(sv);
		}
		
		return training_result_list;
	}
	
	@Override
	public List<HashMap> selectTrainingLogChartReportExcel(String[] list) throws Exception {
		// TODO Auto-generated method stub
		List<HashMap> training_result_list = new ArrayList<HashMap>();

		for (int i = 0; i < list.length; i++) {
			
			HashMap sv = statisticsDAOService.selectTrainingLogChartReportExcel(list[i]);
			sv.put("code", i+1);
			
			String status="";
					
			status =	sv.get("status").toString();
			
			if("ready".equals(status)){
				status="준비";
			}else 	if("ready".equals(status)){
				status="준비";
			}else 	if("sending".equals(status) || "send".equals(status) || "receive".equals(status) ){
				status="발송중";
			}else 	if("step1".equals(status)){
				status="step1";
			}else 	if("end".equals(status)){
				status="발송완료";
			}else 	if("stopping".equals(status)){
				status="발송중지중";
			}else 	if("stop".equals(status)){
				status="발송중지";
			}else 	if("resend".equals(status)){
				status="재준비중";
			}else 	if("init".equals(status)){
				status="초기화중";
			}else 	if("approval".equals(status)){
				status="승인요청중";
			}else 	if("reservation".equals(status)){
				status="진행대기중";
			}else {
				status="-";
			}		
			
			sv.put("status", status);
			
			training_result_list.add(sv);
		}
		
		//전체 훈련 합계
		HashMap total= statisticsDAOService.selectTrainingLogChartReportTotalEXcel(Arrays.asList(list));
		
		total.put("group_name", "__gray__");
		total.put("code", "__gray__");
		total.put("institution_name", "__gray__");
		total.put("tname", "__gray__");
		total.put("status", "합 계");
		
		training_result_list.add(total);
		
		return training_result_list;
	}
	
	@Override
	public StatisticsVO selectTrainingLogChartReportTotal(List<String> list)	throws Exception {
		// TODO Auto-generated method stub
		return statisticsDAOService.selectTrainingLogChartReportTotal(list);
	}
	
	@Override
	public HashMap selectTrainingLogChartReportTotalEXcel(List<String> list)	throws Exception {
		// TODO Auto-generated method stub
		return statisticsDAOService.selectTrainingLogChartReportTotalEXcel(list);
	}
	
	@Override
	public List<HashMap> selectTrainingLogListGrupByUserExcel(
			String training_code) throws Exception {
		// TODO Auto-generated method stub
		return statisticsDAOService.selectTrainingLogListGrupByUserExcel(training_code);
	}

	@Override
	public List<HashMap> selectTrainingLogListGrupByDepartmentExcel(
			String training_code) throws Exception {
		// TODO Auto-generated method stub
		return statisticsDAOService.selectTrainingLogListGrupByDepartmentExcel(training_code);
	}

	@Override
	public StatisticsVO selectTrainingLogListGrupByUserSum(String training_code) throws Exception {
		return statisticsDAOService.selectTrainingLogListGrupByUserSum(training_code);
	}

	@Override
	public List<TrainingRegisterVO> selectTrainingRegisterList(TrainingRegisterVO vo) throws Exception {
		return statisticsDAOService.selectTrainingRegisterList(vo);
	}


	@Override
	public int selectTrainingRegisterListCnt(TrainingRegisterVO vo)throws Exception {
		return statisticsDAOService.selectTrainingRegisterListCnt(vo);
	}
	
	@Override
	public int selectTrainingRegisterListCntExceptReduplication(TrainingRegisterVO vo)throws Exception {
		return statisticsDAOService.selectTrainingRegisterListCntExceptReduplication(vo);
	}
	
	@Override
	public List<TrainingRegisterVO> selectTrainingRegisterExceptReduplication(TrainingRegisterVO vo) throws Exception {
		return statisticsDAOService.selectTrainingRegisterExceptReduplication(vo);
	}



	@Override
	public List<TrainingVO> selectGroupList(TrainingVO vo) throws Exception {
		return statisticsDAOService.selectGroupList(vo);
	}





	@Override
	public List<TrainingVO> selectTrainingListByGroupCode(TrainingVO vo)
			throws Exception {
		return statisticsDAOService.selectTrainingListByGroupCode(vo);
	}





	@Override
	public List<StatisticsVO> selectTrainingLogChart2(String ig_code) throws Exception {
		return statisticsDAOService.selectTrainingLogChart2(ig_code);
	}

	@Override
	public List<StatisticsVO> selectTrainingLogListGrupByUser2(String[] training_code_list) throws Exception {
		
		List<TrainingVO> list_temp = new ArrayList<TrainingVO>(); 
		
		for(int i=0;i<training_code_list.length;i++)
		{
			
			TrainingVO  tvo = new TrainingVO();
			tvo.setCode(training_code_list[i]);
			list_temp.add(tvo);
		}
		
		return statisticsDAOService.selectTrainingLogListGrupByUser2(list_temp);
	}





	@Override
	public List<StatisticsVO> selectTrainingLogListGrupByDepartment2(String[] training_code_list) throws Exception {
		
		List<TrainingVO> list_temp = new ArrayList<TrainingVO>(); 
		
		for(int i=0;i<training_code_list.length;i++)
		{
			
			TrainingVO  tvo = new TrainingVO();
			tvo.setCode(training_code_list[i]);
			list_temp.add(tvo);
		}
		return statisticsDAOService.selectTrainingLogListGrupByDepartment2(list_temp);
	}

	@Override
	public List<StatisticsVO> selectTrainingGroupList(String[] training_code_list) throws Exception {
		
		List<TrainingVO> list_temp = new ArrayList<TrainingVO>(); 
		
		for(int i=0;i<training_code_list.length;i++)
		{
			
			TrainingVO  tvo = new TrainingVO();
			tvo.setCode(training_code_list[i]);
			list_temp.add(tvo);
		}
		return statisticsDAOService.selectTrainingGroupList(list_temp);
	}


	@Override
	public List<StatisticsVO> selectGroupStatisticalByGroup_code(List<StatisticsVO> list) throws Exception {

		return statisticsDAOService.selectGroupStatisticalByGroup_code(list);
	}
	
	@Override
	public List<StatisticsVO> selectPhishingList(StatisticsVO vo) throws Exception {

		return statisticsDAOService.selectPhishingList(vo);
	}
	
	@Override
	public TrainingVO selectMatchedTraininguser(TrainingVO vo) throws Exception {
		return statisticsDAOService.selectMatchedTraininguser(vo);
	}
	
	@Override
	public List<HashMap> selectTemplateExcelRoport(String training_code)
			throws Exception {
		// TODO Auto-generated method stub
		return statisticsDAOService.selectTemplateExcelRoport(training_code);
	}
	
	@Override
	public List<HashMap> selectTrainingRegisterListExcel(String training_code) throws Exception {
		// TODO Auto-generated method stub
		return statisticsDAOService.selectTrainingRegisterListExcel(training_code);
	}
	
	@Override
	public List<HashMap> selectTrainingRegisterExceptReduplicationExcel(String training_code) throws Exception {
		// TODO Auto-generated method stub
		return statisticsDAOService.selectTrainingRegisterExceptReduplicationExcel(training_code);
	}
	
	@Override
	public int selectTrainingLogListByTriningCodeCnt(String code) throws Exception {
		
		return statisticsDAOService.selectTrainingLogListByTriningCodeCnt(code);
	}
	
	@Override
	public List<StatisticsVO> selectTrainingLogListByTriningCode(StatisticsVO vo) throws Exception {
		
		return statisticsDAOService.selectTrainingLogListByTriningCode(vo);
	}
}
