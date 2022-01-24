package kr.nshare.common.service.security;

import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.impl.SystemService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service("loginService")
public class LoginService implements UserDetailsService{
	@Autowired
	private SystemService systemImpl;
	
	//요청된 ID의 User 정보를 리턴
	@Override
	public CustomUserDetails loadUserByUsername(String userid)
			throws UsernameNotFoundException {		
			
		//DB에서 불러 온 User 정보 저장할 객체
			SystemVO memberInfo;
			
			//memberInfo 객체에서 필요한 정보만 저장할 객체(아이디, 사용자이름, 비밀번호)
			CustomUserDetails user;				
			
			try {
				//해당 User에 대한 정보를 DB에서 불러옴
				memberInfo = systemImpl.selectMemberById(userid);
				
				//해당 User에 대한 권한 Set
				user=new CustomUserDetails(userid, memberInfo.getUserpw(), memberInfo.getName());		
				user.setAuthorities(memberInfo.getLev());
		         
		        return user;
	         
			} catch (Exception e) {
	
				e.printStackTrace();
				
				return null;
			}	
			
		
	}
     
   
}
