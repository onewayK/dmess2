package kr.nshare.common.service.security;

import java.util.Collection;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.nshare.common.UserInfoVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.FilterInvocation;



public class CustomAccessDecisionManager implements AccessDecisionManager {
	private static final Logger logger = LoggerFactory.getLogger(CustomAccessDecisionManager.class);
	
	
	//해당 URL 접근에 대한 판단을 하는 메서드
	@Override
	public void decide(Authentication authentication, Object object, Collection<ConfigAttribute> configAttributes) throws InsufficientAuthenticationException {
		logger.info("샐행시작(Security     CustomAccessDecisionManager   ):");
        				
		Iterator<ConfigAttribute> iterator = configAttributes.iterator();
		
		//동적 Url의 접근권한과 접속자의 권한을 비교
		while (iterator.hasNext()) {
			ConfigAttribute configAttribute = iterator.next();
			
			String needPermission = configAttribute.getAttribute();
			logger.info("샐행(Security    CustomAccessDecisionManager   )동적 URL에 대한 권한 : "+ needPermission);
			
			for (GrantedAuthority ga : authentication.getAuthorities()) {
				logger.info("샐행(Security  CustomAccessDecisionManager   )접속자에 대한 권한 : "+ ga.getAuthority().toString());
		        
				if (needPermission.equals(ga.getAuthority())) {
					return;
				}
			}
		}
	
		//접속자가 해당 Url에 접근권한이 없을 시 예외 발생하여 로그인 실패하도록 함
		throw new AccessDeniedException(" Access Denied ");
	}
	
	//전달된 ConfigAttribute 객체를 승인할수 있는지 여부  확인
	@Override
	public boolean supports(ConfigAttribute attribute) {
		return true;
	}
	//AccessDecisionManager 객체에 대한 액세스 제어 결정을 제공 할 수 있는지 여부 확인
	@Override
	public boolean supports(Class<?> clazz) {
		return true;
	}
}
