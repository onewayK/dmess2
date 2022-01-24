package kr.nshare.common.util;

import javax.servlet.http.HttpSession;

import kr.nshare.common.UserInfoVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class SessionUtil {
	
	/**
	 * 
	 * @param session
	 * @param key
	 * @param val
	 */
	public static void setSession( String key, String val)
	{
	
		 ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		 attr.getRequest().setAttribute(key, val);
	}
	
	/**
	 *
	 * @param session
	 * @param key
	 * @return
	 */
	public static String getSession(String key)
	{
		 ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		return (String) attr.getRequest().getAttribute(key);
	}
	
	
	/**
	 * 사용자 세션 정보 추출
	 * @return
	 */
	public static UserInfoVO getSessionUserInfo()
	{
		UserInfoVO userInfo = null;
	
		 ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		 
		userInfo =  (UserInfoVO) attr.getRequest().getSession().getAttribute("UserInfoVO");
		
		return userInfo;
	}
	
	
	
	
}
