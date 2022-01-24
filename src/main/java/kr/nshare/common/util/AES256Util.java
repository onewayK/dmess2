package kr.nshare.common.util;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.EncoderException;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.net.URLCodec;

import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AES256Util {
	private String iv;
	private Key keySpec;
	static Logger logger = LoggerFactory.getLogger(AES256Util.class);
	private HashMap store = new HashMap();

	public AES256Util(String key) throws UnsupportedEncodingException {
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
	 * HashMap 을 JSON STRING으로 변경후 암호화 시킴
	 * @param hm
	 * @return
	 * @throws InvalidKeyException
	 * @throws UnsupportedEncodingException
	 * @throws NoSuchAlgorithmException
	 * @throws NoSuchPaddingException
	 * @throws InvalidAlgorithmParameterException
	 * @throws IllegalBlockSizeException
	 * @throws BadPaddingException
	 */
	public String JsonEncode(HashMap hm) throws InvalidKeyException,
			UnsupportedEncodingException, NoSuchAlgorithmException,
			NoSuchPaddingException, InvalidAlgorithmParameterException,
			IllegalBlockSizeException, BadPaddingException {
		Gson gson = new Gson();
		String str = gson.toJson(hm);

		return aesEncode(str);

	}
	
	/**
	 * 암호화된 json String 을 HashMap 으로 리턴
	 * @param securityStr
	 * @return
	 * @throws InvalidKeyException
	 * @throws UnsupportedEncodingException
	 * @throws NoSuchAlgorithmException
	 * @throws NoSuchPaddingException
	 * @throws InvalidAlgorithmParameterException
	 * @throws IllegalBlockSizeException
	 * @throws BadPaddingException
	 */
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

	/**
	 * 복호화
	 * @param str
	 * @return
	 * @throws java.io.UnsupportedEncodingException
	 * @throws NoSuchAlgorithmException
	 * @throws NoSuchPaddingException
	 * @throws InvalidKeyException
	 * @throws InvalidAlgorithmParameterException
	 * @throws IllegalBlockSizeException
	 * @throws BadPaddingException
	 */
	public String aesDecode(String str)
			throws java.io.UnsupportedEncodingException,
			NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, InvalidAlgorithmParameterException,
			IllegalBlockSizeException, BadPaddingException {
		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		c.init(Cipher.DECRYPT_MODE, keySpec,
				new IvParameterSpec(iv.getBytes("UTF-8")));

		byte[] byteStr = Base64.decodeBase64(str.getBytes());

		return new String(c.doFinal(byteStr), "UTF-8");
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

	/**
	 * 테스트
	 * @param args
	 * @throws IOException
	 * @throws InvalidKeyException
	 * @throws NoSuchAlgorithmException
	 * @throws NoSuchPaddingException
	 * @throws InvalidAlgorithmParameterException
	 * @throws IllegalBlockSizeException
	 * @throws BadPaddingException
	 * @throws EncoderException
	 * @throws DecoderException
	 */
	public static void main(String[] args) throws IOException,
			InvalidKeyException, NoSuchAlgorithmException,
			NoSuchPaddingException, InvalidAlgorithmParameterException,
			IllegalBlockSizeException, BadPaddingException, EncoderException,
			DecoderException {
		String hostname = "";
		String ip = "";
		InetAddress addr = InetAddress.getLocalHost();
		hostname = addr.getHostName();
		ip = addr.getHostAddress();
		InetAddress ip2 = InetAddress.getLocalHost();
		String macStr = "";

		String key = "aes256-test-key!!"; // key는 16자 이상
		AES256Util aes256 = new AES256Util(key);

		HashMap hm = new HashMap();
		hm.put("license_key","16-55-5asdf-4asdf89qasdf65as9fa656asd9fas5df95a9sdf");
		hm.put("hostname", hostname);
		hm.put("ip", ip);
		hm.put("mac", aes256.getMacAddress());
		hm.put("startDt", "2014-01-01");
		hm.put("endDt", "2017-01-01");
		hm.put("option","test12345");
		hm.put("random", "test123");

		String str = aes256.JsonEncode(hm);
		HashMap m = aes256.JsonDecode(str);
	}

}
