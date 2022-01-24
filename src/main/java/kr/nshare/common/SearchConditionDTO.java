package kr.nshare.common;

/**
 * packageName              : kr.nshare.common           <p>
 * <p>
 * fileName                 : SearchConditionDTO
 * <p>
 * author                   : USER
 * <p>
 * date                     : 2021-12-14
 * <p>
 * description : 테이블 검색 조건 VO
 * <p>
 * ===========================================================
 * <p>
 * DATE              AUTHOR                        NOTE
 * <p>
 * -----------------------------------------------------------
 * <p>
 * 2021-12-14            USER                      최초 생성
 */
public class SearchConditionDTO {

    private String code = "";
    private String keyword= "";
    private String institutionCode= "";
    private int pageNo;
    private int startRowNum;
    private int pageSize;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getInstitutionCode() {
        return institutionCode;
    }

    public void setInstitutionCode(String institutionCode) {
        this.institutionCode = institutionCode;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getStartRowNum() {
        return startRowNum;
    }

    public void setStartRowNum(int startRowNum) {
        this.startRowNum = startRowNum;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

}
