package kr.nshare.member;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import javax.servlet.http.HttpSessionContext;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class LoginManager implements HttpSessionBindingListener {
	private static LoginManager loginManager = null;
	private static Hashtable loginUsers = new Hashtable();
	
	public LoginManager() {
		super();
	}
	
	

	public static synchronized LoginManager getInstance() {
		if (loginManager == null) {
			loginManager = new LoginManager();
		}
		return loginManager;
	}

	// 해당 세션에 이미 로그인 되있는지 체크
	public boolean isLogin(String sessionID) {
		boolean isLogin = false;
		Enumeration e = loginUsers.keys();
		String key = "";
		while (e.hasMoreElements()) 
		{
			key = (String) e.nextElement();
			if (sessionID.equals(key)) {
				isLogin = true;
			}
		}
		return isLogin;
	}

	// 중복 로그인 막기 위해 아이디 사용중인지 체크
	public boolean isUsing(String userID) {
		boolean isUsing = false;
		Enumeration e = loginUsers.keys();
		String key = "";
		while (e.hasMoreElements()) {
			key = (String) e.nextElement();
			HashMap hm = (HashMap) loginUsers.get(key);
			
			
			if (userID.equals(hm.get("userid"))) {
				isUsing = true;
			}
		}
		return isUsing;
	}
	
	public String getSessionId(String userID)
	{
		String recv = "";
		Enumeration e = loginUsers.keys();
		String key = "";
		while (e.hasMoreElements()) {
			key = (String) e.nextElement();
			HashMap hm = (HashMap) loginUsers.get(key);
			
			
			if (userID.equals(hm.get("userid"))) {
				recv = (String) hm.get("sessionId");
				break;
			}
		}
		return recv;
	}
	
	/**
	 * 
	 * @param userID
	 * @return
	 */
	public String getUserIp(String userID)
	{
		String ip = "";
		Enumeration e = loginUsers.keys();
		String key = "";
		while (e.hasMoreElements()) {
			key = (String) e.nextElement();
			HashMap hm = (HashMap) loginUsers.get(key);
			
			
			if (userID.equals(hm.get("userid"))) {
				ip = (String) hm.get("userip");
				break;
			}
		}
		return ip;
	}

	// 세션 생성
	public void setSession(HttpSession session, String userID, String Ip) {
		
		
		HashMap hm = new HashMap();
		hm.put("userid", userID);
		hm.put("userip",Ip);
		hm.put("sessionId",session.getId());
		
		loginUsers.put(session.getId(), hm);
		session.setAttribute("login", this.getInstance());		
	}
	
	

	// 세션 성립될 때
	public void valueBound(HttpSessionBindingEvent event) 
	{
			System.out.println("0##################################################");
			System.out.println(loginUsers.get(event.getSession().getId()));
			System.out.println("0##################################################");
	}

	// 세션 끊길때
	public void valueUnbound(HttpSessionBindingEvent event) {
		loginUsers.remove(event.getSession().getId());
		System.out.println("0##################################################");
		System.out.println(loginUsers.get(event.getSession().getId()));
		System.out.println("0##################################################");
	}

	
	/**
	 * 세션 종료처리
	 * @param sessionid
	 */
	synchronized public void sessionExpire(String sessionid)
	{
		System.out.println("sessionExpire=>"+sessionid);
		
		loginUsers.remove(sessionid);
		
		int cnt =0;
		Enumeration e = loginUsers.keys();
		String key = "";
		while (e.hasMoreElements()) {
			key = (String) e.nextElement();
			HashMap hm = (HashMap) loginUsers.get(key);
			
			System.out.println("==============="+cnt+"================");
			cnt++;
			
			HttpSession sh_session = null;
			try {
			    sh_session = (HttpSession) e.nextElement();
			   } catch (Exception ex) {
			   ex.printStackTrace();
			}
			String temp_session  = (String) hm.get("sessionId");
			//세션 초기화
			if(temp_session.equals(sessionid))
			{
				System.out.println("===============logout================");
				sh_session.invalidate();
				break;
			}
		}
		
		
		
	}
	
	
	

	// 현재 접속자수
	public int getUserCount() {
		return loginUsers.size();
	}
}
