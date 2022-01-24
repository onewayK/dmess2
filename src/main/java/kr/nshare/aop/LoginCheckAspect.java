package kr.nshare.aop;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import kr.nshare.common.UserInfoVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

/**
 * 실행순서 
 * @Before
	@Around (대상 메소드 수행 전)
	대상 메소드 (ArithmeticException 예외가 발생한다)
	@After(finally)
	@AfterThrowing
 * @author impro
 *
 */

@Aspect
public class LoginCheckAspect {
	/**
	protected Log log = LogFactory.getLog(LoginCheckAspect.class);
    static String name = "";
    static String type = "";
    
    @Before("execution(* kr..web.*Controller.*(..))")
    public Object  trace(JoinPoint jp) throws IOException {
    	
    	 ModelAndView mav = new ModelAndView();
    	HttpServletRequest request = null;
    	//HttpServletResponse response = null;
    	
    	//ServletWebRequest servletContainer = (ServletWebRequest) RequestContextHolder.getRequestAttributes();
    	for (Object obj : jp.getArgs()) {
            if (obj instanceof HttpServletRequest || obj instanceof MultipartHttpServletRequest) {
                 request = (HttpServletRequest) obj;
            }
            
        }
    	
    	UserInfoVO userInfo = null;
    	
    	
    	
    	//페이지 권한 관리
    	if(!jp.getSignature().getName().equals("movePage") && !jp.getSignature().getName().equals("menuPage") 
    			&& !jp.getSignature().getName().equals("initBinder") )
    	{
    		if(null==request.getSession().getAttribute("UserInfoVO"))
        	{
    			System.out.println("세션없음");
    			
    			
        		RedirectView rv = new RedirectView("redirect:/");
        		rv.setExposeModelAttributes(false);
        		
        		return new ModelAndView("view");

        		
        		

        	}
        	else
        	{
        		userInfo =  (UserInfoVO) request.getSession().getAttribute("UserInfoVO");
        	
        		System.out.println("userid====>"+userInfo.getUserid());
        		System.out.println("lev====>"+userInfo.getLev());
        		
        		
        		
        	}
    		
    		if(request!=null)
    		{
    			log.info("샐행URL : "+request.getRequestURI());
    		}
    		log.info("실행위치 : "+jp.getSignature().getName());
    		System.out.println("===>"+mav.getView());
    	}
    	
    
    	
		return null;
    }
    
    @After("execution(* kr..web.*Controller.*(..)) or execution(* kr..mapper.*DAO*.*(..))")
    public void log2(JoinPoint jp) throws Throwable {}
  **/
}  