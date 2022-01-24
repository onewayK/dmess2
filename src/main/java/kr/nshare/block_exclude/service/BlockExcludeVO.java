package kr.nshare.block_exclude.service;

/**
 * packageName              : kr.nshare.request.service           <p>
 * <p>
 * fileName                 : RequestRejectVO
 * <p>
 * author                   : 안찬진
 * <p>
 * date                     : 2021-12-14
 * <p>
 * description : 특정 URL 과 IP의 열람을 제한 Table 의 VO
 * <p>
 * ===========================================================
 * <p>
 * DATE              AUTHOR                        NOTE
 * <p>
 * -----------------------------------------------------------
 * <p>
 * 2021-12-14            안찬진                      최초 생성
 */
public class BlockExcludeVO {

    private String code = "";
    private String name = "";
    private String url = "";
    private String ip = "";
    private String createUserId = "";
    private String sdate = "";
    private String updateUserId = "";
    private String udate = "";
    private String type = "";
    private String institutionCode = "";

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(String createUserId) {
        this.createUserId = createUserId;
    }

    public String getSdate() {
        return sdate;
    }

    public void setSdate(String sdate) {
        this.sdate = sdate;
    }

    public String getUpdateUserId() {
        return updateUserId;
    }

    public void setUpdateUserId(String updateUserId) {
        this.updateUserId = updateUserId;
    }

    public String getUdate() {
        return udate;
    }

    public void setUdate(String udate) {
        this.udate = udate;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getInstitutionCode() {
        return institutionCode;
    }

    public void setInstitutionCode(String institutionCode) {
        this.institutionCode = institutionCode;
    }

}
