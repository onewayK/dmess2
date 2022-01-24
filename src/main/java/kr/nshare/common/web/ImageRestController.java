package kr.nshare.common.web;

import com.google.gson.JsonObject;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.nshare.common.CommonVO;
import kr.nshare.common.impl.CommonService;
import kr.nshare.common.util.EgovProperties;
import kr.nshare.common.util.formBasedFileUtil;
import kr.nshare.system.service.impl.SystemService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * packageName              : kr.nshare.common.web           <p>
 * <p>
 * fileName                 : ImageController
 * <p>
 * author                   : USER
 * <p>
 * date                     : 2021-12-09
 * <p>
 * description :
 * <p>
 * ===========================================================
 * <p>
 * DATE              AUTHOR                        NOTE
 * <p>
 * -----------------------------------------------------------
 * <p>
 * 2021-12-09            USER                      최초 생성
 */
@Controller
public class ImageRestController {
    @Autowired
    private SystemService systemService;
    @Autowired
    private CommonService commonService;

    @RequestMapping(value = "/training/image.do", method = RequestMethod.POST)
    @ResponseBody
    public void uploadTrainingImage(HttpServletRequest req, HttpServletResponse res, MultipartHttpServletRequest multiFile) throws Exception{
        String pageType = "training";
        uploadCkImage(req, res, multiFile, pageType);
    }

    @RequestMapping(value = "/template/image.do", method = RequestMethod.POST)
    @ResponseBody
    public void uploadTemplateImage(HttpServletRequest req, HttpServletResponse res, MultipartHttpServletRequest multiFile) throws Exception{
        String pageType = "template";
        uploadCkImage(req, res, multiFile, pageType);
    }


    private void uploadCkImage(HttpServletRequest req, HttpServletResponse res,
        MultipartHttpServletRequest multiFile, String pageType)
        throws Exception {
        JsonObject json = new JsonObject();
        PrintWriter printWriter = null;
        OutputStream out = null;
        MultipartFile file = multiFile.getFile("upload");

        CommonVO vo = new CommonVO();
        String uploadPath = "";
        String systemPath = EgovProperties.getProperty("Globals.url");

        String uploadUrl = EgovProperties.getProperty("Globals.file.upload.url");
        String imageUrl = "";


        String memberCode = systemService.selectMemberById(req.getRemoteUser()).getCode();
        vo.setUc(memberCode);

        switch (pageType) {
            case "training":
                vo.setType("0");
                uploadPath = EgovProperties.getProperty("Globals.file.upload.path");
                break;

            case "template":
                vo.setType("1");
                uploadPath = EgovProperties.getProperty("Globals.file.upload.template.path");
                break;
        }

        if (!file.isEmpty() && !"".equals(file.getName())) {
            if (file.getContentType().toLowerCase().startsWith("image/")) {
                try {
                    String oriFileName = file.getOriginalFilename();
                    // 원본명-ori_name
                    vo.setOri_name(oriFileName);

                    // 저장명-file_name
                    String nowDate = formBasedFileUtil.getNowString();
                    String realFileName = nowDate + "_" + UUID.randomUUID().toString() + "."
                        + FilenameUtils.getExtension(oriFileName);
                    vo.setFile_name(realFileName);

                    String dirDate = formBasedFileUtil.getThisMonthString();
                    // 저장경로-path
                    vo.setPath(dirDate + "/");

                    // file 저장
                    String code = commonService.insertImage(vo);
                    String fileDirectory = uploadPath + dirDate + "/";
                    // 파일 경로 체크, 존재하지 않을 경우 해당 경로의 폴더 생성
                    File uploadFile = new File(fileDirectory);
                    if (!uploadFile.exists()) {
                        uploadFile.mkdirs();
                    }

                    byte[] bytes = file.getBytes();
                    imageUrl = systemPath + uploadUrl + code;

                    String realFilePath = fileDirectory + realFileName;

                    out = new FileOutputStream(new File(realFilePath));
                    out.write(bytes);

                    printWriter = res.getWriter();
                    res.setContentType("text/html");

                    json.addProperty("uploaded", 1);
                    json.addProperty("fileName", oriFileName);
                    json.addProperty("url", imageUrl);

                    printWriter.println(json);
                } catch (IOException e) {
                    e.printStackTrace();
                } finally {
                    if (out != null) {
                        out.close();
                    }
                    if (printWriter != null) {
                        printWriter.close();
                    }
                }
            }
        }
    }
}
