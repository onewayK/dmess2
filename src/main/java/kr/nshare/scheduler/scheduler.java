package kr.nshare.scheduler;

import java.util.List;

import kr.nshare.common.util.EgovProperties;
import kr.nshare.scheduler.service.SchedulerVO;
import kr.nshare.scheduler.service.impl.SchedulerService;
import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.impl.SystemService;
import kr.nshare.training.service.TrainingVO;
import kr.nshare.training.service.impl.TrainingService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

public class scheduler {

	private static final Logger log = LoggerFactory.getLogger(scheduler.class);
	
	@Autowired
	private SchedulerService schedulerImpl;
	
	@Autowired
	private SystemService systemImpl;
	
	@Autowired
	private TrainingService trainingImpl; 
	
	public void executeJob() throws Exception
    {
		
		
		if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1"))
		{
			//삭제 설정에 따라 자동 삭제 진행
			if(EgovProperties.getProperty("Globals.training.del.service").equals("1"))
			{
					
				SchedulerVO dvo = new SchedulerVO();			
			
				String auto_end_date = EgovProperties.getProperty("Globals.training.del.auto");
				String manual_end_date =  EgovProperties.getProperty("Globals.training.del.manual");
				
				dvo.setAuto_end_date(auto_end_date);
				dvo.setManual_end_date(manual_end_date);
				
				List<TrainingVO> t_list = schedulerImpl.selectDeleteTrainingListByService(dvo);
				
				if(t_list.size()>0)
				{
					for(TrainingVO tvo : t_list)
					{
						TrainingVO tvo2=new TrainingVO();
						SchedulerVO tvo3 = new SchedulerVO();		
						
						tvo2.setTraining_code(tvo.getCode());
					
						tvo3.setCode(tvo.getCode());
						tvo3.setDel_type("n");
						
						
						//훈련 삭제 루틴
						trainingImpl.deleteTrainingLogByCode(tvo.getCode());
						trainingImpl.deleteTrainingUserByCode(tvo.getCode());
						trainingImpl.deleteTrainingRegisterByCode(tvo.getCode());
						
						trainingImpl.deleteTrainingGrpByCdoe(tvo2);
						trainingImpl.deleteTraining2UserByCdoe(tvo2);
						
						//해당 훈련에 대한 삭제 플래그만 변경
						schedulerImpl.updateTrainingDelFlag(tvo3);
					}
				}
				
			}else{//삭제 정책에 따라 실제 삭제는안하고 관리자에게 알릴 수 있도록 del_flag를 r 타입으로 변경 
				
				SchedulerVO dvo = new SchedulerVO();			
				
				String auto_end_date = EgovProperties.getProperty("Globals.training.del.auto");
				String manual_end_date =  EgovProperties.getProperty("Globals.training.del.manual");
				
				dvo.setAuto_end_date(auto_end_date);
				dvo.setManual_end_date(manual_end_date);
				
				List<TrainingVO> t_list = schedulerImpl.selectDeleteTrainingListByService(dvo);
				
				if(t_list.size()>0)
				{
					for(TrainingVO tvo : t_list)
					{
						SchedulerVO tvo2 = new SchedulerVO();		
						
						tvo2.setDel_flag("r");
						tvo2.setCode(tvo.getCode());
						
						//해당 훈련에 대한 삭제 플래그만 변경(r : 로 변경)
						schedulerImpl.updateTrainingDelFlag(tvo2);
					}
						
				}
				
				
			}
			
			
			
			//훈련 서비스 설정 변경에 대한 로그 기록
			List<SystemVO> svo_list= schedulerImpl.selectServiceListNotinDate();
	    	
			if(null != svo_list || 0 < svo_list.size()){
				
				for(SystemVO temp_vo :  svo_list){
					
					temp_vo.setComment("훈련 서비스 설정 기간 만료로 인한 미사용 설정(스케쥴러)");		
					temp_vo.setService_code(temp_vo.getCode());
					temp_vo.setCreate_user("scheduler");
					
					systemImpl.insertServiceSettingLog(temp_vo);
				}
				
			}
			
			//기간이 지난 모든 훈련 서비스 설정 N으로 초기화
			schedulerImpl.updateServiceUseStatus();
		}
    }
}
