package kr.nshare.block_exclude.service.impl;

import java.util.List;
import kr.nshare.block_exclude.service.BlockExcludeVO;
import kr.nshare.common.SearchConditionDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * packageName              : kr.nshare.block_exclude.service.impl           <p>
 * <p>
 * fileName                 : BlockExcludeImpl
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
@Service("blockExcludeImpl")
public class BlockExcludeImpl implements BlockExcludeService{

    @Autowired
    private BlockExcludeDAO blockExcludeDAOService;

    @Override
    public void insertBlockExclude(BlockExcludeVO blockExcludeVO) throws Exception {
        blockExcludeDAOService.insertBlockExclude(blockExcludeVO);
    }

    @Override
    public List<BlockExcludeVO> selectBlockExcludeListByKeyword(SearchConditionDTO conditionDTO)
        throws Exception {
        return blockExcludeDAOService.selectBlockExcludeListByKeyword(conditionDTO);
    }

    @Override
    public int selectBlockExcludeCountByKeyword(SearchConditionDTO conditionDTO) throws Exception {
        return blockExcludeDAOService.selectBlockExcludeCountByKeyword(conditionDTO);
    }


    @Override
    public BlockExcludeVO selectBlockExcludeByCode(String code) throws Exception {
        return blockExcludeDAOService.selectBlockExcludeByCode(code);
    }

    @Override
    public void updateBlockExclude(BlockExcludeVO blockExcludeVO) throws Exception {
        blockExcludeDAOService.updateBlockExclude(blockExcludeVO);
    }

    @Override
    public void deleteBlockExcludeByCodes(List<String> codes) throws Exception {
        blockExcludeDAOService.deleteBlockExcludeByCodes(codes);
    }
}
