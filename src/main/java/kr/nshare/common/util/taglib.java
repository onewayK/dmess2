package kr.nshare.common.util;

import kr.nshare.common.pageVO;

public final  class taglib {
	private taglib() {}

	
	/**
	 * \n -> <br>으로 변경
	 * @param string
	 * @return
	 */
	public static String nl2br(String string) {
        return (string != null) ? string.replace("\n", "<br/>") : null;
    }
	
	public static String nl2br_html(String string){
		String str = string;
		if(string != null)
		{
				str = taglib.getSpclStrCnvr(str);
		}
		return str;
	}
	
	public static String getSpclStrCnvr(String srcString) {
		String rtnStr = null;
		try{
		StringBuffer strTxt = new StringBuffer("");
		char chrBuff;
		int len = srcString.length();

		for(int i = 0; i < len; i++) {
		chrBuff = (char)srcString.charAt(i);

		switch(chrBuff) {
		case '<':
		strTxt.append("&lt;");
		break;
		case '>':
		strTxt.append("&gt;");
		break;
		case '&':
		strTxt.append("&amp;");
		break;
		default:
		strTxt.append(chrBuff);
		}
		}

		rtnStr = strTxt.toString();

		}catch(Exception e) {
		e.printStackTrace();
		}

		return rtnStr;
		}
}
