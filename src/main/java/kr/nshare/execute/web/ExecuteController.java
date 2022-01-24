package kr.nshare.execute.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.nshare.common.UserInfoVO;
import kr.nshare.common.pageVO;
import kr.nshare.common.util.EgovProperties;
import kr.nshare.common.util.SessionUtil;
import kr.nshare.common.util.commonUtil;
import kr.nshare.execute.service.impl.ExcuteService;
import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.impl.SystemService;
import kr.nshare.training.service.TrainingVO;
import kr.nshare.training.service.impl.TrainingService;

import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ExecuteController {
	private static final Logger logger = LoggerFactory.getLogger(ExecuteController.class);
	
	@Autowired
	private TrainingService trainingImpl;
	
	@Autowired
	private ExcuteService excuteImpl; 
	
	@Autowired
	private SystemService systemImpl;
	
	/**
	 * 훈려실행
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/execute/TrainingExcuteList.do")
	public String TrainingExcuteList(
			Locale locale
			, @ModelAttribute("searchVO") TrainingVO searchVO 
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
				
				List<HashMap> group_merge_list = null;		
				
				/**
				 * 게시물 전체 데이터 추출
				 */
				int total = excuteImpl.selectExcuteListCnt(searchVO);
				
				/**
				 * page 처리 위한 데이터
				 */
				pageVO pagevo = new pageVO();
				pagevo.setPageNo(searchVO.getPageNo());
				pagevo.setTotalCount(total); // 게시물 총 개수
				searchVO.setStartRowNum(pagevo.getStartRowNum());
				searchVO.setPageSize(pagevo.getPageSize());
				
				
				/**
				 * page처리 기반으로 실제 가져올 데이터 추출
				 */
				
				List<TrainingVO> list  = excuteImpl.selectExcuteList(searchVO);
				
				//기관 리스트 출력
				List<TrainingVO> list2  = trainingImpl.selectMemberInstitutionList(searchVO);
			
				//row수 취합
				List<TrainingVO> summaryList = excuteImpl.selectExcuteGroupSummary(searchVO); 
				
				
				model.addAttribute("summaryList", summaryList);
				model.addAttribute("pageing", pagevo);
				model.addAttribute("list",list);
				model.addAttribute("list2",list2);
				
				return "training/traingExcuteList";
		}
	
	
	
	/**
	 * 훈련 상태값 변경
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/execute/ajax_excuteTraining.do")
	@ResponseBody 
	public ResponseEntity  ajax_excuteTraining(HttpServletRequest request,ModelMap model) throws Exception{
		
		HttpHeaders responseHeaders = new HttpHeaders();
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
		HashMap hm = new HashMap();
		
		String code = request.getParameter("code");
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		
		//Training값 추출
		TrainingVO vo = trainingImpl.selectTrainingByCode(code);
		
		//asp 서비스
		if(EgovProperties.getProperty("Globals.service_type").equals("0"))
		{
			//훈련 서비스 설정이 활성화인 경우
			if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1"))
			{				
				if("admin".equals(userInfo.getLev()) ||  vo.getService_setting_code().equals(userInfo.getService_setting_code())){ //해당 훈련에 등록된 서비스 코드와 해당 계정 서비스 코드가 같은지 확인
				
					if("Y".equals(userInfo.getService_use())){
						
						SystemVO service_info = systemImpl.selectServiceByCode(vo.getService_setting_code());
						service_info.setService_setting_code(service_info.getCode());
						
						//훈련 설정서비스 날짜 체크 
						if( 
								(
									Long.parseLong(service_info.getStart_date().replaceAll("-", "").replaceAll(" ", ""))<=Long.parseLong(commonUtil.getNowDateString_yyyyMMdd().toString()) 
									&& 
									Long.parseLong(service_info.getEnd_date().replaceAll("-", "").replaceAll(" ", ""))>=Long.parseLong(commonUtil.getNowDateString_yyyyMMdd().toString())
								)
						)
						{
							//이미 진행되었던 훈련 인원들을 합쳐서 가져옴(중복 체크함)
							List<SystemVO> trainingrInfo_list= systemImpl.selectTrainingUserCntByServiceSettingCode(service_info);
							
							//실행한 훈련 코드값 삽입
							service_info.setTraining_code(vo.getCode());
							
							//실행한 훈련에 등록한 훈련 인원과 이미 진행되었던 훈련 인원들을 합쳐서 가져옴(중복 체크함)
							List<SystemVO> trainingrInfo_list2 = systemImpl.selectTrainingUserCntByServiceSettingCode(service_info);
							
							int pre_sended_number=0; //발송전 인원 수 
							
							int sended_number = 0; // 현재 실행한 훈련을 포함한 발송 인원 총 인원 수
							
							int setting_send_number=0; //훈련 선비스에 설정된 인원 수
							
							//훈련 서비스에 설정된 최대 발송인원 조회
							if("test".equals(vo.getService_type()) ){
								setting_send_number= Integer.parseInt(service_info.getTest_send_number());
							}else if("real".equals(vo.getService_type())){
								setting_send_number= Integer.parseInt(service_info.getReal_send_number());
							}
							
							//훈련 발송 전 인원 수 조회
							for(SystemVO tmp_vo: trainingrInfo_list){							
								if("test".equals(vo.getService_type()) && "test".equals(tmp_vo.getService_type())){
									pre_sended_number = Integer.parseInt(tmp_vo.getSended_user_cnt());
								}else if("real".equals(vo.getService_type()) && "real".equals(tmp_vo.getService_type())){
									pre_sended_number = Integer.parseInt(tmp_vo.getSended_user_cnt());
								}				
							}
							
							//발 송 후 인원 수 
							for(SystemVO tmp_vo: trainingrInfo_list2){							
								if("test".equals(vo.getService_type()) && "test".equals(tmp_vo.getService_type())){
									sended_number = Integer.parseInt(tmp_vo.getSended_user_cnt());
								}else if("real".equals(vo.getService_type()) && "real".equals(tmp_vo.getService_type())){
									sended_number = Integer.parseInt(tmp_vo.getSended_user_cnt());
								}				
							}
							
							//훈련 인원 체크하여 발송해도 되는지 확인
							if(sended_number <=  setting_send_number){
								
								//발송 인원이 0일 경우
								if("0".equals(vo.getSend_number()) &&  "N".equals(vo.getAll_send_type())){
									String errMessage = "발송할 인원이 없습니다.\n다시 설정해주세요.";
									hm.put("status", errMessage);
									hmlist.add(hm);
								}else{
									//훈련 로그 생성
									if(null != vo.getAll_send_type() && !("100".equals(vo.getSend_percent())) &&  "N".equals(vo.getAll_send_type())){
										excuteImpl.insertTrainingUserLogExcute(vo);
										
										excuteImpl.insertTrainingUserLogExcuteEXcetp(vo);
									}else{
										excuteImpl.insertTrainingUserLogExcute(vo);
									}
									
									if("Y".equals(vo.getReservation_type())){
										vo.setStatus("reservation");
									}else{
										vo.setStatus("send");
									}
									
									excuteImpl.updateTrainingStatus(vo);
									
									
									systemImpl.insertServiceSettingLogByExecute(vo,sended_number -pre_sended_number);
									
									hm.put("status", "success");
									hmlist.add(hm);
								}
							}else{
								String errMessage ="발송 가능한 훈련 인원이 "+(sended_number-setting_send_number) +"명 초과되었습니다.\n상단의 발송 가능한 인원을 다시 확인해주세요 ";
								hm.put("status", errMessage);
								hmlist.add(hm);	
							}				
							
						}else{
							String errMessage ="현재 훈련 서비스 기간이 아닙니다.\n관리자에게 문의해주세요";
							hm.put("status", errMessage);
							hmlist.add(hm);	
						}
						
					}else if("admin".equals(userInfo.getLev())){// 권한이 admin 일 경우 
						int userCnt = 0;
						
						//훈련대상자수 추출
						List<TrainingVO> list = trainingImpl.selectTrainingUserByCode(code);
						userCnt = list.size();
						
						//발송 인원이 0일 경우
						if("0".equals(vo.getSend_number()) &&  "N".equals(vo.getAll_send_type())){
							String errMessage = "발송할 인원이 없습니다.\n다시 설정해주세요.";
							hm.put("status", errMessage);
							hmlist.add(hm);
						}else{
							//훈련 로그 생성
							if(null != vo.getAll_send_type() && !("100".equals(vo.getSend_percent())) &&  "N".equals(vo.getAll_send_type())){
								excuteImpl.insertTrainingUserLogExcute(vo);
								
								excuteImpl.insertTrainingUserLogExcuteEXcetp(vo);
							}else{
								excuteImpl.insertTrainingUserLogExcute(vo);
							}
							
							if("Y".equals(vo.getReservation_type())){
								vo.setStatus("reservation");
							}else{
								vo.setStatus("send");
							}
							
							excuteImpl.updateTrainingStatus(vo);
							
							
							systemImpl.insertServiceSettingLogByExecute(vo,userCnt); 
							
							hm.put("status", "success");
							hmlist.add(hm);				
						}
						
					}else{
						
						String errMessage ="사용중인 훈련 서비스 설정이 없습니다..\n 관리자에게 문의해주세요";
						hm.put("status", errMessage);
						hmlist.add(hm);	
					}
				
				}else{
					String errMessage ="해당 훈련은 현재 서비스에 등록된 훈련이 아닙니다..\n해당 훈련을 수정하시거나 새로 생성해주세요";
					hm.put("status", errMessage);
					hmlist.add(hm);	
				}
			}else{ //asp에서 훈련 서비스 설정 서비스를 사용하지 않을 경우 술루션 진행이랑 동일하게 함
				
				//발송 인원이 0일 경우
				if("0".equals(vo.getSend_number()) &&  "N".equals(vo.getAll_send_type())){
					String errMessage = "발송할 인원이 없습니다.\n다시 설정해주세요.";
					hm.put("status", errMessage);
					hmlist.add(hm);
				}else{
					//훈련 로그 생성
					if(null != vo.getAll_send_type() && !("100".equals(vo.getSend_percent())) &&  "N".equals(vo.getAll_send_type())){
						excuteImpl.insertTrainingUserLogExcute(vo);
						
						excuteImpl.insertTrainingUserLogExcuteEXcetp(vo);
					}else{
						excuteImpl.insertTrainingUserLogExcute(vo);
					}
					
					if("Y".equals(vo.getReservation_type())){
						vo.setStatus("reservation");
					}else{
						vo.setStatus("send");
					}
					
					excuteImpl.updateTrainingStatus(vo);
					
					hm.put("status", "success");
					hmlist.add(hm);
				}
			}
			
			
			/*
				//과금에 대한 소스 코드
				SystemVO memberInfo = systemImpl.selectMemberByCode(userInfo.getCode());
				
				int userPaycnt = Integer.parseInt(memberInfo.getPaycnt());
				
				if(!"".equals(code) && userPaycnt > 0)
				{	
					int userCnt = 0;
					int total_paycnt = 0;
					
					//과금정책 추출
					double billingRule = Double.parseDouble(EgovProperties.getProperty("Globals.training.billing.rule"));
					
					//훈련대상자수 추출
					List<TrainingVO> list = trainingImpl.selectTrainingUserByCode(code);
					userCnt = list.size();
					
					//정책에 따른 과금 계산
					int bill = (int)Math.ceil(userCnt/billingRule);
					
					if(.0userPaycnt >= bill)
					{
						
						//훈련 로그 생성
						if("N".equals(vo.getAll_send_type())){
							excuteImpl.insertTrainingUserLogExcute(vo);
							excuteImpl.insertTrainingUserLogExcuteEXcetp(vo);
						}else{
							excuteImpl.insertTrainingUserLogExcute(vo);
						}
						
						if("Y".equals(vo.getReservation_type())){
							vo.setStatus("reservation");
						}else{
							vo.setStatus("send");
						}
						
						excuteImpl.updateTrainingStatus(vo);
						
						//bill수에 맞게 과금 실행
						total_paycnt = userPaycnt - bill;
						memberInfo.setPaycnt(String.valueOf(total_paycnt));
						memberInfo.setNow_count(String.valueOf(bill));
						memberInfo.setType("minus");
						memberInfo.setTraining_code(code);
						memberInfo.setComment(vo.getTname()+"("+vo.getCode()+") 의 훈련을 생성하였습니다.");
						
						systemImpl.insertPayment(memberInfo);
						
						systemImpl.updatePayCntMember(memberInfo);
						
						hm.put("status", "success");
						hmlist.add(hm);
					}
					else
					{
						String errMessage = "훈련을 실행하기에 보유하신 과금이 부족합니다.\n과금을 충전하세요.\n" + memberInfo.getName() + "님의 현재 보유하신 과금 : " + userPaycnt + "\n현재 훈련에 필요한 과금 : " + bill;
						hm.put("status", errMessage);
						hmlist.add(hm);	
					}
					
				}
				else
				{			
					String errMessage = "과금이 없습니다.\n관리자에게 문의하세요.";
					hm.put("status", errMessage);
					hmlist.add(hm);
				}
			*/
		//솔루션(과금 미적용)
		}else if(EgovProperties.getProperty("Globals.service_type").equals("1")){
			
			//발송 인원이 0일 경우
			if("0".equals(vo.getSend_number()) &&  "N".equals(vo.getAll_send_type())){
				String errMessage = "발송할 인원이 없습니다.\n다시 설정해주세요.";
				hm.put("status", errMessage);
				hmlist.add(hm);
			}else{
				//훈련 로그 생성
				if(null != vo.getAll_send_type() && !("100".equals(vo.getSend_percent())) &&  "N".equals(vo.getAll_send_type())){
					excuteImpl.insertTrainingUserLogExcute(vo);
					
					excuteImpl.insertTrainingUserLogExcuteEXcetp(vo);
				}else{
					excuteImpl.insertTrainingUserLogExcute(vo);
				}
				
				if("Y".equals(vo.getReservation_type())){
					vo.setStatus("reservation");
				}else{
					vo.setStatus("send");
				}
				
				excuteImpl.updateTrainingStatus(vo);
				
				hm.put("status", "success");
				hmlist.add(hm);
			}
		}		
		
		JSONArray json = new JSONArray(hmlist);
		return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
		
	}
	
	
	/**
	 * 훈련 일시정지
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/execute/ajax_stopTraining.do")
	@ResponseBody 
	public ResponseEntity  ajax_stopTraining(HttpServletRequest request,ModelMap model) throws Exception{
		
		HttpHeaders responseHeaders = new HttpHeaders();
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
		HashMap hm = new HashMap();
		
		String code = request.getParameter("code");
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		
		//Training값 추출
		TrainingVO vo = trainingImpl.selectTrainingByCode(code);
				
		vo.setStatus("stopping");
		excuteImpl.updateTrainingStatus(vo);
		
		hm.put("status", "success");
		hmlist.add(hm);
					
		JSONArray json = new JSONArray(hmlist);
		return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
		
	}
	
	/**
	 * 훈련 재시작
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/execute/ajax_reexcuteTraining.do")
	@ResponseBody 
	public ResponseEntity  ajax_reexcuteTraining(HttpServletRequest request,ModelMap model) throws Exception{
		
		HttpHeaders responseHeaders = new HttpHeaders();
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
		HashMap hm = new HashMap();
		
		String code = request.getParameter("code");
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		
		//Training값 추출
		TrainingVO vo = trainingImpl.selectTrainingByCode(code);
				
		vo.setStatus("resend");
		excuteImpl.updateTrainingStatus(vo);
		
		hm.put("status", "success");
		hmlist.add(hm);
					
		JSONArray json = new JSONArray(hmlist);
		return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
		
	}
	
	/**
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/execute/ajax_TrainingExcuteList.do")
	@ResponseBody 
	public ResponseEntity  ajax_dashboardl_group_ist(HttpServletRequest request,ModelMap model) throws Exception{
		
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		List<TrainingVO> list_temp = new ArrayList<TrainingVO>();
		
		String training_code_list = request.getParameter("training_code");
		
		
		for(int i=0;i<training_code_list.split("_").length;i++)
		{
			
			TrainingVO  tvo = new TrainingVO();
			tvo.setCode(training_code_list.split("_")[i]);
			list_temp.add(tvo);
		}
		
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
		List<TrainingVO> list = null;
		
		list = trainingImpl.selectAjaxExcuteTrainingStatusList(list_temp);
		
		
		for(TrainingVO vo2:list)
		{
			HashMap hm = new HashMap();
			
			
			hm.put("code",vo2.getCode());
			hm.put("status",vo2.getStatus());
			hm.put("progress", vo2.getProgress());
			if("reservation".equals(vo2.getStatus())){
				hm.put("reservation_date",vo2.getReservation_date());
			}
			
			hmlist.add(hm);
		}
		
		JSONArray json = new JSONArray(hmlist);
		return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
		
	}	
	
}
