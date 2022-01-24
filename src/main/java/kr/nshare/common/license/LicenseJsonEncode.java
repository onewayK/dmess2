package kr.nshare.common.license;

import java.io.BufferedInputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.EncoderException;
import org.apache.commons.codec.binary.Base64;

import com.google.gson.Gson;

public class LicenseJsonEncode {

    private String iv;
    private Key keySpec;
    private HashMap store = new HashMap();

    public LicenseJsonEncode(String key) throws UnsupportedEncodingException {
              this.iv = key.substring(0, 16);

              byte[] keyBytes = new byte[16];
              byte[] b = key.getBytes("UTF-8");
              int len = b.length;
              if (len > keyBytes.length) {
                         len = keyBytes.length;
              }
              System.arraycopy(b, 0, keyBytes, 0, len);
              SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
              
              this.keySpec = keySpec;
    }
       
	
	
    /**
    * 문자열에서 패턴에 맞는 문자열 즉 맥주소를 뽑아낸다.
    * 
     * @param text
    *            검사할 문자열
    * @return 맥 주소
    */
    public static String ParseMacAddress(String text) {
              String result = null;
              String[] list = text.split("\\p{XDigit}{2}(-\\p{XDigit}{2}){5}");
              int index = 0;
              for (String str : list) {
                         if (str.length() < text.length()) {
                                   index = str.length();
                                   result = text.substring(index, index + 17);
                                   if (!result.equals("00-00-00-00-00-00")) {
                                              break;
                                   }
                                   text = text.substring(index + 17);

                         }
              }
              return result;
    }
	
	
    /*
    * Linux 에 있는 네트워크 설정 값들을 문자열로 불러온다.
    */

    private final static String linuxRunIfConfigCommand() throws IOException {
              Process p = Runtime.getRuntime().exec("ifconfig");
              InputStream stdoutStream = new BufferedInputStream(p.getInputStream());

              StringBuffer buffer = new StringBuffer();
              for (;;) {
                         int c = stdoutStream.read();
                         if (c == -1)
                                   break;
                         buffer.append((char) c);
              }
              String outputText = buffer.toString();

              stdoutStream.close();

              return outputText;
    }

    /*
    * Windows에 있는 네트워크 설정값들을 문자열로 가져온다.
    */

    private final static String windowsRunIpConfigCommand() throws IOException {
              Process p = Runtime.getRuntime().exec("ipconfig /all");
              InputStream stdoutStream = new BufferedInputStream(p.getInputStream());

              StringBuffer buffer = new StringBuffer();
              for (;;) {
                         int c = stdoutStream.read();
                         if (c == -1)
                                   break;
                         buffer.append((char) c);
              }
              String outputText = buffer.toString();

              stdoutStream.close();

              return outputText;
    }
	

    /**
    * 현재 컴퓨터의 맥 주소를 리턴한다.
    * 
     * @return MAC Address
    * @throws IOException
    */
    public final static String getMacAddress() throws IOException {
              String os = System.getProperty("os.name");

              if (os.startsWith("Windows")) {
                         return ParseMacAddress(windowsRunIpConfigCommand());
              } else if (os.startsWith("Linux")) {
                         return ParseMacAddress(linuxRunIfConfigCommand());
              } else {
                         throw new IOException("unknown operating system: " + os);
              }
    }
    
    public String JsonEncode(HashMap hm) throws InvalidKeyException,
	    UnsupportedEncodingException, NoSuchAlgorithmException,
	    NoSuchPaddingException, InvalidAlgorithmParameterException,
	    IllegalBlockSizeException, BadPaddingException {
    	Gson gson = new Gson();
    	String str = gson.toJson(hm);
	
    	return aesEncode(str);
	
	}
    
    // 암호화
    public String aesEncode(String str)
                         throws java.io.UnsupportedEncodingException,
                         NoSuchAlgorithmException, NoSuchPaddingException,
                         InvalidKeyException, InvalidAlgorithmParameterException,
                         IllegalBlockSizeException, BadPaddingException {
              Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
              c.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));

              byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
              String enStr = new String(Base64.encodeBase64(encrypted));

              return enStr;
    }
    
    // 암호화 파일 생성 
    public String LicenseFileSave(String str, String licenseKey) throws IOException{
    	String dir = "e:/" + licenseKey;
    	File file = new File(dir);
    	
    	BufferedWriter bw = null;
    	bw = new BufferedWriter(new FileWriter(file));
    	bw.write(str);
    	bw.flush();
    	bw.close();
    	
    	return "license save!!";
    }
    
    
    // 라이센스 key 암호화
    public static final String md5(final String s) {
        try {
            // Create MD5 Hash
            MessageDigest digest = java.security.MessageDigest
                    .getInstance("MD5");
            digest.update(s.getBytes());
            byte messageDigest[] = digest.digest();
     
            // Create Hex String
            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < messageDigest.length; i++) {
                String h = Integer.toHexString(0xFF & messageDigest[i]);
                while (h.length() < 2)
                    h = "0" + h;
                hexString.append(h);
            }
            return hexString.toString();
     
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return "";
    }



	public static void main(String [] args) throws IOException,
                                InvalidKeyException, NoSuchAlgorithmException,
                                NoSuchPaddingException, InvalidAlgorithmParameterException,
                                IllegalBlockSizeException, BadPaddingException, EncoderException,
                                DecoderException {

		//테스트를 위한 시스템상에서 출력 (차후 관리 시스템 입력값으로 Encode 시킴)
		String hostname = ""; 
		String macStr = ""; 
		String startDt = "";
		String endDt = "";
		String licenseKey = "";
		String aesKey = "";
		String siteLimit = "";
		String licenseKeyMD5 = ""; 
		InetAddress addr = InetAddress.getLocalHost();
		hostname = addr.getHostName();
		macStr = LicenseJsonEncode.getMacAddress();
		startDt = "2014-01-01";
		endDt = "2018-01-01";
		licenseKey = "wm-47aaf41a9e4a74c16da884ca3d2fd8c1";
		licenseKeyMD5 = LicenseJsonEncode.md5(licenseKey);
		siteLimit = "200";
		
	    Date now = new Date(); 
	    SimpleDateFormat sdf = new SimpleDateFormat("ddmmMMHH");
	    //aesKey = sdf.format(now) + licenseKey.substring(licenseKey.length()-8, licenseKey.length());
	    aesKey = md5(licenseKeyMD5.substring(licenseKeyMD5.length()-8, licenseKeyMD5.length()) + licenseKey.substring(licenseKey.length()-8, licenseKey.length()));
	    System.out.println(aesKey);
	    LicenseJsonEncode aes256 = new LicenseJsonEncode(aesKey);
	    
	    LinkedHashMap hm = new LinkedHashMap();
	    hm.put("license_key", licenseKey);
	    hm.put("hostname", hostname);
	    hm.put("mac", macStr);
	    hm.put("startDt", startDt);
	    hm.put("endDt", endDt);
	    hm.put("siteLimit", siteLimit);
	    
	    String str = aes256.JsonEncode(hm);
	    System.out.println(str);
	    
	    String result = aes256.LicenseFileSave(str, licenseKey);
	    System.out.println(result);
	   
	}

}