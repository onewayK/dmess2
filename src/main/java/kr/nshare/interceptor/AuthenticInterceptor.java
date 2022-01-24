package kr.nshare.interceptor;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.nshare.common.impl.CommonService;
import kr.nshare.common.license.LicenseJsonDecode;
import kr.nshare.common.util.EgovProperties;
import kr.nshare.common.util.commonUtil;
import kr.nshare.member.service.impl.MemberService;
import kr.nshare.system.service.impl.SystemService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthenticInterceptor extends HandlerInterceptorAdapter{
	@Autowired
	private MemberService memberImpl;
	
	@Autowired
	private SystemService systemImpl;
	
	@Autowired
	private CommonService commonImpl;
	
	
	
	/**
	 * 사용자 로그인 체크 및 세션관리
	 */ 
	  @Override
	  public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
		  
		  boolean bool = true;
		  boolean chk = false;
		  //UserInfoVO userInfo = null;
		 // HttpSession httpSession = req.getSession();
		 		  
		  String filePath = EgovProperties.getProperty("Globals.file.license");
		  
		  ArrayList<String> licenseKeys =new ArrayList<String>();		  
		  String startDt = "";
		  String endDt = "";
		  
		  try{
			  licenseKeys = LicenseJsonDecode.getLicenseKey(filePath); // 라이선스 파일 체크(mess 시작하는 파일 목록) 
			
			 //라이선스 파일 유무 체크
		     if(null == licenseKeys || licenseKeys.size() < 0){
		    	 res.sendRedirect("/common/license_valid.do");  
		    	 bool = false;
		     }else{
		    	 HashMap m=null; 
		    	 
		    	for(int i=0; i< licenseKeys.size(); i++ ){ 
		    		 m = LicenseJsonDecode.getHashmapFromFIle(licenseKeys.get(i),filePath);
		    		 if(m!=null){
		    			 break;
		    		 }
		    	}
		    	
				if(m != null){
					startDt =(String) m.get("startDt");
					endDt =(String) m.get("endDt");
					
					chk= commonUtil.betweenStartStopYmd(startDt,endDt);				
								
					//라이선스 기간이 만료됐을 경우
					if(!chk){
						res.sendRedirect("/common/license_valid.do");  
						bool = false;
					}
				}else{
					res.sendRedirect("/common/license_valid.do");  
					bool = false;
				}
		    	
		     }
		  }catch(Exception e){
			  	System.out.println("license file is wrong!!");
				res.sendRedirect("/common/license_valid.do");  
				bool = false;
		  }
		  /*
		  if(httpSession.getAttribute("UserInfoVO")!=null)
		  {
			  
			  userInfo =  (UserInfoVO) httpSession.getAttribute("UserInfoVO");
			
			  List<MenuVO> menulist = commonImpl.selectMenuByLev(userInfo.getLev());
			  
			  StringBuffer sb = new StringBuffer();
			  
			  for(MenuVO menu : menulist)
			  {
				  if(sb.toString()==null || sb.toString().equals(""))
				  {
					  sb.append(menu.getSub_url());
				  }
				  else
				  {
					  sb.append(","+menu.getSub_url());
				  }
			  }
			  
			  String[] menuArray = sb.toString().split(",");
			  
			  for(int i =0;i<menuArray.length;i++)
			  {
				  if(menuArray[i].equals(req.getRequestURI()))
				  {
					  chk = true;
					  break;
				  }
						  
			  }
			 
			  systemImpl.selectMemberById(userInfo.getUserid());
			  
			  if(chk==true)
			  {
			  
				System.out.println(req.getRequestURI());
			  	System.out.println(userInfo.getLev());
			  	System.out.println(userInfo.getUserid());

			  	bool = true;
			  }
			  else
			  {
				  System.out.println(req.getRequestURI());
				  //System.exit(0);
				  res.sendRedirect("/member/loginForm.do");
				  bool = false;
			  }
		  }
		  else
		  {
			  res.sendRedirect("/member/loginForm.do");
			  bool = false;
		  }
		  */
		return bool;
	}
}