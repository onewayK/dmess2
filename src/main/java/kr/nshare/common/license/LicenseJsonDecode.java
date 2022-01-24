package kr.nshare.common.license;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import kr.nshare.common.util.EgovProperties;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.EncoderException;
import org.apache.commons.codec.binary.Base64;

import com.google.gson.Gson;

public class LicenseJsonDecode {

    private String iv;
    private Key keySpec;
    private HashMap store = new HashMap();

    public LicenseJsonDecode(String key) throws UnsupportedEncodingException {
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
       
	
	
    public HashMap JsonDecode(String securityStr) throws InvalidKeyException,
							    UnsupportedEncodingException, NoSuchAlgorithmException,
							    NoSuchPaddingException, InvalidAlgorithmParameterException,
							    IllegalBlockSizeException, BadPaddingException {
		HashMap hm = new HashMap();
		Map<String, Object> map = new HashMap<String, Object>();
		Gson gson = new Gson();
		String str = aesDecode(securityStr);
		hm = (HashMap) gson.fromJson(str, map.getClass());
		store = hm;
		return hm;
	}


	// 복호화
	public String aesDecode(String str) throws java.io.UnsupportedEncodingException,
							    NoSuchAlgorithmException, NoSuchPaddingException,
							    InvalidKeyException, InvalidAlgorithmParameterException,
							    IllegalBlockSizeException, BadPaddingException {
		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		c.init(Cipher.DECRYPT_MODE, keySpec,
		              new IvParameterSpec(iv.getBytes("UTF-8")));
		byte[] byteStr = Base64.decodeBase64(str.getBytes());
		
		return new String(c.doFinal(byteStr), "UTF-8");
	}
	
	
    // 암호화 파일 내용 읽기 
    public String LicenseFileRead(String licenseKey, String dirPath) throws IOException{
    	String dir = dirPath;
    	dir = dir + licenseKey;
    	 
    	File file = new File(dir);
    	
    	BufferedReader br = null;
    	br = new BufferedReader(new FileReader(file));
    	String line;
    	String str = "";
        while ((line = br.readLine()) != null) {
        	str = line;
        }
    	br.close();
    	
    	return str;
    }
    
    
    // 암호화 파일 날짜 출력 
    public final static String LicenseFileDate(String licenseKey) throws IOException{
    	String dir = "e:/" + licenseKey;
		File oFile = new File(dir);
		String str = "";
		
		if (oFile.exists()) {
            long L = oFile.length();
            //System.out.println(L + " bytes : " + oFile.getAbsoluteFile());
            SimpleDateFormat sf = new SimpleDateFormat("ddmmMMHH"); // 날짜 포맷을 지정해주면 됨(SimpleDateFormat 이용)                       
            //System.out.println(sf.format(oFile.lastModified())); // 파일의 마지막 수정 날짜가 출력됨
            str = sf.format(oFile.lastModified()) + licenseKey.substring(licenseKey.length()-8, licenseKey.length()); 
         }
         else System.err.println("파일이 없음...");
    	
    	return str;
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

    // 라이센스 key 출력
    public static ArrayList<String> getLicenseKey(final String s) {
    	
    	ArrayList<String> fileNames=new ArrayList<String>();
    	
    	try {
        	
          File dir = new File(s); 
	      if(dir.isDirectory()){
		   		  File[] fileList = dir.listFiles(); 
		   		  
		   		  for(int i = 0 ; i < fileList.length ; i++){
		
		   				File file = fileList[i]; 
		
		   				if(file.isFile()){   					
		   					if(file.getName().startsWith("mess")){
		   						fileNames.add(file.getName());		   				
		   					}
		   				}
		   			}
	     }
        } catch (Exception e) {
            e.printStackTrace();
        }
    	
        return fileNames;
    }
    
    // 라이센스 key 출력
    public static HashMap getHashmapFromFIle(String licenseKey,String filePath) {
    	
    	  HashMap m=null;
    	  		
		  String licenseKeyMD5 = "";				  
		  String aesKey = "";
		  
    	try {	
		     
		    	licenseKeyMD5 = LicenseJsonDecode.md5(licenseKey);   
		    	aesKey = LicenseJsonDecode.md5(licenseKeyMD5.substring(licenseKeyMD5.length()-8, licenseKeyMD5.length()) + licenseKey.substring(licenseKey.length()-8, licenseKey.length()));
				 			
				LicenseJsonDecode aes256 = new LicenseJsonDecode(aesKey);
				String str = aes256.LicenseFileRead(licenseKey,filePath);
				
				m = aes256.JsonDecode(str);				
		    
        } catch (Exception e) {
        	System.out.println("licenseKey is wrong!!");
            e.printStackTrace();        
        }
    	
        return m;
    }
    
    
}