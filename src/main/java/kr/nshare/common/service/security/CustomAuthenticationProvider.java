package kr.nshare.common.service.security;

import java.util.Collection;

import kr.nshare.common.util.EgovFileScrty;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;

public class CustomAuthenticationProvider implements AuthenticationProvider {  
	private static final Logger logger = LoggerFactory.getLogger(CustomAuthenticationProvider.class);
	
	@Autowired
	private LoginService loginService;
	
	//비밀번호 인증시 첫번째로 실행함	
	@Override
    public boolean supports(Class<?> authentication) {
		 logger.info("샐행시작(      CustomAuthenticationProvider.supports        ) ");
		 //authentication이 UsernamePasswordAuthenticationToken으로 구현한 클래스인지 체크
		 return (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication));
    }    
	
	//비밀번호 인증 및 접속자 정보 리턴
    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        
    	  logger.info("샐행시작(      CustomAuthenticationProvider.authenticate     ) ");
    	 
    	  try {
    		  	//DB에서 불러온 User Data을 담기위한 변수 선언
	    		CustomUserDetails user;    	
			
		    	//Login form에 입력된 User ID와 password을 불러옴
				String user_id = (String)authentication.getPrincipal();		
				String user_pw = (String)authentication.getCredentials();
				String enc_pw = "";
				
				//접속자 권한을 할당할 객체 생성
				Collection<? extends GrantedAuthority> authorities;
				
				logger.info("샐행(      CustomAuthenticationProvider           ) 접속자 ID : "+user_id);
				
				//DB에 저장되어 있는 User Data를 불러옴
			    user =(CustomUserDetails)loginService.loadUserByUsername(user_id);
			    
				//입력받은 password을 SHA 512로 암호화(Salt= 입력받은 User ID)
			    enc_pw=EgovFileScrty.encryptPassword(user_pw, user_id);
				
			    //DB에 저장되어 있는 PW와 입력받은 PW를 비교 
				if (!enc_pw.equals(user.getPassword())){
					  logger.info("샐행(      CustomAuthenticationProvider           ) pass error ");
					 throw new BadCredentialsException("password error.");
				}		 
	   
				//DB에서 받은 User Data 중 권한 Data을 할당
				authorities = user.getAuthorities();
				
				//인증에 성공한 User ID(User의 String 비교로 중복 로그인 체크), 암호화된 PW, 권한을 인자로 객체 생성(이 객체를 통해서 인증이 이루어짐)
				return new UsernamePasswordAuthenticationToken(user_id, user_pw, authorities);
				
    	} catch(Exception e){
			   e.printStackTrace();
		}
		
    	return null;
	}
}