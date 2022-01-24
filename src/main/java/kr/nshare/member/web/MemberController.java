package kr.nshare.member.web;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.nshare.common.UserInfoVO;
import kr.nshare.common.util.EgovFileScrty;
import kr.nshare.common.util.commonUtil;
import kr.nshare.member.service.MemberVO;
import kr.nshare.member.service.impl.MemberService;
import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.impl.SystemService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MemberController {
	private static final Logger log = LoggerFactory.getLogger(MemberController.class);
	@Autowired
	private MemberService memberImpl;
	
	@Autowired
	private SystemService systemImpl;
	

	/**
	 * 세션값 체크하여 로그인할것인지 체크
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/member/actionMain.do","/"})
	public String actionMain(
				Locale locale
				, @ModelAttribute("searchVO") MemberVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
	
		String return_url = "";
		
		UserInfoVO sessLoginInfo=null;
		if(null!=httpsession.getAttribute("UserInfoVO"))
		{
			sessLoginInfo = (UserInfoVO) httpsession.getAttribute("UserInfoVO");
			
		}
		
		if(sessLoginInfo!=null)
		{
			if(sessLoginInfo.getLev().equals("institution_user"))
			{
				return_url = "redirect:/statistical/chart.do";
			}
			else
			{
				return_url = "redirect:/training/TrainingList.do";
			}
		}
		else
		{
			return_url = "redirect:/member/loginForm.do";
		}
		
		
		
		return return_url;
	}
	
	
	@RequestMapping(value="/member/logOut.do")
	public String logOut(
			Locale locale
			, @ModelAttribute("searchVO") MemberVO searchVO 
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
	{
	
		
		
		
		return "redirect:/member/loginForm.do";
	}
	/**
	 * 로그인폼
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/member/loginForm.do")
	public String loginForm(
				Locale locale
				, @ModelAttribute("searchVO") MemberVO searchVO 
				, HttpSession httpsession
				, Model model
				, HttpServletRequest req
				, HttpServletResponse res
			) throws Exception
	{
		String view = "member/loginForm";
	/*
		if(!commonUtil.browserCheck(req).equals("Chrome"))
		{
			view = "member/browser";
		}
		*/
		 HttpSession session = req.getSession();  
	     session.invalidate();  
		
		return view;
	}
	
	@RequestMapping(value="/member/changePasswd.do")
	public String changePasswd(Locale locale
			, @ModelAttribute("searchVO") MemberVO searchVO 
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			String return_page = "";
			String msg = "";
			SystemVO memberInfo = systemImpl.selectMemberById(searchVO.getJ_username());
			
			UserInfoVO userInfo = new UserInfoVO();
			
			String pass = EgovFileScrty.encryptPassword(searchVO.getJ_password(), searchVO.getJ_username());
			String chgPasswd = EgovFileScrty.encryptPassword(searchVO.getChgPasswd(), searchVO.getJ_username());
			
			
			if(memberInfo!=null && !memberInfo.getUserid().equals("") && (pass.equals(memberInfo.getUserpw())) && memberInfo.getInit().equals("n"))
			{
				memberInfo.setChgPasswd(chgPasswd);
				systemImpl.updateMemberFirstPasswd(memberInfo);
				msg = "최초 접속 비밀번호 변경이 성공하였습니다.";
				return_page = "member/loginForm";
			}
			else
			{
				return_page = "member/firstLogin";
				msg = "아이디 또는 비밀번호가 잘못입력되었습니다. 다시 시도해주시기 바랍니다!";
			}
			
			
			model.addAttribute("msg", msg);
			
			return return_page;
		}
	@RequestMapping(value="/member/loginProc.do")
	public String loginProc(Locale locale
			, @ModelAttribute("searchVO") MemberVO searchVO 
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
			,Authentication authentication
			) throws Exception
			{
					String msg = "";
					String return_page = "";
				
					//중복 로그인 체크
					SystemVO memberInfo=systemImpl.selectMemberByIdWithServiceSetting(authentication.getName());
					
					UserInfoVO userInfo = new UserInfoVO();
					
					//최초접속시 비밀번호 변경처리
					if(memberInfo!=null && memberInfo.getInit().equals("n"))
					{
						model.addAttribute("info", searchVO);
						return_page = "member/firstLogin";
					}
					else
					{
						userInfo.setCode(memberInfo.getCode());
						userInfo.setUserid(memberInfo.getUserid());
						userInfo.setName(memberInfo.getName());
						userInfo.setLev(memberInfo.getLev());
						userInfo.setFax(memberInfo.getFax());
						userInfo.setComp_name(memberInfo.getComp_name());
						userInfo.setSessionId(req.getSession().getId());
						
						//훈련 서비스 설정 관련 
						userInfo.setService_setting_code(memberInfo.getService_setting_code());
						userInfo.setTitle(memberInfo.getTitle());
						userInfo.setStart_date(memberInfo.getStart_date());
						userInfo.setEnd_date(memberInfo.getEnd_date());
						userInfo.setTest_send_number(memberInfo.getTest_send_number());
						userInfo.setReal_send_number(memberInfo.getReal_send_number());
						userInfo.setService_use(memberInfo.getService_use());						
						
						req.getSession().setAttribute("UserInfoVO", userInfo);
						
						//감사로그에 로그인 정보 저장
						MemberVO membervo = new MemberVO();
						membervo.setIm_code(memberInfo.getCode());
						membervo.setLev(memberInfo.getLev());
						membervo.setAction("login");
						membervo.setRefer(commonUtil.getRefer(req));
						membervo.setIp(req.getRemoteAddr());
						memberImpl.insertMemberLog(membervo);
						
						return_page = "redirect:/member/actionMain.do";
					}
					
					return return_page;
			}
}

class RequestWrapperForSecurity extends HttpServletRequestWrapper {
	private String username = null;
	private String password = null;

	public RequestWrapperForSecurity(HttpServletRequest request, String username, String password) {
		super(request);
		this.username = username;
		this.password = password;
	}

	@Override
	public String getRequestURI() {
		System.out.println("00000000000000000000000");
		return ((HttpServletRequest)super.getRequest()).getContextPath() + "/j_spring_security_check";
	}

	@Override
	public String getParameter(String name) {
		if (name.equals("j_username")) {
        	return username;
        }

        if (name.equals("j_password")) {
        	return password;
        }

        return super.getParameter(name);
    }
}
