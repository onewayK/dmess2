package kr.nshare.common.util;

import java.net.URLDecoder;
import java.net.URLEncoder;

import org.apache.commons.codec.binary.Base64;

/**
 * url 유틸
 * @author air82
 *
 */
public class urlUtil {
	
	public String urlEncode(String str)
	{
		return base64Encode(URLEncoder.encode(str));
	}
	
	public String urlbase64Decode(String str)
	{
		return base64Decode(URLDecoder.decode(str));
	}
	
	
	/**
	 * 엔코딩
	 * @param str
	 * @return
	 */
	public String base64Encode(String str)
	{
		String result = "";
		byte[] encodedBytes = Base64.encodeBase64(str.getBytes());
		result = new String(encodedBytes);
		return result;
		
	}
	
	/**
	 * 디코딩
	 * @param str
	 * @return
	 */
	public String base64Decode(String str)
	{
		String result = "";
		byte[] decodedBytes = Base64.decodeBase64(str.getBytes());
		result =new String(decodedBytes);
		return result;
		
	}
	
	public static void main(String[] args)
	{
		urlUtil uu = new urlUtil();
		String ss = uu.urlEncode("39");
		String ss2 = uu.urlEncode("693");
		System.out.println(ss);
		System.out.println(ss2);
		System.out.println(uu.base64Decode(ss));
	}
	
}
