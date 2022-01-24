package kr.nshare.common.util;

public class AuthUtil {
	
	/**
	 * 세션을 체크하여 기관 및 훈련에 대한 접근권한 이있는지 체크 권한이있으면  true / 없으면 false
	 * @return
	 */
	public static boolean authInstatutionCheck(String instatution_code)
	{
		instatution_code = "";
		return false;
	}
	
	/**
	 * 세션의 권한을 체크하여 해당 훈련코드의 진행 권한이있는지 체크함.
	 * @param training_code
	 * @return
	 */
	public static boolean authTrainingCheck(String training_code)
	{
		return false;
	}
	
	
	
}
