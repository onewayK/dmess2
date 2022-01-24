package kr.nshare.system.web;

import java.net.InetAddress;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.nshare.common.CommonVO;
import kr.nshare.common.UserInfoVO;
import kr.nshare.common.pageVO;
import kr.nshare.common.license.LicenseJsonDecode;
import kr.nshare.common.license.LicenseJsonEncode;
import kr.nshare.common.util.EgovProperties;
import kr.nshare.common.util.SessionUtil;
import kr.nshare.common.util.commonUtil;
import kr.nshare.common.util.urlUtil;
import kr.nshare.execute.service.impl.ExcuteService;
import kr.nshare.faq.service.impl.FaqService;
import kr.nshare.member.service.MemberVO;
import kr.nshare.member.service.impl.MemberService;
import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.TemplateVO;
import kr.nshare.system.service.impl.SystemService;
import kr.nshare.training.service.TrainingVO;
import kr.nshare.training.service.impl.TrainingService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SystemController {
	private static final Logger log = LoggerFactory.getLogger(SystemController.class);
	
	@Autowired
	private SystemService systemImpl;
	
	@Autowired
	private MemberService memberImpl;
	
	@Autowired
	private TrainingService trainingImpl; 
	
	@Autowired
	private ExcuteService excuteImpl; 
	
	@Autowired
	private FaqService faqImpl;
	
	/**
	 * 사용자 접속 로그
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/memberLogList.do")
	public String memberLogList(
			Locale locale
			, @ModelAttribute("searchVO") SystemVO searchVO 
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
	{
		
		
		int total = memberImpl.selectMemberLogListCnt(searchVO);
		
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
		List<SystemVO> list  = memberImpl.selectMemberLogList(searchVO);
		model.addAttribute("pageing", pagevo);
		model.addAttribute("list",list);
		return "system/memberLogList";
	}
	
	/**
	 * 접속자 리스트(사용자관리 및 권한 관리)
	 *    관리자 접속시 전체 리스트 출력
	 *    
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/system/memberList.do")
	public String memberList(
				Locale locale
				, @ModelAttribute("searchVO") SystemVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
	
		/**
		 * 게시물 전체 데이터 추출
		 */
		int total = systemImpl.selectMemberListCnt(searchVO);
		
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
		List<SystemVO> list  = systemImpl.selectMemberList(searchVO);
		model.addAttribute("pageing", pagevo);
		model.addAttribute("list",list);
		return "system/memberList";
	}
	
	
	/**
	 * 사용자 등록 폼 호출
	 * @param locale
	 * @param searchVO
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 */
	@RequestMapping(value="/system/memberForm.do")
	public String memberFrom(
				Locale locale
				, @ModelAttribute("searchVO") SystemVO searchVO
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		
		//테스트
		SystemVO systemVO = null;
		List<SystemVO> authList = null;
		String pageType="";
		//
		if(!searchVO.getCode().equals(""))
		{
			authList = systemImpl.selectAuthMappingListByMemberCode(String.valueOf(searchVO.getCode()));
			
			pageType = "update";
			systemVO = systemImpl.selectMemberByCode(String.valueOf(searchVO.getCode()));
		}
		else
		{
			pageType = "insert";
		}
		
		model.addAttribute("authList", authList);
		model.addAttribute("detail", systemVO);
		model.addAttribute("pageType", pageType);
		model.addAttribute("userInfo",userInfo);
		
		return "system/memberForm";
	}
	

	/**
	 * 사용자 계정  삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/system/member_del.do")
	public String deleteMember(
				Locale locale
				, @ModelAttribute("searchVO") SystemVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		String view = "";
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
	
		if(!"admin".equals(userInfo.getUserid()) || "admin".equals(userInfo.getLev()))
		{
				//게정 삭제
				systemImpl.deleteMemberByCode(searchVO,userInfo);
			
				//계정 로그 삭제 
				memberImpl.deleteMemberLogByMemberCode(searchVO.getCode());
				
				model.addAttribute("msg", "정상적으로 삭제를 완료하였습니다.");
				
				model.addAttribute("redirect", "/system/memberList.do");
				
				view = "common/alert_redirect";
			
		}
		else
		{
			model.addAttribute("msg", "삭제를 실패하였습니다.");
			model.addAttribute("redirect", "/system/memberList.do");
			view = "common/alert_redirect";
		}
		
	    return view;
	}
	
	
	
	/**
	 * 회원처리
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/system/memberProc.do")
	public String memberProc(
			Locale locale
			, @ModelAttribute("searchVO") SystemVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
		
		String return_page = "";
			
		
			if(searchVO.getPageType().equals("insert"))
			{
			
				
				
				SystemVO checkUser = systemImpl.selectMemberById(searchVO.getUserid());
				
				if(checkUser == null || "".equals(checkUser.getUserid()))
				{
					systemImpl.insertMember(searchVO);
					return_page =  "redirect:/system/memberForm.do?code="+searchVO.getCode();
				}
				else
				{
					model.addAttribute("msg","아이디를 이미 사용중입니다. 다른 아이디로 등록하여주세요!");
					return_page = "common/alert_back";
				}
				
			}
			else
			{
				SystemVO vo = systemImpl.selectMemberByCode(searchVO.getCode());
				searchVO.setUserid(vo.getUserid());
				systemImpl.updateMember(searchVO);
				return_page =  "redirect:/system/memberForm.do?code="+searchVO.getCode();
			}
			
			return return_page;			
		}

	/**
	 * 기관 리스트 출력
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/institutionList.do")
	public String institutionList(
			Locale locale
			, @ModelAttribute("searchVO") SystemVO searchVO 
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			
			/**
			 * 게시물 전체 데이터 추출
			 */
			int total = systemImpl.selectInstitutionListCnt(searchVO);
			
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
			List<SystemVO> list  = systemImpl.selectInstitutionList(searchVO);
			model.addAttribute("pageing", pagevo);
			model.addAttribute("list",list);
			
			return "system/institutionList";
		}
	
	
	/**
	 * 기관 등록 폼 호출
	 * @param locale
	 * @param searchVO
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 */
	@RequestMapping(value="/system/institutionForm.do")
	public String institutionForm(
				Locale locale
				, @ModelAttribute("searchVO") SystemVO searchVO
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		
		//테스트
		SystemVO systemVO = null;
		
		String pageType="";
		//
		if(!searchVO.getCode().equals(""))
		{
			pageType = "update";
			systemVO = systemImpl.selectInstitutionByCode(String.valueOf(searchVO.getCode()));
		}
		else
		{
			pageType = "insert";
		}
		
		model.addAttribute("detail", systemVO);
		model.addAttribute("pageType", pageType);
		model.addAttribute("userInfo",userInfo);
		
		return "system/institutionForm";
	}
	
	/**
	 * 기관  삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/system/institution_del.do")
	public String deleteInstitution(
				Locale locale
				, @ModelAttribute("searchVO") SystemVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		String view = "";
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		searchVO.setUserid(userInfo.getUserid());
		
		if("admin".equals(userInfo.getLev()))
		{
			List<TrainingVO> g_list= trainingImpl.selectGroupByInstitutionCode(searchVO.getCode());
			
			//훈련,훈련그룹 삭제 
			for(TrainingVO gvo : g_list){
				//그룹안에 존재하는 모든 훈련 삭제
				List<TrainingVO> t_list= trainingImpl.selectTrainingByGroupCode(gvo.getCode());
				
				for(TrainingVO tvo : t_list){
					TrainingVO temp_vo=new TrainingVO(); 
					temp_vo.setTraining_code(tvo.getCode());
					
					trainingImpl.deleteTrainingByCode(tvo.getCode());
					trainingImpl.deleteTrainingLogByCode(tvo.getCode());
					trainingImpl.deleteTrainingUserByCode(tvo.getCode());
					trainingImpl.deleteTrainingRegisterByCode(tvo.getCode());
					trainingImpl.deleteTrainingGrpByCdoe(temp_vo);
					trainingImpl.deleteTraining2UserByCdoe(temp_vo);
					
					excuteImpl.deleteTrainingApproval(tvo.getCode());
				}
				
				trainingImpl.deleteTrainingGroupByCode(gvo.getCode());
			}
			
			//템플릿 삭제
			systemImpl.updateDisabledTemplatesByCateCode(searchVO.getCode());
			//fqd 삭제
			faqImpl.deleteFaqByInstitutionCode(searchVO.getCode());
			
			List<MemberVO> m_list= memberImpl.selectMemberByInstitutionCode(searchVO.getCode());
			
			
			//게정 삭제
			for(MemberVO mvo : m_list){
				SystemVO svo = new SystemVO();
				svo.setCode(String.valueOf(mvo.getCode()));
				svo.setUserid(mvo.getUserid());
				
				systemImpl.deleteMemberByCode(svo,userInfo);
				memberImpl.deleteMemberLogByMemberCode(String.valueOf(mvo.getCode()));
			}
			
			//기관 삭제
			systemImpl.deleteInstitutionByCode(searchVO.getCode());
			
			model.addAttribute("msg", "정상적으로 삭제를 완료하였습니다.");
			
			model.addAttribute("redirect", "/system/institutionList.do");
			
			view = "common/alert_redirect";
			
		}
		else
		{
			model.addAttribute("msg", "삭제를 실패하였습니다.");
			model.addAttribute("redirect", "/system/institutionList.do");
			view = "common/alert_redirect";
		}
		
	    return view;
	}
	
	/**
	 * 회원처리
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/system/institutionProc.do")
	public String institutionProc(
			Locale locale
			, @ModelAttribute("searchVO") SystemVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
		
			log.info("==>"+searchVO.getCode());
		
			if(searchVO.getPageType().equals("insert"))
			{
				systemImpl.insertInstitution(searchVO);
			}
			else
			{
				systemImpl.updateInstitution(searchVO);
			}
			return "redirect:/system/institutionForm.do?code="+searchVO.getCode();
		}
	
	/**
	 * 기관 리스트 팝업
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/institution_list_pop.do")
	public String institution_list_pop(
			Locale locale
			, @ModelAttribute("searchVO") SystemVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			//기관 리스트는 현재 사용하고있는것만 출력해야하기때문에 사용상태값을 설정한다.
			searchVO.setUseyn("0");
			
			/**
			 * 게시물 전체 데이터 추출
			 */
			int total = systemImpl.selectInstitutionListCnt(searchVO);
			
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
			List<SystemVO> list  = systemImpl.selectInstitutionList(searchVO);
			model.addAttribute("pageing", pagevo);
			model.addAttribute("list",list);
			
			return "system/institution_list_pop";
		}
	
	/**
	 * 과금내역관리
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/paymentLogList.do")
	public String payment_log_list(
			Locale locale
			, @ModelAttribute("searchVO") SystemVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			/**
			 * 게시물 전체 데이터 추출
			 */
			int total = systemImpl.selectPayMentListCnt(searchVO);
			
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
			List<SystemVO> list  = systemImpl.selectPayMentList(searchVO);
			model.addAttribute("pageing", pagevo);
			model.addAttribute("list",list);
			
			return "system/paymentList";
		}
	
	
	/**
	 * 서비스 로그 
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/serviceLog_List.do")
	public String serviceLog_List(
			Locale locale
			, @ModelAttribute("searchVO") SystemVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
		

			//날짜 셋팅
		
			if((searchVO.getSearchBgnDe()==null || searchVO.getSearchBgnDe().equals("") || searchVO.getSearchEndDe()==null || searchVO.getSearchEndDe().equals("")))
			{
				String end_date = commonUtil.getYmd();
				String start_date = commonUtil.getCurrentPrevData(-7);
				
				//시작일
				searchVO.setSearchBgnDe(start_date);
				//종료일
				searchVO.setSearchEndDe(end_date);
			}
			
			/**
			 * 게시물 전체 데이터 추출
			 */
			int total = systemImpl.selectServiceLogListCnt(searchVO);
			
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
			List<SystemVO> list  = systemImpl.selectServiceLogList(searchVO);
			model.addAttribute("pageing", pagevo);
			model.addAttribute("list",list);
			
			return "system/serviceLog_List";
		}
	/**
	 * 이메일 발송 리스트
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/emailSendLogList.do")
	public String email_send_log_list(
			Locale locale
			, @ModelAttribute("searchVO") SystemVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			
		
			//날짜 셋팅
		
			if((searchVO.getSearchBgnDe()==null || searchVO.getSearchBgnDe().equals("") || searchVO.getSearchEndDe()==null || searchVO.getSearchEndDe().equals("")))
			{
				String end_date = commonUtil.getYmd();
				String start_date = commonUtil.getCurrentPrevData(-7);
						
				
				//시작일
				searchVO.setSearchBgnDe(start_date);
				//종료일
				searchVO.setSearchEndDe(end_date);
				
			}
		
			/**
			 * 게시물 전체 데이터 추출
			 */
			int total = systemImpl.selectEmailSendLogListCnt(searchVO);
			
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
			List<SystemVO> list  = systemImpl.selectEmailSendLogList(searchVO);
			model.addAttribute("pageing", pagevo);
			model.addAttribute("list",list);
			
			return "system/sendMailLog";
		}
	
	/**
	 * 과금 처리 폼
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/paymanage_pop.do")
	public String paymanage_pop(
			Locale locale
			, @ModelAttribute("searchVO") SystemVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			List<SystemVO> authList;
		
			SystemVO memberInfo = systemImpl.selectMemberByCode(String.valueOf(searchVO.getCode()));
			
			authList = systemImpl.selectAuthMappingListByMemberCode(String.valueOf(searchVO.getCode()));
		
			model.addAttribute("memberInfo",memberInfo);
			model.addAttribute("authList", authList);
		
			return "system/paymanage_pop";
		}
	
	/**
	 * 훈련 서비스 등록/수정 폼
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/service_setting_pop.do")
	public String service_setting_pop(
			Locale locale
			, @ModelAttribute("searchVO") SystemVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			List<SystemVO> serviceList=null;
			SystemVO detail=null;
			String pageType="";
			
			SystemVO memberInfo = systemImpl.selectMemberByCode(String.valueOf(searchVO.getUc()));
			
			
			if(null==searchVO.getPageType() || "".equals(searchVO.getPageType()) || "insert".equals(searchVO.getPageType()))
			{
				pageType = "insert";
			}
			else
			{
				pageType = "update";
				
				
				serviceList=systemImpl.selectServiceByUserCode(String.valueOf(searchVO.getUc()));
				
				//서비스 활성화된 서비스가 존재하는 지 조회
				SystemVO temp_vo= new SystemVO();
				temp_vo.setUserid(memberInfo.getUserid());				
				
				if(null != searchVO.getCode()  && !"".equals(searchVO.getCode())  ){
					temp_vo.setCode(searchVO.getCode());
				}
				
				detail=systemImpl.selectServiceSettingInfoByUserID(temp_vo);
			}
			
			
			model.addAttribute("memberInfo",memberInfo);
			model.addAttribute("serviceList",serviceList);
			model.addAttribute("detail", detail);
			model.addAttribute("pageType", pageType);
			
			return "system/service_setting_pop";
		}
	
	
	/**
	 * 훈련 서비스 설정 처리
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/servicemanage_proc.do")
	public String servicemanage_proc(
			Locale locale
			, @ModelAttribute("searchVO") SystemVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
			searchVO.setCreate_user(userInfo.getUserid());		
			
			//서비스 상태가 Y 인 서비스를 입력 또는 수정시 나머지 서비스 상태를 N으로 만듬
			if("Y".equals(searchVO.getService_use())){
				SystemVO temp_vo = new SystemVO();
				
				temp_vo.setUc(searchVO.getUc());		
				temp_vo.setService_use("N");
				
				systemImpl.updateServicStatusByUc(temp_vo);
			}
			
			//사용자 paycnt최정 업데이트
			if("insert".equals(searchVO.getPageType()))
			{				
				searchVO.setType("create");
				
				systemImpl.insertServiceSetting(searchVO);
				searchVO.setService_code(searchVO.getCode());
			}
			else if("update".equals(searchVO.getPageType()))
			{
				searchVO.setType("updaet");
				
				systemImpl.updateServiceSetting(searchVO);
				
				searchVO.setService_code(searchVO.getUpdate_list());
			}
			
			systemImpl.insertServiceSettingLog(searchVO);
			
			
			return "common/opener_fn_search";
		}
	
	/**
	 * 과금 디비 처리
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/paymanage_proc.do")
	public String paymanage_proc(
			Locale locale
			, @ModelAttribute("searchVO") SystemVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
		
		
			SystemVO memberInfo = systemImpl.selectMemberByCode(String.valueOf(searchVO.getCode()));
		
			int total_paycnt = 0;
			SystemVO updatePayCnt = new SystemVO();
			
			searchVO.setNow_count(searchVO.getPaycnt());
			systemImpl.insertPayment(searchVO);
			
			
			
			//사용자 paycnt최정 업데이트
			if(searchVO.getType().equals("plus"))
			{
				total_paycnt = Integer.valueOf(searchVO.getPaycnt())+Integer.valueOf(memberInfo.getPaycnt());
			}
			else if(searchVO.getType().equals("minus")) 
			{
				total_paycnt = Integer.valueOf(memberInfo.getPaycnt()) - Integer.valueOf(searchVO.getPaycnt());
			}
			
			updatePayCnt.setCode(searchVO.getCode());
			updatePayCnt.setPaycnt(String.valueOf(total_paycnt));
			systemImpl.updatePayCntMember(updatePayCnt);
			
			
			return "common/opener_fn_search";
		}
	
	/**
	 * 템플릿 리스트
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/templateList.do")
	public String templateList(
			Locale locale
			, @ModelAttribute("searchVO") TemplateVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
		
		UserInfoVO sessLoginInfo=null;
		if(null!=httpsession.getAttribute("UserInfoVO"))
		{
			sessLoginInfo = (UserInfoVO) httpsession.getAttribute("UserInfoVO");
		}
		
		
		/**
		 * 게시물 전체 데이터 추출
		 */
		int total = systemImpl.selectTemplateListCnt(searchVO);
		
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
		List<TemplateVO> list  = systemImpl.selectTemplateList(searchVO);
		model.addAttribute("pageing", pagevo);
		model.addAttribute("list",list);
			
		
			return "system/templateList";
		}
	
	
	/**
	 * 
	 * 
	 * 템플릿 등록 및 출력 메뉴
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/templateForm.do")
	public String templateForm(
			Locale locale
			, @ModelAttribute("searchVO") TemplateVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			TemplateVO template_detail = null;
		
			
			
			UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
			searchVO.setUserid(userInfo.getUserid());
			
			//기관 리스트 출력
			List<TrainingVO> institutionList = trainingImpl.selectMemberInstitutionList(searchVO);
						
			//테스트
			SystemVO TrainingVO = null;
			List<TrainingVO> authList = null;
			String pageType="";
			
			//
			List<TemplateVO> templateCateList = systemImpl.selectTemplateCateList(searchVO);
			
			
			//
			
			if(!searchVO.getCode().equals(""))
			{
				template_detail = systemImpl.selectTemplateByCode(searchVO.getCode());
				pageType = "update";
				
				template_detail.setLev(userInfo.getLev());
				
				MemberVO mv = new MemberVO();
				mv.setUserid(userInfo.getUserid());
				mv.setTemplate_code(searchVO.getCode());
				List<MemberVO> chkList = memberImpl.selectMemberInstitutionListAndTemplate(mv);
				
				if(chkList.size()>0)
				{
					template_detail.setLev_use("Y");
				}
			}
			else
			{
				pageType = "insert";
			}
			
			model.addAttribute("institutionList", institutionList);
			model.addAttribute("pageType", pageType);
			model.addAttribute("userInfo",userInfo);
			model.addAttribute("detail",template_detail);
			model.addAttribute("templateCateList", templateCateList);
			return "system/templateForm";
		}
	
	/**
	 * 템플릿 저장
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/templateSave.do")
	public String templateSave(
			Locale locale
			, @ModelAttribute("searchVO") TemplateVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
		String memberCode = systemImpl.selectMemberById(req.getRemoteUser()).getCode();
		searchVO.setUc(memberCode);
		if(searchVO.getPageType().equals("") || searchVO.getPageType().equals("insert"))
		{
			systemImpl.insertTemplate(searchVO);
		}
		else
		{
			systemImpl.updateTemplate(searchVO);
		}
		
		return "redirect:/system/templateList.do";
		}
	
	/**
	 * 템플릿 카테고리 히팅 기준 관리
	 * 
	 *    
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/system/templateHitManagerList.do")
	public String templateHitManagerList(
				Locale locale
				, @ModelAttribute("searchVO") TemplateVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
	
		//전체 카테고리 출력
		TemplateVO tvo = new TemplateVO();
		List<TemplateVO> categoryList = systemImpl.selectTemplateCateList(tvo);
		
		model.addAttribute("categoryList",categoryList);
		return "system/templateHitManagerList";
	}
	
	
	/**
	 * 해당 카테고리에 관련 단어 등록 수정 삭제 기능 수행.
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/templateHitManagerListPopForm.do")
	public String templateHitManagerListPopForm(
				Locale locale
				, @ModelAttribute("searchVO") TemplateVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		
		
		//전체 카테고리 출력
		TemplateVO tvo = new TemplateVO();
		List<TemplateVO> cateWordList = systemImpl.selectTemplateCateWordByCateCode(searchVO.getTc_code());
		
		TemplateVO detail = systemImpl.selectTemplateCateDetailByCode(searchVO.getTc_code());
		
		
		model.addAttribute("detail",detail);
		model.addAttribute("cateWordList",cateWordList);
		return "system/templateHitManagerListPopForm";
	}
	
	/*
	/**
	 * 카테고리 분류 수정
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 
	@RequestMapping(value="/system/templateHitManagerListPopProc.do")
	@ResponseBody 
	public ResponseEntity templateHitManagerListPopProc(
				Locale locale
				, @ModelAttribute("searchVO") TemplateVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		HashMap hm = new HashMap();
		HttpHeaders responseHeaders = new HttpHeaders();
		List<TemplateVO> list = null;
		List<HashMap> hlist = new ArrayList<HashMap>();
		//성공여부
		String status = "";
		
		if(searchVO.getType().equals("add"))
		{
			systemImpl.insertTemplateCateWord(searchVO);
		}
		else if(searchVO.getType().equals("update"))
		{
			systemImpl.updateTemplateCateWord(searchVO);
		}
		else if(searchVO.getType().equals("delete"))
		{
			systemImpl.deleteTemplateCateWord(searchVO);
		}
		
		
		list = systemImpl.selectTemplateCateWordByCateCode(searchVO.getTc_code());
		
		for(TemplateVO vo :list){
			Map m = commonUtil.voToHm(vo);
			hlist.add((HashMap) m);
		}
		
		hm.put("status", status);
		hm.put("list", hlist);
		JSONObject json = new JSONObject(hm);
		return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
	}
	*/
	
	/**
	 * mess version info
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/versionInfo.do")
	public String salesManage(
			Locale locale
			, @ModelAttribute("searchVO")SystemVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
	{
	
		CommonVO lvo= new CommonVO();
		
		ArrayList<String> licenseKeys =new ArrayList<String>();		  
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		
		
		String license_file_type="fail";
		String license_key_type="fail";
		
		String host_type="fail";
		String mac_type="fail";
		String date_type="fail";
		
		boolean date_chk= false;
		boolean host_chk= false;
		
		
		String filePath = EgovProperties.getProperty("Globals.file.license");
		
		try{  
			  licenseKeys = LicenseJsonDecode.getLicenseKey(filePath); // 라이선스 파일 체크(mess 시작하는 파일 목록) 
				
			 //라이선스 파일 유무 체크
			  if(null == licenseKeys || licenseKeys.size() < 0){
				  lvo.setLicense_key_type(license_file_type);  //라이센서 파일이 없는 경우
		     }else{
		    	 license_file_type= "success";
		    	 license_key_type="success";
		    	 
		    	 HashMap m=null; 
		    	 
		    	for(int i=0; i< licenseKeys.size(); i++ ){ 
		    		 m = LicenseJsonDecode.getHashmapFromFIle(licenseKeys.get(i),filePath);
		    		 if(m!=null){
		    			 break;
		    		 }
		    	}
			    	
		    	 if(m != null || m.containsKey("license_key")){
		    			
		    		 	lvo.setLicense_key((String) m.get("license_key"));				
		    		 	
		    		 	lvo.setHost_use((String) m.get("host_use"));
		    		 	lvo.setHostname((String) m.get("hostname"));
		    		 
		    		 	lvo.setMac_use((String) m.get("mac_use"));
		    		 	lvo.setMac((String) m.get("mac"));
		    		 	
		    		 	lvo.setDate_use((String) m.get("date_use"));		    		 	
		    		 	lvo.setStartDt((String) m.get("startDt"));
						lvo.setEndDt((String) m.get("endDt"));
											
						lvo.setSdate((String) m.get("sdate"));
						
						//사용 기간 체크
						if("Y".equals(lvo.getDate_use())){
							
							date_chk= commonUtil.betweenStartStopYmd(lvo.getStartDt(),lvo.getEndDt());	
							
							if(date_chk){
								date_type="success";
							}
							
						}else if("N".equals(lvo.getDate_use())){
							date_type="success";
						}
						
						//hostname 체크
						if("Y".equals(lvo.getHost_use())){
							
							InetAddress addr = InetAddress.getLocalHost();
							String hostname=addr.getHostName();
							
							if(null != hostname && hostname.equals(lvo.getHostname())){
								host_type="success";
							}
							
						}else if("N".equals(lvo.getHost_use())){
							host_type="success";
						}
						
						//mac 주소 체크
						if("Y".equals(lvo.getMac_use())){
							
							String cur_mac=LicenseJsonEncode.getMacAddress();
							
							//Mac 주소 비교
							if(null != cur_mac && cur_mac.equals(lvo.getMac())){
								mac_type="success";
							}
						}else if("N".equals(lvo.getMac_use())){
							mac_type="success";
						}
												
						
						lvo.setLicense_file_type(license_file_type);
						lvo.setLicense_key_type(license_key_type);
						lvo.setHost_type(host_type);
						lvo.setMac_type(mac_type);
						lvo.setDate_type(date_type);
						
				}else{
					
					lvo.setLicense_key_type(license_key_type); //잘못된 라이센스 키 일경우
					
				}
		     }		     
		}catch(Exception e){
			System.out.println("license file is wrong(Controller)!!");
			lvo.setLicense_key_type(license_file_type);
		}
		
		model.addAttribute("userInfo",userInfo);
		model.addAttribute("license_detail", lvo);
		
		return "system/versionInfo";
	}
	
	/**
	 * 템플릿 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/system/template_del.do")
	public String deleteTemplate(
				Locale locale
				, @ModelAttribute("searchVO") TemplateVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		String view = "";
		urlUtil uu = new urlUtil();
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		searchVO.setUserid(userInfo.getUserid());
		
		MemberVO mv = new MemberVO();
		mv.setUserid(userInfo.getUserid());
		mv.setTemplate_code(searchVO.getCode());
		List<MemberVO> chkList = memberImpl.selectMemberInstitutionListAndTemplate(mv);
		
		if(chkList.size()>0 || userInfo.getLev().equals("admin"))
		{
			
			//템플릿  비활성화 시킴
			systemImpl.updateDisabledTemplateByCode(searchVO.getCode());
			
			model.addAttribute("msg", "정상적으로 삭제를 완료하였습니다.");
			
			model.addAttribute("redirect", "/system/templateList.do");
			
			view = "common/alert_redirect";
		}
		else
		{
			model.addAttribute("msg", "삭제를 실패하였습니다.");
			model.addAttribute("redirect", "/system/templateList.do");
			view = "common/alert_redirect";			
		}
		
		
	    return view;
	}
	
	/**
	 * 카테고리 수정/삭제/등록 폼
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/templateCategoryForm.do")
	public String GroupForm(
				Locale locale
				, @ModelAttribute("searchVO") TemplateVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		urlUtil uu = new urlUtil();
		String pageType = "";
		TemplateVO detail = null;
		List<TemplateVO> list = null;
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		searchVO.setUserid(userInfo.getUserid());
		
		if(null==searchVO.getCode() || searchVO.getCode().equals(""))
		{
			pageType = "insert";
		}
		else
		{
			pageType = "update";
			detail = systemImpl.selectTemplateCateDetailByCode(searchVO.getCode());
			
			detail.setLev(userInfo.getLev());
			list = systemImpl.selectTemplateCateWordByCateCode(searchVO.getCode());
		}
		
		model.addAttribute("pageType",pageType);
		model.addAttribute("detail",detail);
		model.addAttribute("list",list);
		
	    return "/system/templateCategoryForm";
	}
	
	/**
	 * 카테고리 생성 및 수정
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/system/categorySave.do")
	public String groupSave(
			Locale locale
			, @ModelAttribute("searchVO") TemplateVO searchVO 
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
	{
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		searchVO.setUserid(userInfo.getUserid());
	
		if(userInfo.getLev().equals("admin"))
		{
			if(searchVO.getPageType().equals("") || searchVO.getPageType().equals("insert"))
			{
				systemImpl.insertCategory(searchVO);
			}
			else
			{
				systemImpl.updateCategory(searchVO);
			}
		}
		return "redirect:/system/templateCategoryForm.do?code="+searchVO.getCode();
	
	}
	
	
	/**
	 * 카테고리  삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/system/category_del.do")
	public String deleteTemplateCategory(
				Locale locale
				, @ModelAttribute("searchVO") TemplateVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		String view = "";
		urlUtil uu = new urlUtil();
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		searchVO.setUserid(userInfo.getUserid());
		
		
		if(userInfo.getLev().equals("admin"))
		{
			TemplateVO chk_vo = systemImpl.selectTemplateCateDetailByCode(searchVO.getCode());
			
			if("etc".equals(chk_vo.getCate_type())){
				model.addAttribute("msg", "해당 항목은 삭제할 수 없습니다.");
				model.addAttribute("redirect", "/system/templateHitManagerList.do");
				view = "common/alert_redirect";
			}else{
				//단어 삭제
				systemImpl.deleteTemplateCateWord(searchVO.getCode());		
				
				//카테고리에 포함된 모든 템플릿 비활성화
				systemImpl.updateDisabledTemplatesByCateCode(searchVO.getCode());
				
				//카테고리 비활성화 
				systemImpl.updateDisabledCategoryByCode(searchVO.getCode());
				
				model.addAttribute("msg", "정상적으로 삭제를 완료하였습니다.");
				
				model.addAttribute("redirect", "/system/templateHitManagerList.do");
				
				view = "common/alert_redirect";
			}
		}
		else
		{
			model.addAttribute("msg", "삭제를 실패하였습니다.");
			model.addAttribute("redirect", "/system/templateHitManagerList.do");
			view = "common/alert_redirect";
		}
		
	    return view;
	}
	
}
