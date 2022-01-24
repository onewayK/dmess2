package kr.nshare.common.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.nshare.common.util.EgovProperties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * 공통
 * @author impro
 *
 */
@Controller
public class DownloadController {
	
	
	private static final Logger log = LoggerFactory.getLogger(DownloadController.class);
	
	
	
	@RequestMapping(value="/download/file.do")
	public ModelAndView file(
			Locale locale
			, HttpSession session
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res) throws Exception{
		
		File file = null;
		try{
		String fullPath = EgovProperties.getProperty("Globals.template.user.sample");
		file = new File(fullPath);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		

		res.setContentType("applicaiton/download;charset=utf-8");
		res.setContentLength((int)file.length());
		
		String fileName = java.net.URLEncoder.encode(file.getName(), "UTF-8");
		
		res.setHeader("Content-Disposition", "attachment;filename=\""+fileName+"\";");
		res.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream out = res.getOutputStream();
		FileInputStream fis = null;
		
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) { try { fis.close(); } catch (Exception e2) {}}
		}
		out.flush();
		out.close();
		return null;
	}
	
	@RequestMapping(value="/download/register_file.do")
	public ModelAndView register_file(
			Locale locale
			, HttpSession session
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res) throws Exception{
		
		File file = null;
		try{
		String fullPath = EgovProperties.getProperty("Globals.template.register.sample");
		file = new File(fullPath);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		

		res.setContentType("applicaiton/download;charset=utf-8");
		res.setContentLength((int)file.length());
		
		String fileName = java.net.URLEncoder.encode(file.getName(), "UTF-8");
		
		res.setHeader("Content-Disposition", "attachment;filename=\""+fileName+"\";");
		res.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream out = res.getOutputStream();
		FileInputStream fis = null;
		
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) { try { fis.close(); } catch (Exception e2) {}}
		}
		out.flush();
		out.close();
		return null;
	}
	
	/**
	 * 크롬64비트 다운로드
	 * @param locale
	 * @param session
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/download/chrome64.do")
	public ModelAndView chrome64(
			Locale locale
			, HttpSession session
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res) throws Exception{
	
		
		File file = null;
		try{
		String fullPath = EgovProperties.getProperty("Globals.chrome.64bit");
		file = new File(fullPath);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		

		res.setContentType("applicaiton/download;charset=utf-8");
		res.setContentLength((int)file.length());
		
		String fileName = java.net.URLEncoder.encode(file.getName(), "UTF-8");
		
		res.setHeader("Content-Disposition", "attachment;filename=\""+fileName+"\";");
		res.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream out = res.getOutputStream();
		FileInputStream fis = null;
		
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) { try { fis.close(); } catch (Exception e2) {}}
		}
		out.flush();
		out.close();
		return null;
		
	}
	
	/**
	 * 크롬32비트 다운로드
	 * @param locale
	 * @param session
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/download/chrome32.do")
	public ModelAndView chrome32(
			Locale locale
			, HttpSession session
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res) throws Exception{
		File file = null;
		try{
		String fullPath = EgovProperties.getProperty("Globals.chrome.32bit");
		file = new File(fullPath);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		

		res.setContentType("applicaiton/download;charset=utf-8");
		res.setContentLength((int)file.length());
		
		String fileName = java.net.URLEncoder.encode(file.getName(), "UTF-8");
		
		res.setHeader("Content-Disposition", "attachment;filename=\""+fileName+"\";");
		res.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream out = res.getOutputStream();
		FileInputStream fis = null;
		
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) { try { fis.close(); } catch (Exception e2) {}}
		}
		out.flush();
		out.close();
		return null;
	}
	
	/**
	 * 크롬32비트 다운로드
	 * @param locale
	 * @param session
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/download/manual.do")
	public ModelAndView manual(
			Locale locale
			, HttpSession session
			, Model model
			, HttpServletRequest req
			, HttpServletResponse res) throws Exception{
		File file = null;
		try{
		String fullPath = EgovProperties.getProperty("Globals.small.manual");
		file = new File(fullPath);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		

		res.setContentType("applicaiton/download;charset=utf-8");
		res.setContentLength((int)file.length());
		
		String fileName = java.net.URLEncoder.encode(file.getName(), "UTF-8");
		
		res.setHeader("Content-Disposition", "attachment;filename=\""+fileName+"\";");
		res.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream out = res.getOutputStream();
		FileInputStream fis = null;
		
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) { try { fis.close(); } catch (Exception e2) {}}
		}
		out.flush();
		out.close();
		return null;
	}
}
