package kr.nshare.common.util;



import java.io.File;
import java.lang.reflect.Field;
import java.net.Inet4Address;
import java.net.UnknownHostException;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import kr.nshare.system.service.TemplateVO;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class commonUtil {

	static Logger log = LoggerFactory.getLogger(commonUtil.class);
	
	
	public static long microTimeStart()
	{
		long start = System.currentTimeMillis();
		return start;
	}
	
	public static String microTimeEnd(long start)
	{
		long end = System.currentTimeMillis();
		return String.valueOf(( end - start )/1000.0);
	}
	
	public static String getYmd(){
		
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd", java.util.Locale.KOREA);
        
        return sdf.format(java.util.Calendar.getInstance().getTime());
    }	

	  /**
     * 지정 날짜를 Date로 변경
     * @param String
     * @return
     */
	public static java.util.Date convertStringToDateYmd(String ymd) throws ParseException{
		
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd", java.util.Locale.KOREA);
        
        return sdf.parse(ymd);
    }
	
	  /**
     * 현재 날짜가 입력된 시작 날짜와 끝날짜 사이에 있는지 비교
     * @param String(Start YMD) ,String(Stop YMD)
     * @return boolean
     */
	public static boolean betweenStartStopYmd(String start, String stop) throws ParseException{
		boolean bool=true;
			 		
		 java.util.Date StartDate = convertStringToDateYmd(start);
		 java.util.Date StopDate = convertStringToDateYmd(stop);
		 java.util.Date currentDate =convertStringToDateYmd(getNowDateStringYmd());
		 		 
		 long startInt=StartDate.compareTo(currentDate);
		 long stopInt=StopDate.compareTo(currentDate);
				
		 if(startInt > 0 || stopInt < 0){
			 bool = false;
		 }
		 
        return bool;
    }
	
    /**
     * 지정 날짜를 문자열로 변경
     * @param date
     * @return
     */
    public static String toDefaultDateFormater(java.util.Date date){
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss", java.util.Locale.KOREA);
        
        return sdf.format(date);
    }
    
    /**
     * 현재 시간 문자열 
     * @return
     */
    public static String getNowDateString(){
        
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss", java.util.Locale.KOREA);
        return sdf.format(java.util.Calendar.getInstance().getTime());
    }
    
    /**
     * 현재 시간 문자열 (yyyyMMddHHmm)
     * @return
     */
    public static String getNowDatetimeString(){
        
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmm", java.util.Locale.KOREA);
        return sdf.format(java.util.Calendar.getInstance().getTime());
    }
    
    /**
     * 현재 시간 문자열 (yyyyMMdd)
     * @return
     */
    public static String getNowDateString_yyyyMMdd(){
        
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd", java.util.Locale.KOREA);
        return sdf.format(java.util.Calendar.getInstance().getTime());
    }
    
    /**
     * 현재 시간 문자열 (yyyy-MM-dd)
     * @return
     */
    public static String getNowDateStringYmd(){
        
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd", java.util.Locale.KOREA);
        return sdf.format(java.util.Calendar.getInstance().getTime());
    }
    
    
    /**
     * 
     * @param date
     * @return yyyyMMddHHmmss
     */
    public static String getDateString(Date date){
        
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss", java.util.Locale.KOREA);
        return sdf.format(date);
    }
    
	public static String getDateString2(Date date){
	    
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", java.util.Locale.KOREA);
	    return sdf.format(date);
	}


    
    public static long convertStringToDate(String strDate)
    {
    	Date date = null;
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss", java.util.Locale.KOREA);
        try {
			date = sdf.parse(strDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        return Long.parseLong(toDefaultDateFormater(date));
    }
    
    
    /**
     * 현재 시간 마이크로 타임까지 리턴
     * @return
     */
    public static String getNowDateString2()
    {
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS", java.util.Locale.KOREA);
    	return sdf.format(java.util.Calendar.getInstance().getTime());
    }
    
    /**
     * 로컬의 ip address 가져오기
     * @return String
     * @throws UnknownHostException 
     */
    public static String getLocalAddress() throws UnknownHostException
    {
    	String address = null;
    	address =  (String)Inet4Address.getLocalHost().getHostAddress();
		return address;
    }
    
    public static String getIp()
    {
    	return "";
    }
    
    /**
     * refer정보
     * @param req
     * @return
     * @throws Exception
     */
    public static String getRefer(HttpServletRequest req) throws Exception
    {
    	return  req.getHeader("refer");
    }
    
    
    /**
     * 로컬의 hostname 가져오기
     * @return String
     * @throws UnknownHostException 
     */
    public static String getLocalHostName() throws UnknownHostException
    {
    	String hostname = null;
    	hostname = Inet4Address.getLocalHost().getHostName().toString();
		return hostname;
    }
    
    
    /**
     * null => ture , not null => false
     * null check 
     * @param str
     * @return
     */
    public static boolean StringIsNullCheck(String str)
    {
    	boolean isNull  = true;
    	if(str!=null && !"".equals(str) )
    	{
    		isNull = false;
    	}
    	return isNull;
    }
    
    
    /**
     * 년 월 일 리턴
     * @param type   (yyyy, mm, dd ) 
     * @return String
     * <PRE>
     * yyyyMMddHHmmssSSS
     * </pre>
     */
    public static String GetDate(String type)
    {
    	String calendar = "";
    	if(type.equals("yyyy"))
    	{
    		calendar = "yyyy";
    	}
    	else if(type.equals("mm"))
    	{
    		calendar = "MM";
    	}
    	else if(type.equals("dd"))
    	{
    		calendar = "dd";
    	}
    	else if(type.equals("hh"))
    	{
    		calendar = "24HH";
    	}
    	else if(type.equals("mm"))
    	{
    		calendar = "mm";
    	}
    	
    	else if(type.equals("ss"))
    	{
    		calendar = "ss";
    	}
    	
    	
    	
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(calendar, java.util.Locale.KOREA);
        return sdf.format(java.util.Calendar.getInstance().getTime());
    }
    
    /**
     * 유니크키 리턴    
     * @return
     */
    public static String uniKey()
    {
    	//UNIX타임 + UUID.randomUUID().toString().replace("-", "")
    	StringBuffer sb = new StringBuffer();
    	sb.append(GetDate("hh"));
    	sb.append(GetDate("mm"));
    	sb.append(GetDate("ss"));
    	sb.append("_");
    	sb.append(UUID.randomUUID().toString().replace("-", ""));
    	return sb.toString();
    }
    
    
    /**
	 * 시작시간과 종료시간을 입력하여 두시간간의 초를 계산한다.
	 * @param sdate
	 * @param edate
	 * @return secoend
	 */
	public static String getDateBetween(String sdate , String edate)
	{
		String seconed = null;
		if(Long.valueOf(edate)<=Long.valueOf(sdate))
		{
			seconed= "0";
		}
		else
		{
			SimpleDateFormat sf=new SimpleDateFormat("yyyyMMddHHmmss");
			Calendar tempcal=Calendar.getInstance();
			Date startday=sf.parse(sdate, new ParsePosition(0));
			Date endday=sf.parse(edate, new ParsePosition(0));
			
			long miles = endday.getTime() - startday.getTime();
			
			long second = miles/1000;
			
			seconed = String.valueOf(second);
		}
		
		return seconed;
	}
    
	
	/**
	 * 특정일자 이전의 날짜를 호출함
	 * @return
	 */
	public static String getCurrentPrevData(int days)
	{
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = new GregorianCalendar();
	    cal.add(Calendar.DATE, days);
	    
	    String ymdHis = sf.format(cal.getTime());
	    
	    return ymdHis;
	}
    
	/**
	 * VO - Hm 변환 위한 함수
	 * @return
	 */
	public static Map voToHm(Object obj)
	{
		try{
			Field[] fields = obj.getClass().getDeclaredFields();
	        Map resultMap = new HashMap();
	        for(int i=0; i<=fields.length-1;i++){
	        	fields[i].setAccessible(true);
	        	if(fields[i].get(obj)!=null)
	        		resultMap.put(fields[i].getName(), fields[i].get(obj));
	        }
	        return resultMap;
		} catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        return null;
	}
	
	/**
	 * 
	 * @param obj
	 */
	public static Map voToHm2(Object obj)
	{
		try{
			Field[] fields = obj.getClass().getDeclaredFields();
	        Map resultMap = new HashMap();
	        for(int i=0; i<=fields.length-1;i++){
	        	fields[i].setAccessible(true);
	        	if(fields[i].get(obj)!=null && !"".equals(fields[i].get(obj)))
	        	{
	        		resultMap.put(fields[i].getName(), fields[i].get(obj));
	        	}
	        }
	        return resultMap;
		} catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        return null;
	}
	
	/**
	 * json - Hm 변환 위한 함수
	 * @return
	 * @throws JSONException 
	 */
	public static Map jsonToHm(JSONObject json ) throws JSONException
	{
		try{
			Iterator<String> nameItr = json.keys();
	        Map outMap = new HashMap();
	        while(nameItr.hasNext()) {
	            String name = nameItr.next();
	            outMap.put(name, json.getString(name));
	        }
	        return outMap;
		}catch (IllegalArgumentException e) {
            e.printStackTrace();
        }
        return null;
		
		
	}
	
	
	
	/**
	 * 접속브라우저 체크
	 * @param request
	 * @return
	 */
	public static String browserCheck(HttpServletRequest request)
	{
		String browser = "";
		String userAgent = request.getHeader("User-Agent");
		
		System.out.println(userAgent);
		
		if (userAgent.indexOf("Trident") > 0 || userAgent.indexOf("MSIE") > 0) {
		 browser = "IE";
		} else if (userAgent.indexOf("Opera") > 0) {
		 browser = "Opera";
		} else if (userAgent.indexOf("Firefox") > 0) {
		 browser = "Firefox";
		} else if (userAgent.indexOf("Safari") > 0) {
		 if (userAgent.indexOf("Chrome") > 0) {
		  browser = "Chrome";
		 } else {
		  browser = "Safari";
		 }
		}
		return browser;
	}
	
	/**
	 * list중에 code값이 있는지 체크하여 존재하면 true / 존재하지 않으면 false 리턴
	 * @param list
	 * @param code
	 * @return
	 */
	public static boolean checkEquals(String[] list, String code)
	{
		boolean recv = false;
		if(list.length>0)
		{
			for(int i=0;i<list.length;i++)
			{
				if(list[i].equals(code))
				{
					recv = true;
					break;
				}
			}
		}
		else
		{
			recv = false;
		}
		
		return recv;
	}
	
	/**
	 * list중에 code값이 있는지 체크하여 존재하면 true / 존재하지 않으면 false 리턴
	 * @param list
	 * @param code
	 * @return
	 */
	public static void deleteFileOnDir(String dirpath)
	{
		try{
			File dir = new File(dirpath); 
	    	
			if(dir.isDirectory()){
				File[] fileList = dir.listFiles(); 
				
		   		for(int i = 0 ; i < fileList.length ; i++){
	
						File file = fileList[i]; 
	
						if(file.isFile()){ 
								file.delete();	   					
						}
				}
			}
		}catch(Exception e){
			System.out.println("File Delete Error(commonUtil)");
		}
		
   		return;
	}
	
	/**
	 * 단어 맵핑
	 * 해당 hm에서 부서 기준단어를 카테고리 등록 리스트와 맵핑 하여 스코어링 하고 스코어링 값이 존재하지 않는다면 기타카테고리로 선택하여 리턴한다.
	 * @param list
	 * @param hm
	 * @return
	 */
	public static HashMap wordMapping(List<TemplateVO> list, HashMap hm)
	{
		String department = String.valueOf(hm.get("department_name"));
		HashMap<String, Float> score_hm = new HashMap<String, Float>();
		float max_score=0;
		
		for(TemplateVO tvo : list)
		{				
			String word = tvo.getWord();			
			Float val =  Float.parseFloat(tvo.getVal());			
			
			if(!score_hm.containsKey(tvo.getTc_code()) && !tvo.getCate_type().equals("0")){
				score_hm.put(tvo.getTc_code(), new Float(0));
			}
			
			if(department.contains(word))
			{
				if(score_hm.containsKey(tvo.getTc_code())){
					score_hm.put(tvo.getTc_code(),score_hm.get(tvo.getTc_code()) + val)	;
				}else{
					score_hm.put(tvo.getTc_code(), val);
				}
			}
		}		
	
		Iterator<String> iterator = score_hm.keySet().iterator();
	    while (iterator.hasNext()) {
	    	
	    	String key = (String) iterator.next();
	    	
	    	if(score_hm.get(key) > max_score){
	    		max_score=score_hm.get(key);
	    		hm.put("cate_code", key);	    	
	    	}else if(max_score!=0 && score_hm.get(key) == max_score ){
	    		if(Math.random()>0.5){
	    			 hm.put("cate_code", key);
	    		}	    	
	    	}else if(max_score==0){
	    		hm.put("cate_code", key);
	    	}	    	
	    }   
	    
		return hm;
		
	}

	public static long diffOfDate(String begin, String end) throws Exception
	  {
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");	 

	    Date beginDate = formatter.parse(begin);
	    Date endDate = formatter.parse(end);
	    
	    long diff = endDate.getTime() - beginDate.getTime();
	   
	    long diffDays = diff / (24 * 60 * 60 * 1000);
	
	    return diffDays;
	  }

	
    

}

