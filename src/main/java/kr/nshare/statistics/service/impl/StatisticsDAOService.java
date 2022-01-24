package kr.nshare.statistics.service.impl;

import java.util.HashMap;
import java.util.List;

import kr.nshare.common.AbstractDAO;
import kr.nshare.statistics.service.StatisticsVO;
import kr.nshare.statistics.service.mapper.StatisticsMapper;
import kr.nshare.training.service.TrainingRegisterVO;
import kr.nshare.training.service.TrainingVO;

import org.springframework.stereotype.Service;

@Service("statisticsDAOService")
public class StatisticsDAOService extends AbstractDAO implements StatisticsDAO 
{
	@Override
	public List<StatisticsVO> selectTrainingListByInstatutionCode(
			String Instatitution_code) throws Exception {
		// TODO Auto-generated method stub
		
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingListByInstatutionCode(Instatitution_code);
	}

	@Override
	public List<StatisticsVO> selectTrainingLogListGrupByUser(
			String training_code) throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingLogListGrupByUser(training_code);
	}

	@Override
	public List<StatisticsVO> selectTrainingLogListGrupByDepartment(
			String training_code) throws Exception {
		// TODO Auto-generated method stub
			StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
			return mapper.selectTrainingLogListGrupByDepartment(training_code);
	}

	@Override
	public StatisticsVO selectTrainingLogChart(List<StatisticsVO> list)
			throws Exception {
		// TODO Auto-generated method stub
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingLogChart(list);
	}
	
	@Override
	public HashMap selectTrainingLogChartReportTotalEXcel(List<String> list)
			throws Exception {
		// TODO Auto-generated method stub
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingLogChartReportTotalEXcel(list);
	}
	
	@Override
	public StatisticsVO selectTrainingLogChartReportTotal(List<String> list)
			throws Exception {
		// TODO Auto-generated method stub
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingLogChartReportTotal(list);
	}
	
	@Override
	public HashMap selectTrainingLogChartReportExcel(String code) throws Exception {
		// TODO Auto-generated method stub
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingLogChartReportExcel(code);
	}
	
	@Override
	public StatisticsVO selectTrainingLogChartReport(String code) throws Exception {
		// TODO Auto-generated method stub
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingLogChartReport(code);
	}

	@Override
	public List<HashMap> selectTrainingLogListGrupByUserExcel(String training_code) throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingLogListGrupByUserExcel(training_code);
	}

	@Override
	public List<HashMap> selectTrainingLogListGrupByDepartmentExcel(String training_code) throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingLogListGrupByDepartmentExcel(training_code);
		
	}

	@Override
	public StatisticsVO selectTrainingLogListGrupByUserSum(String training_code) throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingLogListGrupByUserSum(training_code);
	}

	@Override
	public List<TrainingRegisterVO> selectTrainingRegisterList(TrainingRegisterVO vo) throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingRegisterList(vo);
	}

	@Override
	public int selectTrainingRegisterListCnt(TrainingRegisterVO vo)throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingRegisterListCnt(vo);
	}
	
	@Override
	public int selectTrainingRegisterListCntExceptReduplication(TrainingRegisterVO vo)throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingRegisterListCntExceptReduplication(vo);
	}
	
	@Override
	public List<TrainingRegisterVO> selectTrainingRegisterExceptReduplication(TrainingRegisterVO vo) throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingRegisterExceptReduplication(vo);
	}
	
	@Override
	public List<TrainingVO> selectGroupList(TrainingVO vo) throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectGroupList(vo);
	}

	@Override
	public List<TrainingVO> selectTrainingListByGroupCode(TrainingVO vo)
			throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingListByGroupCode(vo);
	}

	@Override
	public List<StatisticsVO> selectTrainingLogChart2(String ig_code)
			throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingLogChart2(ig_code);
	}

	@Override
	public List<StatisticsVO> selectTrainingLogListGrupByUser2(List<TrainingVO> training_code_list) throws Exception {
		
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingLogListGrupByUser2(training_code_list);
	}

	@Override
	public List<StatisticsVO> selectTrainingLogListGrupByDepartment2(List<TrainingVO> training_code_list) throws Exception {
		
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingLogListGrupByDepartment2(training_code_list);
	}

	@Override
	public List<StatisticsVO> selectTrainingGroupList(List<TrainingVO> list) throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingGroupList(list);
	}

	@Override
	public List<StatisticsVO> selectGroupStatisticalByGroup_code(
			List<StatisticsVO> list) throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectGroupStatisticalByGroup_code(list);
	}
	
	@Override
	public List<StatisticsVO> selectPhishingList(StatisticsVO vo) throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectPhishingList(vo);
	}
	
	@Override
	public TrainingVO selectMatchedTraininguser(TrainingVO vo)
			throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectMatchedTraininguser(vo);
	}
	
	@Override
	public List<HashMap> selectTemplateExcelRoport(String training_code)
			throws Exception {
		// TODO Auto-generated method stub
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTemplateExcelRoport(training_code);
	}
	
	@Override
	public List<HashMap> selectTrainingRegisterListExcel(String training_code) throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingRegisterListExcel(training_code);
	}
	
	@Override
	public List<HashMap> selectTrainingRegisterExceptReduplicationExcel(String training_code) throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingRegisterExceptReduplicationExcel(training_code);
	}
	
	@Override
	public List<StatisticsVO> selectTrainingLogListByTriningCode(StatisticsVO vo) throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingLogListByTriningCode(vo);
	}
	
	@Override
	public int selectTrainingLogListByTriningCodeCnt(String code) throws Exception {
		StatisticsMapper mapper = sqlSession.getMapper(StatisticsMapper.class);
		return mapper.selectTrainingLogListByTriningCodeCnt(code);
	}
}
