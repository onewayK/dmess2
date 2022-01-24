package kr.nshare.common.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.nshare.common.CommonVO;
import kr.nshare.common.MenuVO;
import kr.nshare.common.UserInfoVO;
import kr.nshare.common.impl.CommonService;
import kr.nshare.common.license.LicenseJsonDecode;
import kr.nshare.common.license.LicenseJsonEncode;
import kr.nshare.common.util.EgovProperties;
import kr.nshare.common.util.SessionUtil;
import kr.nshare.common.util.commonUtil;
import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.impl.SystemService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 * 공통
 * @author impro
 *
 */
@Controller
public class CommonController {
	
	
	@Autowired
	private SystemService systemImpl;
	
	
	@Autowired
	private CommonService commonImpl; 
	
	
	private static final Logger log = LoggerFactory.getLogger(CommonController.class);
	
	
	
	/**
	 * jsp 
	 * @param locale
	 * @param linkPage
	 * @param baseMenuNo
	 * @param session
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 */
	@RequestMapping(value="/common/pageLink.do")
	public String movePage(
		Locale locale
		, @RequestParam("link") String linkPage
		, @RequestParam(value="baseMenuNo", required=false) String baseMenuNo
		, HttpSession session
		, Model model
		, HttpServletRequest req
		, HttpServletResponse res) 
	{
		String link = linkPage;
		if (linkPage==null || linkPage.equals("")){
			link="cmm/egovError";
		}else{
			if(link.indexOf(",")>-1){
			    link=link.substring(0,link.indexOf(","));
			}
		}
		if (baseMenuNo!=null && !baseMenuNo.equals("") && !baseMenuNo.equals("null")){
			session.setAttribute("baseMenuNo",baseMenuNo);
		}
		
		
		
//		log.info("##################################################");
//		log.info(link);
//		log.info(link.split("/")[0]);
//		log.info("##################################################");
		
		if(link.split("/")[0].equals("inc"))
		{
			
		}
		else
		{
			link = "error/nopage";
		}
		return link;
	}
	
	
	/**
	 * 메뉴 생성 및 출력
	 * @param locale
	 * @param linkPage
	 * @param baseMenuNo
	 * @param session
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 */
	@RequestMapping(value="/common/menu.do")
	public String menuPage(
			Locale locale
			, HttpSession session
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res)throws Exception
	{
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		
		List<MenuVO> list = commonImpl.selectMenuByLev(userInfo.getLev());
		List<MenuVO> list2 = new ArrayList<MenuVO>();
		
		//list출력시 asp용 or 솔루션용도에 따라서 메뉴 구조 변경을 위해 정체 처리
		
		for(MenuVO vo : list )
		{
			if(vo.getShow().equals("Y"))
			{
			//	if(EgovProperties.getProperty("Globals.service_type").equals("0") && vo.getMenu_id().equals("0300004000"))
			//	{
					
			//	}
			//	else if(EgovProperties.getProperty("Globals.service_type").equals("1") && vo.getMenu_id().equals("0500004000"))
			//	{
				
			//	}
				 if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("0") && vo.getMenu_id().equals("0500004000"))
				{
				
				}else{
				
					list2.add(vo);
				}
			}
		}
		
		SystemVO memberInfo = systemImpl.selectMemberByIdWithServiceSetting(userInfo.getUserid());
		
		if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1"))
		{
			List<SystemVO> trainingrInfo_list = systemImpl.selectTrainingUserCntByServiceSettingCode(memberInfo);
			
			SystemVO trainingrInfo = new SystemVO();
			
			for(SystemVO tmp_vo: trainingrInfo_list){
				
				if("test".equals(tmp_vo.getService_type())){
					trainingrInfo.setTest_sended_number(tmp_vo.getSended_user_cnt());
				}else if("real".equals(tmp_vo.getService_type())){
					trainingrInfo.setReal_sended_number(tmp_vo.getSended_user_cnt());
				}				
			}
			
			model.addAttribute("trainingService", trainingrInfo);
		}
		
		//메뉴정보 출력		
		model.addAttribute("userInfo", memberInfo);
		model.addAttribute("menuList", list2);
		return "inc/menu";
	}
	
	
	@RequestMapping(value="/common/SmartEditor2Skin.do")
	public String SmartEditor2Skin(
			Locale locale
			, HttpSession session
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res) throws Exception
	{
		res.addHeader("X-Frame-Options", "SAMEORIGIN"); 
		return "common/SmartEditor2Skin";
	}	
	
	/**
	 * 파일업로드
	 * @param locale
	 * @param session
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 */
	@RequestMapping(value="/common/photo_uploader.do")
	public String photo_uploader(
			Locale locale
			, HttpSession session
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res)
	{
		model.addAttribute("page_type",req.getParameter("page_type"));
		res.addHeader("X-Frame-Options", "SAMEORIGIN"); 
		return "common/photo_uploader";
	}
	
	/**
	 * 파일업로드 실행
	 * @param locale
	 * @param session
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 */
	@RequestMapping(value="/common/file_uploader.do")
	public String file_uploader(
			Locale locale
			, HttpSession session
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res)
	{
		
		return "common/photo_uploader";
	}
	
	/**
	 * 파일업로드 실행
	 * @param locale
	 * @param session
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 */
	@RequestMapping(value="/common/file_uploader_html5.do")
	public String file_uploader_html5(
			Locale locale
			, HttpSession session
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res) throws Exception
	{
		
		try{
			
			CommonVO cv = new CommonVO();
			
			String sFileInfo = "";
			String filename = req.getHeader("file-name");
			String page_type =req.getHeader("page_type");					
			
			String filename_ext = filename.substring(filename.lastIndexOf(".")+1);
			filename_ext = filename_ext.toLowerCase();
			
			String[] allow_file = {"jpg","png","bmp","gif"};
			
			int cnt = 0;
			for(int i=0;i<allow_file.length;i++){
				if(filename_ext.equals(allow_file[i])){
					cnt++;
				}
			}
			
			if(cnt == 0){
				PrintWriter print = res.getWriter();
				print.print("NOTALLOW_"+filename);
				print.flush();
				print.close();
			} else {
				
				String filePath="";
				
				if("training".equals(page_type)){
					filePath = EgovProperties.getProperty("Globals.file.upload.path");
					cv.setType("0");
				}else if("template".equals(page_type)){
					filePath = EgovProperties.getProperty("Globals.file.upload.template.path");
					cv.setType("1");
				}
				
								
				SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM");
				String dirDate = formatter.format(new java.util.Date());
				
				String realFilePath = filePath + dirDate + "/";
				
				
				
				File file = new File(realFilePath);
				
				if(!file.exists()){
					file.mkdirs();
				}
				//시스템 url
				String url = EgovProperties.getProperty("Globals.url");
				
				SimpleDateFormat formatter2 = new SimpleDateFormat("yyyyMMddHHmmss");
				String today = formatter2.format(new java.util.Date());
				String realFileNm = today+ "_" +UUID.randomUUID().toString()+filename.substring(filename.lastIndexOf("."));
				
				String rlFileNm = realFilePath + realFileNm;
				
				//실저장경로
				String path = dirDate+"/"+realFileNm;
				
				
				
				//저장경로
				cv.setPath(dirDate+"/");
				
				//원본명
				cv.setOri_name(filename);
				
				//저장명
				cv.setFile_name(realFileNm);
				
				UserInfoVO userinfo = SessionUtil.getSessionUserInfo();
				
				cv.setUc(userinfo.getCode());
				
				
				String code = commonImpl.insertImage(cv);
				
				
				
				
				InputStream is = req.getInputStream();
				OutputStream os = new FileOutputStream(rlFileNm);
				
				int numRead;
				byte b[] = new byte[Integer.parseInt(req.getHeader("file-size"))];
				while((numRead = is.read(b,0,b.length)) != -1){
					os.write(b,0,numRead);
				}
				if(is != null){
					is.close();
				}
				os.flush();
				os.close();
				
				String imageUrl = EgovProperties.getProperty("Globals.url")+"/common/getImage.do?code="+code;
				
				sFileInfo += "&bNewLine=true";
				sFileInfo += "&sFileName=" + imageUrl;
				//sFileInfo += "&sFileURL=" + "/asdf/" + dirDate + "/" + realFileNm;
				sFileInfo += "&sFileURL=" +imageUrl;
				
				
				System.out.println("###############################");
				System.out.println(sFileInfo);
				System.out.println("###############################");
				
				PrintWriter print = res.getWriter();
				print.print(sFileInfo);
				print.flush();
				print.close();				
			
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "common/SmartEditor2Skin";
		
	}

	@RequestMapping(value="/common/fontview.do")
	public String testview(
			Locale locale
			, HttpSession session
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res)throws Exception
	{
		
		return "common/fontview";
	}
	
	/**
	 * license 확인창 ( 로그인 후 ) 
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/common/license_valid_pop.do")
	public String license_valid2(
			Locale locale
			, HttpSession session
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res)throws Exception
	{
		
		CommonVO lvo= new CommonVO();
		
		ArrayList<String> licenseKeys =new ArrayList<String>();		  
		
		String license_file_type="fail";
		String license_key_type="fail";
		
		String host_type="fail";
		String mac_type="fail";
		String date_type="fail";
		
		boolean date_chk= false;
		long diffDay=-1;
		
		
		String filePath = EgovProperties.getProperty("Globals.file.license");
		
		try{  
			  licenseKeys = LicenseJsonDecode.getLicenseKey(filePath); // 라이선스 파일 체크(mess 시작하는 파일 목록) 
				
			 //라이선스 파일 유무 체크
			  if(null == licenseKeys || licenseKeys.size() < 0){
				  lvo.setLicense_key_type(license_file_type);  //라이센서 파일이 없는 경우
		     }else{
		    	 license_file_type= "success";
		    	 license_key_type="success";
		    	 
		    	 HashMap m=null; 
		    	 
		    	for(int i=0; i< licenseKeys.size(); i++ ){ 
		    		 m = LicenseJsonDecode.getHashmapFromFIle(licenseKeys.get(i),filePath);
		    		 if(m!=null){
		    			 break;
		    		 }
		    	}
			    	
		    	 if(m != null || m.containsKey("license_key")){
		    			
		    		 	lvo.setLicense_key((String) m.get("license_key"));				
		    		 	
		    		 	lvo.setHost_use((String) m.get("host_use"));
		    		 	lvo.setHostname((String) m.get("hostname"));
		    		 
		    		 	lvo.setMac_use((String) m.get("mac_use"));
		    		 	lvo.setMac((String) m.get("mac"));
		    		 	
		    		 	lvo.setDate_use((String) m.get("date_use"));		    		 	
		    		 	lvo.setStartDt((String) m.get("startDt"));
						lvo.setEndDt((String) m.get("endDt"));
											
						lvo.setSdate((String) m.get("sdate"));
						
						
						System.out.println(lvo.getStartDt());			System.out.println(lvo.getStartDt());
						System.out.println(lvo.getEndDt());			System.out.println(lvo.getEndDt());
						System.out.println(lvo.getDate_use());	System.out.println(lvo.getDate_use());	
						
						//사용 기간 체크
						if("Y".equals(lvo.getDate_use())){
							diffDay = commonUtil.diffOfDate(commonUtil.getNowDateStringYmd() , lvo.getEndDt());
							
							
							
							date_chk= commonUtil.betweenStartStopYmd(lvo.getStartDt(),lvo.getEndDt());	
							
							if(date_chk){
								date_type="success";
							}
							
						}else if("N".equals(lvo.getDate_use())){
							date_type="success";
						}
						
						//hostname 체크
						if("Y".equals(lvo.getHost_use())){
							
							InetAddress addr = InetAddress.getLocalHost();
							String hostname=addr.getHostName();
							
							if(null != hostname && hostname.equals(lvo.getHostname())){
								host_type="success";
							}
							
						}else if("N".equals(lvo.getHost_use())){
							host_type="success";
						}
						
						//mac 주소 체크
						if("Y".equals(lvo.getMac_use())){
							
							String cur_mac=LicenseJsonEncode.getMacAddress();
							
							//Mac 주소 비교
							if(null != cur_mac && cur_mac.equals(lvo.getMac())){
								mac_type="success";
							}
						}else if("N".equals(lvo.getMac_use())){
							mac_type="success";
						}
												
						
						lvo.setLicense_file_type(license_file_type);
						lvo.setLicense_key_type(license_key_type);
						lvo.setHost_type(host_type);
						lvo.setMac_type(mac_type);
						lvo.setDate_type(date_type);
						lvo.setDiffDay(Long.toString(diffDay));
						
				}else{
					
					lvo.setLicense_key_type(license_key_type); //잘못된 라이센스 키 일경우
					
				}
		     }		     
		}catch(Exception e){
			System.out.println("license file is wrong(Controller)!!");
			lvo.setLicense_key_type(license_file_type);
		}		
		
		model.addAttribute("license_detail", lvo);
		
		return "common/license_valid_pop";
	}
	
	/**
	 * license 확인창 ( 로그인 전 ) 
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/license_valid.do")
	public String license_valid(
			Locale locale
			, HttpSession session
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res)throws Exception
	{
		
		CommonVO lvo= new CommonVO();
		
		ArrayList<String> licenseKeys =new ArrayList<String>();		  
		
		String license_file_type="fail";
		String license_key_type="fail";
		
		String host_type="fail";
		String mac_type="fail";
		String date_type="fail";
		
		boolean date_chk= false;
		long diffDay=-1;
		
		
		String filePath = EgovProperties.getProperty("Globals.file.license");
		
		try{  
			  licenseKeys = LicenseJsonDecode.getLicenseKey(filePath); // 라이선스 파일 체크(mess 시작하는 파일 목록) 
				
			 //라이선스 파일 유무 체크
			  if(null == licenseKeys || licenseKeys.size() < 0){
				  lvo.setLicense_key_type(license_file_type);  //라이센서 파일이 없는 경우
		     }else{
		    	 license_file_type= "success";
		    	 license_key_type="success";
		    	 
		    	 HashMap m=null; 
		    	 
		    	for(int i=0; i< licenseKeys.size(); i++ ){ 
		    		 m = LicenseJsonDecode.getHashmapFromFIle(licenseKeys.get(i),filePath);
		    		 if(m!=null){
		    			 break;
		    		 }
		    	}
			    	
		    	 if(m != null || m.containsKey("license_key")){
		    			
		    		 	lvo.setLicense_key((String) m.get("license_key"));				
		    		 	
		    		 	lvo.setHost_use((String) m.get("host_use"));
		    		 	lvo.setHostname((String) m.get("hostname"));
		    		 
		    		 	lvo.setMac_use((String) m.get("mac_use"));
		    		 	lvo.setMac((String) m.get("mac"));
		    		 	
		    		 	lvo.setDate_use((String) m.get("date_use"));		    		 	
		    		 	lvo.setStartDt((String) m.get("startDt"));
						lvo.setEndDt((String) m.get("endDt"));
											
						lvo.setSdate((String) m.get("sdate"));
						
						
						
						//사용 기간 체크
						if("Y".equals(lvo.getDate_use())){
							diffDay = commonUtil.diffOfDate(commonUtil.getNowDateStringYmd() , lvo.getEndDt());
														
							date_chk= commonUtil.betweenStartStopYmd(lvo.getStartDt(),lvo.getEndDt());	
							
							if(date_chk){
								date_type="success";
							}
							
						}else if("N".equals(lvo.getDate_use())){
							date_type="success";
						}
						
						//hostname 체크
						if("Y".equals(lvo.getHost_use())){
							
							InetAddress addr = InetAddress.getLocalHost();
							String hostname=addr.getHostName();
							
							if(null != hostname && hostname.equals(lvo.getHostname())){
								host_type="success";
							}
							
						}else if("N".equals(lvo.getHost_use())){
							host_type="success";
						}
						
						//mac 주소 체크
						if("Y".equals(lvo.getMac_use())){
							
							String cur_mac=LicenseJsonEncode.getMacAddress();
							
							//Mac 주소 비교
							if(null != cur_mac && cur_mac.equals(lvo.getMac())){
								mac_type="success";
							}
						}else if("N".equals(lvo.getMac_use())){
							mac_type="success";
						}
												
						
						lvo.setLicense_file_type(license_file_type);
						lvo.setLicense_key_type(license_key_type);
						lvo.setHost_type(host_type);
						lvo.setMac_type(mac_type);
						lvo.setDate_type(date_type);
						lvo.setDiffDay(Long.toString(diffDay));
						
				}else{
					
					lvo.setLicense_key_type(license_key_type); //잘못된 라이센스 키 일경우
					
				}
		     }		     
		}catch(Exception e){
			System.out.println("license file is wrong(Controller)!!");
			lvo.setLicense_key_type(license_file_type);
		}
		
		model.addAttribute("license_detail", lvo);
		
		return "common/license_valid";
	}
	
	/**
	 * license upload 팝업
	 * @param locale
	 * @param searchVO
	 * @param httpsession
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/license_upload_pop.do")
	public String license_upload_pop(
			Locale locale
			, @ModelAttribute("searchVO") CommonVO searchVO 
			, HttpSession httpsession
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res
		) throws Exception
		{
			String pageType = "";
			String parseType = "";	
									
			if(null==searchVO.getUploadfile())
			{
				pageType = "form";
			}
			else
			{
				try{
					
					String filePath = EgovProperties.getProperty("Globals.file.license.template");
					ArrayList<String> licenseKeys =new ArrayList<String>();		  
					
					commonUtil.deleteFileOnDir(filePath);
								   		
					MultipartFile uploadfile =searchVO.getUploadfile();
					
					if(!uploadfile.isEmpty()){				
						
		                uploadfile.transferTo(new File(filePath+uploadfile.getOriginalFilename()));
						
		                licenseKeys = LicenseJsonDecode.getLicenseKey(filePath); // 라이선스 파일 체크(mess 시작하는 파일 목록) 
						
		                if(null == licenseKeys || licenseKeys.size() < 0){
		                	parseType = "fail";
		                	pageType = "form";
		                	
		                }else{
		   		     
		                	 HashMap m=null; 
		    		    	 
		     		    	for(int i=0; i< licenseKeys.size(); i++ ){ 
		     		    		 m = LicenseJsonDecode.getHashmapFromFIle(licenseKeys.get(i),filePath);
		     		    		 if(m!=null){
		     		    			 break;
		     		    		 }
		     		    	}
		     		    	
			   		    	commonUtil.deleteFileOnDir(filePath);
			   		    	 
			   		    	 if(m != null){
			   		    		 filePath = EgovProperties.getProperty("Globals.file.license");
			   		    		
			   		    		commonUtil.deleteFileOnDir(filePath);
			   		    		
			   		    		uploadfile =searchVO.getUploadfile();
								
				                uploadfile.transferTo(new File(filePath+uploadfile.getOriginalFilename()));
				                
				                pageType = "proc";
				                parseType = "success";
				                
			   		    	 }else{		   		    	
				            	parseType = "fail";
			   		    		pageType = "form";
			   		    	 }		   		    	 
		                }
					}else{
						parseType = "fail";
	                	pageType = "form";
					}
				}
				catch(Exception e)
				{					
					e.printStackTrace();
					parseType = "fail";				
				}
			}
			
			model.addAttribute("pageType",pageType);
			
			model.addAttribute("parseType",parseType);
			
			return "common/license_upload_pop";
		}
	
	
	/**
	 * 이미지 보기
	 * @param locale
	 * @param session
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 */
	@SuppressWarnings("resource")
	@RequestMapping(value="/common/getImage.do")
	public String imgView(
			Locale locale
			, HttpSession session
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res)throws Exception
	{
		
		String code = req.getParameter("code");
		
		//EgovProperties.getProperty("")
		if(null!=code && !code.equals(""))
		{
			CommonVO cv = commonImpl.selectImage(code);
			String page_type= cv.getType();
			String filePath="";
			
			if("0".equals(page_type)){
				filePath=EgovProperties.getProperty("Globals.file.upload.path");
			}else if("1".equals(page_type)){
				filePath=EgovProperties.getProperty("Globals.file.upload.template.path");
			}
			
			File file = new File(filePath+cv.getPath()+cv.getFile_name());
			FileInputStream fis = null; new FileInputStream(file);

			BufferedInputStream in = null;
			ByteArrayOutputStream bStream = null;
			try{
				fis = new FileInputStream(file);
				in = new BufferedInputStream(fis);
				bStream = new ByteArrayOutputStream();
				int imgByte;
				while ((imgByte = in.read()) != -1) {
				    bStream.write(imgByte);
				}
				String filename = cv.getFile_name();
				String filename_ext = filename.substring(filename.lastIndexOf(".")+1);
				filename_ext = filename_ext.toLowerCase();
				
				String type = "";

				if (filename_ext != null && !"".equals(filename_ext)) {
				    if ("jpg".equals(filename_ext.toLowerCase())) {
				    	type = "image/jpeg";
				    } else {
				    	type = "image/" + filename_ext;
				    }
				    	type = "image/" + filename_ext;

				} else {
					type = "image/jpeg";
				}
				type = "image/jpeg";
				res.setHeader("Content-Type", type);
				res.setContentLength(bStream.size());

				bStream.writeTo(res.getOutputStream());

				res.getOutputStream().flush();
				res.getOutputStream().close();
			
			}catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		else
		{
			
		}
		
		return null;
		
		
	
    }
	
	
}
