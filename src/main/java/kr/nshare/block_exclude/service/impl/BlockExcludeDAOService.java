package kr.nshare.block_exclude.service.impl;

import java.util.List;
import kr.nshare.block_exclude.service.BlockExcludeVO;
import kr.nshare.block_exclude.service.mapper.BlockExcludeMapper;
import kr.nshare.common.AbstractDAO;
import kr.nshare.common.SearchConditionDTO;
import org.springframework.stereotype.Service;

/**
 * packageName              : kr.nshare.block_exclude.service.impl           <p>
 * <p>
 * fileName                 : BlockExcludeDAOService
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
@Service("blockExcludeDAOService")
public class BlockExcludeDAOService  extends AbstractDAO implements BlockExcludeDAO {

    @Override
    public void insertBlockExclude(BlockExcludeVO blockExcludeVO) throws Exception {
        BlockExcludeMapper mapper = sqlSession.getMapper((BlockExcludeMapper.class));
        mapper.insertBlockExclude(blockExcludeVO);
    }

    @Override
    public List<BlockExcludeVO> selectBlockExcludeListByKeyword(SearchConditionDTO conditionDTO)
        throws Exception {
        BlockExcludeMapper mapper = sqlSession.getMapper((BlockExcludeMapper.class));
        return mapper.selectBlockExcludeListByKeyword(conditionDTO);
    }

    @Override
    public int selectBlockExcludeCountByKeyword(SearchConditionDTO conditionDTO)
    throws Exception {
        BlockExcludeMapper mapper = sqlSession.getMapper((BlockExcludeMapper.class));
        return mapper.selectBlockExcludeCountByKeyword(conditionDTO);
    }

    @Override
    public BlockExcludeVO selectBlockExcludeByCode(String code) throws Exception {
        BlockExcludeMapper mapper = sqlSession.getMapper((BlockExcludeMapper.class));
        return mapper.selectBlockExcludeByCode(code);
    }

    @Override
    public void updateBlockExclude(BlockExcludeVO blockExcludeVO) throws Exception {
        BlockExcludeMapper mapper = sqlSession.getMapper((BlockExcludeMapper.class));
        mapper.updateBlockExclude(blockExcludeVO);
    }

    @Override
    public void deleteBlockExcludeByCodes(List<String> codes) throws Exception {
        BlockExcludeMapper mapper = sqlSession.getMapper((BlockExcludeMapper.class));
        mapper.deleteBlockExcludeByCodes(codes);
    }
}
