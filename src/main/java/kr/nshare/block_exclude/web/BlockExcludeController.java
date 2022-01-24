package kr.nshare.block_exclude.web;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import kr.nshare.block_exclude.service.BlockExcludeVO;
import kr.nshare.block_exclude.service.impl.BlockExcludeService;
import kr.nshare.common.SearchConditionDTO;
import kr.nshare.common.pageVO;
import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.impl.SystemService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * packageName              : kr.nshare.block_exclude.web           <p>
 * <p>
 * fileName                 : BlockExcludeController
 * <p>
 * author                   : USER
 * <p>
 * date                     : 2021-12-14
 * <p>
 * description :
 * <p>
 * ===========================================================
 * <p>
 * DATE              AUTHOR                        NOTE
 * <p>
 * -----------------------------------------------------------
 * <p>
 * 2021-12-14            USER                      최초 생성
 */
@Controller
public class BlockExcludeController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());


    @Autowired
    private BlockExcludeService blockExcludeService;
    @Autowired
    private SystemService systemService;

    /**
     * 열람 제한 등록(수정) 화면 이동
     *
     * @return the string
     */
    @RequestMapping(value = "/system/blockExcludeForm.do", method = RequestMethod.GET)
    public String blockExcludeForm(String code, Model model) throws Exception{
        String pageType = "insert";
        if(code != null && !"".equals(code)){
            pageType = "detail";
            // institution info
            SystemVO systemVo = new SystemVO();
            List<SystemVO> systemVOS = systemService.selectAllInstitutionList(systemVo);
            model.addAttribute("institutions", systemVOS);
            // blockExclude info
            BlockExcludeVO blockExcludeVO = blockExcludeService.selectBlockExcludeByCode(code);
            model.addAttribute("detail", blockExcludeVO);
        }
//        model.addAttribute("pageType", pageType);
        return "block_exclude/blockExcludeForm";
    }

    /**
     * 열람 제한 등록(수정)
     *
     * @param blockExcludeVO the block exclude vo
     * @param req            the req
     * @return list page
     * @throws Exception the exception
     */
    @RequestMapping(value = "/system/blockExcludeSave.do", method = RequestMethod.POST)
    public String registerBlockExclude(String pageType, BlockExcludeVO blockExcludeVO, HttpServletRequest req) throws Exception{
        if("insert".equals(pageType)){
            blockExcludeVO.setCreateUserId(req.getRemoteUser());
            blockExcludeService.insertBlockExclude(blockExcludeVO);
        }else if("detail".equals(pageType) && !"".equals(blockExcludeVO.getCode())){
            blockExcludeVO.setUpdateUserId(req.getRemoteUser());
            blockExcludeService.updateBlockExclude(blockExcludeVO);
        }
        return "redirect:block_exclude/blockExcludeList";
    }



    @RequestMapping(value = "/system/blockExcludeList.do" )
    public String blockExcludeList(SearchConditionDTO conditionDTO, Model model) throws Exception{
        // for pagination
        int blockExcludeTotalCount = blockExcludeService.selectBlockExcludeCountByKeyword(conditionDTO);
        pageVO pagevo = new pageVO();
        pagevo.setPageSize(10);
        pagevo.setPageNo(conditionDTO.getPageNo());
        pagevo.setTotalCount(blockExcludeTotalCount); // 게시물 총 개수
        conditionDTO.setStartRowNum(pagevo.getStartRowNum());
        conditionDTO.setPageSize(pagevo.getPageSize());
        model.addAttribute("paging", pagevo);
        // find block exclude list
        List<BlockExcludeVO> blockExcludes = blockExcludeService.selectBlockExcludeListByKeyword(
            conditionDTO);
        model.addAttribute("list", blockExcludes);
        return "block_exclude/blockExcludeList";
    }

}
