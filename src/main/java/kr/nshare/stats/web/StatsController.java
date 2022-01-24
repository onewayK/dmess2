package kr.nshare.stats.web;

import java.io.PrintWriter;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.nshare.common.pageVO;
import kr.nshare.faq.service.FaqVO;
import kr.nshare.faq.service.impl.FaqService;
import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.impl.SystemDAOService;
import kr.nshare.system.service.impl.SystemService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StatsController {
	private static final Logger log = LoggerFactory.getLogger(StatsController.class);
	
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
	@RequestMapping(value={"/Stats/faqList.do"}) 
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
			
			//실행경로 체크
			if(req.getRequestURI().equals("/system/faqList.do"))
			{
				pageType="system";
			}
			else
			{
				pageType="faq";
			}
				
		
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
	@RequestMapping(value="/Stats/faqForm.do")
	public String faq_form2(
			Locale locale
			, @ModelAttribute("searchVO") FaqVO searchVO
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
		
				SystemVO systemVO = new SystemVO();
				List<SystemVO> institutionList = systemService.selectAllInstitutionList(systemVO);
		
				//테스트
				FaqVO faqVO = null;
				String pageType="";

				if(null!=searchVO.getCode() &&  !"".equals(searchVO.getCode()))
				{
					pageType = "update";
					faqVO = faqImpl.selectFaqByCode(searchVO.getCode());
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
	@RequestMapping(value="/Stats/faqProc.do")
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

	
			
}
