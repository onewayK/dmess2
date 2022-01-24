package kr.nshare.training.web;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.nshare.common.CommonVO;
import kr.nshare.common.UserInfoVO;
import kr.nshare.common.pageVO;
import kr.nshare.common.impl.CommonService;
import kr.nshare.common.util.EgovProperties;
import kr.nshare.common.util.ExcelUtil;
import kr.nshare.common.util.SessionUtil;
import kr.nshare.common.util.StringUtil;
import kr.nshare.common.util.commonUtil;
import kr.nshare.common.util.urlUtil;
import kr.nshare.execute.service.impl.ExcuteService;
import kr.nshare.member.service.MemberVO;
import kr.nshare.member.service.impl.MemberService;
import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.TemplateVO;
import kr.nshare.system.service.impl.SystemService;
import kr.nshare.training.service.TrainingVO;
import kr.nshare.training.service.impl.TrainingService;
import net.coobird.thumbnailator.Thumbnails;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

@Controller
public class TrainingController {
	 @InitBinder
	    public void initBinder(WebDataBinder dataBinder) {
	        dataBinder.setAutoGrowCollectionLimit(20000);
	    }
	
	private static final Logger logger = LoggerFactory.getLogger(TrainingController.class);
	
	@Autowired
	private TrainingService trainingImpl; 
	 
	@Autowired
	private SystemService systemImpl;
	
	@Autowired
	private ExcuteService excuteImpl; 
	
	@Autowired
	private CommonService commonImpl;
	
	@Autowired
	private MemberService memberImpl;
	
	/**
	 * 훈련관리 > 휸련그룹관리 리스트
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/GroupList.do")
	public String GroupList(
			Locale locale
			, @ModelAttribute("searchVO") TrainingVO searchVO 
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
				UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
				searchVO.setUserid(userInfo.getUserid());
				searchVO.setLev(userInfo.getLev());
			
			/**
			 * 게시물 전체 데이터 추출
			 */
			int total = trainingImpl.selectTrainingGroupListCnt(searchVO);
			
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
			List<TrainingVO> list  = trainingImpl.selectTrainingGroupList(searchVO);
			
			//기관 리스트 출력
			List<TrainingVO> list2  = trainingImpl.selectMemberInstitutionList(searchVO);
			
			model.addAttribute("pageing", pagevo);
			model.addAttribute("list",list);
			model.addAttribute("list2",list2);
			
			return "training/groupList";
	}
	
	//
	
	/**
	 * 훈련그룹관리 폼
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/GroupForm.do")
	public String GroupForm(
				Locale locale
				, @ModelAttribute("searchVO") TrainingVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		urlUtil uu = new urlUtil();
		String pageType = "";
		TrainingVO detail = null;
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		searchVO.setUserid(userInfo.getUserid());
		
		//기관 리스트 출력
		List<TrainingVO> institutionList = trainingImpl.selectMemberInstitutionList(searchVO);
		
		
		if(null==searchVO.getCode() || searchVO.getCode().equals(""))
		{
			pageType = "insert";
		}
		else
		{
			pageType = "update";
			detail = trainingImpl.selectGroupByCode(searchVO.getCode());
			
			//권한 관련(버튼 표시 유무)
			detail.setLev(userInfo.getLev());
		}
		
		model.addAttribute("pageType",pageType);
		model.addAttribute("institutionList", institutionList);
		model.addAttribute("detail",detail);
		    
	    return "training/groupForm";
	}
	
	
	/**
	 * 기관 선택시 그룹리스트 출력용
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/ajax_group_list.do")
	@ResponseBody 
	public ResponseEntity  ajax_group_list(HttpServletRequest request,ModelMap model) throws Exception{
		
		HttpHeaders responseHeaders = new HttpHeaders();
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
		HashMap hm = new HashMap();
		
		String code = request.getParameter("code");
				
		List<TrainingVO> list = trainingImpl.selectGroupListByInstitutionCode(code);
		
		for(TrainingVO vo : list)
		{
			hm = new HashMap();
			hm.put("group_name", vo.getGroup_name());
			hm.put("code", vo.getCode());
			
			hmlist.add(hm);
		}
		

		JSONArray json = new JSONArray(hmlist);
		return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
		
	}
	
	/**
	 * 훈련의 상세 설정 내용 추출
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/type2_detail_list.do")
	@ResponseBody 
	public ResponseEntity  type2_detail_list(HttpServletRequest request,ModelMap model) throws Exception{
		
		HttpHeaders responseHeaders = new HttpHeaders();
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
		HashMap hm = new HashMap();
		
		String code = request.getParameter("code");
		
		List<TrainingVO> tlist = trainingImpl.selectTraining2DetailList(code);
		
		for(TrainingVO  tvo : tlist ){			
				HashMap hm_tvo = (HashMap) commonUtil.voToHm2(tvo);		
				hmlist.add(hm_tvo);
		}
		
		JSONArray json = new JSONArray(hmlist);
		return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
	}
	
	
	/**
	 * 취향분석 ajax db 처리(훈련대상자)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/ajax_training2Porc.do")
	@ResponseBody 
	public ResponseEntity  ajax_training2Porc(@ModelAttribute("searchVO") TrainingVO searchVO ,
			HttpServletRequest request,ModelMap model) throws Exception{
		
		HttpHeaders responseHeaders = new HttpHeaders();
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
		HashMap hm = new HashMap();
		
		List<TrainingVO> list = 	new ArrayList<TrainingVO>();
		TrainingVO training_detail = null;
		
		
		String code = searchVO.getTraining_code();
		String type = searchVO.getType();		
		String status="";
		
		if(null!=type && "add_user".equals(type))
		{			
			String tc_code = searchVO.getTc_code();
			
			if(null!=tc_code && !"".equals(tc_code)){		//신규 체크박스 체크시 grp 생성			
				TemplateVO tvo =systemImpl.selectTemplateByCode(searchVO.getTc_code());
				tvo.setTraining_code(searchVO.getTraining_code());			
				trainingImpl.insertTraining2grp(tvo); 
				searchVO.setTg_code(tvo.getCode());
			}
			
			list.add(searchVO);			
			trainingImpl.insertTraining2User(list);			
		}
		else if(null!=type && "del_user".equals(type))
		{				
			trainingImpl.deleteTraining2UserByCdoe(searchVO);			
		}
		else if(null!=type && "mod_user".equals(type))
		{
			String tc_code = searchVO.getTc_code(); 
			
			if(null!=tc_code && !"".equals(tc_code)){	 //신규 체크박스 체크시 grp 생성			
				TemplateVO tvo =systemImpl.selectTemplateByCode(searchVO.getTc_code());
				tvo.setTraining_code(searchVO.getTraining_code());			
				trainingImpl.insertTraining2grp(tvo); 
				searchVO.setTg_code(tvo.getCode());
			}
			
			trainingImpl.updateTraining2UserbySelect(searchVO);						
		}		
		
		training_detail = trainingImpl.selectTrainingByCode(code);
		status=training_detail.getStatus();
		List<TrainingVO> tvo = null; 
		

		
		if("ready".equals(training_detail.getStatus()) ||  "approval".equals(training_detail.getStatus()) || "step1".equals(training_detail.getStatus())){
			//훈련 사용자 리스트
			tvo = trainingImpl.selectTraining2UserListByCode(code);			
		}else{
			//훈련 사용자에 대한 발송 상태를 포함한 유저 리스트test
			tvo = trainingImpl.selectTraining2UserListWithStatusByCode(code);			
		}
		
		List<TrainingVO> noUsertvo = trainingImpl.selectTraining2GrpNoUser(code);
		
		for(TrainingVO vo: tvo){			
			HashMap hm_tvo = (HashMap) commonUtil.voToHm2(vo);	
			hmlist.add(hm_tvo);
		}
		
		for(TrainingVO vo: noUsertvo){			
			HashMap hm_tvo = (HashMap) commonUtil.voToHm2(vo);	
			hmlist.add(hm_tvo);
		}
						
		JSONArray json = new JSONArray(hmlist);		
	
		return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
		
	}
	
	/**
	 * 취향분석 ajax db 처리(카테고리)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/ajax_training2Cate.do")
	@ResponseBody 
	public ResponseEntity  ajax_training2Cate(@ModelAttribute("searchVO") TrainingVO searchVO ,
			HttpServletRequest request,ModelMap model) throws Exception{
		
		HttpHeaders responseHeaders = new HttpHeaders();
		HashMap hm = new HashMap();
		String type = searchVO.getType();		
		
		if(null!=type && "add_cate".equals(type)) // Tc_code
		{
			TemplateVO tvo =systemImpl.selectTemplateByCode(searchVO.getTc_code());
			tvo.setTraining_code(searchVO.getTraining_code());			
			trainingImpl.insertTraining2grp(tvo); 
		}
		else if(null!=type && "del_cate".equals(type)) 
		{
			
			trainingImpl.deleteTrainingGrpByCdoe(searchVO);
			searchVO.setCode("");
			trainingImpl.deleteTraining2UserByCdoe(searchVO);
		}		
		
		hm.put("status", "ok");
		
		JSONObject json = new JSONObject(hm);
		return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
		
	}
	
	/**
	 * 훈련 복사
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/training_copy.do")
	@ResponseBody 
	public ResponseEntity  training_copy(HttpServletRequest request,ModelMap model) throws Exception{
		
		HttpHeaders responseHeaders = new HttpHeaders();
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
		HashMap hm = new HashMap();
		
		String code = request.getParameter("code");
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();	
		
		TrainingVO vo=new TrainingVO();
		vo.setCode(code);
		vo.setCreate_id(userInfo.getUserid());
		
		int status = trainingImpl.insertCopyTrainingByCode(vo);		
		
		if(status>0)
		{
			//훈련 승인 테이블 생성(1=> 활성화)
			if(EgovProperties.getProperty("Globals.approval_type").equals("1"))
			{	
				TrainingVO avo=new TrainingVO();
				avo.setTraining_code(vo.getCode());
				excuteImpl.insertTrainingApproval(avo);			
				
				//권한이 admin일 경우 승인처리됨
				if("admin".equals(userInfo.getLev())){
					avo.setApproval_type("y");
					avo.setApproval_id(userInfo.getUserid());
				}else{
					//권한이 admin이 아닐 경우 수정시 관리자에게 승인요청하도록 승인 상태를  n상태로 변경
					avo.setApproval_type("n");
					avo.setApproval_id("");
				}
				
				excuteImpl.updateTrainingApproval(avo);
				
			}else{
				//승인 기능 비활성화시 무조건 승인된 훈련으로 처리됨
				TrainingVO avo=new TrainingVO();
				avo.setTraining_code(vo.getCode());
				excuteImpl.insertTrainingApproval(avo);		
				
				avo.setApproval_type("y");
				avo.setApproval_id(userInfo.getUserid());			
				
				excuteImpl.updateTrainingApproval(avo);
				
			}
			
			hm.put("status", "ok");
		}
		else
		{
			hm.put("status", "err");
		}
		
		JSONObject json = new JSONObject(hm);
		return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
		
	}
	
	
	/**
	 * 훈련 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/training/training_del.do")
	public String deleteTraining(
				Locale locale
				, @ModelAttribute("searchVO") TrainingVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		String view = "";
		urlUtil uu = new urlUtil();
		String pageType = "";
		TrainingVO detail = null;
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		searchVO.setUserid(userInfo.getUserid());
		
		//TrainingVO trainingvo = trainingImpl.selectTrainingByCode(searchVO.getCode());
		//삭제에 대한 정합성 체크
		
		MemberVO mv = new MemberVO();
		mv.setUserid(userInfo.getUserid());
		mv.setTraining_code(searchVO.getCode());
		List<MemberVO> chkList = memberImpl.selectMemberInstitutionList(mv);
		
		if(chkList.size()>0 || userInfo.getLev().equals("admin"))
		{
			TrainingVO tvo=new TrainingVO();
			tvo.setTraining_code(searchVO.getCode());
			
			trainingImpl.deleteTrainingByCode(searchVO.getCode());
			trainingImpl.deleteTrainingLogByCode(searchVO.getCode());
			trainingImpl.deleteTrainingUserByCode(searchVO.getCode());
			trainingImpl.deleteTrainingRegisterByCode(searchVO.getCode());
			trainingImpl.deleteTrainingGrpByCdoe(tvo);
			trainingImpl.deleteTraining2UserByCdoe(tvo);
			
			//승인 테이블의 해당 훈련 데이터 삭제
			excuteImpl.deleteTrainingApproval(searchVO.getCode());
			
			model.addAttribute("msg", "정상적으로 삭제를 완료하였습니다.");
			
			model.addAttribute("redirect", "/training/TrainingList.do");
			
			view = "common/alert_redirect";
			
		}
		else
		{
			model.addAttribute("msg", "삭제를 실패하였습니다.");
			model.addAttribute("redirect", "/training/TrainingList.do");
			view = "common/alert_redirect";
			
			//alert('<c:out value="${msg}"/>');
			//document.location.replace("<c:out value="${redirect}"/>");";
		}
		
		
	    return view;
	}
	
	/**
	 * 훈련 그룹 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/training/training_group_del.do")
	public String deleteTrainingGroup(
				Locale locale
				, @ModelAttribute("searchVO") TrainingVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		String view = "";
		urlUtil uu = new urlUtil();
		String pageType = "";
		TrainingVO detail = null;
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		searchVO.setUserid(userInfo.getUserid());
		
		if(userInfo.getLev().equals("admin"))
		{
			List<TrainingVO> t_list= trainingImpl.selectTrainingByGroupCode(searchVO.getCode());
		
			for(TrainingVO tvo : t_list){
				TrainingVO temp_vo=new TrainingVO(); 
				temp_vo.setTraining_code(tvo.getCode());
				
				trainingImpl.deleteTrainingByCode(tvo.getCode());
				trainingImpl.deleteTrainingLogByCode(tvo.getCode());
				trainingImpl.deleteTrainingUserByCode(tvo.getCode());
				trainingImpl.deleteTrainingRegisterByCode(tvo.getCode());
				trainingImpl.deleteTrainingGrpByCdoe(temp_vo);
				trainingImpl.deleteTraining2UserByCdoe(temp_vo);
				
				//승인 테이블의 해당 훈련 데이터 삭제
				excuteImpl.deleteTrainingApproval(tvo.getCode());
			}
			
			trainingImpl.deleteTrainingGroupByCode(searchVO.getCode());
			
			model.addAttribute("msg", "정상적으로 삭제를 완료하였습니다.");
			
			model.addAttribute("redirect", "/training/GroupList.do");
			
			view = "common/alert_redirect";
			
		}
		else
		{
			model.addAttribute("msg", "삭제를 실패하였습니다.");
			model.addAttribute("redirect", "/training/GroupList.do");
			view = "common/alert_redirect";
			
			//alert('<c:out value="${msg}"/>');
			//document.location.replace("<c:out value="${redirect}"/>");";
		}
		
	    return view;
	}
	
	/**
	 * 훈련 발송 초기화
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/training/training_execute_init.do")
	public String training_execute_init(
				Locale locale
				, @ModelAttribute("searchVO") TrainingVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		String view = "";
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		searchVO.setUserid(userInfo.getUserid());
		
		//초기화 권한 체크
		MemberVO mv = new MemberVO();
		mv.setUserid(userInfo.getUserid());
		mv.setTraining_code(searchVO.getCode());
		List<MemberVO> chkList = memberImpl.selectMemberInstitutionList(mv);
		
		if(chkList.size()>0 || userInfo.getLev().equals("admin"))
		{
			TrainingVO tvo=new TrainingVO();
			tvo.setTraining_code(searchVO.getTraining_code());
			
			//해당 발송로그 삭제 및 신고등록 내역 삭제
			trainingImpl.deleteTrainingLogByCode(searchVO.getCode());
			trainingImpl.deleteTrainingRegisterByCode(searchVO.getCode());
			
			//데몬 단에 삭제 요청(해당 훈련 상태 값 init으로 표현)
			tvo.setCode(searchVO.getCode());
			tvo.setStatus("init");
			excuteImpl.updateTrainingStatus(tvo);
			
			model.addAttribute("msg", "정상적으로 초기화를 요청하였습니다.");
					
			model.addAttribute("redirect", "/training/TrainingList.do");
			
			view = "common/alert_redirect";
			
		}
		else
		{
			model.addAttribute("msg", "초기화 요청을 실패하였습니다.");
			model.addAttribute("redirect", "/training/TrainingList.do");
			view = "common/alert_redirect";
			
			//alert('<c:out value="${msg}"/>');
			//document.location.replace("<c:out value="${redirect}"/>");";
		}
		
	    return view;
	}
	
	
	/**
	 * 그룹 생성 및 수정
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/groupSave.do")
	public String groupSave(
			Locale locale
			, @ModelAttribute("searchVO") TrainingVO searchVO 
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			
			UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
			searchVO.setUserid(userInfo.getUserid());
		
			if(searchVO.getPageType().equals("") || searchVO.getPageType().equals("insert"))
			{
				trainingImpl.insertGroup(searchVO);
			}
			else
			{
				trainingImpl.updateGroup(searchVO);
			}
			
			return "redirect:/training/GroupList.do";
		
		}
	
	
	
	
	/**
	 * 훈련생성관리
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/TrainingList.do")
	public String TrainingList(
				Locale locale
				, @ModelAttribute("searchVO") TrainingVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		searchVO.setUserid(userInfo.getUserid());
		/**
		 * 게시물 전체 데이터 추출
		 */
		int total = trainingImpl.selectTrainingListCnt(searchVO);
		
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
		List<TrainingVO> list  = trainingImpl.selectTrainingList(searchVO);
		
		//기관 리스트 출력
		List<TrainingVO> list2  = trainingImpl.selectMemberInstitutionList(searchVO);
		
		model.addAttribute("userInfo", userInfo);
		
		model.addAttribute("pageing", pagevo);
		model.addAttribute("list",list);
		model.addAttribute("list2",list2);
		
		return "training/traingList";
	}
	
	
	/**
	 * 취향분석
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/TrainingList2.do")
	public String TrainingList2(
				Locale locale
				, @ModelAttribute("searchVO") TrainingVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		searchVO.setUserid(userInfo.getUserid());
		/**
		 * 게시물 전체 데이터 추출
		 */
		int total = trainingImpl.selectTraining2ListCnt(searchVO);
		
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
		List<TrainingVO> list  = trainingImpl.selectTraining2List(searchVO);
		
		//기관 리스트 출력
		List<TrainingVO> list2  = trainingImpl.selectMemberInstitutionList(searchVO);
		
		model.addAttribute("pageing", pagevo);
		model.addAttribute("list",list);
		model.addAttribute("list2",list2);
		
		return "training/traingList2";
	}
	
	
	
	/**
	 * 훈련관리 리스트
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/trainingForm.do")
	public String CreateTrainingList(
				Locale locale
				, @ModelAttribute("searchVO") TrainingVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		urlUtil uu = new urlUtil();
		String pageType = "";
		TrainingVO training_detail = null;
		List<TrainingVO> trainingUserList = null;
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		searchVO.setUserid(userInfo.getUserid());
				
		//기관 리스트 출력
		List<TrainingVO> institutionList = trainingImpl.selectMemberInstitutionList(searchVO);
		
		if(null==searchVO.getCode() || searchVO.getCode().equals(""))
		{
			pageType = "insert";
		}
		else
		{
			pageType = "update";
			
			//훈련정보
			training_detail = trainingImpl.selectTrainingByCode(searchVO.getCode());
			
			//승인 요청 관련(버튼 표시 유무)
			training_detail.setLev(userInfo.getLev());
			
			if("ready".equals(training_detail.getStatus()) ||  "approval".equals(training_detail.getStatus())){
				//훈련 사용자 리스트
				trainingUserList = trainingImpl.selectTrainingUserByCode(searchVO.getCode());			
			}else{
				//훈련 사용자에 대한 발송 상태를 포함한 유저 리스트
				trainingUserList = trainingImpl.selectTrainingUserStatusByCode(searchVO.getCode());					
			}
			
			
			String register_url_param = "?t="+uu.urlEncode(searchVO.getCode());
			training_detail.setRegister_url_param(register_url_param);
			
		}

		 
		if(pageType.equals("update"))
		{
			model.addAttribute("training_detail", training_detail);
			model.addAttribute("trainingUserList", trainingUserList);
		}

		if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1"))
		{
			SystemVO svo=  new SystemVO();
			
			 if(pageType.equals("insert")){
				//해당 계정에 설정된 서비스 정보를 가져옴
				svo = systemImpl.selectServiceSettingInfoByUserID(svo);		
				model.addAttribute("service_type",searchVO.getService_type());	
				
			}else if(pageType.equals("update")){			
				svo.setCode(training_detail.getService_setting_code());
				svo = systemImpl.selectServiceSettingInfoByUserID(svo);
				model.addAttribute("service_type",training_detail.getService_type());
			}
			
			model.addAttribute("serviceSetting",svo);
		
		}
		
		model.addAttribute("pageType",pageType);
		model.addAttribute("institutionList", institutionList);
	
		String uploadPath = httpsession.getServletContext().getRealPath("/upload/");
	    File dir = new File(uploadPath);
	    
	    return "training/traingForm";
	}
	
	
	
	/**
	 * 취향분석 훈련 생성 step1
	 *  => 취향분석의 경우 내부적인 디비 처리가 많이 필요하고 그렇기때문에 훈련을 생성한후 내용 작성이 필요함
	 *  => 시스템의 안정성을 위한 조치임.
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/trainingForm2_step1.do")
	public String trainingForm2_step1(
				Locale locale
				, @ModelAttribute("searchVO") TrainingVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		//기관 리스트 출력
		List<TrainingVO> institutionList = trainingImpl.selectMemberInstitutionList(searchVO);
		
		
		if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1"))
		{
			SystemVO svo=  new SystemVO();
		
			//해당 계정에 설정된 서비스 정보를 가져옴
			svo = systemImpl.selectServiceSettingInfoByUserID(svo);		
			model.addAttribute("service_type",searchVO.getService_type());	
			
			model.addAttribute("serviceSetting",svo);
		}
		
		model.addAttribute("institutionList", institutionList);
		
		return "training/trainingForm2_step1";
	}
	
	/**
	 * 취향분석
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/trainingForm2.do")
	public String trainingForm2(
				Locale locale
				, @ModelAttribute("searchVO") TrainingVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		
		urlUtil uu = new urlUtil();
		String pageType = "";
		TrainingVO training_detail = null;
		List<TrainingVO> trainingUserList = null;
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		searchVO.setUserid(userInfo.getUserid());
		
		//기관 리스트 출력
		List<TrainingVO> institutionList = trainingImpl.selectMemberInstitutionList(searchVO);
		
		
		if(null==searchVO.getCode() || searchVO.getCode().equals(""))
		{
			pageType = "insert";
		}
		else
		{
			pageType = "update";
			
			//훈련정보
			training_detail = trainingImpl.selectTrainingByCode(searchVO.getCode());
			//승인 요청 관련(버튼 표시 유무)을 위한 권한 표시
			training_detail.setLev(userInfo.getLev());
						
			String register_url_param = "?t="+uu.urlEncode(searchVO.getCode());
			training_detail.setRegister_url_param(register_url_param);
			
		}

		
		if(pageType.equals("update"))
		{
			model.addAttribute("training_detail", training_detail);
			model.addAttribute("trainingUserList", trainingUserList);
		}
		
		if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1"))
		{
			SystemVO svo=  new SystemVO();
			
			 if(pageType.equals("insert")){
				//해당 계정에 설정된 서비스 정보를 가져옴
				svo = systemImpl.selectServiceSettingInfoByUserID(svo);		
				model.addAttribute("service_type",searchVO.getService_type());	
				
			}else if(pageType.equals("update")){			
				svo.setCode(training_detail.getService_setting_code());
				svo = systemImpl.selectServiceSettingInfoByUserID(svo);
				model.addAttribute("service_type",training_detail.getService_type());
			}
			
			model.addAttribute("serviceSetting",svo);
		
		}
		
		model.addAttribute("pageType",pageType);
		model.addAttribute("institutionList", institutionList);
	
		String uploadPath = httpsession.getServletContext().getRealPath("/upload/");
	       
	        
	    File dir = new File(uploadPath);
		return "training/trainingForm2";
	}
	
	/**
	 * 
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/trainingSave.do")
	public String trainingSave(
			Locale locale
			, @ModelAttribute("searchVO") TrainingVO searchVO 
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
			, RedirectAttributes redirectAttr

		) throws Exception
		{				
			String pageUrl = "";
			UserInfoVO userInfo = SessionUtil.getSessionUserInfo();	
			
			if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1"))
			{
				searchVO.setService_setting_code(userInfo.getService_setting_code()); 
			}
			
			if(searchVO.getPageType().equals("") || searchVO.getPageType().equals("insert"))
			{
								
				searchVO.setCreate_id(userInfo.getUserid());
				//설정 내용 저장			
				trainingImpl.insertTraining(searchVO);
				
				//승인데이터 생성
				TrainingVO vo=new TrainingVO();
				vo.setTraining_code(searchVO.getCode());
				excuteImpl.insertTrainingApproval(vo);							
				
				pageUrl = "/training/trainingForm.do";
				
				
			}
			else
			{
				if(searchVO.getType().equals("0")) //일반 훈련 생성
				{
					trainingImpl.updateTraining(searchVO);
					pageUrl = "/training/trainingForm.do";
				}
				else if(searchVO.getType().equals("1")) // 취향분석 훈련 생성
				{
					searchVO.setStatus("ready");
					trainingImpl.updateTraining2(searchVO);
					pageUrl = "/training/trainingForm2.do";
				}
				
			}
			
			//훈련 승인 테이블 생성(1=> 활성화)
			if(EgovProperties.getProperty("Globals.approval_type").equals("1"))
			{
				TrainingVO avo = new TrainingVO();		
				
				//권한이 admin일 경우 승인처리됨
				if("admin".equals(userInfo.getLev())){
					avo.setApproval_type("y");
					avo.setApproval_id(userInfo.getUserid());
				}else{
					//권한이 admin이 아닐 경우 수정시 관리자에게 승인요청하도록 승인 상태를  n상태로 변경
					avo.setApproval_type("n");
					avo.setApproval_id("");
				}
				avo.setTraining_code(searchVO.getCode());
				
				excuteImpl.updateTrainingApproval(avo);
			}else{
				//비활성화일 경우 무조건 승인된 훈련으로 처리됨
				TrainingVO avo = new TrainingVO();		
			
				avo.setApproval_type("y");
				avo.setApproval_id(userInfo.getUserid());
				avo.setTraining_code(searchVO.getCode());
				
				excuteImpl.updateTrainingApproval(avo);
			}
			
			ArrayList<HashMap> list = new ArrayList<HashMap>();
			
			HashMap hm = new HashMap();
			hm.put("key", "code");
			hm.put("value", searchVO.getCode());
			list.add(hm);
			
			model.addAttribute("action_url",pageUrl);
			model.addAttribute("list", list);
			
			return "common/post_action";
		
		}
	
	/**
	 * 취향분석 휸련 생성
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/trainingSave2.do")
	public String trainingSave2(
			Locale locale
			, @ModelAttribute("searchVO") TrainingVO searchVO 
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
		
			String return_url = "";
			
			if(searchVO.getPageType().equals("") || searchVO.getPageType().equals("step1"))
			{
				UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
				searchVO.setCreate_id(userInfo.getUserid());
								
				//설정 내용 저장
				trainingImpl.insertTraining2step1(searchVO);
				
				//훈련 승인 
				TrainingVO vo=new TrainingVO();
				vo.setTraining_code(searchVO.getCode());
				excuteImpl.insertTrainingApproval(vo);							
				
				
				return_url = "redirect:/training/trainingForm2.do?code="+searchVO.getCode();
				
			}
			else
			{
				
				trainingImpl.updateTraining(searchVO);
				return_url = "redirect:/training/TrainingList.do";
			}
			
			return return_url;
		
		}
	
	/**
	 * 팝업 자용자 등록용 팝업
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/training_add_user_pop.do")
	public String training_add_user_pop(
			Locale locale
			, @ModelAttribute("searchVO") TrainingVO searchVO 
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			String pageType = "";
			String parseType = "success";
			JSONObject jsonroot=new JSONObject();
			ArrayList<HashMap> list = null;
			ArrayList<HashMap> list2 = new ArrayList<HashMap>();
			ArrayList<HashMap> errList = new ArrayList<HashMap>();
			
			int user_cnt=0;
			int max_user_cnt= Integer.parseInt(EgovProperties.getProperty("Globals.training.max.user.count"));
			
			
			if(null==searchVO.getUploadfile())
			{
				pageType = "form";
			}
			else
			{
				try{
					
					FileInputStream fis= (FileInputStream) searchVO.getUploadfile().getInputStream();
				
					
					list = ExcelUtil.convertFileStreamToArrayList(fis);
			
				
					pageType = "proc";
					for(HashMap hm : list)
					{
						String email = StringUtil.refine(String.valueOf(hm.get("0")));
						String name = StringUtil.refine(String.valueOf(hm.get("1")));
						String department_name = StringUtil.refine(String.valueOf(hm.get("2")));
						String unikey = StringUtil.refine(String.valueOf(hm.get("3")));
						
						HashMap hm2 = new HashMap();
						if(StringUtil.isValidEmail(String.valueOf(hm.get("0")))==true && !hm.get("1").equals("") && !hm.get("2").equals("") && !hm.get("3").equals(""))
						{
							hm2.put("email", email);
							hm2.put("name", name);
							hm2.put("department_name", department_name);
							hm2.put("unikey", unikey);
							
							
							list2.add(hm2);
							
							user_cnt++;
						}
						else
						{							
							hm2.put("email", email);
							hm2.put("name", name);
							hm2.put("department_name", department_name);
							hm2.put("unikey", unikey);
							
							errList.add(hm2);
	
							parseType = "false";
						}
							
					}
									
				}
				catch(Exception e)
				{					
					e.printStackTrace();
					parseType = "false";				
				}
			}
			
			if(user_cnt > max_user_cnt){
				parseType = "user_false";		
			}
			
			
			model.addAttribute("errList",errList);
			model.addAttribute("list", list2);	
			
			model.addAttribute("parseType",parseType);						
			model.addAttribute("pageType",pageType);
					
			return "training/training_add_user_pop";
		}
	
	/**
	 * 취향분석 수신자 추가
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/training_add_user_pop2.do")
	public String training_add_user_pop2(
			Locale locale
			, @ModelAttribute("searchVO") TrainingVO searchVO 
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			String pageType = "";
			String parseType = "success";
			JSONObject jsonroot=new JSONObject();
			ArrayList<HashMap> list = null;
			ArrayList<HashMap> list2 = new ArrayList<HashMap>();
			ArrayList<HashMap> errList = new ArrayList<HashMap>();
			ArrayList<HashMap> category = new ArrayList<HashMap>();
				
			UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
			
			int user_cnt=0;
			int max_user_cnt= Integer.parseInt(EgovProperties.getProperty("Globals.training.max.user.count"));
			
			
			if(req.getParameter("training_code")!=null ){
				httpsession.setAttribute("training_code", req.getParameter("training_code"));			
			}
			
			
			if(null==searchVO.getUploadfile())
			{
				pageType = "form";
			}
			else
			{
				FileInputStream fis= (FileInputStream) searchVO.getUploadfile().getInputStream();
				try{
					list = ExcelUtil.convertFileStreamToArrayList(fis);
				}
				catch(Exception e)
				{
					
					e.printStackTrace();
				}
				
				//카테고리 단어 리스트 추출
				//trainingImpl.selecttraining
				//						
				List<TemplateVO> tempalteWordList = systemImpl.selectTemplateCateWordAllList(userInfo.getUserid());
								
				pageType = "proc";
				for(HashMap hm : list)
				{
					String email = StringUtil.refine(String.valueOf(hm.get("0")));
					String name = StringUtil.refine(String.valueOf(hm.get("1")));
					String department_name = StringUtil.refine(String.valueOf(hm.get("2")));
					String unikey = StringUtil.refine(String.valueOf(hm.get("3")));
					
					HashMap hm2 = new HashMap();
					
					
					if(StringUtil.isValidEmail(String.valueOf(hm.get("0")))==true && !hm.get("1").equals("") && !hm.get("2").equals("") && !hm.get("3").equals(""))
					{
						
						hm2.put("email", email);
						hm2.put("name", name);
						hm2.put("department_name", department_name);
						hm2.put("unikey", unikey);
						
						hm2=commonUtil.wordMapping(tempalteWordList,hm2);
												
						list2.add(hm2);
						
						user_cnt++;
					}
					else
					{
						
						hm2.put("email", email);
						hm2.put("name", name);
						hm2.put("department_name", department_name);
						hm2.put("unikey", unikey);
						
						errList.add(hm2);

						parseType = "false";
					}
						
				}
			
				if(user_cnt > max_user_cnt){
					parseType = "user_false";		
				}
				
				if(parseType.equals("success")){		
					
					String code=(String)httpsession.getAttribute("training_code");
					
					List<TemplateVO> tempalteAllList = systemImpl.selectTemplateRandomAllList();
					trainingImpl.insertTraining2(tempalteAllList,list2,code);				
				}
				
			}
			
			
			model.addAttribute("parseType",parseType);			
			
			model.addAttribute("errList",errList);
			model.addAttribute("list", list2);	
			
			model.addAttribute("pageType", pageType);
			
			return "training/training_add_user_pop2";
		}
	
	/**
	 * 해당 훈련에 등록된 grp(템플릿) list에 취향분석 수신자  랜덤으로 추가함
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/training_add_user_pop2_existing.do")
	public String training_add_user_pop2_existing(
			Locale locale
			, @ModelAttribute("searchVO") TrainingVO searchVO 
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			String pageType = "";
			String parseType = "success";
			JSONObject jsonroot=new JSONObject();
			ArrayList<HashMap> list = null;
			ArrayList<HashMap> list2 = new ArrayList<HashMap>();
			ArrayList<HashMap> errList = new ArrayList<HashMap>();
			
			int user_cnt=0;
			int max_user_cnt= Integer.parseInt(EgovProperties.getProperty("Globals.training.max.user.count"));
						
			UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
			
			
			if(req.getParameter("training_code")!=null ){
				httpsession.setAttribute("training_code", req.getParameter("training_code"));			
			}
			
			if(null==searchVO.getUploadfile())
			{
				pageType = "form";
			}
			else
			{
				FileInputStream fis= (FileInputStream) searchVO.getUploadfile().getInputStream();
				try{
					list = ExcelUtil.convertFileStreamToArrayList(fis);
				}
				catch(Exception e)
				{
					
					e.printStackTrace();
				}
										
				pageType = "proc";
				for(HashMap hm : list)
				{
					String email = StringUtil.refine(String.valueOf(hm.get("0")));
					String name = StringUtil.refine(String.valueOf(hm.get("1")));
					String department_name = StringUtil.refine(String.valueOf(hm.get("2")));
					String unikey = StringUtil.refine(String.valueOf(hm.get("3")));
					
					HashMap hm2 = new HashMap();
					
					
					if(StringUtil.isValidEmail(String.valueOf(hm.get("0")))==true && !hm.get("1").equals("") && !hm.get("2").equals("") && !hm.get("3").equals(""))
					{
						
						hm2.put("email", email);
						hm2.put("name", name);
						hm2.put("department_name", department_name);
						hm2.put("unikey", unikey);
						
						list2.add(hm2);
						
						user_cnt++;
					}
					else
					{
						
						hm2.put("email", email);
						hm2.put("name", name);
						hm2.put("department_name", department_name);
						hm2.put("unikey", unikey);
						
						errList.add(hm2);

						parseType = "false";
					}
						
				}
				
				//현재 등록된 훈련자 수
				int cur_user_cnt=trainingImpl.selectTrainingUserCnt((String)httpsession.getAttribute("training_code"));
				
				//등록 최대인원 제한
				if((user_cnt+cur_user_cnt) > max_user_cnt){
					parseType = "user_false";		
				}
				
			 //랜덤 조회 할수 있도록 등록 소스 추가
				
				if(parseType.equals("success")){		
					
					String code=(String)httpsession.getAttribute("training_code");
					String randrom_use=searchVO.getRandom_insert_use();
					
					if("true".equals(randrom_use)){
						List<TrainingVO> tempalteAllList=trainingImpl.selectTraining2GrpListByCode(code);
						
						//등록된 카테고리가 없을 경우 실패로 인식
						if(tempalteAllList.size()==0){
							parseType = "false_zero";
						}else{
							trainingImpl.insertTraining2_rand(tempalteAllList,list2,code);
						}
					}else if("false".equals(randrom_use)){
						trainingImpl.insertTraining2_selectGrp(list2,code,searchVO.getTg_code());
					}else{
						parseType = "false_zero";
					}
														
				}
				
			}
			
			model.addAttribute("parseType",parseType);
			model.addAttribute("errList",errList);
			model.addAttribute("list", list2);
			
			model.addAttribute("pageType", pageType);
			return "training/training_add_user_pop2";
		}
	
	/**
	 * 템플릿 선택페이지
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/template_select_popup.do")
	public String template_select_popup(
				Locale locale
				, @ModelAttribute("searchVO") TemplateVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		String pageType = "";
		TemplateVO vo = null;
		List<TemplateVO> cateList = null;
		List<TemplateVO> templateList = null;
		
		//템플릿 cate list 호출
		
		cateList = systemImpl.selectTemplateCateList(searchVO);
		
		if(searchVO.getTemplate_code()!=null && !"".equals(searchVO.getTemplate_code()))
		{
			pageType = "view";
			vo = systemImpl.selectTemplateByCode(searchVO.getTemplate_code());
		}
		else
		{
			pageType = "none";
		}
	
		model.addAttribute("detail", vo);
		model.addAttribute("pageType",pageType);
		model.addAttribute("cateList", cateList);
		model.addAttribute("templateList", templateList);
		
		
		//템플릿 선택
		return "training/template_select_popup";
	}
	
	/**
	 * 취향 분석 템플릿 수정 페이지
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/template_update_popup.do")
	public String template_update_popup(
				Locale locale
				, @ModelAttribute("searchVO") TemplateVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
	
		/////
		String pageType = "";
		TemplateVO vo = null;
		TrainingVO vo2 = new TrainingVO();
		List<TrainingVO> vo_list = null;
		List<TrainingVO> cateList = null;
		List<TemplateVO> templateList = null;		
		
		if(searchVO.getTemplate_code()!=null && !"".equals(searchVO.getTemplate_code()))
		{			
			pageType = "view";
			vo = systemImpl.selectTemplateByCode(searchVO.getTemplate_code());
			vo2=vo;

			vo2.setGp_title(vo.getTitle());
			vo2.setGp_send_name(vo.getSend_name());
			vo2.setGp_send_email(vo.getSend_email());
			vo2.setTraining_code(searchVO.getTraining_code());			
			vo2.setTc_code(searchVO.getTc_code());
			vo2.setTemplate_code(searchVO.getTemplate_code());
			vo2.setTg_code(searchVO.getTg_code());
		}else if(searchVO.getTg_code()!=null && !"".equals(searchVO.getTg_code()))
		{
			pageType = "view";
			vo_list = trainingImpl.selectTraining2GrpByCode(searchVO);
			vo2=vo_list.get(0);
			vo2.setTg_code(searchVO.getTg_code());
		}
		else
		{
			pageType = "none";
		}
		
		//템플릿 cate list 호출		
		cateList = trainingImpl.selectAllTemplistExceptGrp(vo2);
				
		model.addAttribute("detail", vo2);
		model.addAttribute("pageType",pageType);
		model.addAttribute("cateList", cateList);
		model.addAttribute("templateList", templateList);		
		
		//템플릿 선택
		return "training/template_update_popup";
	}
	
	/**
	 * 취향 분석 템플릿 수정 페이지를 통한 GRP 수정
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/grp_template_update.do")
	public void grp_template_update(
				Locale locale
				, @ModelAttribute("searchVO") TemplateVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		trainingImpl.updateTraining2grp(searchVO);
	}
	
	/**
	 *해당 훈련에 등록된 주 분류 카테고리 리스트 검색
	 * @param searchVO	
	 * @param model
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/ajax_tempalte_main_list.do")
	@ResponseBody 
	public ResponseEntity tempalte_mainList(				
				@ModelAttribute("searchVO") TrainingVO searchVO, 
				HttpServletRequest request,ModelMap model
			) throws Exception
	{
		HttpHeaders responseHeaders = new HttpHeaders();
		
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
		HashMap hm = new HashMap();
		
		List<TrainingVO> cateList = trainingImpl.selectTraining2GrpListByCode(searchVO.getTraining_code());		
		
		for(TrainingVO vo : cateList)
		{
				hm = new HashMap();
				hm.put("cate_name", vo.getCate_name());
				hm.put("cate_code", vo.getCate_code());
				hmlist.add(hm);
		}		

		JSONArray json = new JSONArray(hmlist);		
		return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
	}
	
	/**
	 *해당 훈련에 등록된 소 분류 카테고리 리스트 검색
	 * @param searchVO	
	 * @param model
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/ajax_tempalte_sub_list.do")
	@ResponseBody 
	public ResponseEntity tempalte_subList(				
				@ModelAttribute("searchVO") TrainingVO searchVO, 
				HttpServletRequest request,ModelMap model
			) throws Exception
	{
		HttpHeaders responseHeaders = new HttpHeaders();
		
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
		HashMap hm = new HashMap();
		String cate_code=searchVO.getCate_code();
		List<TrainingVO> tmpList = trainingImpl.selectTraining2GrpListByCode(searchVO.getTraining_code());		
		
		for(TrainingVO vo : tmpList)
		{
			if(null!=cate_code && cate_code.equals(vo.getCate_code())){
				hm = new HashMap();
				hm.put("tg_code", vo.getCode());
				hm.put("template_name", vo.getTemplate_name());
				hmlist.add(hm);
			}
		}		
		
		JSONArray json = new JSONArray(hmlist);		
		return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
	}
	
	/**
	 *해당 훈련에 등록된 카테고리를 제외한 카테고리 리스트 검색
	 * @param searchVO	
	 * @param model
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/ajax_tempalte_all_list.do")
	@ResponseBody 
	public ResponseEntity tempalte_allList(				
				@ModelAttribute("searchVO") TrainingVO searchVO, 
				HttpServletRequest request,ModelMap model
			) throws Exception
	{
		HttpHeaders responseHeaders = new HttpHeaders();
		
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
		HashMap hm = new HashMap();
	
		String type=searchVO.getType();
		String cate_code=searchVO.getCate_code();
		
		List<TrainingVO> cateList = trainingImpl.selectAllTemplistExceptGrp(searchVO);		
		
		for(TrainingVO vo : cateList)
		{
			if(null!=type && "maincate".equals(type)){
				
				hm = new HashMap();
				hm.put("cate_name", vo.getCate_name());
				hm.put("cate_code", vo.getCate_code());
				hmlist.add(hm);
				
			}else if(null!=type && "subcate".equals(type)){
				if(null!=cate_code && cate_code.equals(vo.getCate_code())){
					hm = new HashMap();
					hm.put("tc_code", vo.getCode());
					hm.put("template_name", vo.getTemplate_name());
					hmlist.add(hm);
				}
			}
		}
		
		JSONArray json = new JSONArray(hmlist);		
		return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
	}
	
	/**
	 * 기관 선택시 그룹리스트 출력용
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/training/ajax_tempalte_list.do")
	@ResponseBody 
	public ResponseEntity  tempalte_list(HttpServletRequest request,ModelMap model) throws Exception{
		
		HttpHeaders responseHeaders = new HttpHeaders();
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
		HashMap hm = new HashMap();
		
		String code = request.getParameter("code");
		
		if(null!=code && !"".equals(code))
		{
			TemplateVO tv = new TemplateVO();
			tv.setCate_code(code);
			List<TemplateVO> list = systemImpl.selectTemplateAllList(tv);
			for(TemplateVO vo : list)
			{
				hm = new HashMap();
				hm.put("template_name", vo.getTemplate_name());
				hm.put("code", vo.getCode());
				
				hmlist.add(hm);
			}
		}
		

		JSONArray json = new JSONArray(hmlist);		
		return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
		
	}
	
	 
	 
		@RequestMapping(value="/training/ajax_tempalte_view.do")
		@ResponseBody 
		public ResponseEntity  ajax_tempalte_view(HttpServletRequest request,ModelMap model) throws Exception{
			
			HttpHeaders responseHeaders = new HttpHeaders();
			ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
			HashMap hm = new HashMap();
			
			String code = request.getParameter("code");
			
			TemplateVO tv = new TemplateVO();
			
			tv.setCate_code(code);
			
			//List<TemplateVO> list = systemImpl.select
			
			
			TemplateVO vo = systemImpl.selectTemplateByCode(code);
			
			
			Gson gson = new Gson();
			String json = gson.toJson(vo);
			
			return new ResponseEntity(json,responseHeaders, HttpStatus.CREATED);
			
		}
		
		
		/**
		 * 파일 업로드용
		 * @param locale
		 * @param searchVO
		 * @param httpsession
		 * @param model
		 * @param req
		 * @param res
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value="/training/imgUploadForm_popup.do")
		public String imgUploadForm(
					Locale locale
					, @ModelAttribute("searchVO") TemplateVO searchVO 
					, HttpSession httpsession
					, Model model
					, HttpServletRequest req
					, HttpServletResponse res
				) throws Exception
		{
			
			String pageType = "";
			
			String code = searchVO.getCode();
			String imageUrl = "";
			if(!code.equals(""))
			{
				pageType = "view";
				imageUrl = EgovProperties.getProperty("Globals.url")+"/common/getImage.do?code="+code;
				model.addAttribute("imageUrl", imageUrl);
				model.addAttribute("code", code);
			}
			else
			{
				pageType = "form";
			}
			
			
			model.addAttribute("pageType", pageType);
			
			//템플릿 선택
			return "training/imgUploadForm_popup";
		}
		
		
		/**
		 * 파일업로드 진행
		 * @param locale
		 * @param searchVO
		 * @param httpsession
		 * @param model
		 * @param req
		 * @param res
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value="/training/imgUploadProc.do")
		public String imgUploadProc(
				Locale locale
				, @ModelAttribute("searchVO") TemplateVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
		{
			
			
				String view = "";
				String code = "";
				boolean uploadCheck = false;
				CommonVO cv = new CommonVO();
				String imageUrl = "";
				String rlFileNm  = "";
				BufferedImage ori = ImageIO.read(searchVO.getUploadfile().getInputStream());
				
				int w = ori.getWidth();
				int h = ori.getHeight();
			
				if(w>600){
					  
					  int y=(h*600)/w;
					  w=600;
					  h=y;
					 
				}
				
				
				
				
				String filename = searchVO.getUploadfile().getOriginalFilename();
				String filename_ext = filename.substring(filename.lastIndexOf(".")+1);
				filename_ext = filename_ext.toLowerCase();
				
				String[] allow_file = {"jpg","png","bmp","gif","jpeg"};
				int cnt = 0;
				for(int i=0;i<allow_file.length;i++){
					if(filename_ext.equals(allow_file[i])){
						cnt++;
					}
				}
				
				
				if(cnt>0)
				{
					String filePath = EgovProperties.getProperty("Globals.file.upload.path");
					SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM");
					String dirDate = formatter.format(new java.util.Date());
					String realFilePath = filePath + dirDate + "/";
					
					File file = new File(realFilePath);
					
					if(!file.exists()){
						file.mkdirs();
					}
					//시스템 url
					String url = EgovProperties.getProperty("Globals.url");
					
					SimpleDateFormat formatter2 = new SimpleDateFormat("yyyyMMddHHmmss");
					String today = formatter2.format(new java.util.Date());
					String realFileNm = today+ "_" +UUID.randomUUID().toString()+filename.substring(filename.lastIndexOf("."));
					
					rlFileNm = realFilePath + realFileNm;
					
					//실저장경로
					String path = dirDate+"/"+realFileNm;
					
					
					
					//저장경로
					cv.setPath(dirDate+"/");
					
					//원본명
					cv.setOri_name(filename);
					
					//저장명
					cv.setFile_name(realFileNm);
					
					UserInfoVO userinfo = SessionUtil.getSessionUserInfo();
					
					cv.setUc(userinfo.getCode());
					
					cv.setType("0");
					
					code = commonImpl.insertImage(cv);
					
					Thumbnails.of(ori).size(w, h).outputFormat(filename_ext).toFile(rlFileNm);
					imageUrl = EgovProperties.getProperty("Globals.url")+"/common/getImage.do?code="+code;
					
					uploadCheck = true;
					
					
					
				}
				
				if(cnt>0 && !code.equals(""))
				{
					view = "redirect:/training/imgUploadForm_popup.do?code="+code;
				}
				else
				{
					
					model.addAttribute("msg", "파일이 정상적이지 않습니다. 다시 시도해주세요!");
					view = "common/alert_back";
				}
				
		
				return view;
		}
		
		/**
		 * 
		 * 훈련 승인 요청
		 * @param locale
		 * @param searchVO
		 * @param httpsession
		 * @param model
		 * @param req
		 * @param res
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value="/training/training_approval_request.do")
		public String training_approval_request(
				Locale locale
				, @ModelAttribute("searchVO") TrainingVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
				, RedirectAttributes redirectAttr

			) throws Exception
			{	
				String pageUrl = "";
				
				TrainingVO trainingvo = trainingImpl.selectTrainingByCode(searchVO.getCode());
				
				if("update".equals(searchVO.getPageType()) || "ready".equals(trainingvo.getStatus()))
				{
					TrainingVO vo = new TrainingVO();
					vo.setCode(searchVO.getCode());
					vo.setStatus("approval");
					
					excuteImpl.updateTrainingStatus(vo);
										
				}				
				
				if(searchVO.getType().equals("0")) //일반 훈련 생성
				{
					pageUrl = "/training/trainingForm.do";
					
				}else if(searchVO.getType().equals("1")) // 취향분석 훈련 생성
				{
					pageUrl = "/training/trainingForm2.do";
				}
				
				ArrayList<HashMap> list = new ArrayList<HashMap>();
				
				HashMap hm = new HashMap();
				hm.put("key", "code");
				hm.put("value", searchVO.getCode());
				list.add(hm);
				
				model.addAttribute("action_url",pageUrl);
				model.addAttribute("list", list);
				
				return "common/post_action";
			
			}
		
		
		/**
		 * 
		 * 훈련 승인 취소
		 * @param locale
		 * @param searchVO
		 * @param httpsession
		 * @param model
		 * @param req
		 * @param res
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value="/training/training_approval_cancel.do")
		public String training_approval_cancel(
				Locale locale
				, @ModelAttribute("searchVO") TrainingVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
				, RedirectAttributes redirectAttr

			) throws Exception
			{	
				String pageUrl = "";
				
				TrainingVO trainingvo = trainingImpl.selectTrainingByCode(searchVO.getCode());
				
				if("update".equals(searchVO.getPageType()) || "approval".equals(trainingvo.getStatus()))
				{
					TrainingVO vo = new TrainingVO();
					vo.setCode(searchVO.getCode());
					vo.setStatus("ready");
					
					excuteImpl.updateTrainingStatus(vo);
						
				}
				
				if(searchVO.getType().equals("0")) //일반 훈련 생성
				{
					pageUrl = "/training/trainingForm.do";
					
				}else if(searchVO.getType().equals("1")) // 취향분석 훈련 생성
				{
					pageUrl = "/training/trainingForm2.do";
				}
				
				ArrayList<HashMap> list = new ArrayList<HashMap>();
				
				HashMap hm = new HashMap();
				hm.put("key", "code");
				hm.put("value", searchVO.getCode());
				list.add(hm);
				
				model.addAttribute("action_url",pageUrl);
				model.addAttribute("list", list);
				
				return "common/post_action";
			
			}
		
		/**
		 * 
		 * 훈련 승인(관리자)
		 * @param locale
		 * @param searchVO
		 * @param httpsession
		 * @param model
		 * @param req
		 * @param res
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value="/training/training_approval.do")
		public String training_approval(
				Locale locale
				, @ModelAttribute("searchVO") TrainingVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
				, RedirectAttributes redirectAttr

			) throws Exception
			{	
				String pageUrl = "";
				
				urlUtil uu = new urlUtil();
				String pageType = "";
				TrainingVO detail = null;
				
				UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
				searchVO.setUserid(userInfo.getUserid());
				
				TrainingVO trainingvo = trainingImpl.selectTrainingByCode(searchVO.getCode());
							
				if("update".equals(searchVO.getPageType()) && "approval".equals(trainingvo.getStatus()) && userInfo.getLev().equals("admin"))
				{
					TrainingVO vo = new TrainingVO();
					TrainingVO avo = new TrainingVO();
					
					vo.setCode(searchVO.getCode());
					vo.setStatus("ready");
				
					excuteImpl.updateTrainingStatus(vo);
					
					avo.setApproval_type("y");
					avo.setApproval_id(userInfo.getUserid());
					avo.setTraining_code(searchVO.getCode());
					
					excuteImpl.updateTrainingApproval(avo);
					
					//예약발송이 설정되어 있는 경우 훈련 승인시 바로 훈련 실행 (1=> 활성화)
					if(EgovProperties.getProperty("Globals.approval.direct.execution").equals("1"))
					{
						TrainingVO vo2 = new TrainingVO();	
						
						//예약발송이 설정되어 있는지 검사
						if(null != trainingvo.getReservation_type() && "Y".equals(trainingvo.getReservation_type())){
							vo2.setStatus("reservation");
							vo2.setReservation_date(searchVO.getReservation_date());
						}else{
							vo2.setStatus("send");
						}
						
						vo2.setCode(searchVO.getCode());
						
						//훈련 로그 생성
						if(null != trainingvo.getAll_send_type() && !("100".equals(trainingvo.getSend_percent())) &&  "N".equals(trainingvo.getAll_send_type())){
							excuteImpl.insertTrainingUserLogExcute(trainingvo);
							
							excuteImpl.insertTrainingUserLogExcuteEXcetp(trainingvo);
						}else{
							excuteImpl.insertTrainingUserLogExcute(trainingvo);
						}
						
						excuteImpl.updateTrainingStatus(vo2);
					}
				}
				
				if(searchVO.getType().equals("0")) //일반 훈련 생성
				{
					pageUrl = "/training/trainingForm.do";
					
				}else if(searchVO.getType().equals("1")) // 취향분석 훈련 생성
				{
					pageUrl = "/training/trainingForm2.do";
				}
				
				
				ArrayList<HashMap> list = new ArrayList<HashMap>();
				
				HashMap hm = new HashMap();
				hm.put("key", "code");
				hm.put("value", searchVO.getCode());
				list.add(hm);
				
				model.addAttribute("action_url",pageUrl);
				model.addAttribute("list", list);
				
				return "common/post_action";
			
			}
		
		
		/**
		 * 
		 * 발송 예약 취소
		 * @param locale
		 * @param searchVO
		 * @param httpsession
		 * @param model
		 * @param req
		 * @param res
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value="/training/training_reservation_cancel.do")
		public String training_reservation_cancel(
				Locale locale
				, @ModelAttribute("searchVO") TrainingVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
				, RedirectAttributes redirectAttr

			) throws Exception
			{	
				String pageUrl = "";
				
				TrainingVO trainingvo = trainingImpl.selectTrainingByCode(searchVO.getCode());
				
				if("update".equals(searchVO.getPageType()) || "reservation".equals(trainingvo.getStatus()))
				{	
					//해당 발송로그 삭제 및 신고등록 내역 삭제
					trainingImpl.deleteTrainingLogByCode(searchVO.getCode());
					trainingImpl.deleteTrainingRegisterByCode(searchVO.getCode());
					
					TrainingVO vo = new TrainingVO();
					vo.setCode(searchVO.getCode());
					vo.setStatus("ready");
					
					excuteImpl.updateTrainingStatus(vo);
						
				}
				
				
				if(searchVO.getType().equals("0")) //일반 훈련 생성
				{
					pageUrl = "/training/trainingForm.do";
					
				}else if(searchVO.getType().equals("1")) // 취향분석 훈련 생성
				{
					pageUrl = "/training/trainingForm2.do";
				}
				
				ArrayList<HashMap> list = new ArrayList<HashMap>();
				
				HashMap hm = new HashMap();
				hm.put("key", "code");
				hm.put("value", searchVO.getCode());
				list.add(hm);
				
				model.addAttribute("action_url",pageUrl);
				model.addAttribute("list", list);
				
				return "common/post_action";
			
			}
		
		/**
		 *해당 훈련에 에 대한 신고 URL 출력
		 * @param searchVO	
		 * @param model
		 * @param req
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value="/training/ajax_register_url_create.do")
		@ResponseBody 
		public ResponseEntity ajax_register_url_create(				
					@ModelAttribute("searchVO") TrainingVO searchVO, 
					HttpServletRequest request,ModelMap model
				) throws Exception
		{
			HttpHeaders responseHeaders = new HttpHeaders();
			urlUtil uu = new urlUtil();
			
			ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
			HashMap hm = new HashMap();
			
			
			
			
			if(null!=searchVO.getCode() || !("".equals(searchVO.getCode()))){
				
				TrainingVO tvo = trainingImpl.selectTrainingByCode(searchVO.getCode());		
				if(tvo != null){
						// 신고 기능 url
						String register_url =  tvo.getRegister_url();
						String register_url_param = "?t="+uu.urlEncode(searchVO.getCode());
							
						hm = new HashMap();
						hm.put("status", "success");
						hm.put("register_url", register_url+register_url_param);
						hmlist.add(hm);
				}else{
					hm = new HashMap();
					hm.put("status", "fail");
					hmlist.add(hm);
				}
			}else{
				hm = new HashMap();
				hm.put("status", "fail");
				hmlist.add(hm);
			}			
			
			JSONArray json = new JSONArray(hmlist);		
			return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
		}
		
		/**
		 *해당 훈련에 등록된 주 분류 카테고리 리스트 검색
		 * @param searchVO	
		 * @param model
		 * @param req
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value="/training/ajax_training_date_update.do")
		@ResponseBody 
		public ResponseEntity ajax_training_date_update(				
					@ModelAttribute("searchVO") TrainingVO searchVO, 
					HttpServletRequest request,ModelMap model
				) throws Exception
		{
			HttpHeaders responseHeaders = new HttpHeaders();
			
			ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
			HashMap hm = new HashMap();
			hm = new HashMap();
			
			UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
			
			MemberVO mv = new MemberVO();
			mv.setUserid(userInfo.getUserid());
			mv.setTraining_code(searchVO.getCode());
			
			List<MemberVO> chkList = memberImpl.selectMemberInstitutionList(mv);
			
			if(chkList.size()>0 || userInfo.getLev().equals("admin")){				
				
				trainingImpl.updateTrainingDate(searchVO);						
			
				hm.put("status", "success");
				hmlist.add(hm);
				
			}
			else{
				
				hm.put("status", "err");				
				hmlist.add(hm);
				
			}
			
			JSONArray json = new JSONArray(hmlist);		
			return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
		}

		/**
		 * 삭제해야 할 훈련 리스트 팝업
		 * @param locale
		 * @param searchVO
		 * @param httpsession
		 * @param model
		 * @param req
		 * @param res
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value="/training/training_del_valid_pop.do")
		public String training_del_valid_pop(
					Locale locale
					, @ModelAttribute("searchVO") TrainingVO searchVO 
					, HttpSession httpsession
					, Model model
					, HttpServletRequest req
					, HttpServletResponse res
				) throws Exception
		{
			
			UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
			searchVO.setUserid(userInfo.getUserid());
			/**
			 * 게시물 전체 데이터 추출
			 */
			int total = trainingImpl.selectDeleteExpectedTrainingListCnt(searchVO);
			
			/**
			 * page 처리 위한 데이터
			 */
			pageVO pagevo = new pageVO();
			pagevo.setPageSize(10);
			pagevo.setPageNo(searchVO.getPageNo());
			pagevo.setTotalCount(total); // 게시물 총 개수
			searchVO.setStartRowNum(pagevo.getStartRowNum());
			searchVO.setPageSize(pagevo.getPageSize());
			
			/**
			 * page처리 기반으로 실제 가져올 데이터 추출
			 */
			List<TrainingVO> list  = trainingImpl.selectDeleteExpectedTrainingList(searchVO);
			
			
			model.addAttribute("pageing", pagevo);
			model.addAttribute("list",list);
			
			return "training/training_del_valid_pop";
		}
		
		/**
		 * 삭제 팝업으로 인한 훈련 삭제
		 * @param request
		 * @param model
		 * @return
		 * @throws Exception  
		 */
		@RequestMapping(value="/training/training_pop_del.do")
		public String training_pop_del(
					Locale locale
					, @ModelAttribute("searchVO") TrainingVO searchVO 
					, HttpSession httpsession
					, Model model
					, HttpServletRequest req
					, HttpServletResponse res
				) throws Exception
		{
			
			String view = "";
		
			UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
			searchVO.setUserid(userInfo.getUserid());
	
			if( "admin".equals(userInfo.getLev()))
			{
				TrainingVO tvo=new TrainingVO();
				tvo.setTraining_code(searchVO.getCode());
				
				trainingImpl.deleteTrainingByCode(searchVO.getCode());
				trainingImpl.deleteTrainingLogByCode(searchVO.getCode());
				trainingImpl.deleteTrainingUserByCode(searchVO.getCode());
				trainingImpl.deleteTrainingRegisterByCode(searchVO.getCode());
				trainingImpl.deleteTrainingGrpByCdoe(tvo);
				trainingImpl.deleteTraining2UserByCdoe(tvo);
				
				//승인 테이블의 해당 훈련 데이터 삭제
				excuteImpl.deleteTrainingApproval(searchVO.getCode());
				
				model.addAttribute("msg", "정상적으로 삭제를 완료하였습니다.");
				
				model.addAttribute("redirect", "/training/training_del_valid_pop.do");
				
				view = "common/alert_redirect";
				
			}
			else
			{
				model.addAttribute("msg", "삭제를 실패하였습니다.");
				model.addAttribute("redirect", "/training/training_del_valid_pop.do");
				view = "common/alert_redirect";			
			}
			
		    return view;
		}
}
