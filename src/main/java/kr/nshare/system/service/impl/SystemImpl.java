package kr.nshare.system.service.impl;

import java.util.ArrayList;
import java.util.List;

import kr.nshare.common.UserInfoVO;
import kr.nshare.common.util.EgovFileScrty;
import kr.nshare.common.util.SessionUtil;
import kr.nshare.system.service.SystemVO;
import kr.nshare.system.service.TemplateVO;
import kr.nshare.training.service.TrainingVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("systemImpl")
public class SystemImpl implements SystemService{
	private static final Logger log = LoggerFactory.getLogger(SystemImpl.class);
	@Autowired
	private SystemDAO systemDAOService;
	
	/**
	 * 사용자 등록
	 */ 
	@Override
	public void insertMember(SystemVO vo) throws Exception 
	{
		String pass = EgovFileScrty.encryptPassword(vo.getUserpw(), vo.getUserid());
		
		vo.setUserpw(pass);
		
		systemDAOService.insertMember(vo);
		
		//기관 코드 설정
		if(!vo.getInstitution_code().equals(""))
		{
			for(String institution_code:vo.getInstitution_code().split(","))
			{
				
				
				SystemVO authvo = new SystemVO();
				authvo.setMember_code(String.valueOf(vo.getCode()));
				authvo.setInstitution_code(institution_code);
				systemDAOService.insertAuthMapping(authvo);
			}
		}
		
	}
	
	/**
	 * 사용자 업데이트
	 */
	@Override
	public void updateMember(SystemVO vo) throws Exception {
		
		//기관 코드 설정
		if(null!=vo.getInstitution_code() && !vo.getInstitution_code().equals(""))
		{
			//기존데이터 삭제
			systemDAOService.deleteAuthMappingByMemberCode(String.valueOf(vo.getCode()));
			for(String institution_code:vo.getInstitution_code().split(","))
			{
				SystemVO authvo = new SystemVO();
				authvo.setMember_code(String.valueOf(vo.getCode()));
				authvo.setInstitution_code(institution_code);
				systemDAOService.insertAuthMapping(authvo);
			}
		}
		if(vo.getIsChgPaswd().equals("0"))
		{
			String pass = EgovFileScrty.encryptPassword(vo.getUserpw(), vo.getUserid());
			vo.setUserpw(pass);
		}
		
		systemDAOService.updateMember(vo);
	}
	
	/**
	 * 사용자 아이디로 검색
	 */
	@Override
	public SystemVO selectMemberById(String userid) throws Exception {
		// TODO Auto-generated method stub
		return systemDAOService.selectMemberById(userid);
	}
	
	/**
	 * 훈련 서비스 설정이 포함된 사용자 아이디로 검색
	 */
	@Override
	public SystemVO selectMemberByIdWithServiceSetting(String userid) throws Exception {
		// TODO Auto-generated method stub
		return systemDAOService.selectMemberByIdWithServiceSetting(userid);
	}
	
	/**
	 * 사용자 리스트 검색
	 * @see kr.nshare.system.service.impl.SystemService#selectMemberList(kr.nshare.system.service.SystemVO)
	 */
	@Override
	public List<SystemVO> selectMemberList(SystemVO vo) throws Exception {
		return systemDAOService.selectMemberList(vo);
	}
	
	/**
	 * 사용자  삭제
	 */
	@Override
	public void deleteMemberByCode(SystemVO vo, UserInfoVO uvo) throws Exception {
		
		SystemVO svo = new SystemVO();
		svo.setCode(vo.getCode()); 
		svo.setMember_code(uvo.getCode()); 
		svo.setCreate_id(uvo.getUserid()); 
		svo.setUserid(vo.getUserid()); 
		
		//해당 계정에 해당하는 정보들 수정
		//i_auth_mapping 삭제
		systemDAOService.deleteAuthMappingByMemberCode(vo.getCode());
		
		//사용자 삭제로 인한 템플릿,파일, 훈련 생성자 변경
		systemDAOService.updateTemplateUcByCode(svo);
		systemDAOService.updateFileUcByCode(svo);
		
		systemDAOService.updateTrainingUcAndIdByCode(svo);
		systemDAOService.updateTrainingGroupIdAndIdByCode(svo);
		
		//사용자 계정 삭제
		systemDAOService.deleteMemberByCode(vo.getCode());
	}
	
	@Override
	public void updateTemplateUcByCode(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		systemDAOService.updateTemplateUcByCode(vo);
	}
	
	@Override
	public void updateFileUcByCode(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		systemDAOService.updateFileUcByCode(vo);
	}
	
	@Override
	public void updateTrainingUcAndIdByCode(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		systemDAOService.updateTrainingUcAndIdByCode(vo);
	}
	
	@Override
	public void updateTrainingGroupIdAndIdByCode(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		systemDAOService.updateTrainingGroupIdAndIdByCode(vo);
	}
	
	/**
	 * 사용자 리스트 총갯수
	 */
	@Override
	public int selectMemberListCnt(SystemVO vo) throws Exception {
		return systemDAOService.selectMemberListCnt(vo);
				
	}

	@Override
	public SystemVO selectMemberByCode(String code) throws Exception {
		// TODO Auto-generated method stub
		return systemDAOService.selectMemberByCode(code);
	}

	@Override
	public void insertInstitution(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		systemDAOService.insertInstitution(vo);
	}

	@Override
	public void updateInstitution(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		systemDAOService.updateInstitution(vo);
	}

	@Override
	public SystemVO selectInstitutionByCode(String code) throws Exception {
		// TODO Auto-generated method stub
		return systemDAOService.selectInstitutionByCode(code);
	}

	@Override
	public List<SystemVO> selectInstitutionList(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		return systemDAOService.selectInstitutionList(vo);
	}

	@Override
	public int selectInstitutionListCnt(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		return systemDAOService.selectInstitutionListCnt(vo);
	}

	@Override
	public List<SystemVO> selectAuthMappingListByMemberCode(String member_code)
			throws Exception {
		return systemDAOService.selectAuthMappingListByMemberCode(member_code);
	}

	@Override
	public void insertAuthMapping(SystemVO vo) throws Exception {
		
		systemDAOService.insertAuthMapping(vo);
	}

	@Override
	public void updateAuthMapping(SystemVO vo) throws Exception {
		systemDAOService.updateAuthMapping(vo);
	}

	@Override
	public void deleteAuthMappingByMemberCode(String member_code) throws Exception {
		systemDAOService.deleteAuthMappingByMemberCode(member_code);
	}

	@Override
	public void deleteInstitutionByCode(String code) throws Exception {
		systemDAOService.deleteInstitutionByCode(code);
	}
	
	@Override
	public List<SystemVO> selectAllInstitutionList(SystemVO vo) throws Exception {
		return systemDAOService.selectAllInstitutionList(vo);
	}

	/**
	 * 과금 등록
	 */
	@Override
	public void insertPayment(SystemVO vo) throws Exception {
		
		//사용자정보 추출
		SystemVO memberInfo = systemDAOService.selectMemberByCode(String.valueOf(vo.getCode()));
		vo.setUserid(memberInfo.getUserid());
		systemDAOService.insertPayment(vo);
	}

	/**
	 * paycnt 업데이트
	 */
	@Override
	public void updatePayCntMember(SystemVO vo) throws Exception {
		//사용자정보 추출
		systemDAOService.updatePayCntMember(vo);
	}

	@Override
	public List<SystemVO> selectPayMentList(SystemVO vo)throws Exception  {
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setLev(userInfo.getLev());
		vo.setUserid(userInfo.getUserid());
		
		// TODO Auto-generated method stub
		return systemDAOService.selectPayMentList(vo);
	}

	@Override
	public int selectPayMentListCnt(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setLev(userInfo.getLev());
		vo.setUserid(userInfo.getUserid());
		
		return systemDAOService.selectPayMentListCnt(vo);
	}

	@Override
	public int selectEmailSendLogListCnt(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setLev(userInfo.getLev());
		vo.setUserid(userInfo.getUserid());
		
		return systemDAOService.selectEmailSendLogListCnt(vo);
	}

	@Override
	public List<SystemVO> selectEmailSendLogList(SystemVO vo) throws Exception {
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setLev(userInfo.getLev());
		vo.setUserid(userInfo.getUserid());
		
		return systemDAOService.selectEmailSendLogList(vo);
	}

	@Override
	public void updateMemberFirstPasswd(SystemVO vo) throws Exception {
		systemDAOService.updateMemberFirstPasswd(vo);
		
	}

	@Override
	public List<TemplateVO> selectTemplateList(TemplateVO vo) throws Exception {
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setUserid(userInfo.getUserid());
		vo.setLev(userInfo.getLev());
		return systemDAOService.selectTemplateList(vo);
	}

	@Override
	public int selectTemplateListCnt(TemplateVO vo) throws Exception {
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		
		vo.setLev(userInfo.getLev());
		vo.setUserid(userInfo.getUserid());
		
		return systemDAOService.selectTemplateListCnt(vo);
	}

	@Override
	public void insertTemplate(TemplateVO vo) throws Exception {
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setUc(userInfo.getCode());
		
		
		
		systemDAOService.insertTemplate(vo);
		
	}

	@Override
	public void updateTemplate(TemplateVO vo) throws Exception {
		systemDAOService.updateTemplate(vo);
		
	}

	@Override
	public List<TemplateVO> selectTemplateCateList(TemplateVO vo)throws Exception {
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setLev(userInfo.getLev());
		vo.setUserid(userInfo.getUserid());
		
		return systemDAOService.selectTemplateCateList(vo);
	}

	@Override
	public TemplateVO selectTemplateByCode(String code) throws Exception {
		return systemDAOService.selectTemplateByCode(code);
	}

	@Override
	public List<TemplateVO> selectTemplateAllList(TemplateVO vo)throws Exception {
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setLev(userInfo.getLev());
		vo.setUserid(userInfo.getUserid());
		return systemDAOService.selectTemplateAllList(vo);
	}

	
	/**
	 * 카테고리 단어 등록
	 * 
	 */
	@Override
	public void insertTemplateCateWord(List<TemplateVO> list) throws Exception {
		// TODO Auto-generated method stub
		systemDAOService.insertTemplateCateWord(list);
	}

	/**
	 * 카테고리 단어 삭제
	 */
	@Override
	public void deleteTemplateCateWord(String code) throws Exception {
		// TODO Auto-generated method stub
		systemDAOService.deleteTemplateCateWord(code);
	}
	
	/**
	 * 템플릿 삭제
	 */
	@Override
	public void updateDisabledTemplateByCode(String code) throws Exception {
		// TODO Auto-generated method stub
		systemDAOService.updateDisabledTemplateByCode(code);
	}
	
	@Override
	public void updateDisabledTemplatesByCateCode(String code) throws Exception {
		// TODO Auto-generated method stub
		systemDAOService.updateDisabledTemplatesByCateCode(code);
	}
	
	@Override
	public void updateDisabledCategoryByCode(String code) throws Exception {
		// TODO Auto-generated method stub
		systemDAOService.updateDisabledCategoryByCode(code);
	}
	
	/**
	 * 카테고리 단어 수정
	 */
	@Override
	public void updateTemplateCateWord(TemplateVO vo) throws Exception {
		// TODO Auto-generated method stub
		systemDAOService.updateTemplateCateWord(vo);
	}

	/**
	 * 카테고리 단어추출
	 */
	@Override
	public List<TemplateVO> selectTemplateCateWordByCateCode(String cate_code)
			throws Exception {
		// TODO Auto-generated method stub
		return systemDAOService.selectTemplateCateWordByCateCode(cate_code);
	}

	@Override
	public TemplateVO selectTemplateCateDetailByCode(String code)
			throws Exception {
		// TODO Auto-generated method stub
		return systemDAOService.selectTemplateCateDetailByCode(code);
		
	}

	@Override
	public List<TemplateVO> selectTemplateCateWordAllList(String userid)
			throws Exception {
		// TODO Auto-generated method stub
		return systemDAOService.selectTemplateCateWordAllList(userid);
	}

	@Override
	public List<TemplateVO> selectTemplateRandomAllList() throws Exception {
		// TODO Auto-generated method stub
		return systemDAOService.selectTemplateRandomAllList();
	}
	
	/**
	 *  카테고리 등록
	 */
	@Override
	public void insertCategory(TemplateVO vo) throws Exception {

		//카테고리 생성
		systemDAOService.insertCategory(vo);
		
		//카테고리 단어 저장
		if (null != vo.getWlistvo() && vo.getWlistvo().size() > 0) {
		
			List<TemplateVO> list = new ArrayList<TemplateVO>();

			for (TemplateVO tempvo : vo.getWlistvo()) {
				if(null!= tempvo.getWord() && !"".equals(tempvo.getVal())
						&& !"".equals(tempvo.getOrd())){					
					TemplateVO word_vo=new TemplateVO();
					
					word_vo.setWord(tempvo.getWord() );
					word_vo.setVal(tempvo.getVal() );
					word_vo.setOrd(tempvo.getOrd() );
										
					word_vo.setTc_code(String.valueOf(vo.getCode()));
					
					list.add(word_vo);
				}
			}

			systemDAOService.insertTemplateCateWord(list);
			
		}

	}

	/**
	 *  카테고리 수정
	 */
	@Override
	public void updateCategory(TemplateVO vo) throws Exception {

		systemDAOService.updateCategory(vo);
		
		//카테고리 단어 저장
		if (null != vo.getWlistvo() && vo.getWlistvo().size() > 0) {
			systemDAOService.deleteTemplateCateWord(vo.getCode());
			
			List<TemplateVO> list = new ArrayList<TemplateVO>();

			for (TemplateVO tempvo : vo.getWlistvo()) {
				if(null!= tempvo.getWord() && !"".equals(tempvo.getVal())
						&& !"".equals(tempvo.getOrd())){					
					TemplateVO word_vo=new TemplateVO();
					
					word_vo.setWord(tempvo.getWord() );
					word_vo.setVal(tempvo.getVal() );
					word_vo.setOrd(tempvo.getOrd() );
					
					word_vo.setTc_code(vo.getCode());
					
					list.add(word_vo);
				}
			}
			
			systemDAOService.insertTemplateCateWord(list);
			
		}else{
			systemDAOService.deleteTemplateCateWord(vo.getCode());
		}

	}
	
	@Override
	public void deleteTemplateByInstitutionCode(String code) throws Exception {
		systemDAOService.deleteTemplateByInstitutionCode(code);
	}
	
	@Override
	public void insertServiceSetting(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		systemDAOService.insertServiceSetting(vo);
	}
	
	@Override
	public void insertServiceSettingLog(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		systemDAOService.insertServiceSettingLog(vo);
	}
	
	@Override
	public void insertServiceSettingLogByExecute(TrainingVO vo, int diff_send_num) throws Exception {
		// TODO Auto-generated method stub
		SystemVO log_vo = new SystemVO();
		
		String comment= "";
		String service_type= "";
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		
		log_vo.setService_code(vo.getService_setting_code());
		log_vo.setCreate_user(userInfo.getUserid());
		log_vo.setType("execute");
		log_vo.setUc(vo.getUc());		
		log_vo.setTraining_code(vo.getCode());		
		
		if("test".equals(vo.getService_type())){
			service_type="테스트";
		}else if("real".equals(vo.getService_type())){
			service_type="실전";
		}
		
		comment= "해당 "+ service_type+"훈련("+vo.getTname()+")에 의해  총"+diff_send_num+"명(기존 동일한 발송 이메일 제외) 발송 되었습니다.";
		
		log_vo.setComment(comment);
		
		
		
		systemDAOService.insertServiceSettingLog(log_vo);
	}
	
	
	/**
	 * 훈련 서비스 설정 불러오기
	 */
	@Override
	public SystemVO selectServiceByCode(String code) throws Exception {
		// TODO Auto-generated method stub
		return systemDAOService.selectServiceByCode(code);
	}
	
	/**
	 *계정에 포함된 모든  서비스 설정 불러오기
	 */
	@Override
	public List<SystemVO> selectServiceByUserCode(String uc) throws Exception {
		// TODO Auto-generated method stub
		return systemDAOService.selectServiceByUserCode(uc);
	}
	
	/**
	 * 훈련 서비스 설정 수정
	 */
	@Override
	public void updateServiceSetting(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		systemDAOService.updateServiceSetting(vo);
	}
	
	/**
	 * 훈련 서비스 설정 수정
	 */
	@Override
	public void updateServicStatusByUc(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		systemDAOService.updateServicStatusByUc(vo);
	}
	
	/**
	 * 훈련 서비스 설정 로그 카운트
	 */
	@Override
	public int selectServiceLogListCnt(SystemVO vo) throws Exception {
		// TODO Auto-generated method stub
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setLev(userInfo.getLev());
		vo.setUserid(userInfo.getUserid());
		
		return systemDAOService.selectServiceLogListCnt(vo);
	}
	
	/**
	 * 훈련 서비스 설정 로그 출력
	 */
	@Override
	public List<SystemVO> selectServiceLogList(SystemVO vo) throws Exception {
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setLev(userInfo.getLev());
		vo.setUserid(userInfo.getUserid());
		
		return systemDAOService.selectServiceLogList(vo);
	}
	
	/**
	 * 훈련 서비스 설정 정보 가져옴
	 */
	@Override
	public SystemVO selectServiceSettingInfoByUserID(SystemVO vo) throws Exception {
		
		
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		
		if(null == vo.getUserid()  || "".equals(vo.getUserid()) ){
			vo.setLev(userInfo.getLev());
			vo.setUserid(userInfo.getUserid());
		}
		
		return systemDAOService.selectServiceSettingInfoByUserID(vo);
	}
	
	/**
	 * 접속한 User ID의 service setting code을 이용하여 현재까지 실행된 훈련 인원 조회(중복제거)
	 */
	@Override
	public List<SystemVO>  selectTrainingUserCntByServiceSettingCode(SystemVO vo) throws Exception {
		
		return systemDAOService.selectTrainingUserCntByServiceSettingCode(vo);
	}
	
}
