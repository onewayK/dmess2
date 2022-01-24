package kr.nshare.block_exclude.service.impl;

import java.util.List;
import kr.nshare.block_exclude.service.BlockExcludeVO;
import kr.nshare.common.SearchConditionDTO;

/**
 * packageName              : kr.nshare.block_exclude.service.impl           <p>
 * <p>
 * fileName                 : BlockExcludeService
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
public interface BlockExcludeService {
    /**
     * 접속 제한을 신규 등록
     *
     * @param blockExcludeVO the block exclude vo
     * @throws Exception the exception
     */
    public void insertBlockExclude(BlockExcludeVO blockExcludeVO) throws Exception;

    /**
     * 접속 제한 목록을 조회
     *
     * @param conditionDTO keyword, type, institutionCode
     * @return blockExcludes
     * @throws Exception the exception
     */
    public List<BlockExcludeVO> selectBlockExcludeListByKeyword(SearchConditionDTO conditionDTO)throws Exception;

    /**
     * 접속 제한 목록의 총 개수를 조회
     *
     * @param conditionDTO keyword, type, institutionCode
     * @return blockExcludes
     * @throws Exception the exception
     */
    public int selectBlockExcludeCountByKeyword(SearchConditionDTO conditionDTO) throws Exception;

    /**
     * 접속 제한 상세 조회
     *
     * @param code blockExclude code
     * @return the block exclude vo
     * @throws Exception the exception
     */
    public BlockExcludeVO selectBlockExcludeByCode(String code)throws Exception;

    /**
     * 접속 제한 정보 수정
     *
     * @param blockExcludeVO the block exclude vo
     * @throws Exception the exception
     */
    public void updateBlockExclude(BlockExcludeVO blockExcludeVO) throws Exception;

    /**
     * 접속 제한 목록을 삭제
     *
     * @param codes blockExclude codes
     * @throws Exception the exception
     */
    public void deleteBlockExcludeByCodes(List<String> codes) throws Exception;
}
