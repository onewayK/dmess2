package kr.nshare.statistics.web;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.nshare.common.UserInfoVO;
import kr.nshare.common.pageVO;
import kr.nshare.common.util.EgovProperties;
import kr.nshare.common.util.ExcelUtil;
import kr.nshare.common.util.SessionUtil;
import kr.nshare.common.util.StringUtil;
import kr.nshare.common.util.commonUtil;
import kr.nshare.common.util.urlUtil;
import kr.nshare.request.service.RequestVO;
import kr.nshare.statistics.service.StatisticsVO;
import kr.nshare.statistics.service.impl.StatisticsService;
import kr.nshare.system.service.TemplateVO;
import kr.nshare.training.service.TrainingRegisterVO;
import kr.nshare.training.service.TrainingVO;
import kr.nshare.training.service.impl.TrainingService;

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

@Controller
public class StatisticalController {
	 @InitBinder
    public void initBinder(WebDataBinder dataBinder) {
        dataBinder.setAutoGrowCollectionLimit(20000);
    }
	 
	private static final Logger logger = LoggerFactory
			.getLogger(StatisticalController.class);

	@Autowired
	private TrainingService trainingImpl;

	@Autowired
	private StatisticsService statisticsImpl;

	/**
	 * ????????? ??????
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
	@RequestMapping(value = "/statistical/chart.do")
	public String statistical_chart_list(Locale locale,
			@ModelAttribute("searchVO") StatisticsVO searchVO,
			HttpSession httpsession, Model model, HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		TrainingVO tvo = new TrainingVO();

		// ???????????????
		List<TrainingVO> groupList = null;
		//
		List<TrainingVO> trainingList = new ArrayList<TrainingVO>();
		List<TrainingVO> trainingList_temp = null;
		TrainingVO trainingDetail = null;
		List<StatisticsVO> trainingTnameList = null;
		StatisticsVO detail = null;
		List<StatisticsVO> list = null;
		StatisticsVO list_total=null;
		
		// ?????? ????????? ??????
		List<TrainingVO> list2 = trainingImpl.selectMemberInstitutionList(tvo);

		TemplateVO tv = new TemplateVO();
		tv.setCate_code(searchVO.getGroup_code());
		// templateList = systemImpl.selectTemplateAllList(tv);

		// ????????? ????????????????????????
		if (!searchVO.getSearchInstitution().equals("")) {

			// ???????????? ??? ?????? ????????? ??????
			if (!searchVO.getSearchInstitution().equals("")) {
				TrainingVO temp_vo = new TrainingVO();
				temp_vo.setInstitution_code(searchVO.getSearchInstitution());
				groupList = statisticsImpl.selectGroupList(temp_vo);

			}

			// ??????????????? ??????????????? ???
			if (!searchVO.getGroup_code().equals("")) {
				TrainingVO temp_vo = new TrainingVO();
				temp_vo.setIg_code(searchVO.getGroup_code());

				// Training??? ??????
				trainingList_temp = statisticsImpl
						.selectTrainingListByGroupCode(temp_vo);

				for (TrainingVO vo : trainingList_temp) {
					boolean chk = commonUtil.checkEquals(searchVO
							.getTraining_code().split(","), vo.getCode());

					if (chk == true) {
						vo.setSelected(" selected ");
						trainingList.add(vo);
					} else {
						trainingList.add(vo);
					}

				}
			}
		}

		if (!searchVO.getTraining_code().equals("")) {
			List<StatisticsVO> training_list = new ArrayList<StatisticsVO>();

			for (int i = 0; i < searchVO.getTraining_code().split(",").length; i++) {
				StatisticsVO sv = new StatisticsVO();
				sv.setCode(searchVO.getTraining_code().split(",")[i]);
				training_list.add(sv);
			}
			
			detail = statisticsImpl.selectTrainingLogChart(training_list);
			trainingDetail = trainingImpl.selectTrainingByCode(searchVO.getTraining_code());
			
			list=statisticsImpl.selectTrainingLogChartReport(training_list);
			list_total=  statisticsImpl.selectTrainingLogChartReportTotal(Arrays.asList(searchVO.getTraining_code().split(",")));
			
			model.addAttribute("trainingDetail", trainingDetail);
		}

		model.addAttribute("detail", detail);
		
		model.addAttribute("list", list);
		model.addAttribute("listTotal", list_total);
		
		model.addAttribute("trainingTnameList", trainingTnameList);
		model.addAttribute("groupList", groupList);
		model.addAttribute("trainingList", trainingList);

		model.addAttribute("list2", list2);

		return "statistical/chart";
	}

	/**
	 * ????????? ??????(????????????)
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
	@RequestMapping(value = "/statistical/chart_dialog.do")
	public String statistical_chart_list_dialog(Locale locale,
			@ModelAttribute("searchVO") StatisticsVO searchVO,
			HttpSession httpsession, Model model, HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		TrainingVO tvo = new TrainingVO();

		// ???????????????
		List<TrainingVO> groupList = null;
		//
		List<TrainingVO> trainingList = new ArrayList<TrainingVO>();
		
		TrainingVO trainingDetail = null;
		List<StatisticsVO> trainingTnameList = null;
		StatisticsVO detail = null;
		List<StatisticsVO> list = null;
		StatisticsVO list_total=null;
		
		// ?????? ????????? ??????
		List<TrainingVO> list2 = trainingImpl.selectMemberInstitutionList(tvo);

		if (!searchVO.getTraining_code().equals("")) {
			List<StatisticsVO> training_list = new ArrayList<StatisticsVO>();

			for (int i = 0; i < searchVO.getTraining_code().split(",").length; i++) {
				StatisticsVO sv = new StatisticsVO();
				sv.setCode(searchVO.getTraining_code().split(",")[i]);
				training_list.add(sv);
			}

			detail = statisticsImpl.selectTrainingLogChart(training_list);
			trainingDetail = trainingImpl.selectTrainingByCode(searchVO.getTraining_code());
			
			list=statisticsImpl.selectTrainingLogChartReport(training_list);
			list_total=  statisticsImpl.selectTrainingLogChartReportTotal(Arrays.asList(searchVO.getTraining_code().split(",")));
			
			model.addAttribute("trainingDetail", trainingDetail);
		}

		model.addAttribute("detail", detail);
		model.addAttribute("list", list);
		model.addAttribute("listTotal", list_total);
		
		model.addAttribute("trainingTnameList", trainingTnameList);
		model.addAttribute("groupList", groupList);
		model.addAttribute("trainingList", trainingList);

		model.addAttribute("list2", list2);

		return "statistical/chart";
	}
	/**
	 * ????????? ?????? ??????
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
	@RequestMapping(value = "/statistical/chart2.do")
	public String statistical_chart2_list(Locale locale,
			@ModelAttribute("searchVO") StatisticsVO searchVO,
			HttpSession httpsession, Model model, HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		TrainingVO tvo = new TrainingVO();

		// ???????????????
		List<TrainingVO> groupList = new ArrayList<TrainingVO>();
		List<TrainingVO> groupList_temp = null;

		//
		List<TrainingVO> trainingList = new ArrayList<TrainingVO>();
		List<TrainingVO> trainingList_temp = null;
		TrainingVO trainingDetail = null;
		List<StatisticsVO> trainingTnameList = null;
		StatisticsVO detail = null;
		List<StatisticsVO> list = null;

		// ?????? ????????? ??????
		List<TrainingVO> list2 = trainingImpl.selectMemberInstitutionList(tvo);

		TemplateVO tv = new TemplateVO();
		tv.setCate_code(searchVO.getGroup_code());
		// templateList = systemImpl.selectTemplateAllList(tv);

		// ????????? ????????????????????????
		if (!searchVO.getSearchInstitution().equals("")) {

			// ???????????? ??? ?????? ????????? ??????
			if (!searchVO.getSearchInstitution().equals("")) {
				TrainingVO temp_vo = new TrainingVO();
				temp_vo.setInstitution_code(searchVO.getSearchInstitution());
				groupList_temp = statisticsImpl.selectGroupList(temp_vo);
				for (TrainingVO vo : groupList_temp) {
					boolean chk = commonUtil.checkEquals(searchVO
							.getGroup_code().split(","), vo.getCode());

					if (chk == true) {
						vo.setSelected(" selected ");
						groupList.add(vo);
					} else {
						groupList.add(vo);
					}

				}
			}

		}

		if (!searchVO.getGroup_code().equals("")) {
			List<StatisticsVO> temp_group_list = new ArrayList<StatisticsVO>();

			for (int i = 0; i < searchVO.getGroup_code().split(",").length; i++) {
				StatisticsVO sv = new StatisticsVO();
				sv.setIg_code(searchVO.getGroup_code().split(",")[i]);
				temp_group_list.add(sv);
			}

			list = statisticsImpl
					.selectGroupStatisticalByGroup_code(temp_group_list);

		}

		model.addAttribute("detail", detail);
		model.addAttribute("trainingTnameList", trainingTnameList);
		model.addAttribute("groupList", groupList);
		model.addAttribute("trainingList", trainingList);

		model.addAttribute("list", list);
		model.addAttribute("list2", list2);

		return "statistical/chart2";
	}

	/**
	 * ?????? ?????????
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
	@RequestMapping(value = "/statistical/registerList.do")
	public String registerList(Locale locale,
			@ModelAttribute("searchVO") TrainingVO searchVO
			, HttpSession httpsession, Model model
			, HttpServletRequest req
			,HttpServletResponse res) throws Exception {
		
		TrainingVO tvo = new TrainingVO();
		pageVO pagevo = new pageVO();
		StatisticsVO detail = null;

		TrainingVO trainingDetail = null;

		List<TrainingRegisterVO> list = null;

		TrainingRegisterVO searchVO2 = new TrainingRegisterVO();

		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();

		// ?????? ????????? ??????
		List<TrainingVO> list2 = trainingImpl.selectMemberInstitutionList(tvo);
	
		// ???????????????
		List<TrainingVO> groupList = null;
		
		//???????????????
		List<TrainingVO> trainingList = null;
				
		// ????????? ????????????????????????
		if (!searchVO.getSearchInstitution().equals("")) {

			// ???????????? ??? ?????? ????????? ??????
			if (!searchVO.getSearchInstitution().equals("")) {
				TrainingVO temp_vo = new TrainingVO();
				temp_vo.setInstitution_code(searchVO.getSearchInstitution());
				groupList = statisticsImpl.selectGroupList(temp_vo);
			}

			// ??????????????? ??????????????? ???
			if (!searchVO.getGroup_code().equals("")) {
				TrainingVO temp_vo = new TrainingVO();
				temp_vo.setIg_code(searchVO.getGroup_code());				
				trainingList = statisticsImpl.selectTrainingListByGroupCode(temp_vo);			
			}
		}
		
		if (!searchVO.getTraining_code().equals("")) {

			searchVO2.setTraining_code(searchVO.getTraining_code());
			searchVO2.setName(searchVO.getName());
			searchVO2.setEmail(searchVO.getEmail());
			searchVO2.setPageNo(searchVO.getPageNo());

			searchVO2.setSearchCondition(searchVO.getSearchCondition());
			searchVO2.setSearchKeyword(searchVO.getSearchKeyword());

			TrainingRegisterVO trv = new TrainingRegisterVO();
			
			int total= 0;
			
			if("Y".equals(searchVO.getReduplication())){
				total = statisticsImpl.selectTrainingRegisterListCntExceptReduplication(searchVO2);
			}else{
				total  = statisticsImpl.selectTrainingRegisterListCnt(searchVO2);
			}		
			
			/**
			 * page ?????? ?????? ?????????
			 */
			pagevo.setPageNo(searchVO2.getPageNo());
			pagevo.setTotalCount(total); // ????????? ??? ??????
			
			searchVO2.setStartRowNum(pagevo.getStartRowNum());
			searchVO2.setPageSize(pagevo.getPageSize());
			
			/**
			 * ?????? ?????? 
			 */
			if(null != searchVO.getSortcolumn() && !"".equals(searchVO.getSortcolumn())
				&& null != searchVO.getOrderBy() && !"".equals(searchVO.getOrderBy())){
				searchVO2.setSortcolumn(searchVO.getSortcolumn());
				
				if("asc".equals(searchVO.getOrderBy())){
					searchVO2.setOrderBy("asc");
				}else{
					searchVO2.setOrderBy("desc");
				}
			}else{
				searchVO2.setSortcolumn("code");
				searchVO2.setOrderBy("asc");
				
				searchVO.setSortcolumn("code");
				searchVO.setOrderBy("asc");
			}
			
			
			
			/**
			 * page?????? ???????????? ?????? ????????? ????????? ??????
			 */
			if("Y".equals(searchVO.getReduplication())){
				list = statisticsImpl.selectTrainingRegisterExceptReduplication(searchVO2);
			}else{
				list = statisticsImpl.selectTrainingRegisterList(searchVO2);
			}		
			
			trainingDetail = trainingImpl.selectTrainingByCode(searchVO
					.getTraining_code());
			model.addAttribute("trainingDetail", trainingDetail);

		}
		
		model.addAttribute("groupList", groupList);
		model.addAttribute("trainingList", trainingList);
		
		model.addAttribute("pageing", pagevo);
		model.addAttribute("detail", detail);
		model.addAttribute("list2", list2);
		model.addAttribute("list", list);
		model.addAttribute("userInfo", userInfo);

		return "statistical/registerList";
	}

	@RequestMapping(value = { "/statistical/register.do" })
	public String register_data(Locale locale,
			@ModelAttribute("searchVO") RequestVO searchVO,
			HttpSession httpsession, Model model, HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		
		urlUtil uu = new urlUtil();
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		TrainingVO tvo2 = new TrainingVO();
		
		List<TrainingVO> list = trainingImpl.selectMemberInstitutionList(tvo2);
		
		model.addAttribute("list", list);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("msg", searchVO.getMsg());
		return "statistical/register";
	}

	@RequestMapping(value = { "/statistical/register2.do" })
	public String register_data2(Locale locale,
			@ModelAttribute("searchVO") RequestVO searchVO,
			HttpSession httpsession, Model model, HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		
		urlUtil uu = new urlUtil();
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		TrainingVO tvo2 = new TrainingVO();
		
		List<TrainingVO> list = trainingImpl.selectMemberInstitutionList(tvo2);
		
		model.addAttribute("list", list);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("msg", searchVO.getMsg());
		return "statistical/register2";
	}
	
	//??????????????? ????????????
	@RequestMapping(value = { "/statistical/register_save2.do" })
	public String register_save2_data(Locale locale,
			@ModelAttribute("searchVO") TrainingVO searchVO,
			HttpSession httpsession, Model model, HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();

		urlUtil uu = new urlUtil();

		List<TrainingVO> list;
		TrainingRegisterVO trv = new TrainingRegisterVO();
		String msg = "";
		String url = "";
		String redirect = "";
		
		List<TrainingVO> u_list = trainingImpl.selectTrainingUserStatusByCode(searchVO.getTraining_code());
				
		if (!"".equals(searchVO.getTraining_code())) {
			if (null != searchVO.getListvo() && searchVO.getListvo().size() > 0) {
				
				trv.setTraining_code(searchVO.getTraining_code());
				
				for (TrainingVO tempvo : searchVO.getListvo()){
					if(!"".equals(tempvo.getName()) && !"".equals(tempvo.getEmail())){
						for(TrainingVO uvo : u_list){
							if("end".equals(uvo.getStatus()) && tempvo.getName().equals(uvo.getName()) && tempvo.getEmail().equals(uvo.getEmail()))
							{
								trv.setMatching_flag("C_Y");				
								break;
							}						
						}	
						
						if(null == trv.getMatching_flag() || "".equals(trv.getMatching_flag())){
							trv.setMatching_flag("C_N");
						}
							
						trv.setEmail(tempvo.getEmail());
						trv.setName(tempvo.getName());
						trv.setContent(tempvo.getContent());
						trv.setTitle(tempvo.getTitle());
						trv.setSdate(tempvo.getSdate()+":00");
						
						if(EgovProperties.getProperty("Globals.register.valid.send.service").equals("1"))
						{
							trv.setCheck_mail_status("N");
						}else{
							trv.setCheck_mail_status("Y");
						}
						
						trainingImpl.insertTrainingRegister2(trv);
						trv.setMatching_flag("");
					}
				}
				
				msg = "??????????????? ?????????????????????.";
				redirect = "/statistical/registerList.do";
				url = "common/alert_redirect";
				
			} else {
				msg = "???????????? ???????????? ???????????????.";
				url = "common/alert_back";
			}
			
		}else {
			msg = "???????????? ???????????? ???????????????.";
			url = "common/alert_back";
		}


		model.addAttribute("redirect", redirect);
		model.addAttribute("msg", msg);
		return url;

	}
	
	/**
	 * ??????????????? ?????? ????????? ?????? ?????? ??????(Y, N)??? ?????? ?????? ?????? 
	 * @param searchVO	
	 * @param model
	 * @param req
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/statistical/ajax_register_matching_list.do")
	@ResponseBody 
	public ResponseEntity register_matching_list(				
				@ModelAttribute("searchVO") TrainingVO searchVO, 
				HttpServletRequest request
				,ModelMap model
			) throws Exception
	{
		HttpHeaders responseHeaders = new HttpHeaders();
		
		HashMap hm = new HashMap();
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
					
		List<TrainingVO> u_list = trainingImpl.selectTrainingUserStatusByCode(searchVO.getTraining_code());
		
		if(!"".equals(searchVO.getTraining_code()))
		{
			if (null != searchVO.getListvo() && searchVO.getListvo().size() > 0) {
				
				for (TrainingVO tempvo : searchVO.getListvo()) {
					if(!"".equals(tempvo.getName()) && !"".equals(tempvo.getEmail())){
											
						hm = new HashMap();
						hm.put("userCode", tempvo.getCode());
						
						for(TrainingVO uvo : u_list){
							if("end".equals(uvo.getStatus()) && tempvo.getName().equals(uvo.getName()) && tempvo.getEmail().equals(uvo.getEmail()))
							{
								hm.put("matching_flag", "Y");
								break;
							}						
						}	
						
						hmlist.add(hm);	
					}
				}	
			}
		}				
		
		JSONArray json = new JSONArray(hmlist);		
		return new ResponseEntity(json.toString(),responseHeaders, HttpStatus.CREATED);
	}
	
	@RequestMapping(value = { "/statistical/register_save.do" })
	public String register_save_data(Locale locale,
			@ModelAttribute("searchVO") RequestVO searchVO,
			HttpSession httpsession, Model model, HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();

		urlUtil uu = new urlUtil();

		List<TrainingVO> list;
		TrainingRegisterVO trv = new TrainingRegisterVO();
		String msg = "";
		String url = "";
		String redirect = "";
		TrainingVO vo = new TrainingVO();
		
		Date d = new Date();
		String date = commonUtil.getDateString2(d);

		if (!"".equals(searchVO.getTraining_code())) {

			if (!searchVO.getRegister_user().equals("")
					&& !"".equals(searchVO.getTitle())
					&& !"".equals(searchVO.getContent())) {

				String register_user = searchVO.getRegister_user();

				String[] register_data = register_user.split(",");

				searchVO.setEmail(register_data[0]);
				searchVO.setName(register_data[1]);

				trv.setMatching_flag("C_Y");
				trv.setEmail(searchVO.getEmail());
				trv.setName(searchVO.getName());
				trv.setContent(searchVO.getContent());
				trv.setTitle(searchVO.getTitle());
				trv.setTraining_code(searchVO.getTraining_code());
		
				if("Y".equals(searchVO.getSdate_use())){
					trv.setSdate(searchVO.getSdate()+":00");					
				}else{
					trv.setSdate(date);		
				}
				
				if(EgovProperties.getProperty("Globals.register.valid.send.service").equals("1"))
				{
					trv.setCheck_mail_status("N");
				}else{
					trv.setCheck_mail_status("Y");
				}
				
				trainingImpl.insertTrainingRegister2(trv);

				msg = "??????????????? ?????????????????????.";
				redirect = "/statistical/registerList.do";
				url = "common/alert_redirect";
			} else {
				msg = "???????????? ???????????? ???????????????.";
				url = "common/alert_back";
			}
		}

		model.addAttribute("redirect", redirect);
		model.addAttribute("msg", msg);
		return url;

	}
	
	/**
	 * ?????? ?????? ????????? ??????
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
@RequestMapping(value="/statistical/register_add_pop.do")
public String training_add_pop(
		Locale locale
		, @ModelAttribute("searchVO") RequestVO searchVO 
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
					String title = StringUtil.refine(String.valueOf(hm.get("0")));
					String email = StringUtil.refine(String.valueOf(hm.get("1")));
					String name = StringUtil.refine(String.valueOf(hm.get("2")));
					String content = StringUtil.refine(String.valueOf(hm.get("3")));
					String sdate = StringUtil.refine(String.valueOf(hm.get("4")));
					
					HashMap hm2 = new HashMap();
						
					if(!hm.get("0").equals("") && StringUtil.isValidEmail(String.valueOf(hm.get("1")))==true 
							&& !hm.get("2").equals("") && !hm.get("3").equals("")
							&& StringUtil.isValidDate(String.valueOf(hm.get("4")))==true )
					{						
						hm2.put("title", title);
						hm2.put("email", email);
						hm2.put("name", name);
						hm2.put("content", content);
						hm2.put("sdate", sdate);
						
						list2.add(hm2);
					}
					else
					{		
						hm2.put("title", title);
						hm2.put("email", email);
						hm2.put("name", name);
						hm2.put("content", content);
						hm2.put("sdate", sdate);
						
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
		
		model.addAttribute("parseType",parseType);
		model.addAttribute("errList",errList);
		model.addAttribute("list", list2);
		
		model.addAttribute("pageType", pageType);
		return "/statistical/register_add_pop";
	}
	/**
	 * ????????? ?????????
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
	@RequestMapping(value = "/statistical/report.do")
	public String report(Locale locale,
			@ModelAttribute("searchVO") StatisticsVO searchVO,
			HttpSession httpsession, Model model, HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		TrainingVO tvo = new TrainingVO();

		List<StatisticsVO> list = null;

		// ???????????????
		List<TrainingVO> groupList = null;
		//
		List<StatisticsVO> training_sum_list= null; 
		List<TrainingVO> trainingList = new ArrayList<TrainingVO>();
		List<TrainingVO> trainingList_temp = null;
		TrainingVO trainingDetail = null;
		List<StatisticsVO> trainingTnameList = null;

		// ?????? ????????? ??????
		List<TrainingVO> list2 = trainingImpl.selectMemberInstitutionList(tvo);

		TemplateVO tv = new TemplateVO();
		tv.setCate_code(searchVO.getGroup_code());
		// templateList = systemImpl.selectTemplateAllList(tv);

		// ????????? ????????????????????????
		if (!searchVO.getSearchCondition().equals("")) {

			// ???????????? ??? ?????? ????????? ??????
			if (!searchVO.getSearchInstitution().equals("")) {
				TrainingVO temp_vo = new TrainingVO();
				temp_vo.setInstitution_code(searchVO.getSearchInstitution());
				groupList = statisticsImpl.selectGroupList(temp_vo);

			}

			// ??????????????? ??????????????? ???
			if (!searchVO.getGroup_code().equals("")) {
				TrainingVO temp_vo = new TrainingVO();
				temp_vo.setIg_code(searchVO.getGroup_code());

				// Training??? ??????
				trainingList_temp = statisticsImpl
						.selectTrainingListByGroupCode(temp_vo);

				for (TrainingVO vo : trainingList_temp) {
					boolean chk = commonUtil.checkEquals(searchVO
							.getTraining_code().split(","), vo.getCode());

					if (chk == true) {
						vo.setSelected(" selected ");
						trainingList.add(vo);
					} else {
						trainingList.add(vo);
					}

				}
			}
		}

		// ???????????? ?????? ??????(????????????)
		if (searchVO.getSearchCondition().equals("type1")
				&& !searchVO.getTraining_code().equals("")) {
			
			List<StatisticsVO> training_list = new ArrayList<StatisticsVO>();

			for (int i = 0; i < searchVO.getTraining_code().split(",").length; i++) {
				StatisticsVO sv = new StatisticsVO();
				sv.setCode(searchVO.getTraining_code().split(",")[i]);
				training_list.add(sv);
			}
			
			list = statisticsImpl.selectTrainingLogListGrupByUser2(searchVO
					.getTraining_code().split(","));

			training_sum_list = statisticsImpl.selectTrainingLogChartReport(training_list);
			
			trainingDetail = trainingImpl.selectTrainingByCode(searchVO
					.getTraining_code());
			trainingTnameList = statisticsImpl.selectTrainingGroupList(searchVO
					.getTraining_code().split(","));
			
			model.addAttribute("training_sum_list", training_sum_list);
			model.addAttribute("trainingDetail", trainingDetail);
			
		} else if (searchVO.getSearchCondition().equals("type2")
				&& !searchVO.getTraining_code().equals("")) // ?????????
		{
			List<StatisticsVO> training_list = new ArrayList<StatisticsVO>();

			for (int i = 0; i < searchVO.getTraining_code().split(",").length; i++) {
				StatisticsVO sv = new StatisticsVO();
				sv.setCode(searchVO.getTraining_code().split(",")[i]);
				training_list.add(sv);
			}
			
			list = statisticsImpl
					.selectTrainingLogListGrupByDepartment2(searchVO
							.getTraining_code().split(","));

			training_sum_list = statisticsImpl.selectTrainingLogChartReport(training_list);
			
			trainingDetail = trainingImpl.selectTrainingByCode(searchVO
					.getTraining_code());
			
			model.addAttribute("training_sum_list", training_sum_list);
			model.addAttribute("trainingDetail", trainingDetail);
			
			trainingTnameList = statisticsImpl.selectTrainingGroupList(searchVO
					.getTraining_code().split(","));
			trainingTnameList = statisticsImpl.selectTrainingGroupList(searchVO
					.getTraining_code().split(","));
		}

		model.addAttribute("trainingTnameList", trainingTnameList);
		model.addAttribute("groupList", groupList);
		model.addAttribute("trainingList", trainingList);

		model.addAttribute("list", list);
		model.addAttribute("list2", list2);
		return "statistical/report";
	}

	/**
	 *  ?????? ????????? ????????? ????????? ??????
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
	@RequestMapping(value = "/statistical/report_dialog.do")
	public String report_dialog(Locale locale,
			@ModelAttribute("searchVO") StatisticsVO searchVO,
			HttpSession httpsession, Model model, HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		TrainingVO tvo = new TrainingVO();

		List<StatisticsVO> list = null;

		// ???????????????
		List<TrainingVO> groupList = null;
		//
		List<StatisticsVO> training_sum_list= null; 
			
		TrainingVO trainingDetail = null;
		List<StatisticsVO> trainingTnameList = null;

		// ?????? ????????? ??????
		List<TrainingVO> list2 = trainingImpl.selectMemberInstitutionList(tvo);

		TemplateVO tv = new TemplateVO();
		tv.setCate_code(searchVO.getGroup_code());
		// templateList = systemImpl.selectTemplateAllList(tv);
	

		// ???????????? ?????? ??????(????????????)
		if (searchVO.getSearchCondition().equals("type1")
				&& !searchVO.getTraining_code().equals("")) {
			
			List<StatisticsVO> training_list = new ArrayList<StatisticsVO>();

			for (int i = 0; i < searchVO.getTraining_code().split(",").length; i++) {
				StatisticsVO sv = new StatisticsVO();
				sv.setCode(searchVO.getTraining_code().split(",")[i]);
				training_list.add(sv);
			}
			
			list = statisticsImpl.selectTrainingLogListGrupByUser2(searchVO
					.getTraining_code().split(","));

			training_sum_list = statisticsImpl.selectTrainingLogChartReport(training_list);
			
			trainingDetail = trainingImpl.selectTrainingByCode(searchVO
					.getTraining_code());
			trainingTnameList = statisticsImpl.selectTrainingGroupList(searchVO
					.getTraining_code().split(","));
			
			model.addAttribute("training_sum_list", training_sum_list);
			model.addAttribute("trainingDetail", trainingDetail);
			
		} else if (searchVO.getSearchCondition().equals("type2")
				&& !searchVO.getTraining_code().equals("")) // ?????????
		{
			List<StatisticsVO> training_list = new ArrayList<StatisticsVO>();

			for (int i = 0; i < searchVO.getTraining_code().split(",").length; i++) {
				StatisticsVO sv = new StatisticsVO();
				sv.setCode(searchVO.getTraining_code().split(",")[i]);
				training_list.add(sv);
			}
			
			list = statisticsImpl
					.selectTrainingLogListGrupByDepartment2(searchVO
							.getTraining_code().split(","));

			training_sum_list = statisticsImpl.selectTrainingLogChartReport(training_list);
			
			trainingDetail = trainingImpl.selectTrainingByCode(searchVO
					.getTraining_code());
			
			model.addAttribute("training_sum_list", training_sum_list);
			model.addAttribute("trainingDetail", trainingDetail);
			
			trainingTnameList = statisticsImpl.selectTrainingGroupList(searchVO
					.getTraining_code().split(","));
			trainingTnameList = statisticsImpl.selectTrainingGroupList(searchVO
					.getTraining_code().split(","));
		}

		model.addAttribute("trainingTnameList", trainingTnameList);
		model.addAttribute("groupList", groupList);
		
		model.addAttribute("list", list);
		model.addAttribute("list2", list2);
		return "statistical/report";
	}
	
	/**
	 * ?????? ?????? ?????? ??????
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
	@RequestMapping(value = "/statistical/phishing_view.do")
	public String phishing_view(Locale locale,
			@ModelAttribute("searchVO") StatisticsVO searchVO,
			HttpSession httpsession, Model model, HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		TrainingVO tvo = new TrainingVO();

		List<StatisticsVO> list = statisticsImpl.selectPhishingList(searchVO);
		model.addAttribute("list", list);
		return "statistical/phishing_popup";
	}

	/**
	 * ?????? ????????? ??????
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/statistical/ajax_institutionList.do")
	@ResponseBody
	public ResponseEntity ajax_institutionList(HttpServletRequest request,
			ModelMap model) throws Exception {

		HttpHeaders responseHeaders = new HttpHeaders();
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();

		String code = request.getParameter("code");

		String type = "";
		String searchCondition = "";

		/**
		 * if(null!=request.getParameter("searchCondition")) { searchCondition =
		 * request.getParameter("searchCondition"); }
		 **/

		if (null != request.getParameter("type")) {

			type = request.getParameter("type");
		}

		// ??????
		if (type.equals("0")) {
			if (!"".equals(code)) {
				TrainingVO temp_vo = new TrainingVO();
				temp_vo.setInstitution_code(code);
				List<TrainingVO> list = statisticsImpl.selectGroupList(temp_vo);

				for (TrainingVO vo : list) {
					HashMap hm = new HashMap();
					hm.put("code", vo.getCode());
					hm.put("group_name", vo.getGroup_name());
					hmlist.add(hm);
				}

			}
		} else if (type.equals("1")) // ??????
		{

			if (!"".equals(code)) {
				TrainingVO temp_vo = new TrainingVO();
				temp_vo.setIg_code(code);
				// temp_vo.setSearchCondition(searchCondition);

				// Training??? ??????
				List<TrainingVO> list = statisticsImpl
						.selectTrainingListByGroupCode(temp_vo);

				for (TrainingVO vo : list) {
					HashMap hm = new HashMap();
					hm.put("code", vo.getCode());
					hm.put("tname", vo.getTname());
					hmlist.add(hm);
				}

			} else {
				HashMap hm = new HashMap();
				hm.put("status", "err");
				hmlist.add(hm);
			}
		} else if (type.equals("2")) // ??????????????? ???????????? ????????? ??????
		{
			if (!"".equals(code)) {

				// Training??? ??????
				List<StatisticsVO> list = statisticsImpl
						.selectTrainingListByInstatutionCode(code);

				for (StatisticsVO vo : list) {
					HashMap hm = new HashMap();
					hm.put("code", vo.getCode());
					hm.put("tname", vo.getTname());
					hmlist.add(hm);
				}

			} else {
				HashMap hm = new HashMap();
				hm.put("status", "err");
				hmlist.add(hm);
			}
		}

		JSONArray json = new JSONArray(hmlist);
		return new ResponseEntity(json.toString(), responseHeaders,
				HttpStatus.CREATED);

	}

	/**
	 * ????????? ?????? ??????
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/statistical/ajax_userList.do")
	@ResponseBody
	public ResponseEntity ajax_userList(HttpServletRequest request,
			ModelMap model) throws Exception {

		HttpHeaders responseHeaders = new HttpHeaders();
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();

		String code = request.getParameter("code");

		if (!"".equals(code)) {

			// Training??? ??????
			List<TrainingVO> list = trainingImpl.selectTrainingUserStatusByCode(code);

			for (TrainingVO vo : list) {
				if("end".equals(vo.getStatus())){
					HashMap hm = new HashMap();
					hm.put("code", vo.getCode());
					hm.put("email", vo.getEmail());
					hm.put("name", vo.getName());
					hmlist.add(hm);
				}
			}

		} else {
			HashMap hm = new HashMap();
			hm.put("status", "err");
			hmlist.add(hm);
		}

		JSONArray json = new JSONArray(hmlist);
		return new ResponseEntity(json.toString(), responseHeaders,
				HttpStatus.CREATED);

	}

	/**
	 * excel????????????
	 * 
	 * @param locale
	 * @param searchVO
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/statistical/excel.do")
	protected String excelDwn(Locale locale,
			@ModelAttribute("searchVO") StatisticsVO searchVO,
			HttpSession httpsession, Model model, HttpServletRequest req,
			HttpServletResponse res) throws Exception {

		TrainingVO tvo = new TrainingVO();

		ArrayList<HashMap> list = null;

		TrainingVO trainingDetail = null;

		ArrayList<HashMap> columnList = null;

		// ?????? ????????? ??????
		List<TrainingVO> list2 = trainingImpl.selectMemberInstitutionList(tvo);

		String sheetNmae = "";
		String fileName = "";

		// ?????? ?????? ??? ??? split ?????? ??????????????????
		String[] trainingList = searchVO.getTraining_code().split(",");

		ArrayList<HashMap> data = new ArrayList<HashMap>();

		Arrays.sort(trainingList);
		
		fileName = "user.xls";

		if (searchVO.getSearchCondition().equals("type1") && !searchVO.getTraining_code().equals(""))  //????????? ??????
		{
			//?????? ?????? ?????? ??????
			columnList = new ArrayList<HashMap>();
			
			sheetNmae = "total";
			
			columnList.add(ExcelUtil.getColumn("code", "??????", 10, 1));
			columnList.add(ExcelUtil.getColumn("institution_name", "?????????", 15, 1));
			columnList.add(ExcelUtil.getColumn("group_name", "?????????", 15, 1));
			columnList.add(ExcelUtil.getColumn("tname", "?????????", 15, 1));
			columnList.add(ExcelUtil.getColumn("status", "????????????", 10, 1));
			columnList.add(ExcelUtil.getColumn("all_total", "?????? ??????", 10, 1));
			columnList.add(ExcelUtil.getColumn("total", "?????? ??????", 10, 0));
			columnList.add(ExcelUtil.getColumn("type1_use", "????????????", 15, 0));
			columnList.add(ExcelUtil.getColumn("type2_use", "??????(URL)??????", 15, 0));
			columnList.add(ExcelUtil.getColumn("type3_use", "??????????????????", 15, 0));
			columnList.add(ExcelUtil.getColumn("register_cnt", "?????????(??????)", 15, 0));
			columnList.add(ExcelUtil.getColumn("type1_register", "?????????(????????????)", 15, 0));
			columnList.add(ExcelUtil.getColumn("type1_registertime", "???????????????", 15, 0));
						
			list = (ArrayList<HashMap>)statisticsImpl.selectTrainingLogChartReportExcel(trainingList);
			
			HashMap m = new HashMap();
			m.put("sheetName", sheetNmae);
			m.put("columnList", columnList);
			m.put("list", list);
			
			data.add(m);			
			
			//??? ????????? ?????? ????????? 
			for (int i = 0; i < trainingList.length; i++) 
			{
				columnList = new ArrayList<HashMap>();

				list = (ArrayList<HashMap>) statisticsImpl
						.selectTrainingLogListGrupByUserExcel(trainingList[i]);
				trainingDetail = trainingImpl
						.selectTrainingByCode(trainingList[i]);
				sheetNmae = trainingDetail.getTname();
				
			
				// ????????????
				columnList.add(ExcelUtil.getColumn("code", "??????", 10, 0));
				columnList.add(ExcelUtil.getColumn("name", "????????? ??????", 25, 0));
				columnList.add(ExcelUtil.getColumn("email", "????????? ?????????", 25, 0));
				columnList.add(ExcelUtil.getColumn("department_name", "???????????????", 30, 0));

				if (trainingDetail.getType().equals("0")) 
				{
					if (trainingDetail.getTraining_type1().equals("Y")) 
					{
						columnList.add(ExcelUtil.getColumn("type1_use", "??????",20, 0));
						columnList.add(ExcelUtil.getColumn("type1_date","????????????", 20, 0));
					}

					if (trainingDetail.getTraining_type2().equals("Y")) 
					{
						columnList.add(ExcelUtil.getColumn("type2_use", "??????",20, 0));
						columnList.add(ExcelUtil.getColumn("type2_date","????????????", 20, 0));
						columnList.add(ExcelUtil.getColumn("phishing_use","??????", 20, 1));						
					}

					if (trainingDetail.getTraining_type3().equals("Y")) 
					{
						columnList.add(ExcelUtil.getColumn("type3_use","???????????? ??????", 20, 0));
						columnList.add(ExcelUtil.getColumn("type3_date","????????????", 20, 0));
					}
				} 
				else 
				{
					columnList.add(ExcelUtil.getColumn("type1_use", "??????", 20, 1));
					columnList.add(ExcelUtil.getColumn("type1_date", "????????????",20, 1));

					columnList.add(ExcelUtil.getColumn("type2_use", "??????", 20, 1));
					columnList.add(ExcelUtil.getColumn("type2_date", "????????????",20, 1));
					columnList.add(ExcelUtil.getColumn("phishing_use","??????", 20, 1));
					
					columnList.add(ExcelUtil.getColumn("type3_use", "???????????? ??????",20, 1));
					columnList.add(ExcelUtil.getColumn("type3_date", "????????????",20, 1));

				}
				
				columnList.add(ExcelUtil.getColumn("register_use", "????????????", 20,1));
				
				if (trainingDetail.getRegister_type().equals("y")) 
				{
					columnList.add(ExcelUtil.getColumn("register_sdate", "????????????", 30, 0));
					
					if (trainingDetail.getRegister_time_type().equals("Y")) 
					{
						columnList.add(ExcelUtil.getColumn("registertime_use", "??????????????????("+trainingDetail.getRegister_time()+"??? ??????)", 30,0));
						columnList.add(ExcelUtil.getColumn("register_excess_time", "????????????", 30, 0));
					} 
				} 
								
				 m = new HashMap();
				m.put("sheetName", sheetNmae);
				m.put("columnList", columnList);
				m.put("list", list);

				data.add(m);

			}
		} 
		else if (searchVO.getSearchCondition().equals("type2") && !searchVO.getTraining_code().equals("")) //????????? ??????
		{

			fileName = "department.xls";
			
			//?????? ?????? ?????? ??????
			columnList = new ArrayList<HashMap>();
			
			sheetNmae = "total";
			
			columnList.add(ExcelUtil.getColumn("code", "??????", 10, 1));
			columnList.add(ExcelUtil.getColumn("institution_name", "?????????", 15, 1));
			columnList.add(ExcelUtil.getColumn("group_name", "?????????", 15, 1));
			columnList.add(ExcelUtil.getColumn("tname", "?????????", 15, 1));
			columnList.add(ExcelUtil.getColumn("status", "????????????", 10, 1));
			columnList.add(ExcelUtil.getColumn("all_total", "?????? ??????", 10, 0));
			columnList.add(ExcelUtil.getColumn("total", "?????? ??????", 10, 0));
			columnList.add(ExcelUtil.getColumn("type1_use", "????????????", 15, 0));
			columnList.add(ExcelUtil.getColumn("type2_use", "??????(URL)??????", 15, 0));
			columnList.add(ExcelUtil.getColumn("type3_use", "??????????????????", 15, 0));
			columnList.add(ExcelUtil.getColumn("register_cnt", "?????????(??????)", 15, 0));
			columnList.add(ExcelUtil.getColumn("type1_register", "?????????(????????????)", 15, 0));
			columnList.add(ExcelUtil.getColumn("type1_registertime", "???????????????", 15, 0));
						
			list = (ArrayList<HashMap>)statisticsImpl.selectTrainingLogChartReportExcel(trainingList);
			
			HashMap m = new HashMap();
			m.put("sheetName", sheetNmae);
			m.put("columnList", columnList);
			m.put("list", list);
			
			data.add(m);			
			
			
			//??? ????????? ?????? ?????????
			for (int i = 0; i < trainingList.length; i++) {

				columnList = new ArrayList<HashMap>();

				list = (ArrayList<HashMap>) statisticsImpl.selectTrainingLogListGrupByDepartmentExcel(trainingList[i]);

				trainingDetail = trainingImpl.selectTrainingByCode(trainingList[i]);

				sheetNmae = trainingDetail.getTname();

				columnList.add(ExcelUtil.getColumn("department_name", "????????? ??????",10, 1));
				columnList.add(ExcelUtil.getColumn("total", "???????????????", 25, 0));

				if (trainingDetail.getType().equals("0")) 
				{
					if (trainingDetail.getTraining_type1().equals("Y")) 
					{
						columnList.add(ExcelUtil.getColumn("type1_use", "??????",20, 0));
					}

					if (trainingDetail.getTraining_type2().equals("Y")) 
					{
						columnList.add(ExcelUtil.getColumn("type2_use", "??????",20, 0));
					}

					if (trainingDetail.getTraining_type3().equals("Y")) 
					{
						columnList.add(ExcelUtil.getColumn("type3_use", "???????????? ??????", 20, 0));
					}
					columnList.add(ExcelUtil.getColumn("register_cnt", "????????????(??????)", 30, 0));
					columnList.add(ExcelUtil.getColumn("type1_register_cnt", "????????????(????????????)", 30, 0));
				} 
				else 
				{
					columnList.add(ExcelUtil.getColumn("type1_use", "??????", 20, 1));
					columnList.add(ExcelUtil.getColumn("type2_use", "??????", 20, 1));
					columnList.add(ExcelUtil.getColumn("type3_use", "???????????? ??????",20, 1));
					columnList.add(ExcelUtil.getColumn("register_cnt", "????????????(??????)",30, 1));
					columnList.add(ExcelUtil.getColumn("type1_register_cnt", "????????????(????????????)",30, 1));
				}

				m = new HashMap();
				m.put("sheetName", sheetNmae);
				m.put("columnList", columnList);
				m.put("list", list);

				data.add(m);

			}

		}
		
		// excel
		ExcelUtil.excelDwnMuitiSheet(res, fileName, data);

		return null;
	}
	
	/**
	 *  Template excel ????????????
	 * 
	 * @param locale
	 * @param searchVO
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/statistical/templateExcel.do")
	protected ResponseEntity templatEexcelDwn(Locale locale,
			@ModelAttribute("searchVO") StatisticsVO searchVO,
			HttpSession httpsession, 
			Model model, 
			HttpServletRequest req,
			HttpServletResponse res
		) throws Exception {

		ArrayList<HashMap> list = null;
		
		String fileName = "";

		fileName = "report.xls";

		if (!searchVO.getCode().equals("")) 
		{
			list = (ArrayList<HashMap>) statisticsImpl
					.selectTemplateExcelRoport(searchVO.getCode());
		} 
		
		// excel
		ExcelUtil.readExcelDwnSingleSheet(res, fileName, list.get(0));
		
		return null;
	}
	
	/**
	 * ??????????????? excel????????????
	 * 
	 * @param locale
	 * @param searchVO
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/statistical/register_excel.do")
	protected String excelRegisterDwn(Locale locale,
			@ModelAttribute("searchVO") TrainingVO searchVO,
			HttpSession httpsession, Model model, HttpServletRequest req,
			HttpServletResponse res) throws Exception {

		TrainingVO tvo = new TrainingVO();

		ArrayList<HashMap> list = null;

		TrainingVO trainingDetail = null;

		ArrayList<HashMap> columnList = null;
		
		String training_code = searchVO.getTraining_code();
		
		// ?????? ????????? ??????
		List<TrainingVO> list2 = trainingImpl.selectMemberInstitutionList(tvo);

		String sheetNmae = "";
		String fileName = "";

		ArrayList<HashMap> data = new ArrayList<HashMap>();
		
		fileName = "registerList.xls";

		if (!searchVO.getTraining_code().equals("")) 
		{		
			columnList = new ArrayList<HashMap>();

			if("Y".equals(searchVO.getReduplication())){
				list = (ArrayList<HashMap>) statisticsImpl	.selectTrainingRegisterExceptReduplicationExcel(training_code);
			}else{
				list = (ArrayList<HashMap>) statisticsImpl	.selectTrainingRegisterListExcel(training_code);
			}		
			
			
			trainingDetail = trainingImpl.selectTrainingByCode(training_code);
			
			sheetNmae = trainingDetail.getTname();
			
			// ????????????
			columnList.add(ExcelUtil.getColumn("code", "??????", 10, 0));
			columnList.add(ExcelUtil.getColumn("email", "??????????????????", 20, 0));
			columnList.add(ExcelUtil.getColumn("name", "???????????????", 20, 0));
			columnList.add(ExcelUtil.getColumn("title", "????????????", 30, 0));
			columnList.add(ExcelUtil.getColumn("content", "????????????", 40, 0));
			
			columnList.add(ExcelUtil.getColumn("matching_flag", "????????????", 25, 0));
			columnList.add(ExcelUtil.getColumn("type1_use", "????????????", 15, 0));
			columnList.add(ExcelUtil.getColumn("type1_date", "??????????????????", 20, 0));
			columnList.add(ExcelUtil.getColumn("sdate", "????????????", 20, 0));
			columnList.add(ExcelUtil.getColumn("registertime_use", "??????????????????("+trainingDetail.getRegister_time()+"??? ??????)", 25,0));
			columnList.add(ExcelUtil.getColumn("register_excess_time", "????????????", 20, 0));
			
			HashMap m = new HashMap();
			
			m.put("sheetName", sheetNmae);
			m.put("columnList", columnList);
			m.put("list", list);

			data.add(m);
		}
		 		
		// excel
		ExcelUtil.excelDwnMuitiSheet(res, fileName, data);

		return null;
	}
	
	/**
	 * ????????? ?????????
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
	@RequestMapping(value = "/statistical/register_report_pop.do")
	public String register_report_pop(Locale locale,
			@ModelAttribute("searchVO") StatisticsVO searchVO,
			HttpSession httpsession, Model model, HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		
		TrainingVO tvo = new TrainingVO();
		pageVO pagevo = new pageVO();
		TrainingVO trainingDetail = null;
		
		List<StatisticsVO> list = null;
		
		int total= 0;		
		
		total  = statisticsImpl.selectTrainingLogListByTriningCodeCnt(searchVO.getTraining_code());
					
		/**
		 * page ?????? ?????? ?????????
		 */
		pagevo.setPageNo(searchVO.getPageNo());
		pagevo.setTotalCount(total); // ????????? ??? ??????
		
		searchVO.setStartRowNum(pagevo.getStartRowNum());
		searchVO.setPageSize(pagevo.getPageSize());
		
		/**
		 * ?????? ?????? 
		 */
		if(null != searchVO.getSortcolumn() && !"".equals(searchVO.getSortcolumn())
			&& null != searchVO.getOrderBy() && !"".equals(searchVO.getOrderBy())){
			searchVO.setSortcolumn(searchVO.getSortcolumn());
			
			if("asc".equals(searchVO.getOrderBy())){
				searchVO.setOrderBy("asc");
			}else{
				searchVO.setOrderBy("desc");
			}
		}else{
			searchVO.setSortcolumn("code");
			searchVO.setOrderBy("asc");
			
			searchVO.setSortcolumn("code");
			searchVO.setOrderBy("asc");
		}
		
		// ???????????? ?????? ??????(????????????)		
		list = statisticsImpl.selectTrainingLogListByTriningCode(searchVO);
		
		trainingDetail = trainingImpl.selectTrainingByCode(searchVO.getTraining_code());
		
		model.addAttribute("trainingDetail", trainingDetail);
		
		model.addAttribute("pageing", pagevo);
		model.addAttribute("list", list);
		
		return "statistical/register_report_pop";
	}
}
