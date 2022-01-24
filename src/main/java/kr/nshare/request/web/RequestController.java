package kr.nshare.request.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.nshare.common.UserInfoVO;
import kr.nshare.common.util.EgovProperties;
import kr.nshare.common.util.SessionUtil;
import kr.nshare.common.util.commonUtil;
import kr.nshare.common.util.urlUtil;
import kr.nshare.request.service.RequestVO;
import kr.nshare.request.service.impl.RequestService;
import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.impl.SystemService;
import kr.nshare.training.service.TrainingLogVO;
import kr.nshare.training.service.TrainingRegisterVO;
import kr.nshare.training.service.TrainingVO;
import kr.nshare.training.service.impl.TrainingService;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 신고 정보 수집
 * @author impro
 *
 */
@Controller
public class RequestController {
	private static final Logger log = LoggerFactory.getLogger(RequestController.class);
	@Autowired
	private TrainingService trainingImpl;
	
	@Autowired
	private SystemService systemImpl;
	
	@Autowired
	private RequestService requestImpl;
	
	@RequestMapping(value={"/request/data.do"}) 
	public String requeset_data(
			Locale locale
			, @ModelAttribute("searchVO") RequestVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			
			TrainingLogVO trainingLogVo = new TrainingLogVO();
			urlUtil uu = new urlUtil();
			
			//referer정보
			String referer 	= req.getHeader("referer");
			String ip 		= req.getRemoteAddr();
			//ip정보
			
			//base64 => 평문으로
			trainingLogVo.setTraining_code(uu.base64Decode(searchVO.getT()));
			trainingLogVo.setTraining_user_code(uu.base64Decode(searchVO.getU()));
			trainingLogVo.setType(searchVO.getType());
			
			Date d = new Date();
			String date = commonUtil.getDateString2(d);
			
			
			//훈련 코드 호출
			TrainingVO tvo = trainingImpl.selectTrainingByCode(trainingLogVo.getTraining_code());
			TrainingLogVO tl = trainingImpl.selectTrainingLog(trainingLogVo);
			
			System.out.println("################################################");
			System.out.println(tvo.getStart_date());
			System.out.println(tvo.getEnd_date());
			System.out.println(tvo.getType());
			System.out.println("################################################");
			
		
			//해당 정보 수신은 훈련 기간내의 정보만 수신한다.
			//http://localhost:8080/request/data.do?type=type2&t=NzU=&u=NTI2Mw==
			if(
					Long.parseLong(tvo.getStart_date().replaceAll("-", "").replaceAll(" ", "").replaceAll(":", ""))<=Long.parseLong(commonUtil.getNowDatetimeString().toString()) 
					&& 
					Long.parseLong(tvo.getEnd_date().replaceAll("-", "").replaceAll(" ", "").replaceAll(":", ""))>=Long.parseLong(commonUtil.getNowDatetimeString().toString())
					)
			{
				
				
				if("0".equals(tvo.getType()))
				{
						//읽었는지 체크
						if(searchVO.getType().equals("type1") && tvo.getTraining_type1().equals("Y"))
						{
							
							String type_cnt = tl.getType1_use();
							String type_date_all = tl.getType1_date_all();
							
							
							
							
							if(type_cnt.equals("") || type_cnt ==null)
							{
								type_cnt = "1";
								type_date_all = date;
								
								trainingLogVo.setType1_date(date);
							}
							else
							{
								type_cnt = String.valueOf(Integer.valueOf(type_cnt)+1);
								type_date_all = type_date_all + "##"+date;
								
								trainingLogVo.setType1_date(tl.getType1_date());
							}
							
							trainingLogVo.setType1_use(type_cnt);
							trainingLogVo.setType1_ip(ip);
							trainingLogVo.setType1_referer(referer);
							trainingLogVo.setType1_info("");
							
							trainingLogVo.setType1_date_all(type_date_all);
							trainingImpl.updateTrainingLog(trainingLogVo);
						}
						//링크 실행 여부 확인
						else if(searchVO.getType().equals("type2") && tvo.getTraining_type2().equals("Y"))
						{
							String type_cnt = tl.getType2_use();
							String type_date_all = tl.getType2_date_all();
							if(type_cnt.equals("") || type_cnt ==null)
							{
								type_cnt = "1";
								type_date_all = date;
								
								trainingLogVo.setType2_date(date);
							}
							else
							{
								type_cnt = String.valueOf(Integer.valueOf(type_cnt)+1);
								type_date_all = type_date_all + "##"+date;
								
								trainingLogVo.setType2_date(tl.getType2_date());
							}
							trainingLogVo.setType2_use(type_cnt);
							trainingLogVo.setType2_ip(ip);
							trainingLogVo.setType2_referer(referer);
							trainingLogVo.setType2_info("");
							
							trainingLogVo.setType2_date_all(type_date_all);
							
							trainingImpl.updateTrainingLog(trainingLogVo);
							
							//링크 부분은 완료후 link내용 페이지로 이동 처리함.
							
							return "redirect:/request/linkview.do?t="+searchVO.getT()+"&u="+searchVO.getU();
							
							
						}
						//파일 실행 여부 확인
						else if(searchVO.getType().equals("type3") && tvo.getTraining_type3().equals("Y"))
						{
							String type_cnt = tl.getType3_use();
							String type_date_all = tl.getType3_date_all();
							if(type_cnt.equals("") || type_cnt ==null)
							{
								type_cnt = "1";
								type_date_all = date;
								
								trainingLogVo.setType3_date(date);
							}
							else
							{
								type_cnt = String.valueOf(Integer.valueOf(type_cnt)+1);
								type_date_all = type_date_all + "##"+date;
								
								trainingLogVo.setType3_date(tl.getType3_date());
							}
							trainingLogVo.setType3_use(type_cnt);
							trainingLogVo.setType3_ip(ip);
							trainingLogVo.setType3_referer(referer);
							trainingLogVo.setType3_info("");
							trainingLogVo.setType3_date_all(type_date_all);
							
							trainingImpl.updateTrainingLog(trainingLogVo);
					}
					
						
					if(searchVO.getType().equals("type2") && tvo.getTraining_type2().equals("Y"))
					{
						return "redirect:/request/linkview.do?t="+searchVO.getT();
					}
					
					
					
				}
				else if("1".equals(tvo.getType()))
				{
					//사용자정보 추출
					
					//사용자 정보코드
					String u = uu.base64Decode(searchVO.getU());
					String t = uu.base64Decode(searchVO.getT());
					
					TrainingVO training2vo = new TrainingVO();
					
					training2vo.setTraining_code(t);
					training2vo.setTraining_user_code(u);

					TrainingVO training2Info = requestImpl.selectTraining2UserTrainingInfo(training2vo);
					
					//읽었는지 체크
					if(searchVO.getType().equals("type1") && training2Info.getTraining_type1().equals("Y"))
					{
						String type_cnt = tl.getType1_use();
						String type_date_all = tl.getType1_date_all();
						
						if(type_cnt.equals("") || type_cnt ==null)
						{
							type_cnt = "1";
							type_date_all = date;
						
							trainingLogVo.setType1_date(date);
						}
						else
						{
							type_cnt = String.valueOf(Integer.valueOf(type_cnt)+1);
							type_date_all = type_date_all + "##"+date;
							
							trainingLogVo.setType1_date(tl.getType1_date());
						}
						trainingLogVo.setType1_use(type_cnt);
						trainingLogVo.setType1_ip(ip);
						trainingLogVo.setType1_referer(referer);
						trainingLogVo.setType1_info("");
						trainingLogVo.setType1_date_all(type_date_all);
						trainingImpl.updateTrainingLog(trainingLogVo);
					
					}
					else if(searchVO.getType().equals("type2") && training2Info.getTraining_type2().equals("Y"))
					{
						
						String type_cnt = tl.getType2_use();
						String type_date_all = tl.getType2_date_all();
						if(type_cnt.equals("") || type_cnt ==null)
						{
							type_cnt = "1";
							type_date_all = date;
							
							trainingLogVo.setType2_date(date);
						}
						else
						{
							type_cnt = String.valueOf(Integer.valueOf(type_cnt)+1);
							type_date_all = type_date_all + "##"+date;
							
							trainingLogVo.setType2_date(tl.getType2_date());
						}
						trainingLogVo.setType2_use(type_cnt);
						trainingLogVo.setType2_ip(ip);
						trainingLogVo.setType2_referer(referer);
						trainingLogVo.setType2_info("");
						
						trainingLogVo.setType2_date_all(type_date_all);
						
						trainingImpl.updateTrainingLog(trainingLogVo);
						
						//링크 부분은 완료후 link내용 페이지로 이동 처리함.
						
						
						System.out.println("==================>");
						
						return "redirect:/request/linkview.do?t="+searchVO.getT()+"&u="+searchVO.getU();
						
						
					}
					//파일 실행 여부 확인
					else if(searchVO.getType().equals("type3") && training2Info.getTraining_type3().equals("Y"))
					{
						String type_cnt = tl.getType3_use();
						String type_date_all = tl.getType3_date_all();
						if(type_cnt.equals("") || type_cnt ==null)
						{
							type_cnt = "1";
							type_date_all = date;
							
							trainingLogVo.setType3_date(date);
						}
						else
						{
							type_cnt = String.valueOf(Integer.valueOf(type_cnt)+1);
							type_date_all = type_date_all + "##"+date;
							
							trainingLogVo.setType3_date(tl.getType3_date());
						}
						trainingLogVo.setType3_use(type_cnt);
						trainingLogVo.setType3_ip(ip);
						trainingLogVo.setType3_referer(referer);
						trainingLogVo.setType3_info("");
						trainingLogVo.setType3_date_all(type_date_all);
						
						trainingImpl.updateTrainingLog(trainingLogVo);
					}
					
				}
					
				File file = new File(EgovProperties.getProperty("Globals.excel.file.path")+"1px.jpg");
				FileInputStream fis = null; new FileInputStream(file);

				BufferedInputStream in = null;
				ByteArrayOutputStream bStream = null;
				try{
					fis = new FileInputStream(file);
					in = new BufferedInputStream(fis);
					bStream = new ByteArrayOutputStream();
					int imgByte;
					while ((imgByte = in.read()) != -1) {
					    bStream.write(imgByte);
					}
					
					String type = "";

					type = "image/jpeg";
					

					res.setHeader("Content-Type", type);
					res.setContentLength(bStream.size());

					bStream.writeTo(res.getOutputStream());

					res.getOutputStream().flush();
					res.getOutputStream().close();
				}catch(Exception e)
				{
					e.printStackTrace();
				}
			}
			//searchVO.getType()
			return null;
		}

	
	/**
	 * type2(링크)에서 action을 줬을때 데이터 처리
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/request/type2_action.do"})
	public String type2_action(
			Locale locale
			, @ModelAttribute("searchVO") RequestVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
		
		
			JSONObject jResult = new JSONObject();
			JSONArray jArray = new JSONArray();
			
			ArrayList list = new ArrayList();
			urlUtil uu = new urlUtil();
			
			TrainingLogVO trainingLogVo = new TrainingLogVO();
			trainingLogVo.setTraining_code(uu.base64Decode(searchVO.getT()));
			trainingLogVo.setTraining_user_code(uu.base64Decode(searchVO.getU()));
			
			
			TrainingVO training2vo = new TrainingVO();
			training2vo.setTraining_code(uu.base64Decode(searchVO.getT()));
			training2vo.setTraining_user_code(uu.base64Decode(searchVO.getU()));
			
			
			TrainingVO tvo = trainingImpl.selectTrainingByCode(trainingLogVo.getTraining_code());
			
			TrainingVO t2vo = requestImpl.selectTraining2UserTrainingInfo(training2vo);
			
			RequestVO rtv = new RequestVO();
			
			
			//base64 => 평문으로
			trainingLogVo.setTraining_code(uu.base64Decode(searchVO.getT()));
			trainingLogVo.setTraining_user_code(uu.base64Decode(searchVO.getU()));
			trainingLogVo.setType(searchVO.getType());
			
			rtv.setTraining_code(uu.base64Decode(searchVO.getT()));
			rtv.setTraining_user_code(uu.base64Decode(searchVO.getU()));
			
			
			
			
			
			
			TrainingLogVO tl = trainingImpl.selectTrainingLog(trainingLogVo);
			
			String join = tl.getType2_json();
			
			
			String t_userId = "";
			String t_passwd = "";
			String t_01 = "";
			String t_02 = "";
			String t_03 = "";
			String t_04 = "";
			
			
			
			
			if((tvo.getType().equals("0") && tvo.getTraining_type2().equals("Y")) || (tvo.getType().equals("1") && t2vo.getTraining_type2().equals("Y")))			{
				
				t_userId = searchVO.getT_userId();
				t_01 = searchVO.getT_01();
				t_02 = searchVO.getT_02();
				t_03 = searchVO.getT_03();
				t_04 = searchVO.getT_04();
				
				
				HashMap hm = new HashMap();
				
				//비밀번호는 입력된 문자열 길이만 입력함.
				if(null==searchVO.getT_passwd() || "".equals(searchVO.getT_passwd()))
				{
					t_passwd = "0";
				}
				else
				{
					t_passwd = String.valueOf(searchVO.getT_passwd().length());
				}
				
				rtv.setT_userId(t_userId);
				rtv.setT_passwd(t_passwd);
				rtv.setT_01(t_01);
				rtv.setT_02(t_02);
				rtv.setT_03(t_03);
				rtv.setT_04(t_04);
				
							
				requestImpl.insertTrainingLogPhishing(rtv);
			
			}
			
			return "redirect:/request/linkview.do?t="+searchVO.getT()+"&u="+searchVO.getU();
		}
	
	/**
	 * 신고리스트
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/request/register.do"}) 
	public String register_data(
			Locale locale
			, @ModelAttribute("searchVO") RequestVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			urlUtil uu = new urlUtil();
			
			UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
			
			//일반 사용자가 신고접수시
			if(!uu.base64Decode(searchVO.getT()).equals(""))
			{
				String t = uu.base64Decode(searchVO.getT());
				TrainingVO tvo = trainingImpl.selectTrainingWithValidByCode(t);
				
				SystemVO list = systemImpl.selectInstitutionByCode(tvo.getInstitution_code());
				
				model.addAttribute("validation", tvo.getValidation());
				model.addAttribute("list", list);
								
			} 
			//기관관리자가 신고접수시
			else if(userInfo.getLev().equals("institution_admin")){
						
				TrainingVO tvo2 = new TrainingVO();
				List<TrainingVO> list  = trainingImpl.selectMemberInstitutionList(tvo2);				
				
				model.addAttribute("list", list);
			} 
			
			model.addAttribute("userInfo", userInfo);
			
			return "request/register";
		}
	/**
	 * 신고 저장 루
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/request/register_save.do"}) 
	public String register_save_data(
			Locale locale
			, @ModelAttribute("searchVO") RequestVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			urlUtil uu = new urlUtil();
			
			List<TrainingVO> list;
			TrainingRegisterVO trv = new TrainingRegisterVO(); 
			String msg = "";
			String url = "";
			
			TrainingVO vo = new TrainingVO();
			
			//일반 사용자가 신고접수시
			if(!uu.base64Decode(searchVO.getT()).equals(""))
			{
				
				String t = uu.base64Decode(searchVO.getT());
				TrainingVO tvo = trainingImpl.selectTrainingByCode(t);
				
				if(!"".equals(tvo.getCode()))
				{
					if(!searchVO.getName().equals("") && !searchVO.getEmail().equals("") && !"".equals(searchVO.getTitle()) && !"".equals(searchVO.getContent()))
					{
						
						vo.setTraining_code(tvo.getCode());
						vo.setEmail(searchVO.getEmail());
						vo.setName(searchVO.getName());
						
						list = trainingImpl.selectTrainingUserByNameAndEmail(vo);
						
						if(list.size()>0)
						{
							trv.setMatching_flag("Y");
						}
						else
						{
							trv.setMatching_flag("N");
						}
						
						trv.setEmail(searchVO.getEmail());
						trv.setName(searchVO.getName());
						trv.setContent(searchVO.getContent());
						trv.setTitle(searchVO.getTitle());
						trv.setTraining_code(tvo.getCode());
						
						if(EgovProperties.getProperty("Globals.register.valid.send.service").equals("1"))
						{
							trv.setCheck_mail_status("N");
						}else{
							trv.setCheck_mail_status("Y");
						}
						
						trainingImpl.insertTrainingRegister(trv);
						
						msg = "정상적으로 등록되었습니다.";
						url = "common/alert_close";
					}					
				}
				else
				{
					msg = "필수값이 입력되지 않았습니다.";
					url = "common/alert_back";
				}
				
				
			} 
			
			model.addAttribute("msg",msg);
			return url;
			
	}
	
	
	
	
	@RequestMapping(value="/request/linkview.do",produces = "text/html; charset=utf8")
	@ResponseBody
	public String requeset_linkview(
			Locale locale
			, @ModelAttribute("searchVO") RequestVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
		
		
		String action = "";
		//from tag 시작
		StringBuffer s_custom_form = new StringBuffer();
		//from tag 종료
		StringBuffer e_custom_form = new StringBuffer();
		//버튼 실행 스크립트
		StringBuffer action_button_script = new StringBuffer();
		
		urlUtil uu = new urlUtil();
		TrainingLogVO trainingLogVo = new TrainingLogVO();
		//referer정보
		String referer 	= req.getHeader("referer");
		String ip 		= req.getRemoteAddr();
		//ip정보
		
		//base64 => 평문으로
		trainingLogVo.setTraining_code(uu.base64Decode(searchVO.getT()));
		
		TrainingVO tvo = trainingImpl.selectTrainingByCode(trainingLogVo.getTraining_code());
		String content = "";
		
		if(tvo.getType().equals("0"))
		{
			content = tvo.getTraining_type2_content();
		}
		else if(tvo.getType().equals("1"))
		{
			
			
			
			TrainingVO training2vo = new TrainingVO();
			
			training2vo.setTraining_code(uu.base64Decode(searchVO.getT()));
			training2vo.setTraining_user_code(uu.base64Decode(searchVO.getU()));

			TrainingVO training2Info = requestImpl.selectTraining2UserTrainingInfo(training2vo);
			
			
			
			content = training2Info.getTraining_type2_content();
			
			System.out.println("0###########################");
			System.out.println(content);
			System.out.println("0###########################");
			
		}
	
		

		
		
		if(content.contains("#s_custom_form#") && content.contains("#e_custom_form#") && content.contains("#action_button_script#"))
		{
			
			System.out.println("aa1###########################");
			
			action = "/request/type2_action.do";
			s_custom_form.append("<form name='custom_form' action='"+action+"' id='custom_form' method='post'>");
			s_custom_form.append("<input type='hidden' name='t' value='"+searchVO.getT()+"'>");
			s_custom_form.append("<input type='hidden' name='u' value='"+searchVO.getU()+"'>");
			e_custom_form.append("</form>");
			action_button_script.append("document.custom_form.submit();");
			
			
			//form tag 시작
			content = content.replaceAll("\\#s_custom_form\\#", s_custom_form.toString());
			
			//from tag 종료
			content = content.replaceAll("\\#e_custom_form\\#", e_custom_form.toString());
			
			//버튼 스크립트
			content = content.replaceAll("\\#action_button_script\\#", action_button_script.toString());
			
			
			

			
		}
			
			
			
			
			
			model.addAttribute("view", tvo);
			
			//default charset지정
			String defult_chatset = "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">";
			
			tvo.setTraining_type2_content(defult_chatset+content);
		
			return tvo.getTraining_type2_content();
		
		}
			
}
