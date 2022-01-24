package kr.nshare.faq.web;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.nshare.common.UserInfoVO;
import kr.nshare.common.pageVO;
import kr.nshare.common.util.SessionUtil;
import kr.nshare.common.util.urlUtil;
import kr.nshare.faq.service.FaqVO;
import kr.nshare.faq.service.impl.FaqService;
import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.impl.SystemService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FaqController {
	private static final Logger log = LoggerFactory.getLogger(FaqController.class);
	
	@Autowired
	private FaqService faqImpl;
	@Autowired
	private SystemService systemService;	
	
	/**
	 * faq리스트
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/faq/faqList.do") 
	public String faq_list2(
			Locale locale
			, @ModelAttribute("searchVO") FaqVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
		
			String pageType = "";
			UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
			searchVO.setUserid(userInfo.getUserid());
			searchVO.setLev(userInfo.getLev());
			//실행경로 체크
			
			searchVO.setUseyn("0");
			pageType="faq";
		
			/**
			 * 게시물 전체 데이터 추출
			 */
			int total = faqImpl.selectFaqListCnt(searchVO);
			
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
			List<FaqVO> list  = faqImpl.selectFaqList(searchVO);
			model.addAttribute("pageType", pageType);
			model.addAttribute("pageing", pagevo);
			model.addAttribute("list",list);
			return "faq/faqList";
		}
	
	
	@RequestMapping(value="/system/faqList.do") 
	public String faq_list2_system(
			Locale locale
			, @ModelAttribute("searchVO") FaqVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
		
			String pageType = "";
			UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
			searchVO.setUserid(userInfo.getUserid());
			searchVO.setLev(userInfo.getLev());
			//실행경로 체크
				
			pageType="system";
							
		
			/**
			 * 게시물 전체 데이터 추출
			 */
			int total = faqImpl.selectFaqListCnt(searchVO);
			
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
			List<FaqVO> list  = faqImpl.selectFaqList(searchVO);
			model.addAttribute("pageType", pageType);
			model.addAttribute("pageing", pagevo);
			model.addAttribute("list",list);
			return "faq/faqList";
		}
	
	
	/**
	 * faq등록
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/faq/faqForm.do")
	public String faq_form2(
			Locale locale
			, @ModelAttribute("searchVO") FaqVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
				
				UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
			
				SystemVO systemVO = new SystemVO();
				systemVO.setUserid(userInfo.getUserid());
				
				List<SystemVO> institutionList = systemService.selectAllInstitutionList(systemVO);
		
				//테스트
				FaqVO faqVO = null;
				String pageType="";

				if(null!=searchVO.getCode() &&  !"".equals(searchVO.getCode()))
				{
					pageType = "update";
					faqVO = faqImpl.selectFaqByCode(searchVO.getCode());
					
					faqVO.setLev(userInfo.getLev());
				}
				else
				{
					pageType = "insert";
				}
				model.addAttribute("institutionList", institutionList);
				model.addAttribute("detail", faqVO);
				model.addAttribute("pageType", pageType);
			
			return "faq/faqForm";
		}
	
	

	/**
	 * faq등록처리
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/faq/faqProc.do")
	public String faqProc(
			Locale locale
			, @ModelAttribute("searchVO") FaqVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
		
			String url = "";
		
			if(searchVO.getPageType().equals("insert"))
			{
				faqImpl.insertFaq(searchVO);
				url = "redirect:/faq/faqForm.do?code="+searchVO.getCode();
			}
			else
			{
				faqImpl.updateFaq(searchVO);
				url = "redirect:/faq/faqForm.do?code="+searchVO.getCode();
			}
			
			return url;
		}
	
	/**
	 *FAQ 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/faq/faq_del.do")
	public String deleteFaq(
				Locale locale
				, @ModelAttribute("searchVO") FaqVO searchVO 
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
			
			faqImpl.deleteFaqByCode(searchVO.getCode());
			
			model.addAttribute("msg", "정상적으로 삭제를 완료하였습니다.");
			
			model.addAttribute("redirect", "/system/faqList.do");
			
			view = "common/alert_redirect";
			
		}
		else
		{
			model.addAttribute("msg", "삭제를 실패하였습니다.");
			model.addAttribute("redirect", "/system/faqList.do");
			view = "common/alert_redirect";			
		}
		
		
	    return view;
	}
	
	/**
	 * 담당영업
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/faq/salesManage.do")
	public String salesManage(
			Locale locale
			, @ModelAttribute("searchVO") FaqVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
		
			return "faq/salesManage";
		}
	
	
	
	
	/**
	 * 사용자 메뉴얼
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/faq/userManual.do")
	public String userManual(
			Locale locale
			, @ModelAttribute("searchVO") FaqVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
		
			return "faq/userManual";
		}
	
			
}
