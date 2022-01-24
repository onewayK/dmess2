package kr.nshare.common.service.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;


/**
 * 
 * @author impro
 *
 */
//사용자 정보를 담기 위한 객체
public class CustomUserDetails implements UserDetails{	
	
	private static final long serialVersionUID = -4450269958885980297L;
    private String username;
    private String password;
    private String name = "";
    private String test="";
    private  ArrayList<GrantedAuthority> authorities;
    
     

    public CustomUserDetails()
    {
       
    }
    /**
     * userid / password /name입력
     * @param userName
     * @param password
     * @param name
     */    
    public CustomUserDetails(String userName, String password, String name)
    {
        this.username = userName;
        this.password = password;
        this.name = name;
        this.authorities=new ArrayList<GrantedAuthority>();
    }
    
    public void setAuthorities(String rols) {
        
        this.authorities.add(new SimpleGrantedAuthority("ROLE_"+rols));
        
    }
    
    //해당 User의 권한을 리턴
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
       
        return authorities;
    }    
    
    public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTest() {
		return test;
	}

	public void setTest(String test) {
		this.test = test;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
    public String getPassword() {
        return password;
    }
  
    @Override
    public String getUsername() {
        return username;
    }
    
    //사용자의 계정이 만료 되었는지 여부
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }
  
    //사용자가 잠겨 있는지 여부
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }
  
    //사용자의 암호가 만료되었는지 여부
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }
  
    //사용자의 활성화 여부
    @Override
    public boolean isEnabled() {
        return true;
    }  
    
    
}

