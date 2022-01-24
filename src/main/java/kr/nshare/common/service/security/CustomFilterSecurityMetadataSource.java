package kr.nshare.common.service.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.nshare.common.UserInfoVO;
import kr.nshare.common.impl.CommonService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;

public class CustomFilterSecurityMetadataSource implements
		FilterInvocationSecurityMetadataSource {
	protected Log log = LogFactory.getLog(CustomFilterSecurityMetadataSource.class);
	
	
	@Autowired
	private CommonService commonImpl; 
	
		//해당 Url에 대한 권한을 리턴
	   @Override
	    public List<ConfigAttribute> getAttributes(Object object) {
		 	
		   //Request에서 요청 Url을 불러옴
	        FilterInvocation fi = (FilterInvocation) object;	       
	        String url = fi.getRequestUrl();
	        
	        //해당 Url을 담기위한 객체 생성
	        List<ConfigAttribute>  attributes = new ArrayList<ConfigAttribute>();
	        
	        log.info("샐행(Security   CustomFilterSecurityMetadataSource   ) Request URL : "+url);	
	        
	        try{
	        	
	        	//Request에서 받은 Url을 통하여 접근권한을 DB에서 조회 및 attributes 객체에 저장
		        List<String> access_roles=commonImpl.selectMenuForUrl(url);
		        
		        log.info("샐행(Security   CustomFilterSecurityMetadataSource   ) URL.ROLE : "+access_roles);		        
		      
			   for(String role : access_roles ){
		                ConfigAttribute temp = new SecurityConfig(role);   
		                attributes.add(temp);	
			   }
			   
	        }catch(Exception e){			
					e.printStackTrace();
			}		
	        
	        return attributes;
	    }


	   //AbstractSecurityInterceptor에 사용될 각각의 ConfigAttribute에 대한 startup time 을 확인하기 위해 사용됨
	  @Override
	    public Collection<ConfigAttribute> getAllConfigAttributes() {
	        return null;
	    }	 

	  // 해당 객체을 FilterInvocationSecurityMetadataSource  인터페이스가 제공할수 있는지 여부 확인
	  @Override
	    public boolean supports(Class<?> clazz) {
	        return FilterInvocation.class.isAssignableFrom(clazz);
	    }	  
}
