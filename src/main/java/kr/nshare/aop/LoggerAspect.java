package kr.nshare.aop;

import javax.servlet.http.HttpServletRequest;

import kr.nshare.system.web.SystemController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
public class LoggerAspect {
	protected Log log = LogFactory.getLog(LoggerAspect.class);
    static String name = "";
    static String type = "";
    
    @Before("execution(* kr..web.*Controller.*(..)) or execution(* kr..mapper.*DAO*.*(..))")
    public void log(JoinPoint jp) throws Throwable {
    	
    	HttpServletRequest request = null;
    	for (Object obj : jp.getArgs()) {
            if (obj instanceof HttpServletRequest || obj instanceof MultipartHttpServletRequest) {
                 request = (HttpServletRequest) obj;
            }
        }
    	//
    	if(!jp.getSignature().getName().equals("movePage") && !jp.getSignature().getName().equals("menuPage"))
    	{
    		if(request!=null)
    		{
    			log.info("샐행URL : "+request.getRequestURI());
    		}
    		log.info("실행위치 : "+jp.getSignature().getName());
    	}
    }
    
    @After("execution(* kr..web.*Controller.*(..)) or execution(* kr..mapper.*DAO*.*(..))")
    public void log2(JoinPoint jp) throws Throwable {
    }
}