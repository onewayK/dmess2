package kr.nshare.common.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil {
	
	/**
	 * 이메일 정규식 체크
	 * @param email
	 * @return
	 */
	public static boolean isValidEmail(String email) {
		  boolean err = false;
		  //String regex = "^[_a-zA-Z0-9-]+(.[_a-zA-Z0-9-]+)*@(?:\\w+\\.)+\\w+$";   
		  String regex = "^[_a-zA-Z0-9-\\.]+@[\\.a-zA-Z0-9-]+\\.[a-zA-Z]+$";
		  Pattern p = Pattern.compile(regex);
		  Matcher m = p.matcher(email);
		  if(m.matches()) {
		   err = true; 
		  }
		  return err;
		 }
	 
	/**
	 * 날짜 형식 체크
	 * @param email
	 * @return
	 */
	public static boolean isValidDate(String date) {
		  boolean err = false;
		  //String regex = "^[_a-zA-Z0-9-]+(.[_a-zA-Z0-9-]+)*@(?:\\w+\\.)+\\w+$";   
		  String regex ="^[0-9][0-9][0-9][0-9]\\-[0-9][0-9]\\-[0-9][0-9]\\s[0-9][0-9]:[0-9][0-9]$";
		  Pattern p = Pattern.compile(regex);
		  Matcher m = p.matcher(date);
		  if(m.matches()) {
		   err = true; 
		  }
		  return err;
		 }
	
	/**
	 * 이메일 및 기타 값들에 대해서 정체 처리
	 * @see 
	 *<pre>
	 *\n 	=> 제거
	 *\r 	=> 제거
	 *앞뒤 공백 제거 => str.trim()
	 *
	 * </pre>
	 * 
	 * 
	 * @param str
	 * @return
	 */
	 public static String  refine(String str)
	 {
		 str = str.replaceAll("\n", "");
		 str = str.replaceAll("\r", "");
		 str = str.trim();
		 return str;
	 }
	 
	 public static void main(String[] args )
	 {
		 StringUtil su = new StringUtil();
		 
		 if(su.isValidDate("2017-08-14 17:0")==true)
		 {
			 System.out.println("true");
		 }
		 else
		 {
		 
			 System.out.println("false");
		 }
	 }
	
}
