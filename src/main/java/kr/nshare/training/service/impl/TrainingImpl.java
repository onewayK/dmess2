package kr.nshare.training.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import kr.nshare.common.UserInfoVO;
import kr.nshare.common.impl.CommonService;
import kr.nshare.common.util.EgovProperties;
import kr.nshare.common.util.SessionUtil;
import kr.nshare.system.service.TemplateVO;
import kr.nshare.system.service.impl.SystemService;
import kr.nshare.training.service.TrainingLogVO;
import kr.nshare.training.service.TrainingRegisterVO;
import kr.nshare.training.service.TrainingVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

@Service("trainingImpl")
public class TrainingImpl implements TrainingService {
	@Autowired
	private TrainingDAO trainingDAOService;

	@Autowired
	private CommonService commonImpl;

	@Autowired
	private SystemService systemImpl;

	/**
	 * 사용자 등록
	 */
	@Override
	public void insertTraining(TrainingVO vo) throws Exception {

		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setUc(userInfo.getCode());

		// 공통 코드에서 정보 수신 모듈 주소 검색후 지정
		String request_url = EgovProperties.getProperty("Globals.request.data.url");

		// 신고 기능 url
		String register_url = EgovProperties.getProperty("Globals.register.data.url");

		vo.setRequest_url(request_url);

		vo.setRegister_url(register_url);

		// 상태 지정
		if (vo.getStatus().equals("")) {
			vo.setStatus("ready");
		}

		trainingDAOService.insertTraining(vo);

		if(vo.getJson_userlist() !=null && vo.getJson_userlist() != ""){
			Gson gson = new Gson();
			TrainingVO[] array = gson.fromJson(vo.getJson_userlist(), TrainingVO[].class);
			List<TrainingVO> listvo = Arrays.asList(array);
			
			vo.setListvo(listvo);
		}		
		
		if (null != vo.getListvo() && vo.getListvo().size() > 0) {
			List<TrainingVO> list = new ArrayList<TrainingVO>();

			for (TrainingVO tempvo : vo.getListvo()) {
				if(null!= tempvo.getUnikey() && !"".equals(tempvo.getUnikey())){					
					TrainingVO vo2 = new TrainingVO();				
					vo2.setTraining_code(String.valueOf(vo.getCode()));
					vo2.setName(tempvo.getName());
					vo2.setEmail(tempvo.getEmail());
					vo2.setDepartment_name(tempvo.getDepartment_name());
					vo2.setUnikey(tempvo.getUnikey());
					list.add(vo2);
				}
			}

			trainingDAOService.insertTrainingUser(list);
		}

	}

	@Override
	public void updateTraining(TrainingVO vo) throws Exception {

		trainingDAOService.updateTraining(vo);
		
		if(vo.getJson_userlist() !=null && vo.getJson_userlist() != ""){
			Gson gson = new Gson();
			TrainingVO[] array = gson.fromJson(vo.getJson_userlist(), TrainingVO[].class);
			List<TrainingVO> listvo = Arrays.asList(array);
			
			vo.setListvo(listvo);
		}		
		
		if (null != vo.getListvo() && vo.getListvo().size() > 0) {
			// 기존 사용자 등록분 삭제
			trainingDAOService.deleteTrainingUserByCode(vo.getCode());

			List<TrainingVO> list = new ArrayList<TrainingVO>();
			for (TrainingVO tempvo : vo.getListvo()) {

				TrainingVO vo2 = new TrainingVO();
				vo2.setTraining_code(String.valueOf(vo.getCode()));
				if (!tempvo.getName().equals("")
						&& !tempvo.getEmail().equals("")
						&& !tempvo.getDepartment_name().equals("")
						&& !tempvo.getUnikey().equals("")) {
					vo2.setName(tempvo.getName());
					vo2.setEmail(tempvo.getEmail());
					vo2.setDepartment_name(tempvo.getDepartment_name());
					vo2.setUnikey(tempvo.getUnikey());
					list.add(vo2);
				}
			}
		
			trainingDAOService.insertTrainingUser(list);
		}else{
			trainingDAOService.deleteTrainingUserByCode(vo.getCode());
		}

	}

	@Override
	public TrainingVO selectTrainingByCode(String code) throws Exception {
		return trainingDAOService.selectTrainingByCode(code);
	}
	
	@Override
	public TrainingVO selectTrainingWithValidByCode(String code) throws Exception {
		return trainingDAOService.selectTrainingWithValidByCode(code);
	}
	
	@Override
	public List<TrainingVO> selectTrainingList(TrainingVO vo) throws Exception {
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setLev(userInfo.getLev());
		vo.setUserid(userInfo.getUserid());
		return trainingDAOService.selectTrainingList(vo);
	}

	@Override
	public int selectTrainingListCnt(TrainingVO vo) throws Exception {

		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setLev(userInfo.getLev());
		vo.setUserid(userInfo.getUserid());

		return trainingDAOService.selectTrainingListCnt(vo);
	}

	/**
	 * 사용자별 기관 리스트
	 */
	@Override
	public List<TrainingVO> selectMemberInstitutionList(TrainingVO vo)
			throws Exception {

		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setLev(userInfo.getLev());
		vo.setUserid(userInfo.getUserid());
		return trainingDAOService.selectMemberInstitutionList(vo);
	}

	@Override
	public List<TrainingVO> selectTrainingUserByCode(String training_code)
			throws Exception {
		return trainingDAOService.selectTrainingUserByCode(training_code);
	}
	
	@Override
	public List<TrainingVO> selectTrainingUserStatusByCode(String training_code)
			throws Exception {
		return trainingDAOService.selectTrainingUserStatusByCode(training_code);
	}
	
	/**
	 * 훈련 사용자 삭제
	 */
	@Override
	public int deleteTrainingUserByCode(String training_code) throws Exception {
		return trainingDAOService.deleteTrainingUserByCode(training_code);
	}

	@Override
	public List<TrainingVO> selectAjaxExcuteTrainingStatusList(
			List<TrainingVO> vo) throws Exception {
		return trainingDAOService.selectAjaxExcuteTrainingStatusList(vo);
	}

	@Override
	public TrainingLogVO selectTrainingLog(TrainingLogVO vo) throws Exception {
		// TODO Auto-generated method stub
		return trainingDAOService.selectTrainingLog(vo);
	}

	@Override
	public void updateTrainingLog(TrainingLogVO vo) throws Exception {
		trainingDAOService.updateTrainingLog(vo);
	}

	@Override
	public TrainingVO selectTrainingLogSummy(String training_code)
			throws Exception {
		return trainingDAOService.selectTrainingLogSummy(training_code);
	}

	@Override
	public List<TrainingVO> selectTrainingUserByNameAndEmail(TrainingVO vo)
			throws Exception {
		return trainingDAOService.selectTrainingUserByNameAndEmail(vo);
	}

	@Override
	public void insertTrainingRegister(TrainingRegisterVO vo) throws Exception {

		trainingDAOService.insertTrainingRegister(vo);

	}
	
	@Override
	public void insertTrainingRegister2(TrainingRegisterVO vo) throws Exception {

		trainingDAOService.insertTrainingRegister2(vo);

	}
	
	@Override
	public List<TrainingVO> selectTrainingGroupList(TrainingVO vo)
			throws Exception {
		return trainingDAOService.selectTrainingGroupList(vo);
	}

	@Override
	public int selectTrainingGroupListCnt(TrainingVO vo) throws Exception {
		return trainingDAOService.selectTrainingGroupListCnt(vo);
	}

	@Override
	public void insertGroup(TrainingVO vo) throws Exception {
		trainingDAOService.insertGroup(vo);
	}

	@Override
	public void updateGroup(TrainingVO vo) throws Exception {
		trainingDAOService.updateGroup(vo);
	}

	@Override
	public TrainingVO selectGroupByCode(String code) throws Exception {
		return trainingDAOService.selectGroupByCode(code);
	}
	
	@Override
	public List<TrainingVO> selectGroupByInstitutionCode(String code) throws Exception {
		return trainingDAOService.selectGroupByInstitutionCode(code);
	}
	
	@Override
	public List<TrainingVO> selectGroupListByInstitutionCode(String code)
			throws Exception {
		return trainingDAOService.selectGroupListByInstitutionCode(code);
	}

	@Override
	public int insertCopyTrainingByCode(TrainingVO vo) throws Exception {
		// TODO Auto-generated method stub
		return trainingDAOService.insertCopyTrainingByCode(vo);
	}

	@Override
	public int deleteTrainingByCode(String code) throws Exception {
		// TODO Auto-generated method stub
		return trainingDAOService.deleteTrainingByCode(code);
	}
	
	@Override
	public int deleteTrainingLogByCode(String training_code) throws Exception {
		return trainingDAOService.deleteTrainingLogByCode(training_code);
	}

	@Override
	public int deleteTrainingRegisterByCode(String training_code)
			throws Exception {
		return trainingDAOService.deleteTrainingRegisterByCode(training_code);
	}
	
	
	@Override
	public void insertTraining2(List<TemplateVO> list, ArrayList<HashMap> hmlist, String code) throws Exception {
				
		TrainingVO tvo = new TrainingVO();
		tvo.setTraining_code(code);
		
		trainingDAOService.deleteTrainingGrpByCdoe(tvo);
		trainingDAOService.deleteTraining2UserByCdoe(tvo);		
		
		for (TemplateVO tempvo : list) {
			TrainingVO gvo = new TrainingVO();
			
			//카테고리 별 유저 분류
			List<TrainingVO> tulist = new ArrayList<TrainingVO>();		
			for (HashMap hm : hmlist) {
				if(tempvo.getCate_code().equals(hm.get("cate_code"))){
					TrainingVO uvo = new TrainingVO();			
					uvo.setTraining_code(code);
					uvo.setName(String.valueOf(hm.get("name")));
					uvo.setEmail(String.valueOf(hm.get("email")));
					uvo.setDepartment_name(String.valueOf(hm.get("department_name")));
					uvo.setUnikey( String.valueOf(hm.get("unikey")));						
					tulist.add(uvo);
				}
			}
			
			if(tulist.size()==0){
				continue;
			}
			
			//grp 등록
			gvo.setTraining_code(code);
			gvo.setSend_content(tempvo.getSend_content());
			gvo.setTraining_type1(tempvo.getTraining_type1());
			gvo.setTraining_type2(tempvo.getTraining_type2());
			gvo.setTraining_type2_content(tempvo.getTraining_type2_content());
			gvo.setTraining_type2_linkname(tempvo.getTraining_type2_linkname());
			gvo.setTraining_type3(tempvo.getTraining_type3());
			gvo.setTraining_type3_file_type(tempvo.getTraining_type3_file_type());
			gvo.setTraining_type3_file_name(tempvo.getTraining_type3_file_name());
			gvo.setTraining_type3_file_redirect(tempvo.getTraining_type3_file_redirect());
			gvo.setTraining_type3_content(tempvo.getTraining_type3_content());
			gvo.setRequest_url(EgovProperties.getProperty("Globals.request.data.url"));
			gvo.setTc_code(tempvo.getCode());
			gvo.setGp_send_name(tempvo.getSend_name());
			gvo.setGp_send_email(tempvo.getSend_email());
			gvo.setGp_title(tempvo.getTitle());
			
			trainingDAOService.insertTraining2grp(gvo); 
			
			List<TrainingVO> list2=new ArrayList<TrainingVO>();
			
			for(TrainingVO uvo : tulist){
				uvo.setTg_code(gvo.getCode());
				list2.add(uvo);
			}
			
			trainingDAOService.insertTraining2User(list2);
		}	
	}

	/*
	 * (non-Javadoc)
	 * @see kr.nshare.training.service.impl.TrainingService#insertTraining2step1(kr.nshare.training.service.TrainingVO)
	 */
	@Override
	public void insertTraining2step1(TrainingVO vo) throws Exception {

		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setUc(userInfo.getCode());

		// 공통 코드에서 정보 수신 모듈 주소 검색후 지정
		String request_url = EgovProperties.getProperty("Globals.request.data.url");

		// 신고 기능 url
		String register_url = EgovProperties.getProperty("Globals.register.data.url");

		vo.setRequest_url(request_url);

		vo.setRegister_url(register_url);

		trainingDAOService.insertTraining2step1(vo);

	}

	@Override
	public void updateTraining2(TrainingVO vo) throws Exception {
		trainingDAOService.updateTraining2(vo);
	}
	
	@Override
	public void updateTrainingDate(TrainingVO vo) throws Exception {
		trainingDAOService.updateTrainingDate(vo);
	}
	
	@Override
	public List<TrainingVO> selectTraining2List(TrainingVO vo) throws Exception {
		// TODO Auto-generated method stub
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setLev(userInfo.getLev());
		vo.setUserid(userInfo.getUserid());
		return trainingDAOService.selectTraining2List(vo);
	}

	@Override
	public int selectTraining2ListCnt(TrainingVO vo) throws Exception {
		// TODO Auto-generated method stub
		UserInfoVO userInfo = SessionUtil.getSessionUserInfo();
		vo.setLev(userInfo.getLev());
		vo.setUserid(userInfo.getUserid());
		return trainingDAOService.selectTraining2ListCnt(vo);
	}

	@Override
	public void deleteTrainingGrpByCdoe(TrainingVO vo) throws Exception {
		trainingDAOService.deleteTrainingGrpByCdoe(vo);

	}

	@Override
	public void insertTraining2grp(TrainingVO vo) throws Exception {
		// TODO Auto-generated method stub
		vo.setRequest_url(EgovProperties.getProperty("Globals.request.data.url"));
		vo.setTc_code(vo.getCode());
		vo.setGp_send_email(vo.getSend_email());
		vo.setGp_send_name(vo.getSend_name());
		vo.setGp_title(vo.getTitle());
		
		trainingDAOService.insertTraining2grp(vo);
	}

	@Override
	public void updateTraining2grp(TemplateVO vo) throws Exception {
		// TODO Auto-generated method stub
				
		vo.setCode(vo.getTg_code());
		
		trainingDAOService.updateTraining2grp(vo);
	}	


	

	@Override
	public void deleteTraining2UserByCdoe(TrainingVO vo) throws Exception {
		// TODO Auto-generated method stub
		trainingDAOService.deleteTraining2UserByCdoe(vo);
		
	}

	@Override
	public void updateTraining2UserbySelect(TrainingVO vo) throws Exception {
		// TODO Auto-generated method stub
		trainingDAOService.updateTraining2UserbySelect(vo);
		
	}

	@Override
	public void insertTraining2User(List<TrainingVO> list) throws Exception {
		// TODO Auto-generated method stub
		
		trainingDAOService.insertTraining2User(list);
	}
	

	@Override
	public List<TrainingVO> selectTraining2UserListByCode(String code)
			throws Exception {
		// TODO Auto-generated method stub
		
		return trainingDAOService.selectTraining2UserListByCode(code);
	}
	
	@Override
	public List<TrainingVO> selectTraining2UserListWithStatusByCode(String code)
			throws Exception {
		// TODO Auto-generated method stub
		
		return trainingDAOService.selectTraining2UserListWithStatusByCode(code);
	}
	
	@Override
	public List<TrainingVO> selectTraining2GrpListByCode(String code)
			throws Exception {
		// TODO Auto-generated method stub
		return trainingDAOService.selectTraining2GrpListByCode(code);
	}

	@Override
	public List<TrainingVO> selectAllTemplistExceptGrp(TrainingVO vo)
			throws Exception {
		// TODO Auto-generated method stub
		return trainingDAOService.selectAllTemplistExceptGrp(vo);
	}

	@Override
	public List<TrainingVO> selectTraining2GrpNoUser(String code)
			throws Exception {
		// TODO Auto-generated method stub
		return trainingDAOService.selectTraining2GrpNoUser(code);
	}

	@Override
	public List<TrainingVO> selectTraining2DetailList(String code)
			throws Exception {
		// TODO Auto-generated method stub
		return trainingDAOService.selectTraining2DetailList(code);
	}
	
	@Override
	public List<TrainingVO> selectTraining2GrpByCode(TrainingVO vo)
			throws Exception {
		// TODO Auto-generated method stub
		return trainingDAOService.selectTraining2GrpByCode(vo);
	}
	
	public void insertTraining2_rand(List<TrainingVO> list, ArrayList<HashMap> hmlist,String code) throws Exception {
		
		Random random= new Random();
		int list_size=list.size();
		List<TrainingVO> tulist = new ArrayList<TrainingVO>();		
		
		for (HashMap hm : hmlist) {
			
				TrainingVO uvo = new TrainingVO();			
				uvo.setTraining_code(code);
				uvo.setName(String.valueOf(hm.get("name")));
				uvo.setEmail(String.valueOf(hm.get("email")));
				uvo.setDepartment_name(String.valueOf(hm.get("department_name")));
				uvo.setUnikey( String.valueOf(hm.get("unikey")));		
				
				uvo.setTg_code(list.get(random.nextInt(list_size)).getCode());
				tulist.add(uvo);
			
		}		
		
		trainingDAOService.insertTraining2User(tulist);
	}
	
	public void insertTraining2_selectGrp(ArrayList<HashMap> hmlist,String code,String tg_code) throws Exception {
		
		List<TrainingVO> tulist = new ArrayList<TrainingVO>();		
		
		for (HashMap hm : hmlist) {			
				TrainingVO uvo = new TrainingVO();			
				uvo.setTraining_code(code);
				uvo.setName(String.valueOf(hm.get("name")));
				uvo.setEmail(String.valueOf(hm.get("email")));
				uvo.setDepartment_name(String.valueOf(hm.get("department_name")));
				uvo.setUnikey( String.valueOf(hm.get("unikey")));				
				uvo.setTg_code(tg_code);
				tulist.add(uvo);			
		}		
		
		trainingDAOService.insertTraining2User(tulist);
	}	
	
	@Override
	public List<TrainingVO> selectTrainingByGroupCode(String code)
			throws Exception {
		return trainingDAOService.selectTrainingByGroupCode(code);
	}
	
	@Override
	public int deleteTrainingGroupByCode(String code) throws Exception {
		// TODO Auto-generated method stub
		return trainingDAOService.deleteTrainingGroupByCode(code);
	}
	
	@Override
	public List<TrainingVO> selectDeleteExpectedTrainingList(TrainingVO vo) throws Exception {
	
		return trainingDAOService.selectDeleteExpectedTrainingList(vo);
	}

	@Override
	public int selectDeleteExpectedTrainingListCnt(TrainingVO vo) throws Exception {

		return trainingDAOService.selectDeleteExpectedTrainingListCnt(vo);
	}
	
	/**
	 * 한 훈련에 등록된 훈련대상자 수 
	 */
	@Override
	public int selectTrainingUserCnt(String code) throws Exception {

		return trainingDAOService.selectTrainingUserCnt(code);
	}

	
	
}
